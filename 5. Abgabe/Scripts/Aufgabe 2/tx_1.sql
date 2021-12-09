SET TRANSACTION NAME  'FeWoInsertion';
    /*INSERT new Adressen tuple */ 
    INSERT INTO Adressen
    VALUES
    ((SELECT MAX(AdressID)+1 FROM ADRESSEN),
    'Highway',
    '6',
    '2349',
    (SELECT o.OrtsID FROM Orte o, Laender l WHERE o.Land = l.IsoCode AND l.Landesname = 'Tuerkei' AND o.OrtsName = 'Oeludeniz'));
             
            
            
    INSERT INTO Ferienwohnungen(WohnungsID, Zimmerzahl, Groesse, Tagespreis, Beschreibungstext, AdressID)
        VALUES(999, 4, 100, 100, ' ', (SELECT MAX(AdressID) FROM Adressen));

    INSERT
    WHEN NOT EXISTS 
        (SELECT 1
        FROM Zusatzaustattungen
        WHERE Beschreibung IN ('Garten', 'Whirlpool'))
    THEN
    INTO ZUSATZAUSTATTUNGEN (Beschreibung)
    (SELECT 'Garten' FROM DUAL) UNION
    (SELECT 'Whirlpool' FROM DUAL);
    



    INSERT INTO bietet(WohnungsID, Ausstattungsbeschreibung)
        ((SELECT 999, 'Garten' FROM DUAL) UNION
        (SELECT 999, 'Whirlpool' FROM DUAL));


COMMIT