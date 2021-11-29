
/*Selektiert alle Ferienwohnungen in Frankreich mit einem Schwimmbad,
  welche mindestens eine Belegung haben
 */
SELECT DISTINCT f.WOHNUNGSID
FROM
    Adressen a, Orte o, Laender l, bietet,
    Belegungen b, Ferienwohnungen f

WHERE
    b.WohnungsID = f.WohnungsID AND
    f.AdressID = a.AdressID AND
    a.OrtsID = o.OrtsID AND
    o.Land = l.ISOCode AND
    f.WohnungsID = bietet.WohnungsID AND
    l.Landesname = 'Frankreich' AND
    bietet.AUSSTATTUNGSBESCHREIBUNG = 'Schwimmbad';