ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';
/*
Legende für Abkürzungen
PK: Primary-Key
FK: Foreign-Key
AK: Alternate-Key
VV: Valid Values (für CHECK Constraints)
*/


CREATE TABLE Laender
    (ISOCode CHAR(2)
        CONSTRAINT PK_Laender PRIMARY KEY,
    Landesname VARCHAR2(64)
        NOT NULL
        CONSTRAINT AK_Landesname UNIQUE
    );
COMMENT ON COLUMN Laender.ISOCode IS 'Länder.ISOCode müssen dem ISO 3166-1 alpha-2 Standard folgen (z.B. DE, FR, GB, ES)';


/*Wegen Kreisreferenz zwischen Orte-Adressen-Flughaefen wird die Constraint
FK_Orte_Flughafen erst später erstellt*/    
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
ist als Distanz in km zu lesen. Da Länge als messbarer Wert typischerweise 
von stetiger Natur ist wurde an dieser Stelle ein passender Gleitkommadatentyp gewählt.';


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


/* Scharfstellen der FK_Orte_Flughaefen Constraint, da Kreisreferenz nun behoben */   
ALTER TABLE Orte
    ADD CONSTRAINT FK_Orte_Flughafen FOREIGN KEY (Flughafen) REFERENCES Flughaefen(Flughafenname);
COMMENT ON TABLE Orte IS 'Die FK-Constraint FK_Orte_Flughafen wird aufgrund einer 
circulären Dependenz zwischen den Relationen Orte, Adressen, Flughaefen erst nach der vollständigen
Spezifikation dieser drei Relationen auch selbst spezifiziert.';


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
     Größe NUMBER
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
        CONSTRAINT AK_Ferienwohnungen_AdressID UNIQUE
     );


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
COMMENT ON TABLE Bilder IS 'Einer Ferienwohnung können maximal 4 Bilder zugeordnet werden';


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


/* Es ist nur eine Umwandlung von unverbindlichen Reservierungen zu verbindlichen Buchungen möglich  */
/* Die Belegungen einer Ferienwohnung dürfen sich nicht zeitlich überschneiden */


/*Eine Belegung führt nach einer Woche zu einer Rechnung */


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

/*Da die Rechnungaustellung eine Woche nach erfolgter Buchung erfolgt, muss das Rechnungsdatum um 7 Tage größer als 
das Buchungsdatum. Implementierung erfolgt später.*/