-- "Derived Table" (Bảng dẫn xuất) là bảng tạm thời được tạo ra từ một Subquery trong mệnh đề FROM
-- Phải đặt alias 
-- Nếu không có alias lệnh sẽ được coi là ko hợp lệ
-- CODE ĐÚNG LÀ --
SELECT SUM(total_spent)
FROM (
    SELECT student_id, SUM(amount) AS total_spent
    FROM Payments
    GROUP BY student_id
    HAVING SUM(amount) > 10000000
) AS vip_students;
