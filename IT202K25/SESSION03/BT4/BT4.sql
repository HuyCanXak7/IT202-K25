-- Giải pháp 1: Hard Delete --
-- Xóa hẳn các bản ghi có Status = 'Canceled' khỏi bảng bằng lệnh DELETE giúp giảm bỏ dung lượng ổ cứng, Tốc độ truy vấn nhanh hơn vì bảng nhỏ đi --
-- nhựơc điểm: Không thể khôi phục nếu cần --
-- Giải pháp 2: Soft Delete --
-- Cách làm: Không xóa thật, mà cập nhật cột IsDeleted = 1 cho các đơn hàng hủy giúp giữ nguyên dữ liệu, Truy vấn có thể loại bỏ dữ liệu rác bằng điều kiện WHERE IsDeleted = 0 --
-- nhược điểm: Dữ liệu vẫn chiếm dung lượng ổ cứng --
-- CODE HOÀN CHỈNH CHỌN GIẢI PHÁP TỐT NHẤT LÀ: --
UPDATE ORDERS
SET IsDeleted = 1
WHERE Status = 'Canceled';

SELECT OrderID, CustomerName, OrderDate, TotalAmount
FROM ORDERS
WHERE Status = 'Completed'
  AND IsDeleted = 0;
