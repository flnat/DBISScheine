SELECT  fg.GESELLSCHAFTSNAME AS Airline, fg.RATING,
wa.STARTFLUGHAFEN AS Fremdflughafen, wa.ENDFLUGHAFEN AS Heimatflughafen
FROM Ferienwohnungen f, Adressen a, Orte o,
    Flughaefen fh, WIRD_ANGEFLOGEN wa, FLUGGESELLSCHAFTEN fg
WHERE 
    f.AdressID = a.AdressID AND
    a.OrtsID = o.OrtsID AND
    o.FLUGHAFEN = fh.FLUGHAFENNAME AND
    wa.Endflughafen = o.FLUGHAFEN AND
    fg.GESELLSCHAFTSNAME = wa.FLUGGESELLSCHAFT AND
    f.WohnungsID = &gegebeneWohnung AND
    wa.Startflughafen IN 
        (SELECT fh_fremd.Flughafenname
        FROM Flughaefen fh_fremd
        WHERE
            NOT EXISTS(
            SELECT fh_fremd.Flughafenname
            FROM Orte InlandsOrte
            WHERE
                fh_fremd.Flughafenname = InlandsOrte.Flughafen AND
                InlandsOrte.Land = o.Land
                ))
            