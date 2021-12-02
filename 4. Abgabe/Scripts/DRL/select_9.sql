/* Selektiere alle Ferienwohnungen mit Schwimmbad die in Zeitintervall vom 01.05.2016 - 21.05.2016 bereits belegt sind*/
ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';
SELECT
    f.WOHNUNGSID,f.BESCHREIBUNGSTEXT, f.Groesse, f.TAGESPREIS, o.ORTSNAME, b.Von, b.Bis
FROM
    Ferienwohnungen f LEFT OUTER JOIN Belegungen b
        ON f.WohnungsID = b.WohnungsID,
    bietet, Adressen a, Orte o, Laender l
WHERE
    f.AdressID = a.AdressID AND
    a.OrtsID = o.OrtsID AND
    o.Land = l.isocode AND
    f.WohnungsID = bietet.WohnungsID AND
    l.Landesname = 'Tuerkei' AND
    bietet.Ausstattungsbeschreibung = 'Schwimmbad' AND
    ((NOT (b.Von < '01.05.2016' AND
    b.BIS > '21.05.2016') AND
    b.VON NOT BETWEEN '01.05.2016' AND '21.05.2016' AND
    b.BIS NOT BETWEEN '01.05.2016' AND '21.05.2016')
    OR 
    NOT EXISTS (
    SELECT b.BelegungsNr
    FROM Belegungen b
    WHERE b.WohnungsID = f.WohnungsID
    ));