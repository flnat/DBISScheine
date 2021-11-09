SELECT COUNT(B.BelegungsNr) as Anzahl_der_Belegungen, K.KundenID, K.Vorname, K.Nachname
FROM BELEGUNGEN B, Kunden K
WHERE
    K.KundenID = B.KundenID AND
    K.Vorname = '&gewünschterName'
GROUP BY K.KundenID, K.Vorname, K.Nachname
;