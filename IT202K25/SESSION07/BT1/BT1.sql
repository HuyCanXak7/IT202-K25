-- Toán tử = trong SQL chỉ so sánh được với một giá trị duy nhất từ Subquery
--  Nếu Subquery trả về nhiều dòng thì hệ thống báo lỗi
-- cách sữa:
SELECT title, price
FROM Courses
WHERE price IN (SELECT price FROM Courses WHERE instructor_id = 5);
