SELECT COUNT(b.BelegungsNr) AS Anzahl_der_Belegungen, K.Nachname, K.KundenID
FROM Kunden k, Belegungen b 
WHERE (b.KUNDENID = k.KUNDENID) AND
    (k.NACHNAME = '&gewünschter_Nachname')
GROUP BY k.KundenID, k.Nachname
ORDER BY COUNT(b.BelegungsNr)
;