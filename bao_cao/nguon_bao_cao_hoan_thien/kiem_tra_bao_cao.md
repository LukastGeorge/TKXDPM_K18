# Kiểm tra bản báo cáo hoàn thiện

Bản Word trình bày trực tiếp đặc tả, sơ đồ và cách kiểm thử. Không dùng danh sách đường dẫn thay nội dung. Bản Word cũ của người dùng được giữ nguyên; đầu ra mới mang hậu tố Hoan_thien.

## Nội dung đã đối chiếu

- 49 Rule, 154 định nghĩa Scenario/Scenario Outline, 221 trường hợp khi khai triển Examples. Đây là số lượng đặc tả, không phải số test đạt.
- 1083 dòng nội dung kịch bản và các giá trị trong bảng Examples có trong Word; mã TC và loại Scenario/Outline được đối chiếu với bản feature đi kèm.
- 15 sơ đồ: use case, ba class diagram, package, activity, sequence, ba state machine và DFD. Có thêm ba hình trích đoạn đặc tả và mã test hiện có; các hình này không phải ảnh ứng dụng hoặc bằng chứng test xanh.
- 20 hợp đồng KTTT ghi dữ liệu ban đầu, hành động, assertions và cấp kiểm. Bằng chứng đã chạy được tách riêng khỏi test cần thực thi tiếp.
- Mục lục và số trang cập nhật bằng Microsoft Word. Bản xuất PDF nội bộ được render thành ảnh để kiểm tra dàn trang. Không có trang trắng thừa; bảng tiếp trang lặp tiêu đề.

## Hai điểm đặc tả được làm rõ

TC_AUTH_SC029 nêu rõ fixture KH03 đã bị khóa cùng email và mật khẩu thử, thay tiền điều kiện chung không xác định tài khoản. TC_ORDER_DH05 nêu rõ CP20 giảm 20%, ngưỡng 200000 VND, đang hiệu lực và còn một lượt. Các bổ sung làm dữ liệu đầu vào đủ để suy ra Then, không thay quy tắc hoặc kết quả mong đợi.

## Giới hạn bằng chứng

Mốc kiểm thử đơn hàng đã chạy 89 trường hợp đạt: 45 unit Jupiter, 24 BDD và 20 integration. 197 trường hợp BDD bị lọc khỏi runner, không được coi là đã đạt. Các sửa đổi sau mốc này còn phải chạy lại. SMTP và Facebook thật chưa kiểm chứng vì chưa có cấu hình dịch vụ; không mô tả mô phỏng là tích hợp thật.

Nguồn chỉnh sửa cho BC01–BC14 là PlantUML. BC15 là DFD và dùng SVG làm nguồn chính; không coi DFD là UML. BC16–BC18 là ảnh trình xem source. Tệp draw.io giữ các trang cũ và có thêm ba trang class tương ứng BC02–BC04; các trang cũ không được dùng để khẳng định thiết kế hiện hành của báo cáo.

Kiểm tra tài liệu chỉ xác nhận nội dung và cách trình bày; không thay việc chạy phần mềm, kiểm thử toàn bộ hoặc nghiệm thu tích hợp ngoài.
