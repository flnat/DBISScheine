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
			FROM Belegungen
			WHERE BUCHUNGSSTATUS = 'Buchung';
            
        CURSOR Rechnungen_CURSOR IS
            SELECT *
            FROM Rechnungen;
		--Associative Array (Map?) bestehend aus allen Spalten der Relation Belegungen
		TYPE BelegungenRecord IS TABLE OF Belegungen_Cursor%ROWTYPE
			INDEX BY PLS_INTEGER;
        TYPE RechnungsRecord IS TABLE OF Rechnungen_CURSOR%ROWTYPE
            INDEX BY PLS_INTEGER;
            
		--Nested Table bestehend aus der BelegungsNr
		TYPE affected_Belegungs_Nr IS TABLE OF BELEGUNGSNR_CURSOR%ROWTYPE;
		
		tmp_IDs affected_Belegungs_Nr := affected_Belegungs_Nr();
		tmp_Belegungen BelegungenRecord := BelegungenRecord();
        tmp_Rechnungen RechnungsRecord := RechnungsRecord();
        idx INTEGER := 1;
        Rechnungs_Idx INTEGER;
		
		--Variablen um INSERT STATEMENT in Teile herunterzubrechen		
		Buchungsrange INTEGER;
		Buchungspreis NUMBER(12,4);
		Rechnungsstatus VARCHAR2(12);
		KundenName VARCHAR2(32);
		Wohnungsbeschreibung VARCHAR2(1024);
		--tmp Variable für die BelegungsNr im AFTER Statement Block
        BID INTEGER;
	BEFORE STATEMENT IS
		BEGIN		
			For belegungs_record in Belegungen_Cursor LOOP		
				tmp_Belegungen(belegungs_record.BelegungsNr):= belegungs_record;
			END LOOP;
            For rechnungs_record in Rechnungen_Cursor LOOP
                tmp_Rechnungen(rechnungs_record.BelegungsNr) := rechnungs_record;
            END LOOP;
	END BEFORE STATEMENT;

	AFTER EACH ROW IS
		BEGIN
            tmp_IDs.extend(1);
            tmp_IDs(idx).BelegungsNr := :old.BelegungsNr;
            idx := idx +1;
	END AFTER EACH ROW;
	AFTER STATEMENT IS
		BEGIN
        
			For i in 1..tmp_IDs.COUNT() LOOP
                BID := tmp_IDs(i).BelegungsNr;
                Buchungsrange := tmp_Belegungen(BID).Bis - tmp_Belegungen(BID).Von;
                Buchungspreis := preis(Buchungsrange, tmp_Belegungen(BID).WohnungsID);
                
                 rechnungs_Idx := tmp_rechnungen.FIRST();
                 WHILE (rechnungs_Idx IS NOT NULL) LOOP
                 
                 
                    EXIT WHEN rechnungs_Idx IS NULL;
                    IF (tmp_rechnungen(rechnungs_Idx).BelegungsNr = BID AND tmp_rechnungen(rechnungs_Idx).Zahlungseingang IS NOT NULL) THEN
                        Rechnungsstatus := 'beglichen';
                    ELSIF (tmp_rechnungen(rechnungs_Idx).BelegungsNr = BID) THEN
                        Rechnungsstatus := 'offen';
                    END IF;
                    
                rechnungs_Idx := tmp_rechnungen.NEXT(rechnungs_Idx);
                 END LOOP;


                SELECT k.Nachname INTO KundenName
                FROM Kunden k
                WHERE k.KundenID = tmp_Belegungen(BID).KundenID;
                
                SELECT f.Beschreibungstext INTO Wohnungsbeschreibung
                FROM Ferienwohnungen f
                WHERE f.WohnungsID = tmp_Belegungen(BID).WohnungsID;

                INSERT INTO Stornierungen
                    (StornierungsID, Stornierungsdatum, BuchungsNr, Buchungsdatum,
                    Buchungszeitraum,Buchungswert, Status, KundenID,
                    KundenName, WohnungsID, Beschreibung)

                    VALUES(
                        StornierungsNummer.NEXTVAL,
                        CURRENT_DATE,
                        tmp_Belegungen(BID).BelegungsNr,
                        tmp_Belegungen(BID).Buchungsdatum,
                        Buchungsrange,
                        Buchungspreis,
                        Rechnungsstatus,
                        tmp_Belegungen(BID).KundenID,
                        KundenName,
                        tmp_Belegungen(BID).WohnungsID,
                        Wohnungsbeschreibung
);           
            END LOOP;
	END AFTER STATEMENT;
END Archiviere_Stornierte_Buchungen;