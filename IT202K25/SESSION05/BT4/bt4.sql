-- Giải pháp 1: Dùng nhiều toán tử OR --
SELECT order_id, customer_id, reason, created_at
FROM Orders
WHERE reason = 'KHACH_HUY'
   OR reason = 'QUAN_DONG_CUA'
   OR reason = 'KHONG_CO_TAI_XE'
   OR reason = 'BOM_HANG';
-- Giải pháp 2: Dùng toán tử IN --
SELECT order_id, customer_id, reason, created_at
FROM Orders
WHERE reason IN ('KHACH_HUY', 'QUAN_DONG_CUA', 'KHONG_CO_TAI_XE', 'BOM_HANG');
-- so sánh giải pháp 2 ngắn gọn tối ưu hơn, Chỉ cần thêm giá trị vào danh sách IN, tiện lợi hơn --
-- giải pháp tốt nhát là giải pháp 2
