CREATE OR REPLACE TRIGGER Archiviere_Stornierte_Buchungen
	FOR DELETE ON Belegungen
	COMPOUND TRIGGER
		
		CURSOR Belegungen_Cursor IS
			SELECT BelegungsNr, KundenID, WohnungsID
			FROM Belegungen
			WHERE Buchungsstatus = 'Buchung';
			
		TYPE BelegungenRecord IS TABLE OF Belegungen_Cursor%ROWTYPE
			INDEX BY BINARY_INTEGER;
		
		TYPE affected_Belegungs_Nr IS TABLE OF INTEGER;
		
		tmp_IDs affected_Belegungs_Nr;
		tmp_Belegungen BelegungenRecord;			
		

		Buchungsrange INTEGER;
		Buchungspreis NUMBER(12,4);
		Rechnungsstatus VARCHAR2(12);
		KundenName VARCHAR2(32);
		Wohnungsbeschreibung VARCHAR2(1024);
		
	BEFORE STATEMENT IS
		BEGIN		
			For belegungs_record in Belegungen_Cursor
			LOOP
				tmp_Belegungen(belegungs_record.BelegungsNr).BelegungsNr := belegungs_record.BelegungsNr;
				tmp_Belegungen(belegungs_record.BelegungsNr).KundenID := belegungs_record.KundenID;
				tmp_Belegungen(belegungs_record.BelegungsNr).WohnungsID := belegungs_record.WohnungsID;
			END LOOP;

	END BEFORE STATEMENT;

	BEFORE EACH ROW IS
		BEGIN
			Buchungsrange := :old.Bis - :old.Von;
			Buchungspreis := preis(Buchungsrange, :old.WohnungsID);
            DBMS_OUTPUT.PUT_LINE(Buchungsrange);
            DBMS_OUTPUT.PUT_LINE(Buchungspreis);
			SELECT z.Zahlungsstatus INTO Rechnungsstatus
			FROM Zahlungsstatus z
			WHERE z.BelegungsNr = tmp_Belegungen(:old.BelegungsNr).BelegungsNr;
			DBMS_OUTPUT.PUT_LINE(Rechnungsstatus);
			SELECT k.Nachname INTO KundenName
			FROM Kunden k
			WHERE k.KundenID = tmp_Belegungen(:old.BelegungsNr).KundenID;
			
			SELECT f.Beschreibungstext INTO Wohnungsbeschreibung
			FROM Ferienwohnungen f
			WHERE f.WohnungsID = tmp_Belegungen(:old.BelegungsNr).WohnungsID;
		
		/*
			INSERT INTO Stornierungen
				(StornierungsID, Stornierungsdatum, BuchungsNr, Buchungsdatum, Buchungszeitraum,Buchungswert, Status, KundenID, KundenName, WohnungsID, Beschreibung)
			VALUES(
				StornierungsNummer.NEXTVAL,
				CURRENT_DATE,
				:old.BelegungsNr,
				:old.Buchungsdatum,
				Buchungsrange,
				Buchungspreis,
				Rechnungsstatus,
				:old.KundenID,
				KundenName,
				:old.WohnungsID,
				Wohnungsbeschreibung);
                */
	END BEFORE EACH ROW;
END Archiviere_Stornierte_Buchungen;