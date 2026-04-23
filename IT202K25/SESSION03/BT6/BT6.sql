CREATE DATABASE BT6;
USE BT6;
-- Thiết kế bảng --
CREATE TABLE PRODUCTS (
    ProductID VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(100),
    Size VARCHAR(10),
    Price INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- Dữ liệu ban đầu:--
INSERT INTO PRODUCTS (ProductID, ProductName, Size, Price) 
VALUES
('P01', 'Áo sơ mi trắng', 'L', 250000),
('P02', 'Quần Jean xanh', 'M', 450000),
('P03', 'Áo thun Basic', 'XL', 150000),
('P04', 'Áo hoodie', NULL, -200000);
-- Cập nhật giá --
-- Giảm giá P02 xuống 400000 --
UPDATE PRODUCTS
SET Price = 400000
WHERE ProductID = 'P02';
-- Khôi phục giá gốc bằng cách tăng 10% toàn bộ sản phẩm --
UPDATE PRODUCTS
SET Price = Price * 1.1;
-- Xóa sản phẩm ngừng kinh doanh --
DELETE FROM PRODUCTS
WHERE ProductID = 'P03';
-- Truy vấn phục vụ kinh doanh --
-- Xem toàn bộ sản phẩm --
SELECT * FROM PRODUCTS;
-- In nhãn sản phẩm (Tên, Size) --
SELECT ProductName, Size
FROM PRODUCTS;
-- Tìm sản phẩm giá > 300000 --
SELECT ProductID, ProductName, Price
FROM PRODUCTS
WHERE Price > 300000;

