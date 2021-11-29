/*Selektiere alle Ferienwohnungen in Frankreich mit Schwimmbad die noch keine
  Belegung haben
 */
SELECT  f.WOHNUNGSID
FROM
    Ferienwohnungen f, bietet, Adressen a, Orte o, Laender l
WHERE
    f.AdressID = a.AdressID AND
    a.OrtsID = o.OrtsID AND
    o.Land = l.ISOCode AND
    f.WohnungsID = bietet.WohnungsID AND
    l.Landesname = 'Frankreich' AND
    bietet.AUSSTATTUNGSBESCHREIBUNG = 'Schwimmbad' AND
    NOT EXISTS (
        SELECT b.BelegungsNr
        FROM Belegungen b
        WHERE b.WohnungsID = f.WohnungsID
    );