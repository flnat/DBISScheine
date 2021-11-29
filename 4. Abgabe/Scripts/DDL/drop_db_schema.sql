DROP VIEW Buchungen;
DROP VIEW Reservierungen;
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

/*Entferne die FK Constraint FK_Orte_Flughafen um die circuläre Referenz zu deaktivieren und somit die DDL Statements erfolgreich durchzuführen  */
ALTER TABLE Orte DROP CONSTRAINT FK_Orte_Flughafen;
DROP TABLE wird_angeflogen;
DROP TABLE Fluggesellschaften;
DROP TABLE Flughaefen;
DROP TABLE Adressen;
DROP TABLE kalkulierte_Distanz;
DROP TABLE Orte;
DROP TABLE Laender;
