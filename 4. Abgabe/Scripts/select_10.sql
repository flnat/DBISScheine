SELECT l.Landesname, COUNT(b.BelegungsNr) AS "Anzahl der Belegungen"
FROM
    laender l LEFT OUTER JOIN orte o
        ON(l.ISOCode = o.Land)
    LEFT OUTER JOIN Adressen a
        ON(o.OrtsID = a.OrtsID)
    LEFT OUTER JOIN Ferienwohnungen f
        ON(a.AdressID = f.AdressID)
    LEFT OUTER JOIN Belegungen b
        ON(f.WohnungsID = b.WohnungsID)
GROUP BY l.landesname
ORDER BY COUNT(b.BelegungsNr) DESC