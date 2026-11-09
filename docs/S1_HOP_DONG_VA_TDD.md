# S1 hợp đồng và nhịp triển khai

## Phạm vi đã được duyệt

Sau câu hỏi duyệt hồ sơ S1-D01 đến S1-D06 và cho phép code S1, người dùng trả lời **“tiếp tục hoàn thành”**. Xác nhận này áp dụng S1 đã trình, không nghiệm thu G5 hoặc chốt chính sách những lát cắt khác. G4 S1 đang làm.

## Lát cắt và hợp đồng trước implementation

Guest xem sách thường, thêm từ danh sách/chi tiết, xem giỏ, sửa và xóa bằng lượng0. Mã SKU định danh riêng; chủ lấy từ session server; giỏ không giữ hàng. Java core không biết Spring, HTTP hay SQL. Request vào Input Boundary, Response qua Output Boundary, presenter theo request.

Cart giữ id, owner, version và map SKU→lượng nguyên dương. changeLine(sku,0) bỏ đúng dòng; qty âm hoặc SKU rỗng bị từ chối, không đổi đối tượng gốc. Cart bất biến, copy bảo vệ map, không gọi kho/database. Ví dụ {S001:2,S002:1} đổi S001=0 →{S002:1}. Kho và giá thuộc hợp đồng use case chứ không nhét vào aggregate giỏ.

ChangeCartRequest gồm cartId, owner từ server, sku, quantity dạng chuỗi nguyên thủy, expectedVersion, mode ADD/SET. Chuỗi rỗng, âm, lẻ/ký tự hoặc quá int phải bị từ chối; lỗi có mã và thông điệp an toàn. ADD nhận lượng dương để cộng; SET nhận0 để bỏ. Tổng ADD tính bằng long để không tràn int. SET0 bỏ được sách đang hết hàng; không cần điều kiện tồn để bỏ lựa chọn.

Interactor kiểm loadOwned, version, SKU, visible, số lượng và A=H−R; giữ thứ tự để không lộ nội dung giỏ sai chủ. Tính giá thường từ Book hiện hành; mỗi dòng quantity×priceVnd, tổng BigDecimal VND nguyên. Không nhận total từ frontend. save thành công tăng version một lần; xung đột không ghi đè. output.present đúng một lần mỗi execute. Không lưu nếu dữ liệu lỗi; dữ liệu lỗi ở persistence không được trả success.

CartPort.open(owner) đọc hoặc tạo giỏ rỗng id ngẫu nhiên, owner duy nhất; loadOwned trả rỗng khi không tồn tại/khác owner, không rò chủ; save(cart,expectedVersion) cam kết thay các dòng và version cùng transaction hoặc không thay gì. Adapter PostgreSQL phải chứng minh CAS và rollback bằng test thật, fake không chứng minh điều đó.

CartQuery mở/đọc giỏ owner, báo giá hiện tại qua output. Giá hiện tại trong giỏ chưa là snapshot chốt đơn. Catalog đọc danh sách public/chi tiết, không có dữ liệu mật. Việc mở giỏ GET có tác dụng tạo giỏ rỗng được ghi rõ; không đổi tồn.

Web chỉ chuyển đổi UUID/version/mode và session, không tự tính giá. Spring Security giữ CSRF cho POST; trình duyệt không được tự gửi owner để cấp quyền. Lỗi UUID/version/mode không làm500 hoặc ghi giỏ. Phiên hết hạn tạo guest mới; lưu giỏ theo account/gộp giỏ chưa thuộc S1.

## Chu trình dự kiến

1. Cart contract → Jupiter Red → Cart implementation → Green.
2. Application contracts → hành vi/acceptance Red → implementation → Green.
3. Port SQL và web contracts → integration Red → adapter/web → PostgreSQL/HTTP Green.
4. Refactor giữ hành vi, full test, UML khớp code, Word và truy vết cập nhật.

Mỗi mục kết quả chỉ bổ sung sau lệnh thật. Lỗi dependency hoặc Docker không được gọi là Red nghiệp vụ. Build target Java21; chạy kiểm hiện tại bằng JDK25. Chưa tuyên bố thử runtime21.
