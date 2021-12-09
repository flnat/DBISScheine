ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';
/*Relation Laender */
INSERT INTO Laender (isocode, landesname)
    VALUES('DE', 'Deutschland');
INSERT INTO Laender (isocode, Landesname)
    VALUES('CH', 'Schweiz');
INSERT INTO Laender (isocode, landesname)
    VALUES('TR', 'Tuerkei');
INSERT INTO Laender (isocode, landesname)
    VALUES('FR', 'Frankreich');
INSERT INTO Laender (isocode, landesname)
    VALUES('ES', 'Spanien');
INSERT INTO Laender (isocode, landesname)
    VALUES('GL', 'Groenland');

/*Relation Orte */
/*Disable FK Constraint to circumvent circular FK References */

INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (1,'Konstanz', 'Frankfurt', 'DE');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (2, 'Stuttgart', 'Frankfurt', 'DE');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (3, 'Heidelberg', 'Frankfurt', 'DE');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (4, 'Rust', 'Frankfurt', 'DE');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (5, 'Frankfurt', 'Frankfurt', 'DE');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (6, 'Bern', 'Zuerich', 'CH');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (7, 'Zuerich', 'Zuerich', 'CH');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (8, 'Chur', 'Zuerich', 'CH');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (9, 'Flims-Laax', 'Zuerich', 'CH');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (10, 'Istanbul', 'Istanbul', 'TR');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (11, 'Oeludeniz', 'Istanbul', 'TR');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (12, 'Antalya', 'Istanbul', 'TR');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (13, 'Bordeaux', 'Paris', 'FR');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (14, 'Paris', 'Paris', 'FR');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (15, 'Disneyland', 'Paris', 'FR');
INSERT INTO Orte (OrtsID, Ortsname, Flughafen, Land)
    VALUES (16, 'Barcelona', 'Barcelona', 'ES');

    
/*Relation Adressen*/
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(1, 'Am Flughafen', '2', '60541', 5);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(2, 'Sabiha Goekcen', '1', '1452', 10);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(3, 'Flughafen-Allee', '100', '5098', 7);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(4, 'Charles de Gaulle', '1', '8792', 14);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(5, 'Aeropuerto de Barcelona', '10', '8792', 16);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(6, 'Europapark', '1', '78231', 4);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(7, 'Seestr.', '12', '78463', 1);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(8, 'Bergweg', '78', '2371', 9);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(9, 'GreenOne', '29', '1352', 7);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(10, 'rue de gaulle', '10', '8787', 15);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(11, 'Highway', '5', '2349', 11);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(12, 'Markgrafenstr.', '33', '78461', 1);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(13, 'Zur Piste', '189', '2234', 8);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(14, 'rue Monsieur', '980', '8234', 13);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(15, 'rue de gaulle', '22', '8787', 15);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(16, 'rue de la Maison Blanche', '32', '8792', 14);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(17, 'rue liberte', '78', '8792', 14);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(18, 'Strandweg', '90', '2321', 12);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(19, 'Strandweg', '91', '2321', 12);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(20, 'Calle del torro', '821', '5221', 16);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(21, 'Strandweg', '45', '2321', 12);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(22, 'Reutestr.', '104', '78467', 1);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(23, 'Hauptstr.', '12', '69115', 3);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(24, 'Schlossstr.', '54', '70137', 2);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(25, 'Alpenstr.', '11', '3001', 6);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(26, 'Seeweg', '23', '8001', 7);
INSERT INTO Adressen (AdressID, Strasse, Hausnummer, PLZ, OrtsID)
    VALUES(27, 'Rheingutstr.', '14', '78462', 1);


/*Relation Flughaefen*/
INSERT INTO Flughaefen (Flughafenname, AdressID)
    VALUES('Frankfurt', 1);
INSERT INTO Flughaefen (Flughafenname, AdressID)
    VALUES('Istanbul', 2);
INSERT INTO Flughaefen (Flughafenname, AdressID)
    VALUES('Zuerich', 3);
INSERT INTO Flughaefen (Flughafenname, AdressID)
    VALUES('Paris', 4);
INSERT INTO Flughaefen (Flughafenname, AdressID)
    VALUES('Barcelona', 5);
    
/*Nachdem die Relation Flughaefen nun erstellt ist, kann die Constraint FK_Orte_Flughaefen
ohne Vereltzung wieder scharf gestellt werden.*/


/*Relation Touristenattraktion*/
INSERT INTO Touristenattraktionen (Name_der_Attraktion, Beschreibung, AdressID)
    VALUES('Europapark', 'Freizeitpark - Deutschlands Nr. 1', 6);
INSERT INTO Touristenattraktionen (Name_der_Attraktion, Beschreibung, AdressID)
    VALUES('Hoernle', 'Badestrand - Bodensee-Strandbad', 7);
INSERT INTO Touristenattraktionen (Name_der_Attraktion, Beschreibung, AdressID)
    VALUES('Flims-Laax Arena', 'Skigebiet', 8);
INSERT INTO Touristenattraktionen (Name_der_Attraktion, Beschreibung, AdressID)
    VALUES('GreenOne', 'Golfplatz', 9);
INSERT INTO Touristenattraktionen (Name_der_Attraktion, Beschreibung, AdressID)
    VALUES('Disneyland', 'Freizeitpark', 10);

/*Relation Fluggesellschaften */
INSERT INTO Fluggesellschaften (Gesellschaftsname, Rating)
    VALUES('Lufthansa', 1);
INSERT INTO Fluggesellschaften (Gesellschaftsname, Rating)
    VALUES('German Wings', 4);
INSERT INTO Fluggesellschaften (Gesellschaftsname, Rating)
    VALUES('Thomas Cook', 8);
INSERT INTO Fluggesellschaften (Gesellschaftsname, Rating)
    VALUES('Hapag Lloyd', 9);
INSERT INTO Fluggesellschaften (Gesellschaftsname, Rating)
    VALUES('Swiss', 8);

/*Relation wird_angeflogen */
INSERT INTO wird_angeflogen (Startflughafen, Endflughafen, Fluggesellschaft)
    VALUES('Frankfurt', 'Barcelona', 'Lufthansa');
INSERT INTO wird_angeflogen (Startflughafen, Endflughafen, Fluggesellschaft)
    VALUES('Frankfurt', 'Istanbul', 'German Wings');
INSERT INTO wird_angeflogen (Startflughafen, Endflughafen, Fluggesellschaft)
    VALUES('Frankfurt', 'Paris', 'German Wings');
INSERT INTO wird_angeflogen (Startflughafen, Endflughafen, Fluggesellschaft)
    VALUES('Frankfurt', 'Paris', 'Lufthansa');
INSERT INTO wird_angeflogen (Startflughafen, Endflughafen, Fluggesellschaft)
    VALUES('Frankfurt', 'Paris', 'Thomas Cook');
INSERT INTO wird_angeflogen (Startflughafen, Endflughafen, Fluggesellschaft)
    VALUES('Istanbul', 'Barcelona', 'Thomas Cook');
INSERT INTO wird_angeflogen (Startflughafen, Endflughafen, Fluggesellschaft)
    VALUES('Paris', 'Barcelona', 'Hapag Lloyd');
INSERT INTO wird_angeflogen (Startflughafen, Endflughafen, Fluggesellschaft)
    VALUES('Paris', 'Zuerich', 'German Wings');

/*Relation Bankverbindungen*/
INSERT INTO Bankverbindungen (IBAN, BIC, Kontonummer, BLZ)
    VALUES('DE85692717230007823212', 'KARSDE66XXX', '7823212', '69271723');
INSERT INTO Bankverbindungen (IBAN, BIC, Kontonummer, BLZ)
    VALUES('DE83692717230008929368', 'BARSDE77XXX', '8929368', '32793968');
INSERT INTO Bankverbindungen (IBAN, BIC, Kontonummer, BLZ)
    VALUES('DE85692717230001347291', 'KARSDE66XXX', '1347291', '69271723');
INSERT INTO Bankverbindungen (IBAN, BIC, Kontonummer, BLZ)
    VALUES('CH85692717230008792978', 'MEMECH88XXX', '8792978', '29788431');
INSERT INTO Bankverbindungen (IBAN, BIC, Kontonummer, BLZ)
    VALUES('CH85692717230009082780', 'KONSCH12XXX', '9082780', '87890271');
INSERT INTO Bankverbindungen (IBAN, BIC, Kontonummer, BLZ)
    VALUES('DE85692717230007322890', 'KARSDE66XXX', '7322890', '69271723');
    
/*Relation Kunden */
/*Wegen Tab bei Meier mail fragen */
INSERT INTO KUNDEN (KundenID, Email, Telefonnummer, Geburtsdatum, Vorname, Nachname, AdressID, IBAN)
    VALUES(1,'knapf@gmx.de', '07531-123456', '01.01.1960', 'Karl', 'Napf',22,'DE85692717230007823212');
INSERT INTO KUNDEN (KundenID, Email, Telefonnummer, Geburtsdatum, Vorname, Nachname, AdressID, IBAN)
    VALUES(2, 'meiers.hans@t-online.de', '06221-999888', '02.01.1975', 'Hans', 'Meier',23 ,'DE83692717230008929368');    
INSERT INTO KUNDEN (KundenID, Email, Telefonnummer, Geburtsdatum, Vorname, Nachname, AdressID, IBAN)
    VALUES(3, 'huber@t-online.de', '0711-554673', '03.01.1980', 'Franz', 'Huber', 24,'DE85692717230001347291');
INSERT INTO KUNDEN (KundenID, Email, Telefonnummer, Geburtsdatum, Vorname, Nachname, AdressID, IBAN)
    VALUES(4, 'eber@bluewin.ch', '+41-171-9864785', '04.01.1985', 'Klaus', 'Eber', 25, 'CH85692717230008792978');
INSERT INTO KUNDEN (KundenID, Email, Telefonnummer, Geburtsdatum, Vorname, Nachname, AdressID, IBAN)
    VALUES(5, 'meier@gmail. com', '+41-171-9864786', '05.01.1990', 'Egon', 'Meier', 26, 'CH85692717230009082780');
INSERT INTO KUNDEN (KundenID, Email, Telefonnummer, Geburtsdatum, Vorname, Nachname, AdressID, IBAN)
    VALUES(6, 'jim.knopf@gmx.net', '0171-9876543', '06.01.1995', 'Jim', 'Knopf', 27, 'DE85692717230007322890');

/*Relation Ferienwohnungen*/
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(1,200, 6, 349, 'Finka', 11);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(2, 45, 2, 120, 'Ferienwohnung mit Seeblick', 12);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(3, 150, 3, 249, 'im Schnee', 13);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(4, 100, 4, 249, 'direkt am Meer', 14);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(5, 110, 3, 289, 'direkt am Park', 15);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(6, 70, 2, 549, 'mit Blick auf Eifelturm', 16);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(7, 110, 6, 159, 'Dachterrassewohnung zentral', 17);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(8, 200, 12, 240, 'zweigeschoessiges Haus', 18);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(9, 111, 5, 159, 'Topvilla am Strand', 19);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(10, 100, 4, 299, 'Ferienhaus am Strand', 20);
INSERT INTO Ferienwohnungen (WohnungsID, Groesse, Zimmerzahl, Tagespreis, Beschreibungstext, AdressID)
    VALUES(11, 100, 4, 150, 'Strandbungalow', 21);

/*Relation Bilder*/
INSERT INTO Bilder (DateiID, WohnungsID, Bildbeschreibung, Dateipfad)
    VALUES(1, 1, 'Innenansicht', '1_1.jpg');
INSERT INTO Bilder (DateiID, WohnungsID, Bildbeschreibung, Dateipfad)
    VALUES(2, 1, 'Ausenansicht', '1_2.jpg');
INSERT INTO Bilder (DateiID, WohnungsID, Bildbeschreibung, Dateipfad)
    VALUES(3, 5, 'Garage', '5_1.gif');
INSERT INTO Bilder (DateiID, WohnungsID, Bildbeschreibung, Dateipfad)
    VALUES(4, 8, 'Dachterrasse', '8.jpg');
    
/*Relation Zusatzausttatungen*/
INSERT INTO Zusatzaustattungen (Beschreibung)
    VALUES('Schwimmbad');
INSERT INTO Zusatzaustattungen (Beschreibung)
    VALUES('Sauna');
INSERT INTO Zusatzaustattungen (Beschreibung)
    VALUES('Autoabstellplatz');
INSERT INTO Zusatzaustattungen (Beschreibung)
    VALUES('Aufzug');
INSERT INTO Zusatzaustattungen (Beschreibung)
    VALUES('Kinderbetreuung');
INSERT INTO Zusatzaustattungen (Beschreibung)
    VALUES('SAT-TV');
INSERT INTO Zusatzaustattungen (Beschreibung)
    VALUES('Reinigung');
INSERT INTO Zusatzaustattungen (Beschreibung)
    VALUES('Dachterrasse');
INSERT INTO Zusatzaustattungen (Beschreibung)
    VALUES('Garage');
    
/*Relation bietet*/
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(1, 'Schwimmbad');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(1, 'Sauna');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(2, 'Autoabstellplatz');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(2, 'Aufzug');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(3, 'Sauna');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(5, 'Kinderbetreuung');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(5, 'Schwimmbad');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(6, 'Schwimmbad');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(7, 'Schwimmbad');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(8, 'SAT-TV');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(8, 'Reinigung');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(8, 'Dachterrasse');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(9, 'Garage');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(9, 'Schwimmbad');
INSERT INTO Bietet (WohnungsID, Ausstattungsbeschreibung)
    VALUES(11, 'Schwimmbad');
    
/* Relation Belegungen */
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(1, '12.02.2016', '11.03.2016', '13.03.2016', 'Buchung', 4, 2);
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(2, '13.03.2016', '11.05.2016', '17.05.2016', 'Reservierung', 5, 2);
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(3, '10.02.2016', '03.04.2016', '23.04.2016', 'Reservierung', 5, 3);
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(4, '09.02.2016', '04.07.2016', '05.07.2016', 'Buchung', 6, 4);
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(5, '14.02.2016', '28.04.2016', '02.05.2016', 'Reservierung', 10, 2);
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(6, '18.02.2016', '04.05.2016', '22.05.2016', 'Buchung', 8, 3);
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(7, '01.02.2016', '07.05.2016', '08.05.2016', 'Buchung', 2, 1);
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(8, '11.02.2016', '22.05.2016', '28.05.2016', 'Buchung', 9, 5);
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(9, '07.02.2016', '03.07.2016', '08.07.2016', 'Buchung', 10, 5);
INSERT INTO Belegungen(BelegungsNr, Buchungsdatum, Von, Bis, Buchungsstatus, WohnungsID, KundenID)
    VALUES(10, '10.02.2016', '01.05.2016', '24.05.2016', 'Reservierung', 1, 4);
    
/*Relation Rechnungen*/
INSERT INTO Rechnungen(RechnungsNr, Rechnungsdatum, Rechnungsstatus, Rechnungsbetrag, Zahlungseingang, BelegungsNr)
    VALUES(1, '15.03.2016', 'beglichen', 498, '18.03.2016', 1);
INSERT INTO Rechnungen(RechnungsNr, Rechnungsdatum, Rechnungsstatus, Rechnungsbetrag, Zahlungseingang, BelegungsNr)
    VALUES(2, '26.02.2016', 'offen', 549, null, 4);

/*Relation kalkulierte_Distanz*/
INSERT INTO kalkulierte_Distanz (Startpunkt, Endpunkt, kalkulierte_Distanz)
	VALUES(1, 4, 180);
INSERT INTO kalkulierte_Distanz (Startpunkt, Endpunkt, kalkulierte_Distanz)
	VALUES(3, 7, 120);
INSERT INTO kalkulierte_Distanz (Startpunkt, Endpunkt, kalkulierte_Distanz)
	VALUES(8, 9, 40);
INSERT INTO kalkulierte_Distanz (Startpunkt, Endpunkt, kalkulierte_Distanz)
	VALUES(13, 15, 420);
INSERT INTO kalkulierte_Distanz (Startpunkt, Endpunkt, kalkulierte_Distanz)
	VALUES(14, 15, 30);

COMMIT;