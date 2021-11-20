
/*Selektiert alle Ferienwohnungen in Frankreich mit einem Schwimmbad,
  welche mindestens eine Reservierung haben
 */
SELECT f.WOHNUNGSID, o.ORTSNAME, COUNT(*) AS AnzahlBelegungen
FROM
    Adressen a, Orte o, Laender l, bietet,
    Ferienwohnungen f RIGHT OUTER JOIN Belegungen b
        ON(f.WohnungsID = b.WohnungsID)
WHERE
    f.AdressID = a.AdressID AND
    a.OrtsID = o.OrtsID AND
    o.Land = l.ISOCode AND
    f.WohnungsID = bietet.WohnungsID AND
    l.Landesname = 'Frankreich' AND
    bietet.AUSSTATTUNGSBESCHREIBUNG = 'Schwimmbad' AND
    b.BUCHUNGSSTATUS = 'Reservierung'
GROUP BY f.WohnungsID, o.OrtsName
ORDER BY COUNT(*) DESC