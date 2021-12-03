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
                ));

SELECT
    fg.Gesellschaftsname AS Airline, fg.Rating,
    wa.Startflughafen AS Fremdflughafen, wa.Endflughafen AS Heimatflughafen
FROM
    Ferienwohnungen f, Adressen a, Orte o, Flughaefen fh, Fluggesellschaften fg,
    wird_angeflogen wa, Orte o_Ausland, Adressen a_Ausland, Flughaefen fh_Ausland
WHERE
    f.WohnungsID = &gegebeneWohnung AND
    f.AdressID = a.AdressID AND
    a.OrtsID = o.OrtsID AND
    o.Flughafen = fh.Flughafenname AND
    wa.Endflughafen = fh.Flughafenname AND
    fg.Gesellschaftsname = wa.Fluggesellschaft AND
    o.OrtsID <> o_Ausland.OrtsID AND
    o_Ausland.OrtsID = a_Ausland.OrtsID AND
    a_Ausland.AdressID = fh_Ausland.AdressID AND
    wa.Startflughafen = fh_Ausland.Flughafenname;