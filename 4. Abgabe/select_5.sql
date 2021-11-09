SELECT
    FERIENWOHNUNGEN.WOHNUNGSID, FERIENWOHNUNGEN.BESCHREIBUNGSTEXT, ORTE.ORTSNAME, ADRESSEN.STRASSE,
    ADRESSEN.HAUSNUMMER, KALKULIERTE_DISTANZ.KALKULIERTE_DISTANZ
FROM Ferienwohnungen, Adressen, Orte, kalkulierte_Distanz, LAENDER
WHERE
    (Ferienwohnungen.AdressID = Adressen.AdressID) AND
    (Adressen.OrtsID = Orte.OrtsID) AND
    (kalkulierte_Distanz.Startpunkt = Orte.OrtsID) AND
    (ORTE.LAND = LAENDER.ISOCODE) AND
    (LAENDER.LANDESNAME = 'Frankreich') AND
    (kalkulierte_Distanz.KALKULIERTE_DISTANZ <= 100)
ORDER BY KALKULIERTE_DISTANZ ASC;
    
