DROP TABLE Rechnungen;
DROP TABLE Belegungen;
DROP TABLE Kunden;
DROP TABLE Bankverbindungen;
DROP TABLE Bilder;
DROP TABLE Bietet;
DROP TABLE Zusatzaustattungen;
DROP TABLE Ferienwohnungen;

DROP TABLE Touristenattraktionen;
/* TODO: Warum funktioniert DISABLE CONSTRAINT nicht -->Fragen wann welche Methodik
möglich*/
/*Entferne die  */
ALTER TABLE Orte DROP CONSTRAINT FK_Orte_Flughafen;
DROP TABLE wird_angeflogen;
DROP TABLE Fluggesellschaften;
DROP TABLE Flughaefen;
DROP TABLE Adressen;
DROP TABLE kalkulierte_Distanz;
DROP TABLE Orte;
DROP TABLE Laender;
