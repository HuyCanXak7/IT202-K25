-- Khám nghiệm tử thi: Vấn đề nằm ở NULL nếu trong bảng Enrollments có bất kỳ course_id nào bị NULL
-- Thì toàn bộ điều kiện NOT IN sẽ trở thành UNKNOWN
-- Giải pháp kiến trúc: Để code sống sót qua được các đợt rác dữ liệu NULL sau này, bạn phải vá một mệnh NOT EXISTS gì vào ngay bên trong Subquery
-- Thực thi:
SELECT c.*
FROM Courses c
WHERE NOT EXISTS (
    SELECT 1
    FROM Enrollments e
    WHERE e.course_id = c.id
);
