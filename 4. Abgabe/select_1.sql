SELECT b.BelegungsNr,b.Buchungsdatum, b.Von, b.Bis, b.Buchungsstatus
    FROM Belegungen b, ferienwohnungen f
    WHERE (f.WohnungsID = b.WohnungsID) AND
        (f.WohnungsID = &GewŁnschteID)
    ORDER BY b.Buchungsstatus ASC
;
