
CREATE TABLE Patients (
    Patient_ID INT AUTO_INCREMENT PRIMARY KEY,
    Full_Name VARCHAR(100),
    Phone VARCHAR(20),
    Age INT,
    Address VARCHAR(255),
    HIV_Status VARCHAR(50),
    Mental_Health_History VARCHAR(255)
);

DELIMITER //
CREATE PROCEDURE SeedPatients()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 500000 DO
        INSERT INTO Patients (Full_Name, Phone, Age, Address, HIV_Status, Mental_Health_History)
        VALUES (
            CONCAT('Patient ', i),
            CONCAT('090', LPAD(i, 7, '0')),
            FLOOR(RAND() * 100),
            'Ho Chi Minh City',
            IF(RAND() < 0.1, 'Positive', 'Negative'),
            IF(RAND() < 0.2, 'Anxiety', 'None')
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL SeedPatients();

EXPLAIN SELECT * FROM Patients WHERE Phone = '0900000123';

CREATE INDEX idx_phone ON Patients(Phone);

EXPLAIN SELECT * FROM Patients WHERE Phone = '0900000123';

DELIMITER //
CREATE PROCEDURE InsertBatchTest(prefix VARCHAR(3))
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO Patients (Full_Name, Phone, Age, Address, HIV_Status, Mental_Health_History)
        VALUES (
            CONCAT('NewPatient ', i),
            CONCAT(prefix, LPAD(i, 7, '0')),
            FLOOR(RAND() * 100),
            'Hanoi',
            'Negative',
            'None'
        );
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

CALL InsertBatchTest('091');

CALL InsertBatchTest('092');
