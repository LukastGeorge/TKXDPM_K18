# Hồ sơ đề nghị duyệt lát cắt S1

Trạng thái: **Chờ duyệt**, chưa cấp phép code. Hồ sơ trình bày phạm vi cụ thể để người làm bài xem xét; không tự đánh dấu G1/G2 hoặc G3 đã qua. Yêu cầu “hoàn thành tiểu luận cuối kỳ” là mục tiêu chung, chưa chỉ rõ bỏ các cổng duyệt đã thống nhất tại SRC13 mục 3.

## Kết quả S1 cần đạt

Guest xem danh sách/chi tiết một sách giá thường, thêm vào giỏ, xem giỏ, cập nhật lượng và xóa bằng 0. Dữ liệu lưu PostgreSQL trong Docker, giao diện web gọi Spring Boot. Đầu vào → Request → Input Boundary → domain/application → port lưu → Output Boundary → Presenter → đầu ra. Không chỉ demo console hoặc repository in-memory.

Không phải thu nhỏ phạm vi toàn bài: email, Facebook, đơn, COD, kho, giảm, mã, sỉ, combo và kèm vẫn phải làm ở các lát cắt kế tiếp sau nghiệm thu.

## Các quy tắc đề nghị duyệt riêng cho S1

| Mã | Đề nghị cụ thể | Tác động và truy vết |
|---|---|---|
| S1-D01 | Mỗi ấn bản bán có SKU riêng không đổi; không gộp theo tên. Dùng dữ liệu mẫu đã nêu, không khóa cardinality toàn catalog ở S1. | BR-001/002; SC005/006, CL02 |
| S1-D02 | Số lượng nguyên không âm. 0 bỏ dòng; âm/lẻ/ký tự từ chối và giữ giỏ. Thêm lại cùng SKU/giá thường cộng lượng; thao tác sửa đặt lượng tuyệt đối. | BR-003; TC_CART_SC009/015/016/017/018 |
| S1-D03 | Không thêm/sửa thành lượng vượt A hiện tại; giỏ không giữ kho theo QD-01. Kiểm lại tồn khi đặt hàng thuộc S3. | BR-013/014; TC_CART_SC010/011; TC_INV_REV001 |
| S1-D04 | Giỏ Guest gắn phiên do server cấp, không nhận owner từ client. Hai phiên độc lập. Sai chủ không trả dữ liệu hay ghi thay đổi. | BR-016; TC_CART_SC014/NEW008 |
| S1-D05 | S1 chỉ giá thường VND từ backend. Giá mẫu là fixture; chưa áp mã/phí/giá đặc biệt. Không suy fixture phí 0 thành quy định miễn phí. | BR-004; TC_CART_SC008/012/015 |
| S1-D06 | Ghi giỏ bằng version. Request với version cũ trả xung đột và giữ dữ liệu đã commit; người dùng tải lại giỏ. Cập nhật giỏ không thay H/R. | CL01/SQ02; hợp đồng CartPort.save |

Các dòng trên chưa được tự động chuyển thành “đã chốt” trong BR/feature. Sau khi duyệt S1, cập nhật đúng tag và truy vết liên quan; không bỏ toàn bộ needs_confirmation ở các nhóm khác.

## Tiêu chí chấp nhận

1. Chạy từ trình duyệt qua backend và PostgreSQL: xem sách, thêm từ danh sách/chi tiết, sửa, bỏ bằng 0; dữ liệu giỏ được đọc lại sau lưu.
2. TC_CART_SC008 gồm hai Examples; SC012/015/016/017 có tổng khớp fixture.
3. Mã không tồn tại, lượng không hợp lệ, vượt khả dụng, sai chủ và version cũ: phản hồi rõ, không ghi dở hoặc đổi kho.
4. Jupiter unit tests phát hiện và chạy; acceptance có glue thực sự gọi Input Boundary; không logic giỏ trong glue.
5. Kiểm adapter với PostgreSQL thật; cùng hợp đồng dùng fake trong unit và adapter thật trong integration. Fake xanh không được thay kết quả DB.
6. Ghi Red/Green có lệnh và nguyên nhân thật; UML, README, báo cáo và truy vết khớp source sau refactor.

## Công nghệ và quyết định kỹ thuật đề nghị

Java/Spring Boot/PostgreSQL Docker/Jupiter đã xác nhận. Đề nghị Maven để có lifecycle build thống nhất, Cucumber chạy trên JUnit Platform cho yêu cầu glue của môn học, Jupiter cho unit/integration. Không dùng JUnit 4, không mặc định thêm Serenity/Mockito/AssertJ. Phiên bản phải đối chiếu tài liệu chính thức và môi trường trước khi chọn; không công bố version chưa kiểm tra.

Giao diện web đơn giản server-rendered là phương án cho S1 để giảm hai bộ build; đây là lựa chọn kỹ thuật có thể đảo ngược. Package theo tính năng và tầng, không dùng tên cá nhân hoặc logistics. Spring wiring nằm phía ngoài core.

## Điều kiện môi trường cần kiểm sau khi duyệt

- Java/build tool tương thích, Docker engine chạy được, cổng DB không xung đột.
- Database riêng cho bài; không ghi đè dữ liệu sẵn có. Credentials cấu hình ngoài source.
- S1 chưa phụ thuộc SMTP/Facebook. Trước S2/S6 cần chủ đề tài có dịch vụ thật và redirect/domain được cấu hình; không gửi secret vào chat/báo cáo.

## Phạm vi câu duyệt

Có thể xác nhận: **“Duyệt tài liệu và các đề xuất S1-D01 đến S1-D06, bắt đầu code S1.”**

Câu này chỉ duyệt phần S1 và cách kiểm chứng nêu trên, không chốt mọi chính sách còn mở hoặc nghiệm thu toàn bài. Sau S1, trình kết quả thật để nghiệm thu trước khi mở S2/S3 theo quy trình đã thống nhất.
