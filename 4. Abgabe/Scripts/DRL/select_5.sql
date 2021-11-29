
((
    SELECT
    f.WohnungsID, f.Beschreibungstext AS Wohnungsbeschreibung,
    f.Größe, f.Tagespreis,
    o.Ortsname AS Ortschaft,
    kd.kalkulierte_Distanz AS Entfernung
    FROM
        Ferienwohnungen f, Adressen a, Orte o, Laender l,
        kalkulierte_Distanz kd,
        Touristenattraktionen t, Adressen t_a, Orte t_o
    WHERE
        f.AdressID = a.AdressID AND
        a.OrtsID = o.OrtsID AND
        o.Land = l.ISOCode AND
        t.AdressID = t_a.AdressID AND
        t_a.OrtsID = t_o.OrtsID AND
        l.Landesname = 'Frankreich' AND
        t.Name_der_Attraktion = 'Disneyland' AND
        kd.kalkulierte_Distanz <= 100         
        AND
        ((
        kd.Startpunkt = o.OrtsID AND
        kd.Endpunkt = t_o.OrtsID
        )
        OR
        (
        kd.Startpunkt = t_o.OrtsID AND
        kd.Endpunkt = o.OrtsID
        ))
)        
UNION
(
    SELECT
        f.WohnungsID, f.Beschreibungstext AS Wohnungsbeschreibung,
        f.Größe, f.Tagespreis,
        o.Ortsname AS Ortschaft,
        kd.kalkulierte_Distanz AS Entfernung
    FROM
        Ferienwohnungen f, Adressen a, laender l,
        Orte o LEFT OUTER JOIN kalkulierte_Distanz kd
            ON (o.OrtsID = kd.Startpunkt),
        Touristenattraktionen t, Adressen t_a, Orte t_o
    WHERE
        f.AdressID = a.AdressID AND
        a.OrtsID = o.OrtsID AND
        o.Land = l.ISOCode AND
        t_a.AdressID = t.AdressID AND
        t_o.OrtsID = t_a.OrtsID AND
        o.OrtsID = t_o.OrtsID AND
        t.Name_der_Attraktion = 'Disneyland' AND
        l.Landesname = 'Frankreich'
        ))
        ORDER BY WohnungsID