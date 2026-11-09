# Review đặc tả website bán sách

Cập nhật 04/11/2026. Một trợ lý thực hiện review; không phải nhiều QA độc lập.

## Kết quả kiểm tra

- Một Feature, 48 Rule, 152 định nghĩa Scenario/Scenario Outline, 219 trường hợp khai triển Examples.
- 111 định nghĩa / 160 trường hợp khai triển còn chi tiết chờ duyệt. Tag @needs_confirmation không phải lỗi parser.
- Đủ kho, bán thường/giảm/mã/sỉ/combo/kèm, giỏ, email/Facebook thật, đơn, COD; có giới thiệu/tìm lọc công khai và quản trị.
- Bổ sung 14 định nghĩa / 18 trường hợp; giữ mã cũ, thêm BR và REQ cấp G0, mỗi scenario một When.
- QD-01/02 đã chốt, không suy rộng thành duyệt gộp giỏ, chọn giá thấp nhất, quota, làm tròn, trạng thái/quyền COD hoặc auth TTL.

## Phát hiện và sửa

| Vấn đề | Mức độ | Sửa | Kết quả |
|---|---|---|---|
| Cờ kho/giá chưa phân biệt phần đã chốt | Cao | QD-01/02 và trạng thái BR riêng | Không nâng cả P-PRICE thành đã duyệt |
| Thiếu BR/REQ G0 trong feature | Vừa | Thêm tag cho mọi định nghĩa | Có truy vết từng case |
| SC031 chưa xét giỏ Customer có sẵn | Cao | Nêu giỏ Customer trống; REV006–008 là đề xuất gộp riêng | Không ngầm ghi đè giỏ |
| SC039 thiếu hậu điều kiện khi giá đổi | Cao | Không tạo đơn/giữ kho/giữ mã, giỏ giữ nguyên; REV014 xác nhận lại | Nhánh requote rõ |
| NEW014 có fixture quan hệ kèm mâu thuẫn | Vừa | Phụ kiện tồn tại nhưng chưa có quan hệ mua kèm | Dữ liệu ban đầu nhất quán |
| Thiếu hủy lặp bảo vệ giữ chỗ đơn khác | Cao | TC_ORDER_REV002 | Chỉ giải phóng reservation đúng đơn |
| Thiếu hủy/bàn giao đồng thời | Cao | TC_INV_REV009, SQ06C | Một chuyển trạng thái/biến động |
| Giỏ trộn giá thường/đặc biệt chưa rõ | Cao | TC_PRICE_REV003 | Từ chối mã cả đơn theo QD-02 |
| Facebook/email Accepted có thể bị hiểu là verified | Cao | TC_AUTH_REV004/012 | Không bỏ qua xác minh |
| Tag happy/negative cũ suy từ từ khóa sai | Nhẹ | Bỏ tag suy đoán, giữ expected outcome | Không gọi xem public là lỗi |

## Nguồn và điểm còn mở

[Quy tắc hiện hành](QUY_TAC_NGHIEP_VU.md) phân biệt yêu cầu thầy, xác nhận người dùng, phương án và phần chưa biết. [G0](G0/01_DANH_MUC_NGUON.md) ghi vị trí nguồn; [truy vết](TRUY_VET_YEU_CAU.csv) gồm REQ→BR→Scenario→UML→Test→Code→Evidence.

Feature hoàn thiện cấu trúc để review; chưa thể coi mọi quy tắc đã được duyệt. Chưa bổ sung nghiệp vụ online/hoàn tiền. Không thay đổi mật khẩu/phiên/DB thật.

## Kiểm chứng tài liệu

Parser Gherkin 36.1.0/messages 30.1.0: 0 parse errors, 152 định nghĩa, 219 cases, 0 lỗi tag/ID/tham số theo bộ kiểm tra tài liệu. Log ở [bằng chứng](bang_chung/gherkin_parse.log).

Javac 25 phát AccessDeniedException khi đóng JAR trong sandbox ở bước biên dịch helper tài liệu; lớp vẫn sinh. Lần chạy parser riêng kết thúc mã 0, không phát cảnh báo đó. Đây không phải lỗi code website.

Chưa có glue, runner, Jupiter tests hoặc app build. Parse thành công không phải nghiệp vụ pass; bảng truy vết không phải coverage runtime.
