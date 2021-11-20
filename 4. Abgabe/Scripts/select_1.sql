SELECT b.*
    FROM Belegungen b, ferienwohnungen f
    WHERE (f.WohnungsID = b.WohnungsID) AND
        (f.WohnungsID = &GewünschteID)
;
