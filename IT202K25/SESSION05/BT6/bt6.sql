SELECT 
    order_id,
    customer_id,
    total_amount,
    status,
    note,
    user_id,
    CASE 
        WHEN total_amount > 4000000 THEN 'Nguy hiểm'
        ELSE 'Bình thường'
    END AS Alert_Level
FROM Orders
WHERE total_amount BETWEEN 2000000 AND 5000000
  AND status <> 'CANCELLED'
  AND (note LIKE '%gấp%' OR user_id IS NULL)
ORDER BY total_amount DESC
LIMIT 20 OFFSET 40;  -- Trang 3, mỗi trang 20 dòng
-- BETWEEN 2000000 AND 5000000: lọc giá trị thanh toán trong khoảng đó
-- status <> 'CANCELLED': loại bỏ đơn bị hủy
-- (note LIKE '%gấp%' OR user_id IS NULL): bộ lọc kép, được nhóm bằng ngoặc để không phá điều kiện chính
-- CASE: tạo cột ảo Alert_Level
-- ORDER BY total_amount DESC: đơn đắt tiền nhất lên đầu
-- LIMIT 20 OFFSET 40: phân trang, trang 3