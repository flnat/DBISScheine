ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';
/*TODO: Sollten Typen bei FK mitdefiniert werden, ist eigentlich ja nicht notwendig */
/*
Legende für Abkürzungen
PK: Primary-Key
FK: Foreign-Key
AK: Alternate-Key
VV: Valid Values


*/
CREATE TABLE Laender
    (ISOCode CHAR(2),
    Landesname VARCHAR2(64) NOT NULL,
    CONSTRAINT PK_Laender PRIMARY KEY (ISOCode),
    CONSTRAINT AK_Landesname UNIQUE (Landesname)
    );
    
/*Wegen Kreisreferenz zwischen Orte-Adressen-Flughaefen wird die Constraint
FK_Orte_Flughafen anfangs disabled*/    
CREATE TABLE Orte
    (OrtsID INTEGER,
    Ortsname VARCHAR2(128) NOT NULL,
    Flughafen VARCHAR2(64) NOT NULL,
    Land NOT NULL,
    CONSTRAINT PK_Orte PRIMARY KEY (OrtsID),
    CONSTRAINT FK_Orte_Laender FOREIGN KEY (Land) REFERENCES Laender(ISOCode)
    );
    
CREATE TABLE kalkulierte_Distanz
    (Startpunkt,
    Endpunkt,
    kalkulierte_Distanz FLOAT DEFAULT NULL,
    CONSTRAINT PK_kalkulierte_Distanz PRIMARY KEY (Startpunkt, Endpunkt),
    CONSTRAINT FK_Startpunkt FOREIGN KEY (Startpunkt) REFERENCES Orte(OrtsID),
    CONSTRAINT FK_Endpunkt FOREIGN KEY (Endpunkt) REFERENCES Orte(OrtsID)
    );
/* Die kalkulierte Distanz ist als Distanz in km zu lesen. Da Länge als messbarer Wert typischerweise 
von stetiger Natur wurde an dieser Stelle ein passender Gleitkommadatentyp gewählt. */
COMMENT ON COLUMN kalkulierte_Distanz.kalkulierte_Distanz IS ' Die kalkulierte Distanz
ist als Distanz in km zu lesen. Da Länge als messbarer Wert typischerweise 
von stetiger Natur ist wurde an dieser Stelle ein passender Gleitkommadatentyp gewählt.';
CREATE TABLE Adressen
    (AdressID INTEGER,
    Strasse VARCHAR2(64) NOT NULL,
    Hausnummer VARCHAR2(4) NOT NULL,
    PLZ VARCHAR2(10) NOT NULL,
    OrtsID NOT NULL,
    CONSTRAINT PK_Adressen PRIMARY KEY (AdressID),
    CONSTRAINT FK_Adressen_Orte FOREIGN KEY (OrtsID) REFERENCES Orte(OrtsID)
    );
    
CREATE TABLE Flughaefen
    (Flughafenname VARCHAR2(64),
    AdressID NOT NULL,
    CONSTRAINT PK_Flughaefen PRIMARY KEY (Flughafenname),
    CONSTRAINT FK_Flughafen_Adressen FOREIGN KEY (AdressID) REFERENCES Adressen(AdressID),
    CONSTRAINT AK_Flughaefen_AdressID UNIQUE (AdressID)
    );
    
/* Scharfstellen der FK_Orte_Flughaefen Constraint, da Kreisreferenz nun behoben */   
ALTER TABLE Orte
    ADD CONSTRAINT FK_Orte_Flughafen FOREIGN KEY (Flughafen) REFERENCES Flughaefen(Flughafenname);
COMMENT ON TABLE Orte IS 'Die FK-Constraint FK_Orte_Flughafen wird aufgrund einer 
circulären Dependenz zwischen den Relationen Orte, Adressen, Flughaefen erst nach der vollständigen
Spezifikation dieser drei Relationen auch selbst spezifiziert.';



CREATE TABLE Touristenattraktionen
    (Name_der_Attraktion VARCHAR2(64),
    Beschreibung VARCHAR2(256) NOT NULL,
    AdressID NOT NULL,
    CONSTRAINT PK_Touristenattraktionen PRIMARY KEY (Name_der_Attraktion),
    CONSTRAINT FK_Touristenattraktionen_Adressen FOREIGN KEY (AdressID) REFERENCES Adressen(AdressID),
    CONSTRAINT AK_Touristenattraktionen_AdressID UNIQUE (AdressID)
    );
    
CREATE TABLE Fluggesellschaften
    (Gesellschaftsname VARCHAR2(64),
    Rating INTEGER NOT NULL,
    CONSTRAINT PK_Fluggesellschaften PRIMARY KEY (Gesellschaftsname),
    CONSTRAINT VV_FluggesellschaftenRating CHECK (Rating BETWEEN 1 AND 10)
    );

CREATE TABLE wird_angeflogen
    (Startflughafen,
    Endflughafen,
    Fluggesellschaft,
    CONSTRAINT PK_wirdangeflogen PRIMARY KEY (Startflughafen, Endflughafen, Fluggesellschaft),
    CONSTRAINT FK_Startflughafen FOREIGN KEY (Startflughafen) REFERENCES Flughaefen(Flughafenname),
    CONSTRAINT FK_Endflughafen FOREIGN KEY (Endflughafen) REFERENCES Flughaefen(Flughafenname),
    CONSTRAINT FK_Fluggesellschaft FOREIGN KEY (Fluggesellschaft) REFERENCES Fluggesellschaften(Gesellschaftsname)
    );
    
CREATE TABLE Ferienwohnungen
    (WohnungsID INTEGER,
     Größe NUMBER NOT NULL,
     Zimmerzahl INTEGER NOT NULL,
     Tagespreis NUMBER(20,4) NOT NULL,
     Beschreibungstext VARCHAR2(1024) NOT NULL,
     AdressID NOT NULL,
     CONSTRAINT PK_Ferienwohnungen PRIMARY KEY (WohnungsID),
     CONSTRAINT FK_Ferienwohnungen_Adressen FOREIGN KEY (AdressID) REFERENCES Adressen(AdressID),
     CONSTRAINT AK_Ferienwohnungen_AdressID UNIQUE (AdressID)
     );

CREATE TABLE Zusatzaustattungen
    (Beschreibung VARCHAR2(256),
    CONSTRAINT PK_Zusatzaustattungen PRIMARY KEY (Beschreibung)
    );    
    
CREATE TABLE bietet
    (WohnungsID,
    Ausstattungsbeschreibung,
    CONSTRAINT PK_bietet PRIMARY KEY (WohnungsID, Ausstattungsbeschreibung),
    CONSTRAINT FK_bietet_Ferienwohnungen FOREIGN KEY (WohnungsID) REFERENCES Ferienwohnungen(WohnungsID),
    CONSTRAINT FK_bietet_Zusatzaustattungen FOREIGN KEY (Ausstattungsbeschreibung) REFERENCES
    Zusatzaustattungen(Beschreibung)
    );
    
CREATE TABLE Bilder
    (DateiID INTEGER,
    Bildbeschreibung VARCHAR2(128) NOT NULL,
    DateiPfad VARCHAR2(256) NOT NULL,
    WohnungsID NOT NULL,
    CONSTRAINT PK_Bilder PRIMARY KEY (DateiID),
    CONSTRAINT FK_Bilder_Ferienwohnungen FOREIGN KEY (WohnungsID) REFERENCES Ferienwohnungen(WohnungsID)
    );
    
CREATE TABLE Bankverbindungen
    (IBAN CHAR(22),
    BIC CHAR(11) NOT NULL,
    Kontonummer CHAR(7) NOT NULL,
    BLZ CHAR(8) NOT NULL,
    CONSTRAINT PK_Bankverbindungen PRIMARY KEY (IBAN),
    CONSTRAINT AK_Bankverbindungen UNIQUE (Kontonummer, BLZ)
    );   
    
CREATE TABLE Kunden
    (KundenID INTEGER,
    Email VARCHAR2(64) NOT NULL,
    Telefonnummer VARCHAR2(32) NOT NULL,
    Geburtsdatum DATE NOT NULL,
    Vorname VARCHAR2(32) NOT NULL, 
    Nachname VARCHAR2(32) NOT NULL, 
    AdressID NOT NULL,
    IBAN NOT NULL,
    CONSTRAINT PK_Kunden PRIMARY KEY (KundenID),
    CONSTRAINT FK_Kunden_Adressen FOREIGN KEY (AdressID) REFERENCES Adressen(AdressID),
    CONSTRAINT FK_Kunden_Bankverbindungen FOREIGN KEY (IBAN) REFERENCES Bankverbindungen(IBAN),
    CONSTRAINT AK_Kunden_Email UNIQUE (Email),
    CONSTRAINT AK_Kunden_IBAN UNIQUE (IBAN),
    CONSTRAINT AK_Kunden_AdressID UNIQUE(AdressID)
    );   

CREATE TABLE Belegungen
    (BelegungsNr INTEGER,
    Buchungsdatum DATE NOT NULL,
    Von DATE NOT NULL,
    Bis DATE NOT NULL,
    Buchungsstatus VARCHAR2(16) NOT NULL,
    WohnungsID NOT NULL,
    KundenID NOT NULL,
    CONSTRAINT PK_Belegungen PRIMARY KEY (BelegungsNr),
    CONSTRAINT FK_Belegungen_Ferienwohnungen FOREIGN KEY (WohnungsID) REFERENCES Ferienwohnungen(WohnungsID),
    CONSTRAINT FK_Belegungen_Kunden FOREIGN KEY (KundenID) REFERENCES Kunden(KundenID)
    );

CREATE TABLE Rechnungen
    (RechnungsNr INTEGER,
    Rechnungsbetrag NUMBER(10,4) NOT NULL,
    Rechnungsdatum DATE NOT NULL,
    Zahlungseingang DATE,
    Rechnungsstatus VARCHAR2(16) NOT NULL,
    BelegungsNr NOT NULL,
    CONSTRAINT PK_Rechnungen PRIMARY KEY (RechnungsNr),
    CONSTRAINT FK_Rechnungen_Belegungen FOREIGN KEY (BelegungsNr) REFERENCES Belegungen(BelegungsNr),
    CONSTRAINT AK_Rechnungen_BelegungsNr UNIQUE (BelegungsNr),
    CONSTRAINT VV_RechnungenRechnungstatus CHECK (Rechnungsstatus IN ('beglichen', 'offen'))
    );

