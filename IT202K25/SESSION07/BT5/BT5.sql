-- Giải pháp kiến trúc: Scalar Subquery là một Subquery trả về đúng một giá trị duy nhất
-- Khi đặt Scalar Subquery ngay trong mệnh đề SELECT  hiển thị chi tiết từng dòng 
-- Thực thi:
SELECT 
    c.title,
    c.price,
    c.price - (SELECT AVG(price) FROM Courses) AS Price_Difference
FROM Courses c;
