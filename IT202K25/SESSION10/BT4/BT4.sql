CREATE DATABASE Hospital_Pharmacy;
USE Hospital_Pharmacy;

CREATE TABLE Pharmacy_Inventory (
    Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Drug_Name VARCHAR(255),
    Batch_Number VARCHAR(50),
    Expiry_Date DATE,
    Quantity INT
);

INSERT INTO Pharmacy_Inventory
(Drug_Name, Batch_Number, Expiry_Date, Quantity)
VALUES
('Paracetamol', 'B001', '2026-01-10', 500),
('Paracetamol', 'B002', '2025-12-15', 300),
('Amoxicillin', 'A001', '2025-08-20', 150),
('Vitamin C', 'V001', '2025-07-01', 700),
('Paracetamol Extra', 'B003', '2025-11-30', 200),
('Ibuprofen', 'I001', '2026-03-12', 250);

CREATE INDEX idx_drug_name
ON Pharmacy_Inventory(Drug_Name);

CREATE INDEX idx_expiry_date
ON Pharmacy_Inventory(Expiry_Date);

CREATE INDEX idx_drug_expiry
ON Pharmacy_Inventory(Drug_Name, Expiry_Date);

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol'
AND Expiry_Date <= '2025-12-31';

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE 'Para%';

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE '%cetamol%';

ALTER TABLE Pharmacy_Inventory
ADD FULLTEXT(Drug_Name);

SELECT *
FROM Pharmacy_Inventory
WHERE MATCH(Drug_Name)
AGAINST('Paracetamol');