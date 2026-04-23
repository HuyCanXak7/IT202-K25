-- Quantity âm: Không cho phép, cần chặn ngay từ câu lệnh: CHECK (Quantity > 0) --
-- Add trùng sản phẩm: Nếu sản phẩm đã có trong giỏ, thay vì INSERT dòng mới, ta nên UPDATE số lượng để tránh trùng lặp: Dùng INSERT ... ON DUPLICATE KEY UPDATE (MySQL) hoặc logic IF EXISTS → UPDATE ELSE INSERT  --
-- CODE HOÀN CHỈNH: --

INSERT INTO CART_ITEMS (UserID, ProductID, Quantity)
VALUES (123, 10, 1)
ON DUPLICATE KEY UPDATE Quantity = Quantity + VALUES(Quantity);

SELECT ProductID, Quantity, AddedDate
FROM CART_ITEMS
WHERE UserID = 123;

UPDATE CART_ITEMS
SET Quantity = 5
WHERE UserID = 123 AND ProductID = 10 AND Quantity >= 0;

DELETE FROM CART_ITEMS
WHERE UserID = 123 AND ProductID = 10;

