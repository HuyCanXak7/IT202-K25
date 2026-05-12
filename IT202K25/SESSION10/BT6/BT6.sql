CREATE DATABASE ER_System;
USE ER_System;

CREATE TABLE Patients (
    Patient_ID CHAR(5) PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    Admission_Time DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Vitals_Logs (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID CHAR(5),
    Heart_Rate INT CHECK (Heart_Rate > 0),
    Blood_Pressure VARCHAR(20),
    Record_Time DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID)
);

INSERT INTO Patients (Patient_ID, Full_Name)
VALUES
('BN001', 'Nguyen Van A'),
('BN002', 'Tran Thi B'),
('BN003', 'Le Van C');

INSERT INTO Vitals_Logs
(Patient_ID, Heart_Rate, Blood_Pressure, Record_Time)
VALUES
('BN001', 130, '150/90', '2026-05-01 08:00:00'),
('BN001', 125, '145/90', '2026-05-01 09:00:00'),
('BN002', 75, '120/80', '2026-05-01 09:10:00');

CREATE INDEX idx_patient_recordtime
ON Vitals_Logs(Patient_ID, Record_Time);

CREATE VIEW ER_Dashboard_View AS
SELECT
    p.Patient_ID,
    p.Full_Name,
    p.Admission_Time,

    IFNULL(v.Heart_Rate, 'Pending') AS Heart_Rate,

    IFNULL(v.Blood_Pressure, 'Pending') AS Blood_Pressure,

    v.Record_Time,

    CASE
        WHEN v.Heart_Rate > 120
        OR v.Heart_Rate < 50
        THEN 'CRITICAL'

        WHEN v.Heart_Rate IS NULL
        THEN 'Pending'

        ELSE 'STABLE'
    END AS Urgency_Level

FROM Patients p

LEFT JOIN (
    SELECT vl1.*
    FROM Vitals_Logs vl1
    JOIN (
        SELECT
            Patient_ID,
            MAX(Record_Time) AS Latest_Time
        FROM Vitals_Logs
        GROUP BY Patient_ID
    ) vl2
    ON vl1.Patient_ID = vl2.Patient_ID
    AND vl1.Record_Time = vl2.Latest_Time
) v

ON p.Patient_ID = v.Patient_ID;

SELECT * FROM ER_Dashboard_View;

UPDATE ER_Dashboard_View
SET Heart_Rate = 90
WHERE Patient_ID = 'BN001';

INSERT INTO ER_Dashboard_View
VALUES
('BN004', 'Pham Van D', NOW(), 80, '120/80', NOW(), 'STABLE');