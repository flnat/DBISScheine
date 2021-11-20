SELECT COUNT(b.BelegungsNr) AS Anzahl_der_Belegungen, K.Nachname, K.Vorname, K.KundenID
FROM Kunden k, Belegungen b 
WHERE (b.KUNDENID = k.KUNDENID) AND
    (k.NACHNAME = '&gew�nschter_Nachname')
GROUP BY k.KundenID, k.Nachname, K.Vorname
ORDER BY COUNT(b.BelegungsNr)
;