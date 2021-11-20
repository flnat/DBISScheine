select DISTINCT K.KundenID, K.Vorname, K.Nachname, k.Email
from belegungen b, kunden k
where (b.KundenID = k.KundenID) and
    (b.wohnungsID = &GewünschteID)
;