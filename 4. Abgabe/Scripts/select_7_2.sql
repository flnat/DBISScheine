/*Selektiere alle Ferienwohnungen in Frankreich mit Schwimmbad die noch keine
  Reservierung haben
 */
SELECT  f.WOHNUNGSID, o.ORTSNAME
FROM
    Ferienwohnungen f, bietet, Adressen a, Orte o, Laender l
WHERE
    f.AdressID = a.AdressID AND
    a.OrtsID = o.OrtsID AND
    o.Land = l.ISOCode AND
    l.Landesname = 'Frankreich' AND
    f.WohnungsID = bietet.WohnungsID AND
    bietet.AUSSTATTUNGSBESCHREIBUNG = 'Schwimmbad' AND
    NOT EXISTS (
    SELECT 1
    FROM Belegungen b
    WHERE b.WohnungsID = f.WohnungsID AND
          b.BUCHUNGSSTATUS = 'Reservierung'
    )