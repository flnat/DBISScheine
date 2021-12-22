create or replace TRIGGER BuchungStorno
AFTER DELETE ON Belegungen
FOR EACH ROW
WHEN (old.Buchungsstatus = 'Buchung')
DECLARE
	--Define Trigger as Autonomous Transaction to circumvent ORA-4091
    PRAGMA AUTONOMOUS_TRANSACTION;
	Buchungsrange INTEGER;
	Buchungspreis NUMBER(12,4);
	Rechnungsstatus VARCHAR2(12);
	KundenName VARCHAR2(32);
	Wohnungsbeschreibung VARCHAR2(1024);
	--Set of all existing Values for BelegungsNr in TABLE Stornierungen
	BelegungsNrInStornierungen INTEGER;
BEGIN
	
	SELECT s.BuchungsNr INTO BelegungsNrInStornierungen
	FROM Stornierungen s;

	IF old.BelegungsNr NOT IN BelegungsNrInStornierungen THEN
		--Assignment of Variable Values
		Buchungsrange := :old.Bis - :old.Von;
		Buchungspreis := preis(Buchungsrange, :old.WohnungsID);
		FWID := :old.WohnungsID;

		SELECT z.Zahlungsstatus INTO Rechnungsstatus
			FROM Zahlungsstatus z
			WHERE z.BelegungsNr = :old.BelegungsNr
			;
			
		SELECT k.Nachname INTO KundenName
			FROM Kunden k
			WHERE k.KundenID = :old.KundenID
			;
		SELECT f.Beschreibungstext INTO Wohnungsbeschreibung
			FROM Ferienwohnungen f
			WHERE f.WohnungsID = :old.WohnungsID
			;

		--Insertion into Stornierungen TABLE
		INSERT INTO Stornierungen
			(StornierungsID, Stornierungsdatum, BuchungsNr, Buchungsdatum, Buchungszeitraum,
			Buchungswert, Status, KundenID, KundenName, WohnungsID, Beschreibung)
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
			Wohnungsbeschreibung)
			;
	ELSE
		DELETE FROM Stornierungen 
	END IF;
	--TODO: Add logic to reset Table Stornierungen to consistent State after ROLLBACK of DELETE STATEMENT on TABLE Belegungen
    COMMIT;    

END;
