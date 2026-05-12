CREATE DATABASE Hospital_National;
USE Hospital_National;

CREATE TABLE Records_North (
    Record_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Diagnosis TEXT,
    Record_Date DATE
);

CREATE TABLE Records_South (
    Record_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Diagnosis TEXT,
    Record_Date DATE
);

INSERT INTO Records_North VALUES
(1, 'Nguyen Van A', 'Flu', '2026-04-28'),
(2, 'Tran Thi B', 'Fever', '2026-04-29'),
(3, 'Le Van C', 'Headache', '2026-04-30');

INSERT INTO Records_South VALUES
(1, 'Le Thi B', 'Cold', '2026-04-28'),
(4, 'Pham Van D', 'Covid', '2026-04-29'),
(5, 'Vo Thi E', 'Allergy', '2026-04-30');

CREATE VIEW National_Record_View AS
SELECT
    Record_ID,
    Patient_Name,
    Diagnosis,
    Record_Date,
    'North' AS Branch_Name
FROM Records_North
UNION ALL
SELECT
    Record_ID,
    Patient_Name,
    Diagnosis,
    Record_Date,
    'South' AS Branch_Name
FROM Records_South;
SELECT * FROM National_Record_View;