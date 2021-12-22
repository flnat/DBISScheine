create or replace TRIGGER Archiviere_Stornierte_Buchungen
	FOR DELETE ON Belegungen
    WHEN (old.Buchungsstatus = 'Buchung')
	COMPOUND TRIGGER
		--Cursor Objekte zur BefÃ¼llung von Datenstrukturen zur Umgehung von ORA-4091
		CURSOR Belegungen_Cursor IS
			SELECT BelegungsNr, KundenID, WohnungsID
			FROM Belegungen
			WHERE Buchungsstatus = 'Buchung';

		CURSOR BELEGUNGSNR_CURSOR IS
			SELECT BELEGUNGSNR
			FROM BELEGUNGEN
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
				tmp_Belegungen(belegungs_record.BelegungsNr).BelegungsNr:= belegungs_record.BelegungsNr;
                tmp_Belegungen(belegungs_record.BelegungsNr).KundenID:= belegungs_record.KundenID;
                tmp_Belegungen(belegungs_record.BelegungsNr).WohnungsID:= belegungs_record.WohnungsID;
			END LOOP;

	END BEFORE STATEMENT;

	BEFORE EACH ROW IS
		BEGIN
        /*  tmp_IDs.extend();
            tmp_IDs := :old.BelegungsNr;
        */
        null;
	END BEFORE EACH ROW;
	AFTER STATEMENT IS
		BEGIN
            DBMS_OUTPUT.PUT_LINE(tmp_Belegungen(4).BelegungsNr);
			DBMS_OUTPUT.PUT_LINE(tmp_Belegungen(4).WohnungsID);
	END AFTER STATEMENT;
END Archiviere_Stornierte_Buchungen;