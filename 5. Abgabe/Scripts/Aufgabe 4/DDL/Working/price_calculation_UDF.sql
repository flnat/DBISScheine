CREATE OR REPLACE FUNCTION preis(Dauer integer, FerienwohnungsID integer) RETURN NUMBER AS
    price NUMBER(20,4);
    price_daily NUMBER(20,4);
    BEGIN
        SELECT Tagespreis INTO price_daily
        FROM Ferienwohnungen
        WHERE WohnungsID = FerienwohnungsID;
        price := price_daily * Dauer;
        RETURN(price);
    END;
    /