ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';

/*
Legende f¸r Abk¸rzungen
PK: Primary-Key
FK: Foreign-Key
AK: Alternate-Key
VV: Valid Values (f¸r CHECK Constraints)
*/


CREATE TABLE Laender
    (ISOCode CHAR(2)
        CONSTRAINT PK_Laender PRIMARY KEY,
    Landesname VARCHAR2(64)
        NOT NULL
        CONSTRAINT AK_Landesname UNIQUE
    );
COMMENT ON COLUMN Laender.ISOCode IS 'L‰nder.ISOCode m¸ssen dem ISO 3166-1 alpha-2 Standard folgen (z.B. DE, FR, GB, ES)';
    
CREATE TABLE Orte
    (OrtsID INTEGER
        CONSTRAINT PK_Orte PRIMARY KEY,
    Ortsname VARCHAR2(128)
        NOT NULL,
    Flughafen VARCHAR2(64)
        NOT NULL,
    Land CHAR(2)
        NOT NULL
        CONSTRAINT FK_Orte_Laender REFERENCES Laender(ISOCode)
    );

   
CREATE TABLE kalkulierte_Distanz
    (Startpunkt INTEGER
        CONSTRAINT FK_Startpunkt REFERENCES Orte(OrtsID),
    Endpunkt INTEGER
        CONSTRAINT FK_Endpunkt REFERENCES Orte(OrtsID),
    kalkulierte_Distanz FLOAT
        NOT NULL
        CONSTRAINT VV_kalkulierte_Distanz_positiv CHECK (kalkulierte_Distanz > 0),
    CONSTRAINT PK_kalkulierte_Distanz PRIMARY KEY (Startpunkt, Endpunkt),
    CONSTRAINT kalkulierte_Distanz_SP_ungleich_EP CHECK (Startpunkt <> Endpunkt)
    );
COMMENT ON TABLE kalkulierte_Distanz IS'Die Distanz eines Punktes zu sich selbst sei als 0 anzunehmen. Implementierung erfolgt als ???
Falls die Distanz zwischen zwei Punkten nicht bekannt ist, so ist diese als unbekannt null anzunehmen
Die Distanz zwischen zwei beliebigen Punkten wird genau einmal gespeichert.';
COMMENT ON COLUMN kalkulierte_Distanz.kalkulierte_Distanz IS ' Die kalkulierte Distanz
ist als Distanz in km zu lesen. Da L√§nge als messbarer Wert typischerweise 
von stetiger Natur ist wurde an dieser Stelle ein passender Gleitkommadatentyp gew√§hlt.';


CREATE TABLE Adressen
    (AdressID INTEGER
        CONSTRAINT PK_Adressen PRIMARY KEY,
    Strasse VARCHAR2(64)
        NOT NULL,
    Hausnummer VARCHAR2(4)
        NOT NULL,
    PLZ VARCHAR2(10)
        NOT NULL,
    OrtsID  INTEGER
        NOT NULL
        CONSTRAINT FK_Adressen_Orte REFERENCES Orte(ORTSID)
    );
COMMENT ON COLUMN Adressen.AdressID IS 'Eine AdressID darf maximal
entweder einer Wohnung, einem Kunden, einer Touristenattraktion oder einem Flughafen zugeordnet werden';


CREATE TABLE Flughaefen
    (Flughafenname VARCHAR2(64)
        CONSTRAINT PK_Flughaefen PRIMARY KEY,
    AdressID INTEGER
        NOT NULL
        CONSTRAINT FK_Flughafen_Adressen REFERENCES Adressen(AdressID)
        CONSTRAINT AK_Flughaefen_AdressID UNIQUE
    );

ALTER TABLE Orte
    ADD CONSTRAINT FK_Orte_Flughafen FOREIGN KEY (Flughafen) REFERENCES Flughaefen(Flughafenname)
        INITIALLY DEFERRED DEFERRABLE
        ;

    
CREATE TABLE Touristenattraktionen
    (Name_der_Attraktion VARCHAR2(64)
        CONSTRAINT PK_Touristenattraktionen PRIMARY KEY,
    Beschreibung VARCHAR2(256)
        NOT NULL,
    AdressID INTEGER
        NOT NULL
        CONSTRAINT FK_Touristenattraktionen_Adressen REFERENCES ADRESSEN(ADRESSID)
        CONSTRAINT AK_Touristenattraktionen_AdressID UNIQUE
    );

CREATE TABLE Fluggesellschaften
    (Gesellschaftsname VARCHAR2(64)
        CONSTRAINT PK_Fluggesellschaften PRIMARY KEY,
    Rating INTEGER
        NOT NULL
        CONSTRAINT VV_FluggesellschaftenRating CHECK (Rating BETWEEN 1 AND 10)
    );


CREATE TABLE wird_angeflogen
    (Startflughafen VARCHAR2(64)
        CONSTRAINT FK_Startflughafen REFERENCES Flughaefen(Flughafenname),
    Endflughafen VARCHAR2(64)
        CONSTRAINT FK_Endflughafen REFERENCES Flughaefen(Flughafenname),
    Fluggesellschaft VARCHAR2(64)
        CONSTRAINT FK_Fluggesellschaft REFERENCES Fluggesellschaften(Gesellschaftsname),
    CONSTRAINT PK_wirdangeflogen PRIMARY KEY (Startflughafen, Endflughafen, Fluggesellschaft),
    CONSTRAINT wird_angeflogen_StartF_ungleich_Endf CHECK (Startflughafen <> Endflughafen)
    );


CREATE TABLE Ferienwohnungen
    (WohnungsID INTEGER
        CONSTRAINT PK_Ferienwohnungen PRIMARY KEY,
     Groesse NUMBER
        NOT NULL,
     Zimmerzahl INTEGER
        NOT NULL,
     Tagespreis NUMBER(20,4)
        NOT NULL,
     Beschreibungstext VARCHAR2(1024)
        NOT NULL,
     AdressID INTEGER
        NOT NULL
        CONSTRAINT FK_Ferienwohnungen_Adressen REFERENCES Adressen(AdressID)
        CONSTRAINT AK_Ferienwohnungen_AdressID UNIQUE,
        CONSTRAINT VV_Ferienwohnungen_Tagespreis CHECK (Tagespreis > 0),
        CONSTRAINT VV_Ferienwohnungen_Groesse CHECK (Groesse > 0)
     );

COMMENT ON COLUMN Ferienwohnungen.Tagespreis IS 'Angabe in Euro';
COMMENT ON COLUMN Ferienwohnungen.Groesse IS 'Angabe in Quadratmeter';

CREATE TABLE Zusatzaustattungen
    (Beschreibung VARCHAR2(256)
        CONSTRAINT PK_Zusatzaustattungen PRIMARY KEY
    );


CREATE TABLE bietet
    (WohnungsID INTEGER
        CONSTRAINT FK_bietet_Ferienwohnungen REFERENCES Ferienwohnungen(WohnungsID),
    Ausstattungsbeschreibung VARCHAR2(256)
        CONSTRAINT FK_bietet_Zusatzaustattungen REFERENCES Zusatzaustattungen(Beschreibung),
    CONSTRAINT PK_bietet PRIMARY KEY (WohnungsID, Ausstattungsbeschreibung)
    );


CREATE TABLE Bilder
    (DateiID INTEGER
        CONSTRAINT PK_Bilder PRIMARY KEY,
    Bildbeschreibung VARCHAR2(128)
        NOT NULL,
    DateiPfad VARCHAR2(256)
        NOT NULL,
    WohnungsID INTEGER
        NOT NULL
        CONSTRAINT FK_Bilder_Ferienwohnungen REFERENCES Ferienwohnungen(WohnungsID)
    );
COMMENT ON TABLE Bilder IS 'Einer Ferienwohnung k√∂nnen maximal 4 Bilder zugeordnet werden';


CREATE TABLE Bankverbindungen
    (IBAN CHAR(22)
        CONSTRAINT PK_Bankverbindungen PRIMARY KEY,
    BIC CHAR(11)
        NOT NULL,
    Kontonummer CHAR(7)
        NOT NULL,
    BLZ CHAR(8)
        NOT NULL,
    CONSTRAINT AK_Bankverbindungen UNIQUE (Kontonummer, BLZ)
    );   


CREATE TABLE Kunden
    (KundenID INTEGER
        CONSTRAINT PK_Kunden PRIMARY KEY,
    Email VARCHAR2(64)
        NOT NULL
        CONSTRAINT AK_Kunden_Email UNIQUE,
    Telefonnummer VARCHAR2(32)
        NOT NULL,
    Geburtsdatum DATE
        NOT NULL,
    Vorname VARCHAR2(32)
        NOT NULL, 
    Nachname VARCHAR2(32)
        NOT NULL, 
    AdressID INTEGER
        NOT NULL
        CONSTRAINT FK_Kunden_Adressen REFERENCES Adressen(AdressID)
        CONSTRAINT AK_Kunden_AdressID UNIQUE,
    IBAN CHAR(22)
        NOT NULL
        CONSTRAINT FK_Kunden_Bankverbindungen REFERENCES Bankverbindungen(IBAN)
        CONSTRAINT AK_Kunden_IBAN UNIQUE
    );


CREATE TABLE Belegungen
    (BelegungsNr INTEGER
        CONSTRAINT PK_Belegungen PRIMARY KEY,
    Buchungsdatum DATE
        NOT NULL,
    Von DATE
        NOT NULL,
    Bis DATE
        NOT NULL,
    Buchungsstatus VARCHAR2(16)
        NOT NULL
        CONSTRAINT VV_Belegungen_Belegungsstatus CHECK (BUCHUNGSSTATUS IN ('Buchung', 'Reservierung')),
    WohnungsID INTEGER
        NOT NULL
        CONSTRAINT FK_Belegungen_Ferienwohnungen REFERENCES Ferienwohnungen(WohnungsID),
    KundenID INTEGER
        NOT NULL
        CONSTRAINT FK_Belegungen_Kunden REFERENCES Kunden(KundenID),
    CONSTRAINT VV_Belegungen_Von_kleiner_Bis CHECK (Von <= Bis)
    );


/* Es ist nur eine Umwandlung von unverbindlichen Reservierungen zu verbindlichen Buchungen m√∂glich  */
/* Die Belegungen einer Ferienwohnung d√ºrfen sich nicht zeitlich √ºberschneiden */


/*Eine Belegung f√ºhrt nach einer Woche zu einer Rechnung */


CREATE TABLE Rechnungen
    (RechnungsNr INTEGER
        CONSTRAINT PK_Rechnungen PRIMARY KEY,
    Rechnungsbetrag NUMBER(10,4)
        CONSTRAINT Rechnungen_Rechnungsbetrag_positiv CHECK (Rechnungsbetrag > 0)
        NOT NULL,
    Rechnungsdatum DATE
        NOT NULL,
    Zahlungseingang DATE,
    Rechnungsstatus VARCHAR2(16)
        NOT NULL
        CONSTRAINT VV_Rechnungen_Rechnungstatus CHECK (Rechnungsstatus IN ('beglichen', 'offen')),
    BelegungsNr INTEGER
        NOT NULL
        CONSTRAINT FK_Rechnungen_Belegungen REFERENCES Belegungen(BelegungsNr)
        CONSTRAINT AK_Rechnungen_BelegungsNr UNIQUE,
    CONSTRAINT Rechnungen_Zahlungseingang_nach_Rechnungseingang CHECK(ZAHLUNGSEINGANG >= RECHNUNGSDATUM)
    );

/*Da die Rechnungaustellung eine Woche nach erfolgter Buchung erfolgt, muss das Rechnungsdatum um 7 Tage grˆﬂer als 
das Buchungsdatum. Implementierung erfolgt sp‰ter.*/

CREATE VIEW Buchung (BuchungsNr, Buchungsdatum, Von, Bis, WohnungsID, KundenID) AS(
    SELECT
        b.BelegungsNr AS BuchungsNr, b.Buchungsdatum, b.Von, b.Bis, b.WohnungsID, b.KundenID
    FROM
        Belegungen b
    WHERE
        b.Buchungsstatus = 'Buchung'
    );

CREATE VIEW Reservierung (ReservierungsNr, Reservierungsdatum, Von, Bis, WohnungsID, KundenID) AS(
    SELECT
        b.BelegungsNr AS BuchungsNr, b.Buchungsdatum AS Reservierungsdatum,
        b.Von, b.Bis, b.WohnungsID, b.KundenID
    FROM
        Belegungen b
    WHERE
        b.Buchungsstatus = 'Reservierung'
    );
CREATE VIEW Familienwohnungen AS
    SELECT f.*
    FROM Ferienwohnungen f
    WHERE f.Groesse > 100
    WITH CHECK OPTION;
    
CREATE VIEW UebersichtKunden (KundenID, Nachname, Vorname, Email, IBAN, BIC, Ortsname, Strasse,
    Hausnummer, PLZ, BelegungnsNr, Buchungsstatus, Buchungsdatum, Von, Bis ,Rechnungsstatus,
    WohnungsID, Beschreibungstext) AS
    SELECT
        k.KundenID, k.Nachname, k.Vorname, k.Email,
        bv.IBAN, bv.BIC,
        o.OrtsName, a.Strasse, a.Hausnummer, a.PLZ,
        b.BelegungsNr, b.Buchungsstatus, b.Buchungsdatum, b.Von, b.Bis,
        CASE WHEN r.RechnungsNr IS NOT NULL THEN 'Rechnung wurde erstellt'
        ELSE 'Es wurde noch keine Rechnung erstellt' END AS "Rechnungsstatus",
        f.WohnungsID, f.Beschreibungstext
    FROM
        Kunden k LEFT OUTER JOIN Belegungen b
            ON (k.KundenID = b.KundenID)
        LEFT OUTER JOIN Rechnungen r
            ON (b.BelegungsNr = r.BelegungsNr),
        Bankverbindungen bv, Ferienwohnungen f,
        Adressen a, Orte o
    WHERE
        k.IBAN = bv.IBAN AND
        b.WohnungsID = f.WohnungsID AND
        k.AdressID = a.AdressID AND
        a.OrtsID = o.OrtsID
        ;
CREATE VIEW Zahlungsstatus (BelegungsNr, WohnungsID, Beschreibungstext, KundenID,
Nachname, Vorname, RechnungsNr, Rechnungsdatum, Rechnungsbetrag, Zahlungsstatus, Zahlungseingang) AS
    SELECT b.BelegungsNr, f.WohnungsID, f.Beschreibungstext,
    k.KundenID, k.Nachname, k.Vorname,
    r.RechnungsNr, r.Rechnungsdatum, r.Rechnungsbetrag,
    CASE WHEN r.ZAHLUNGSEINGANG IS NOT NULL THEN 'bezahlt' ELSE 'offen' END AS Zahlungsstatus,
    r.ZAHLUNGSEINGANG
    FROM
        Belegungen b LEFT OUTER JOIN Rechnungen r
            ON r.BelegungsNr = b.BelegungsNr,
        Kunden k, Ferienwohnungen f
    WHERE
        b.WohnungsID = f.WohnungsID AND
        b.KundenID = k.KundenID AND
        b.Buchungsstatus = 'Buchung'
    ORDER BY b.BelegungsNr, r.RechnungsNR ASC NULLS LAST        
    ;
CREATE VIEW MidAgeKunden  (KundenID, Email, Telefonnummer, Geburtsdatum,
"Alter", Vorname, Nachname, AdressID, IBAN) AS
    SELECT k.KundenID, K.Email, k.Telefonnummer, k.Geburtsdatum,
    floor(months_between(CURRENT_DATE, k.Geburtsdatum)/12) AS "Alter",
    k.Vorname, k.Nachname, k.AdressID, k.IBAN
    FROM Kunden k
    WHERE
        floor(months_between(CURRENT_DATE, k.Geburtsdatum)/12) BETWEEN 30 AND 40
    ;