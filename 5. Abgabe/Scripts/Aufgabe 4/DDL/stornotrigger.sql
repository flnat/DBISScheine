create or replace TRIGGER BuchungStorno
AFTER DELETE ON Belegungen
FOR EACH ROW
WHEN (old.Buchungsstatus = 'Buchung')
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
	Buchungsrange INTEGER;
	Buchungspreis NUMBER(12,4);
	Rechnungsstatus VARCHAR2(12);
	KundenName VARCHAR2(32);
	Wohnungsbeschreibung VARCHAR2(1024);

	--Workaround for mutating Table Exception
	KID INTEGER;
	FWID INTEGER;
	BID INTEGER;
BEGIN
	--Assignment of Variable Values
	Buchungsrange := :old.Bis - :old.Von;
	Buchungspreis := preis(Buchungsrange, :old.WohnungsID);
	KID := :old.KundenID;
	FWID := :old.WohnungsID;
	BID := :old.BelegungsNr;
	SELECT z.Zahlungsstatus INTO Rechnungsstatus
		FROM Zahlungsstatus z
		WHERE z.BelegungsNr = BID
		;
        
	SELECT k.Nachname INTO KundenName
		FROM Kunden k
		WHERE k.KundenID = KID
		;
	SELECT f.Beschreibungstext INTO Wohnungsbeschreibung
		FROM Ferienwohnungen f
		WHERE f.WohnungsID = FWID
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
    COMMIT;    

END;
