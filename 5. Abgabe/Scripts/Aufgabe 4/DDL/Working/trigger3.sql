CREATE OR REPLACE TRIGGER Archiviere_Stornierte_Buchungen
	FOR DELETE ON Belegungen
    WHEN (old.Buchungsstatus = 'Buchung')
	COMPOUND TRIGGER
		--Cursor Objekte zur Befüllung von Datenstrukturen zur Umgehung von ORA-4091
		CURSOR Belegungen_Cursor IS
			SELECT *
			FROM Belegungen
			WHERE Buchungsstatus = 'Buchung';

		CURSOR BELEGUNGSNR_CURSOR IS
			SELECT BELEGUNGSNR
			FROM BELEGUNGENE
			WHERE BUCHUNGSSTATUS = 'Buchung';
		--Associative Array (Map?) bestehend aus allen Spalten der Relation Belegungen
		TYPE BelegungenRecord IS TABLE OF Belegungen_Cursor%ROWTYPE
			INDEX BY PLS_INTEGER;
		--Nested Table bestehend aus der BelegungsNr
		TYPE affected_Belegungs_Nr IS TABLE OF BELEGUNGSNR_CURSOR%ROWTYPE;
		
		tmp_IDs affected_Belegungs_Nr := affected_Belegungs_Nr();
		tmp_Belegungen  BelegungenRecord := BelegungenRecord();
		idx PLS_INTEGER;
		--Variablen um INSERT STATEMENT in Teile herunterzubrechen		
		Buchungsrange INTEGER;
		Buchungspreis NUMBER(12,4);
		Rechnungsstatus VARCHAR2(12);
		KundenName VARCHAR2(32);
		Wohnungsbeschreibung VARCHAR2(1024);
		
	BEFORE STATEMENT IS
		
		BEGIN		
			For belegungs_record in Belegungen_Cursor
			LOOP
				tmp_Belegungen(belegungs_record.BelegungsNr):= belegungs_record;
			END LOOP;

	END BEFORE STATEMENT;

	BEFORE EACH ROW IS
		BEGIN
            tmp_IDs.extend();
            tmp_IDs := :old.BelegungsNr;
	END BEFORE EACH ROW;
	AFTER STATEMENT IS
		BEGIN
			For i in tmp_IDs.FIRST..tmp_IDs.LAST
			LOOP
				idx := CAST(i AS PLS_INTEGER);
                Buchungsrange := tmp_Belegungen(tmp_IDs(idx)).Bis - tmp_Belegungen(tmp_IDs(idx)).Von;
                Buchungspreis := preis(Buchungsrange, tmp_Belegungen(tmp_IDs(idx)).WohnungsID);
                
                SELECT z.Zahlungsstatus INTO Rechnungsstatus
                FROM Zahlungsstatus z
                WHERE z.BelegungsNr = tmp_Belegungen(tmp_IDs(idx)).BelegungsNr;
                
                SELECT k.Nachname INTO KundenName
                FROM Kunden k
                WHERE k.KundenID = tmp_Belegungen(tmp_IDs(idx)).KundenID;
                
                SELECT f.Beschreibungstext INTO Wohnungsbeschreibung
                FROM Ferienwohnungen f
                WHERE f.WohnungsID = tmp_Belegungen(tmp_IDs(idx)).WohnungsID;
		
            
            
            
                INSERT INTO Stornierungen
                    (StornierungsID, Stornierungsdatum, BuchungsNr, Buchungsdatum,
                    Buchungszeitraum,Buchungswert, Status, KundenID,
                    KundenName, WohnungsID, Beschreibung)
                    VALUES(
                        StornierungsNummer.NEXTVAL,
                        CURRENT_DATE,
                        tmp_Belegungen(tmp_IDs(idx)).BelegungsNr,
                        tmp_Belegungen(tmp_IDs(idx)).Buchungsdatum,
                        Buchungsrange,
                        Buchungspreis,
                        Rechnungsstatus,
                        tmp_Belegungen(tmp_IDs(idx)).KundenID,
                        KundenName,
                        tmp_Belegungen(tmp_IDs(idx)).WohnungsID,
                        Wohnungsbeschreibung);    
            END LOOP;
	END AFTER STATEMENT;
END Archiviere_Stornierte_Buchungen;