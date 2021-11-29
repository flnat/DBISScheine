/* Selektiere alle Ferienwohnungen mit Schwimmbad die in Zeitintervall vom 01.05.2016 - 21.05.2016 bereits belegt sind*/
ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';
SELECT
    f.WOHNUNGSID,f.BESCHREIBUNGSTEXT, f."GRÖßE", f.TAGESPREIS, o.ORTSNAME, b.Von, b.Bis
FROM
    Ferienwohnungen f, Belegungen b, bietet, Adressen a, Orte o, Laender l
WHERE
    b.WohnungsID = f.WohnungsID AND
    f.AdressID = a.AdressID AND
    a.OrtSID = o.OrtsID AND
    o.Land = l.isocode AND
    f.WohnungsID = bietet.WohnungsID AND
    l.Landesname = 'Türkei' AND
    bietet.Ausstattungsbeschreibung = 'Schwimmbad' AND
    ((b.Von < '01.05.2016' AND b.BIS > '21.05.2016') OR
    (b.VON BETWEEN '01.05.2016' AND '21.05.2016') OR
    (b.BIS BETWEEN '01.05.2016' AND '21.05.2016'))
;