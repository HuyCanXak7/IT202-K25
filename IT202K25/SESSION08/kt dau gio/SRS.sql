CREATE DATABASE SalesManagement;
USE SalesManagement;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    birth_date DATE
);

CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    category_id INT,
    
    FOREIGN KEY (category_id)
    REFERENCES Category(category_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    
    FOREIGN KEY (customer_id)
    REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Detail (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),

    PRIMARY KEY (order_id, product_id),

    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES Product(product_id)
);

INSERT INTO Category (category_name)
VALUES
('Laptop'),
('Phone'),
('Accessory');

INSERT INTO Customer (full_name, email, gender, birth_date)
VALUES
('Nguyen Van A', 'a@gmail.com', 'Male', '2000-05-10'),
('Tran Thi B', 'b@gmail.com', 'Female', '1999-08-21'),
('Le Van C', 'c@gmail.com', 'Male', '2001-01-15');

INSERT INTO Product (product_name, price, category_id)
VALUES
('Dell XPS 13', 2500.00, 1),
('iPhone 15', 1500.00, 2),
('Logitech Mouse', 50.00, 3),
('MacBook Pro', 3200.00, 1),
('Samsung S24', 1400.00, 2);

INSERT INTO Orders (customer_id, order_date)
VALUES
(1, '2026-05-01'),
(2, '2026-05-02'),
(1, '2026-05-05');

INSERT INTO Order_Detail (order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 2500.00),
(1, 3, 2, 50.00),
(2, 2, 1, 1500.00),
(3, 4, 1, 3200.00),
(3, 3, 1, 50.00);

SELECT * FROM Customer;
SELECT * FROM Category;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Order_Detail;