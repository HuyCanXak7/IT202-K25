-- PHÂN TÍCH BÀI TOÁN : INPUT CẦN QUÉT Ở BẢNG CUSTOMERS VỚI NHIỀU CỘT --
-- OUTPUT Ở CỘT fullname và email. --
-- sử dụng lệnh SELECT là sai SELECT * sẽ quét toàn bộ hàng chục cột gây tốn dung lượng --
-- GIẢI PHÁP LỌC DỮ LIỆU : khác hàng ở hà nội thì ghi là city= hà nội --
-- Không mua hàng hơn 6 tháng tính đến 01/04/2026 thì LastPurchaseDate <= '2025-10-01' --
-- email buộc phải nhập email NOT NULL --
-- có trạng thái tài khoản hoạt động status = active --
-- CODE HOÀN CHỈNH --
SELECT FullName, Email
FROM CUSTOMERS
WHERE City = 'Hà Nội'
  AND LastPurchaseDate <= '2025-10-01'
  AND Email IS NOT NULL
  AND Status = 'Active';