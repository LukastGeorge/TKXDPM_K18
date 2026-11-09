> **Hồ sơ khảo sát G0 giữ để truy vết.** Quyết định hiện hành QD-01/02 và phạm vi được phép làm tài liệu xem [sổ BR](../QUY_TAC_NGHIEP_VU.md), [báo cáo sống](../BAO_CAO_SONG.md). Nội dung “chưa chốt kho/mã” phía dưới mô tả thời điểm khảo sát trước quyết định mới.

# Kế hoạch và điều kiện duyệt

## Cổng hiện tại

**G0 – Chờ duyệt.** Người dùng đã cho đọc/kiểm kê/lập hồ sơ G0 trong thư mục website. Các lựa chọn công nghệ và làm cá nhân đã được xác nhận riêng. Chưa có xác nhận chuyển G1/G2/G3 hoặc cho viết code website.

| Mốc | Trạng thái | Đầu ra phải trình | Điều kiện chuyển |
|---|---|---|---|
| G0 Hiểu đề | Chờ duyệt | Danh mục đọc/chưa đọc; ma trận yêu cầu; phạm vi; sai lệch; kế hoạch | Người dùng duyệt phạm vi G0 |
| G1 Đặc tả | Chưa làm theo mốc mới; có bản nháp để review | Thuật ngữ, quyền, BR được duyệt, một feature chính, tiêu chí chấp nhận và danh sách lát cắt | Người dùng duyệt đặc tả; điểm mở ảnh hưởng lát cắt được giải quyết |
| G2 Thiết kế | Chưa làm theo mốc mới; có 28 hình hỗ trợ | Class UML .drawio cá nhân, luồng Request/Response/ports, mô hình dữ liệu/invariant, SOLID/DDD/pattern có lý do | Người dùng duyệt thiết kế |
| G3 Sẵn sàng | Chưa làm | Kế hoạch kiểm thử văn bản, truy vết, phân tích–thiết kế, môi trường/phiên bản/cấu hình và rủi ro | Người dùng cho phép code đúng lát cắt cụ thể |
| G4 Từng lát cắt | Chưa làm | Test/code/log thật, demo, UML và báo cáo cập nhật | Người dùng nghiệm thu lát cắt trước khi mở rộng |
| G5 Toàn bài | Chưa làm | Hồ sơ đối chiếu từng mục phiếu chấm, chương trình, hướng dẫn và bằng chứng | Người dùng duyệt bản cuối |

Không dùng phần trăm tiến độ. Chỉ thay trạng thái cổng khi có xác nhận rõ ràng của người dùng.

## Trình tự G1 đề nghị

1. Làm rõ Sách/Ấn bản/SKU, giá tiền, vai trò và dữ liệu chung. Giữ các trường hợp qty=0, quyền Admin kế thừa và không guest checkout.
2. Chốt nhóm BR kho, giá/ưu đãi, giỏ/gộp, trạng thái/hủy/COD và lỗi dịch vụ thật; không bỏ các cách bán bắt buộc.
3. Review lại 138 scenario nháp với từng BR. Giữ mã cũ khi còn đúng; thay đổi có sổ ảnh hưởng. Một When chính, Then quan sát được, dữ liệu độc lập và lỗi chỉ rõ rollback/giữ nguyên.
4. Phân loại luật đã duyệt và luật chờ; viết acceptance criteria và phạm vi từng lát cắt bằng văn bản.
5. Đọc tiếp các mục sách cần thiết trước khi dùng chúng để thiết kế, nhất là aggregate/invariant, SOLID và composition.

## Phân rã lát cắt đề nghị để duyệt sau G1

| Lát cắt ứng viên | Giá trị xuyên suốt | Rủi ro cần kiểm chứng sau cho phép code | Điều kiện trước triển khai |
|---|---|---|---|
| S1 Guest thêm một sách giá thường từ chi tiết vào giỏ | Input web → request → use case/domain → port PostgreSQL → response/output boundary/presenter | Ranh giới input/output, phiên giỏ, validation, lưu/đọc lại và lỗi không sửa giỏ | Duyệt BR liên quan và thiết kế; cho phép riêng S1 |
| S2 Đăng ký/xác minh email thật, đăng nhập/đăng xuất, xử lý giỏ khi đăng nhập | Tài khoản và phiên có kiểm chứng qua dịch vụ thật | Gửi thất bại, token, không xác minh giả, quyền trước đặt | Duyệt gộp giỏ, token và cấu hình dịch vụ |
| S3 Customer đặt COD với giá thường và tồn | Tạo đơn thật và dữ liệu nhất quán | Hai yêu cầu đồng thời, mất phản hồi/rollback, snapshot và không thu COD sớm | Duyệt P-STOCK, trạng thái, COD và transaction PostgreSQL |
| S4 Nhập/điều chỉnh/bàn giao, hủy trước giao, ghi thu COD | Đơn–kho–tiền có lịch sử | Xuất/hoàn/thu lặp; chuyển trạng thái trái quy tắc | Duyệt quyền và BR-013–024 |
| S5 Các cách bán: giảm, mã, sỉ, combo, mua kèm | Báo giá và đặt hàng thống nhất | Tổ hợp ưu đãi, quota, tồn thành phần và thay đổi sau báo giá | Tách tiếp thành các lát cắt nhỏ sau khi duyệt ma trận giá |
| S6 Facebook thật và quản trị/danh mục còn lại | Phạm vi xã hội và quản trị theo đề | Provider lỗi, tài khoản trùng, quyền owner/admin, lịch sử | Có cấu hình thật và duyệt quy tắc liên kết/quản trị |

Đây là thứ tự đề xuất, không phải quyền tự triển khai. Các dòng lớn phải chia nhỏ trước G3; S5 không được triển khai cả nhóm trong một đợt chỉ vì cùng bảng. S1 chỉ kiểm chứng nền kiến trúc, không được dùng để nói rủi ro tồn/quota của S3/S5 đã được giải quyết. Việc chọn giá thường trong lát cắt đầu không loại sỉ/combo/mua kèm khỏi phạm vi toàn bài.

## Kỷ luật BDD/TDD sau khi được cho phép

BDD thống nhất hành vi theo BR; glue thiết lập Given, gọi hành vi When và kiểm tra Then; logic nghiệp vụ nằm trong core. Unit test Jupiter làm rõ từng quy tắc. Integration test kiểm adapter, PostgreSQL, transaction và dịch vụ ngoài. E2E kiểm luồng website khi cần.

Ghi đúng vòng lặp: chạy scenario/test và quan sát thiếu hành vi → viết unit test → Red có nguyên nhân rõ → code vừa đủ Green → refactor giữ hành vi → chạy lại → cập nhật UML, truy vết và tài liệu. Compilation error, test thực sự fail và lỗi môi trường là ba kết quả khác nhau. Không xem chỉ có test xanh là chứng minh đã làm TDD.

Chưa chốt runner Gherkin/Cucumber/Serenity. Tài liệu yêu cầu Gherkin và glue, người dùng đã chốt Jupiter cho unit tests; không suy ra phải bỏ BDD hoặc phải sao chép nguyên khung Serenity của bài khác. Đề xuất lựa chọn tương thích tại G3, kèm đánh đổi và kiểm discovery sau cho phép.

## Quản lý tài liệu sống và thay đổi

Đề xuất `docs/BAO_CAO_SONG.md` là nguồn nội dung báo cáo chính khi sang G1; bản DOCX nộp được xuất từ nội dung đó theo SRC04/SRC03 ở mốc phù hợp. Feature, .drawio, test và code giữ vai trò nguồn đúng loại; review G0 là hồ sơ kiểm soát, không phải báo cáo kết quả thực nghiệm.

Mỗi thay đổi sau duyệt phải ghi quyết định, BR/scenario bị ảnh hưởng, UML/Request/Response, test/code/bằng chứng cần cập nhật. Mỗi pattern cần vấn đề thật, phương án đơn giản hơn, vai trò tham gia và chi phí; không đặt chỉ tiêu đếm pattern.

## Nội dung đề nghị người dùng duyệt G0

Phạm vi được đề nghị là: cá nhân Nguyễn Duy Trường; đủ ba vai trò/sáu nghiệp vụ; stack và dịch vụ thật đã xác nhận; COD, không tự thêm online; giữ chi tiết kho/ưu đãi/trạng thái/gộp giỏ là việc phải duyệt G1; hoàn thiện class UML/draw.io ở G2; chỉ code sau G3 cho lát cắt cụ thể. Đồng ý G0 chỉ mở G1, không tự mở quyền G4.
