CREATE TABLE Price_Changes_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT NOT NULL,
    old_price DECIMAL(15,2) NOT NULL,
    new_price DECIMAL(15,2) NOT NULL,
    change_type VARCHAR(20) NOT NULL,  
    difference DECIMAL(15,2) NOT NULL,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES Medicines(medicine_id)
);

DELIMITER //
CREATE TRIGGER TrackPriceChanges
BEFORE UPDATE ON Medicines
FOR EACH ROW
BEGIN

    IF NEW.price <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Giá thuốc mới ko hợp lệ';
    END IF;


    IF NEW.price <> OLD.price THEN
        IF NEW.price > OLD.price THEN
            INSERT INTO Price_Changes_Log(medicine_id, old_price, new_price, change_type, difference)
            VALUES (OLD.medicine_id, OLD.price, NEW.price, 'TĂNG GIÁ', NEW.price - OLD.price);
        ELSE
            INSERT INTO Price_Changes_Log(medicine_id, old_price, new_price, change_type, difference)
            VALUES (OLD.medicine_id, OLD.price, NEW.price, 'GIẢM GIÁ', OLD.price - NEW.price);
        END IF;
    END IF;
END //
DELIMITER ;

UPDATE Medicines
SET price = price + 5000
WHERE medicine_id = 1;

UPDATE Medicines
SET price = price - 3000
WHERE medicine_id = 2;

UPDATE Medicines
SET stock = stock + 10
WHERE medicine_id = 3;

UPDATE Medicines
SET price = -5000
WHERE medicine_id = 4;

