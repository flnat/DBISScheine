CREATE TABLE Test_A
    (
    A INTEGER,
    B INTEGER,
    CONSTRAINT PK_Test_A PRIMARY KEY (A, B)
    );
    
CREATE TABLE Test_B
    (
    C INTEGER 
        CONSTRAINT PK_Test_B PRIMARY KEY,
    A INTEGER
        NOT NULL,
    B INTEGER
        NOT NULL,
    CONSTRAINT FK_Test_B_Test_A FOREIGN KEY (A, B)
        REFERENCES Test_A(A,B)
        );