CREATE OR REPLACE TRIGGER Archiviere_Stornierte_Buchungen
	FOR DELETE ON Belegungen
	COMPOUND TRIGGER
		
		TYPE tuple_Belegungen IS RECORD (
			BelegungsNr Belegungen.BelegungsNr%TYPE,
			KundenID Belegungen.KundenID%TYPE,
			WohnungsID Belegungen.WohnungsID%TYPE);
			
		TYPE tmp_Belegungen IS TABLE OF tuple_Belegungen
			INDEX BY VARCHAR(38);
		
		
		
		
		
		
		TYPE t_Belegungen_BelegungsNr IS TABLE OF Belegungen.BelegungsNr%TYPE
			INDEX BY INTEGER;
		Belegungen_IDs t_Belegungen_BelegungsNr;
		
		TYPE t_Belegungen_KundenID IS TABLE OF Belegungen.KundenID%TYPE
			INDEX BY INTEGER;
		Kunden_IDs t_Belegungen_KundenID;
		
		TYPE t_Belegungen_WohnungsID IS TABLE OF Belegungen.WohnungsID%TYPE
			INDEX BY INTEGER;
		Wohnungs_IDs t_Belegungen_WohnungsID;
		
		Buchungsrange INTEGER;
		Buchungspreis NUMBER(12,4);
		Rechnungsstatus VARCHAR2(12);
		KundenName VARCHAR2(32);
		Wohnungsbeschreibung VARCHAR2(1024);
		
	BEFORE STATEMENT IS
		BEGIN
			SELECT b.BelegungsNr, b.KundenID, b.WohnungsID
			BULK COLLECT INTO Belegungen_IDs, Kunden_IDs, Wohnungs_IDs
			FROM Belegungen b;

			FOR j IN 1..Belegungen_IDs.COUNT() LOOP
				Belegungen_IDs(Belegungen_IDs(j)) := Belegungen_IDs(j);
				Kunden_IDs(Belegungen_IDs(j)) := Kunden_IDs(j);
				Wohnungs_IDs(Belegungen_IDs(j)) := Wohnungs_IDs(j);
			END LOOP;
	END BEFORE STATEMENT;

	AFTER EACH ROW IS
		BEGIN
			Buchungsrange := :old.Bis - :old.Von;
			Buchungspreis := preis(Buchungsrange, :old.WohnungsID);
		
			SELECT z.Zahlungsstatus INTO Rechnungsstatus
			FROM Zahlungsstatus z
			WHERE z.BelegungsNr = Belegungen_IDs(:old.BelegungsNr);
			
			SELECT k.Nachname INTO KundenName
			FROM Kunden k
			WHERE k.KundenID = Kunden_IDs(:old.BelegungsNr);
			
			SELECT f.Beschreibungstext INTO Wohnungsbeschreibung
			FROM Ferienwohnungen f
			WHERE f.WohnungsID = Wohnungs_IDs(:old.BelegungsNr);
		
		
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
	END AFTER EACH ROW;
END Archiviere_Stornierte_Buchungen;