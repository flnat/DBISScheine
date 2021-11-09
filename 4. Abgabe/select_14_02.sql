SELECT
    laender.landesname, orte.ortsname, fg.gesellschaftsname, fg.rating 
FROM
    Fluggesellschaften fg, Ferienwohnungen, Adressen, Orte, Flughaefen,
    wird_angeflogen, Laender
WHERE 
    (FG.GESELLSCHAFTSNAME = WIRD_ANGEFLOGEN.FLUGGESELLSCHAFT) and
    (WIRD_ANGEFLOGEN.ENDFLUGHAFEN = FLUGHAEFEN.FLUGHAFENNAME) and
    (ORTE.FLUGHAFEN = FLUGHAEFEN.FLUGHAFENNAME) and
    (ADRESSEN.ORTSID = ORTE.ORTSID) and
    (FERIENWOHNUNGEN.ADRESSID = ADRESSEN.ADRESSID) and
    (laender.isocode = orte.land) AND
    (FERIENWOHNUNGEN.WOHNUNGSID = &Wohnung)
ORDER BY
    fg.Rating DESC
FETCH FIRST 1 ROWS ONLY
;