SELECT 
    user_name AS Tên_Khách_Hàng,
    CASE
        WHEN total_orders IS NULL THEN 'Chưa có đơn'
        WHEN total_orders > 500 THEN 'Kim Cương'
        WHEN total_orders BETWEEN 100 AND 500 THEN 'Vàng'
        WHEN total_orders < 100 THEN 'Bạc'
    END AS Xep_Hang
FROM Users;
-- CASE END tạo cột ảo Xep_Hang.
-- IS NULL được xử lý đầu tiên để tránh lỗi báo cáo.
-- > 500 > Kim Cương.
-- BETWEEN 100 AND 500 > Vàng.
-- < 100 > Bạc.