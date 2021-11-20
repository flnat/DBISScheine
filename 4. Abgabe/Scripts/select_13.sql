SELECT DISTINCT fg.GESELLSCHAFTSNAME AS Airline, fg.RATING, wa.STARTFLUGHAFEN, wa.ENDFLUGHAFEN
FROM
    Ferienwohnungen f, Adressen a, Orte o, Laender l,
    Flughaefen fh, WIRD_ANGEFLOGEN wa, FLUGGESELLSCHAFTEN fg,
    Laender Ausland, FLughaefen fh_fremd, Orte o_fremd
WHERE
    f.AdressID = a.AdressID AND
    a.OrtsID = o.OrtsID AND
    o.Land = l.ISOCode AND
    o.FLUGHAFEN = fh.FLUGHAFENNAME AND
    wa.Endflughafen = o.FLUGHAFEN AND
    Ausland.ISOCODE <> l.ISOCODE AND
    o_fremd.LAND = Ausland.ISOCODE AND
    o_fremd.FLUGHAFEN = fh_fremd.FLUGHAFENNAME AND
    wa.STARTFLUGHAFEN = fh_fremd.FLUGHAFENNAME AND
    fg.GESELLSCHAFTSNAME = wa.FLUGGESELLSCHAFT AND
    f.WohnungsID = &gegebeneWohnung