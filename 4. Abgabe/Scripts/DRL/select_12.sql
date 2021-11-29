SELECT f.WOHNUNGSID, f.BESCHREIBUNGSTEXT, o.ORTSNAME, COUNT(*) AS "Anzahl an Belegungen"
FROM Ferienwohnungen f, ADRESSEN a, Orte o, Laender l, Belegungen b
WHERE
    f.ADRESSID = a.ADRESSID AND
    a.ORTSID = o.ORTSID AND
    o.LAND = l.ISOCODE AND
    b.WOHNUNGSID = f.WOHNUNGSID AND
    l.LANDESNAME = 'Frankreich'
HAVING COUNT(*) >
    (SELECT COUNT(*)
    FROM Ferienwohnungen f, ADRESSEN a, Orte o, Laender l, Belegungen b
    WHERE
        f.ADRESSID = a.ADRESSID AND
        a.ORTSID = o.ORTSID AND
        o.LAND = l.ISOCODE AND
        b.WOHNUNGSID = f.WOHNUNGSID AND
        l.LANDESNAME = 'Deutschland'
    )
GROUP BY f.WOHNUNGSID, f.BESCHREIBUNGSTEXT, o.ORTSNAME
ORDER BY COUNT(B.BELEGUNGSNR);
