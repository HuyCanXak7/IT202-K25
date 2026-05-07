-- Bảo vệ quan điểm: khi kiểm tra điều kiện exits sẽ dừng ngay lập tức khi có 1 dòng k thõa mãn
-- với dữ liệu lớn việc dừng sớm giúp tiết kiệm thời gian hơn
-- ngược lại: với NOT IN thì phải tính tất cả tập hợp kết quả trước rồi mới so sánh từng giá trị
-- tốn thời gian
-- Thực thi: Viết câu lệnh SQL hoàn chỉnh sử dụng kỹ thuật NOT EXISTS kết hợp với Truy vấn lồng tương quan (Correlated Subquery) để lấy ra danh sách Email của các học viên này.
SELECT s.email
FROM Students s
WHERE NOT EXISTS (
    SELECT 1
    FROM Payments p
    WHERE p.student_id = s.id
      AND YEAR(p.payment_date) = 2024
);
