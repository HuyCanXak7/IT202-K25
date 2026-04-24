CREATE DATABASE ShopManager;
USE ShopManager;
CREATE TABLE categories(
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Products(
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10,2),
	 stock INT NOT NULL DEFAULT 0 CHECK (stock >=0),
     category_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY(category_id) REFERENCES categories(category_id)
);

INSERT INTO `shopmanager`.`categories` (`category_name`) VALUES ('Điện tử');
INSERT INTO `shopmanager`.`categories` (`category_name`) VALUES ('Thời trang');

INSERT INTO `shopmanager`.`products` (`product_name`, `price`, `stock`, `category_id`) VALUES ('iPhone 15', '25000000', '10', '1');
INSERT INTO `shopmanager`.`products` (`product_name`, `price`, `stock`, `category_id`) VALUES ('Samsung S23', '20000000', '5', '1');
INSERT INTO `shopmanager`.`products` (`product_name`, `price`, `stock`, `category_id`) VALUES ('Áo sơ mi nam', '500000', '50', '2');
INSERT INTO `shopmanager`.`products` (`product_name`, `price`, `stock`, `category_id`) VALUES ('Giày thể thao', '1200000', '20', '2');

UPDATE Products
SET PRICE = 26000000
WHERE product_name = 'iPhone 15';

UPDATE Products
SET stock = stock +10
WHERE category_id = 1;

DELETE FROM products
WHERE product_id = 4;

SELECT * FROM products;
