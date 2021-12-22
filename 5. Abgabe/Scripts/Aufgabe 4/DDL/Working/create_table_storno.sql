CREATE TABLE STORNIERUNGEN(
    StornierungsID INTEGER
        CONSTRAINT PK_STORNIERUNGEN PRIMARY KEY,
    Stornierungsdatum DATE
        NOT NULL,
    BuchungsNr INTEGER
        NOT NULL
        CONSTRAINT AK_STORNIERUNGEN_BUCHUNGSNR UNIQUE,
    BUCHUNGSDATUM DATE
        NOT NULL,
    Buchungszeitraum INTEGER
        NOT NULL
        CONSTRAINT VV_positive_Buchungszeitraum CHECK (Buchungszeitraum >= 0),
    Buchungswert NUMBER(10,4)
        NOT NULL
        CONSTRAINT VV_positive_Buchungswert CHECK (Buchungswert > 0),
    Status VARCHAR2(7)
        NOT NULL,
        CONSTRAINT VV_Range_Status CHECK(Status IN ('bezahlt', 'offen')),
    KUNDENID INTEGER
        NOT NULL,
    Kundenname VARCHAR2(32)
        NOT NULL,
    WOHNUNGSID INTEGER
        NOT NULL,
    BESCHREIBUNG VARCHAR2(1024)
        NOT NULL)
;
