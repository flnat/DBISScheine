SELECT COUNT(*) AS Anzahl_der_Belegungen, K.KundenID
FROM Kunden k, Belegungen b     
WHERE (b.KUNDENID = k.KUNDENID) AND
    (k.NACHNAME = '&gew�nschter_Nachname') AND
    b.Buchungsstatus = 'Buchung'
GROUP BY k.KundenID
ORDER BY COUNT(*)
;