DROP VIEW Buchung;
DROP VIEW Reservierung;
DROP VIEW Familienwohnungen;
DROP VIEW UebersichtKunden;
DROP VIEW Zahlungsstatus;
DROP VIEW MidAgeKunden;

DROP TABLE Rechnungen;
DROP TABLE Belegungen;
DROP TABLE Kunden;
DROP TABLE Bankverbindungen;
DROP TABLE Bilder;
DROP TABLE Bietet;
DROP TABLE Zusatzaustattungen;
DROP TABLE Ferienwohnungen;
DROP TABLE Touristenattraktionen;
DROP TABLE wird_angeflogen;
DROP TABLE Fluggesellschaften;
ALTER TABLE Orte
    DROP CONSTRAINT FK_Orte_Flughafen;
DROP TABLE Flughaefen;
DROP TABLE Adressen;
DROP TABLE kalkulierte_Distanz;
DROP TABLE Orte;
DROP TABLE Laender;
