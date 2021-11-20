SELECT
    f.WohnungsID, f.Beschreibungstext AS Wohnungsbeschreibung,
    f.Größe, f.Tagespreis,
    o.Ortsname AS Ortschaft,
    kd.kalkulierte_Distanz AS Entfernung
FROM
    Orte o LEFT OUTER JOIN kalkulierte_Distanz kd ON
         (o.OrtsID = kd.Startpunkt),
    Adressen a, Touristenattraktionen t,
    Orte TouristenOrte, Adressen TouristenAdressen,
    Ferienwohnungen f, Laender l
WHERE
    f.AdressID = a.AdressID AND
    a.OrtsID = o.OrtsID AND
    o.Land = l.IsoCode AND
    l.Landesname = 'Frankreich' AND
    t.Name_der_Attraktion = 'Disneyland'
    AND(
    (t.AdressID = Touristenadressen.AdressID AND
    TouristenOrte.OrtsID = Touristenadressen.OrtsID AND
    kd.Startpunkt = o.OrtsID AND
    kd.Endpunkt = TouristenOrte.OrtsID AND
    kd.kalkulierte_Distanz <= 100)
    OR
    (o.OrtsName = 'Disneyland' AND
    Touristenorte.OrtsID = o.OrtsID AND
    TouristenAdressen.AdressID = a.AdressID)
    )
ORDER BY  kd.kalkulierte_Distanz, f.Tagespreis ASC  NULLS LAST