CREATE DATABASE BT2;
USE BT2;
CREATE TABLE CUSTOMERS (
    CustomerID INT PRIMARY KEY,             
    FullName   VARCHAR(100) NOT NULL,        
    Email      VARCHAR(100) NOT NULL UNIQUE, 
    Age        INT CHECK (Age >= 0)         
);
