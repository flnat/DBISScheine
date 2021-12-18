SET TRANSACTION NAME 'MovingCustomer';

UPDATE KUNDEN
SET
    Telefonnummer = '06221-546372'    
WHERE
    KundenID = 1
    ;
    
UPDATE Adressen
SET
    Strasse = 'Schlossstrasse',
    Hausnummer = '1',
    PLZ = '69115',
    OrtsID = (SELECT OrtsID FROM Orte WHERE OrtsName = 'Heidelberg')
WHERE
    AdressID = (SELECT a.AdressID FROM Kunden k, Adressen A WHERE k.AdressID = a.AdressID AND k.KundenID = 1)
    ;
    


COMMIT;