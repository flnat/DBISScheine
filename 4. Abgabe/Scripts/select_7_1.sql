/*Selektiere alle Ferienwohnungen in Frankreich mit Schwimmbad, für dich noch keine Belegung existiert.*/

SELECT
    Ferienwohnungen.WohnungsID, Ferienwohnungen.Beschreibungstext
FROM
    Ferienwohnungen 
        LEFT JOIN Belegungen ON Ferienwohnungen.WohnungsID = Belegungen.WohnungsID,
    bietet, Laender, Orte, Adressen
WHERE
    (Ferienwohnungen.WohnungsID = Belegungen.WohnungsID) AND
    (Ferienwohnungen.WohnungsID = bietet.Ausstattungsbeschreibung) AND
    (Adressen.AdressID = Ferienwohnungen.AdressID) AND
    (Orte.OrtsID = Adressen.OrtsID) AND
    (Laender.ISOCode = Orte.Land) AND
    Laender.ISOCode = 'FR' AND
    bietet.AUSSTATTUNGSBESCHREIBUNG = 'Schwimmbad'
ORDER BY Ferienwohnungen.WohnungsID