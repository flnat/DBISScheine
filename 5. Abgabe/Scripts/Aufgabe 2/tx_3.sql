SET TRANSACTION NAME 'FeWoDeletion';
DELETE FROM Ferienwohnungen WHERE WohnungsID = 4;
DELETE FROM Adressen WHERE AdressID = 
    (SELECT a.AdressID FROM Adressen a, Ferienwohnungen f WHERE f.adressID = a.AdressID AND f.WohnungsID = 4);
COMMIT;