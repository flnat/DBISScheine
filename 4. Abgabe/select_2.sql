select DISTINCT K.KundenID, K.Vorname, K.Nachname, k.Email
from belegungen b, kunden k, ferienwohnungen f
where (b.KundenID = k.KundenID) and
    (b.WohnungsID = f.WohnungsID) and
    (f.wohnungsID = &GewünschteID)
;    