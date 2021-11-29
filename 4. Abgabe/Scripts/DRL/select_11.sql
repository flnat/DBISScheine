/*Klären ob SUM(CASE WHEN THEN ELSE END) erlaubt */
SELECT
    f.WohnungsID,
    SUM(CASE WHEN b.Buchungsstatus = 'Reservierung' THEN 1 ELSE 0 END) AS "Anzahl Reservierungen",
    SUM(CASE WHEN b.Buchungsstatus = 'Buchung' THEN 1 ELSE 0 END) AS "Anzahl Buchungen"
FROM
    Ferienwohnungen f LEFT OUTER JOIN Belegungen b
    ON f.WohnungsID = b.WohnungsID
GROUP BY f.WohnungsID
ORDER BY f.WohnungsID ASC;