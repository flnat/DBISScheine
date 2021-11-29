SELECT COUNT(*) as Anzahl_der_Belegungen
FROM BELEGUNGEN B
WHERE
    B.KundenID = &KundenID
;
