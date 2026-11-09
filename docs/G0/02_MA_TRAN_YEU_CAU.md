> **Hồ sơ khảo sát G0 giữ để truy vết.** Quyết định hiện hành QD-01/02 và phạm vi được phép làm tài liệu xem [sổ BR](../QUY_TAC_NGHIEP_VU.md), [báo cáo sống](../BAO_CAO_SONG.md). Nội dung “chưa chốt kho/mã” phía dưới mô tả thời điểm khảo sát trước quyết định mới.

# Ma trận yêu cầu G0

Mã REQ-F/REQ-A/REQ-Q/REQ-D là mã yêu cầu cấp hồ sơ cuối kỳ, được cấp ổn định từ G0. Các tag `REQ_*` và `TC_*` trong feature hiện tại vẫn là mã nháp cấp Rule/scenario; G1 sẽ lập ánh xạ đầy đủ, không tự đổi hoặc xóa mã cũ ở G0.

“Bắt buộc môn học” có căn cứ SRC01–SRC03/SRC05 và tài liệu hướng dẫn đã nêu. “Quyết định đã xác nhận” là lựa chọn của người dùng, không tự gán thành quy định toàn lớp. “Yêu cầu kiểm soát của người dùng” thuộc SRC13. BR và UML trong cột kế thừa là tài nguyên cần review tại mốc tương ứng, chưa là kết quả được duyệt.

| Mã | Phân loại | Yêu cầu | Căn cứ kiểm tra | Nháp có thể kế thừa / phần cần hoàn thiện | Mốc phải có bằng chứng |
|---|---|---|---|---|---|
| REQ-F01 | Bắt buộc môn học | Guest xem danh sách sách | SRC01 tr.1, Guest dòng 1 | Scenario: TC_CATALOG_SC001, TC_CATALOG_SC002, TC_CATALOG_SC004; sơ đồ hỗ trợ AD01, SQ01 | G1/G4 |
| REQ-F02 | Bắt buộc môn học | Guest xem chi tiết sách | SRC01 tr.1, Guest dòng 2 | Scenario: TC_CATALOG_SC005, TC_CATALOG_SC006, TC_CATALOG_SC007; sơ đồ hỗ trợ AD01, SQ01 | G1/G4 |
| REQ-F03 | Bắt buộc môn học | Chọn mua từ cả danh sách và chi tiết | SRC01 tr.1, Guest dòng 3 | Scenario: TC_CART_SC008, TC_CART_SC009; sơ đồ hỗ trợ AD02, SQ02 | G1/G4 |
| REQ-F04 | Bắt buộc môn học | Xem giỏ và sửa số lượng, số lượng 0 bỏ dòng | SRC01 tr.1, Guest dòng 4–5 | Scenario: TC_CART_SC014, TC_CART_SC016, TC_CART_SC017, TC_CART_SC018; sơ đồ hỗ trợ AD02, SQ02 | G1/G4 |
| REQ-F05 | Bắt buộc môn học | Guest đăng ký tài khoản; hỗ trợ email và mạng xã hội | SRC01 tr.1, Guest dòng 6; SRC05 Xác thực | Scenario: TC_AUTH_SC020, TC_AUTH_SC021, TC_AUTH_SC024, TC_AUTH_SC026, TC_AUTH_XT01, TC_AUTH_XT06, TC_AUTH_XT07; sơ đồ hỗ trợ AD08, AD08B, SQ08, SQ08B | G1/G4 |
| REQ-F06 | Bắt buộc môn học | Customer có quyền Guest và đăng nhập/đăng xuất | SRC01 tr.1, Customer | Scenario: TC_AUTH_SC027, TC_AUTH_SC028, TC_AUTH_SC029, TC_AUTH_SC030, TC_AUTH_SC031, TC_CHECKOUT_SC032; sơ đồ hỗ trợ AD08, SQ02 | G1/G4 |
| REQ-F07 | Bắt buộc môn học | Customer đặt/thanh toán và xem trạng thái đơn | SRC01 tr.1, Customer dòng 1–2 | Scenario: TC_CHECKOUT_SC033, TC_CHECKOUT_SC034, TC_ORDER_SC047, TC_ORDER_SC048; sơ đồ hỗ trợ AD04, SQ04, SQ06B, ST01, ST02 | G1/G4 |
| REQ-F08 | Bắt buộc môn học | Admin có quyền Customer và tìm sách/loại/tài khoản/đơn | SRC01 tr.1, Admin mở đầu và dòng 1 | Scenario: TC_CHECKOUT_SC032, TC_ADMIN_SC051, TC_ADMIN_SC052, TC_ADMIN_SC053; sơ đồ hỗ trợ AD09, SQ09 | G1/G4 |
| REQ-F09 | Bắt buộc môn học | Admin quản lý sách, loại sách, tài khoản, đơn | SRC01 tr.1, Admin dòng 2–4 | Scenario: TC_CATALOG_SC054, TC_CATALOG_SC060, TC_AUTH_SC064, TC_ORDER_SC069; sơ đồ hỗ trợ AD09, SQ09 | G1/G4 |
| REQ-F10 | Bắt buộc môn học | Nghiệp vụ kho | SRC05 dòng Kho | Scenario: TC_INV_KHO01, TC_INV_KHO02, TC_INV_KHO05, TC_INV_KHO06, TC_INV_KHO07, TC_INV_KHO08; sơ đồ hỗ trợ AD07, SQ07, ST03 | G1/G4 |
| REQ-F11 | Bắt buộc môn học | Bán bình thường | SRC05 dòng Bán hàng | Scenario: TC_PRICE_BH01; sơ đồ hỗ trợ AD03, SQ03 | G1/G4 |
| REQ-F12 | Bắt buộc môn học | Bán giảm giá | SRC05 dòng Bán hàng | Scenario: TC_PRICE_BH02, TC_PRICE_BH03, TC_PRICE_BH04; sơ đồ hỗ trợ AD03, SQ03, AD09, SQ09 | G1/G4 |
| REQ-F13 | Bắt buộc môn học | Voucher và coupon | SRC05 dòng Bán hàng | Scenario: TC_PRICE_BH05, TC_PRICE_BH06, TC_PRICE_BH07, TC_PRICE_BH08, TC_PRICE_BH09, TC_PRICE_BH10, TC_PRICE_BH11; sơ đồ hỗ trợ AD03, SQ03, SQ04 | G1/G4 |
| REQ-F14 | Bắt buộc môn học | Bán sỉ | SRC05 dòng Bán hàng | Scenario: TC_PRICE_BH12, TC_PRICE_BH13, TC_PRICE_BH14; sơ đồ hỗ trợ AD03, SQ03 | G1/G4 |
| REQ-F15 | Bắt buộc môn học; nghĩa bộ đã xác nhận | Bán bộ là combo | SRC05 dòng Bán hàng; SRC14 | Scenario: TC_PRICE_BH15, TC_PRICE_BH16, TC_PRICE_BH17; sơ đồ hỗ trợ AD03, SQ03, SQ04, ST03 | G1/G4 |
| REQ-F16 | Bắt buộc môn học; nghĩa mua kèm đã xác nhận | Bán đính kèm là sách/phụ kiện mua thêm có tính tiền | SRC05 dòng Bán hàng; SRC14 | Scenario: TC_PRICE_BH18, TC_PRICE_BH19, TC_PRICE_BH20, TC_PRICE_BH21, TC_PRICE_BH22, TC_CART_GH01, TC_CART_GH02; sơ đồ hỗ trợ AD02, AD03, SQ03, SQ04 | G1/G4 |
| REQ-F17 | Bắt buộc môn học; phương thức đã xác nhận | Đơn hàng và COD | SRC05 dòng Đơn hàng/Thanh toán; SRC14 | Scenario: TC_CHECKOUT_SC034, TC_PAY_TT01, TC_PAY_TT02, TC_PAY_TT03, TC_PAY_TT04, TC_PAY_TT05, TC_PAY_TT07; sơ đồ hỗ trợ AD04, AD05, AD06, SQ04, SQ05, SQ06, ST01, ST02 | G1/G4 |
| REQ-F18 | Quyết định đã xác nhận | Email/mật khẩu; xác minh email trước đặt đơn | SRC14, xác nhận 29/10 và tiếp tục có hiệu lực | Scenario: TC_AUTH_XT01, TC_AUTH_XT02, TC_AUTH_XT03, TC_AUTH_XT04, TC_AUTH_XT05; sơ đồ hỗ trợ AD08B, SQ08, SQ04 | G1/G4 |
| REQ-F19 | Quyết định đã xác nhận | Email và Facebook tích hợp dịch vụ thật | SRC14, xác nhận 04/11 | Scenario: TC_AUTH_NEW009, TC_AUTH_NEW010, TC_AUTH_XT06, TC_AUTH_XT07; sơ đồ hỗ trợ SQ08, SQ08B | G1/G3/G4 |
| REQ-F20 | Yêu cầu kiểm soát của người dùng | Backend xác minh lại giá/tồn và lưu snapshot đơn | SRC13 mục 2 | Scenario: TC_CHECKOUT_SC039, TC_CHECKOUT_NEW005, TC_ORDER_DH07; sơ đồ hỗ trợ SQ03, SQ04, SQ06B, DFD02 | G1/G4 |
| REQ-F21 | Yêu cầu kiểm soát của người dùng | Không bán vượt tồn hoặc tạo thêm đơn/hoàn tồn khi yêu cầu lặp | SRC13 mục 2 và 6 | Scenario: TC_INV_SC046, TC_ORDER_DH03, TC_ORDER_DH04, TC_ORDER_DH05, TC_ORDER_DH06, TC_CHECKOUT_NEW006, TC_CHECKOUT_NEW016, TC_ORDER_NEW017; sơ đồ hỗ trợ SQ04, SQ04B, SQ06, ST03 | G1/G3/G4 |
| REQ-F22 | Yêu cầu kiểm soát của người dùng | Chỉ xem đơn của mình, kiểm quyền quản trị | SRC13 mục 2; SRC01 tr.1 phân vai | Scenario: TC_ORDER_SC048, TC_ORDER_SC049, TC_ADMIN_SC053, TC_CART_NEW008; sơ đồ hỗ trợ SQ06B, SQ09, SQ02 | G1/G4 |
| REQ-F23 | Yêu cầu bổ sung của người dùng trước | Giới thiệu website và tìm kiếm/lọc sách công khai | SRC16 mục 2, dòng 24; SRC15 nháp NEW001–004 | Scenario: TC_CATALOG_NEW001, TC_CATALOG_NEW002, TC_CATALOG_NEW003, TC_CATALOG_NEW004; sơ đồ hỗ trợ AD01, SQ01 | G1/G4 |
| REQ-A01 | Bắt buộc môn học | Gherkin mô tả các tính năng | SRC02 tr.2 mục 1; SRC03 tr.1 mục 3.1 | Chưa có bằng chứng hoàn thành theo mốc mới | G1/G4 |
| REQ-A02 | Bắt buộc môn học | Class UML và file draw.io riêng mỗi sinh viên, khớp code | SRC02 tr.2 mục 2; SRC03 tr.1 mục 3.2 | Thiếu class UML website và thiếu .drawio; 28 hình hỗ trợ không thay thế yêu cầu này | G2/G4/G5 |
| REQ-A03 | Bắt buộc môn học | SOLID tại cấp kiến trúc và đúng hướng dependency | SRC02 tr.2; SRC06 s.12,16,18; SRC08 s.2–9 | Chưa có bằng chứng hoàn thành theo mốc mới | G2/G4 |
| REQ-A04 | Bắt buộc môn học | Thành phần được giải thích bằng policy và level | SRC02 tr.2; SRC12 ch.19, tr.in 183–187 | Chưa có bằng chứng hoàn thành theo mốc mới | G2/G4 |
| REQ-A05 | Bắt buộc môn học | Mỗi tính năng là lát cắt dọc hẹp, dùng Tracer Bullet | SRC02 tr.2; SRC08 s.6–8; SRC09 s.5–8 | Chưa có bằng chứng hoàn thành theo mốc mới | G1/G2/G4 |
| REQ-A06 | Bắt buộc môn học | Tư duy DDD có thuật ngữ, trách nhiệm và invariant phù hợp | SRC02 tr.2; SRC11 tr.in 79–85 | Chưa có bằng chứng hoàn thành theo mốc mới | G1/G2/G4 |
| REQ-A07 | Bắt buộc môn học | Request/Response và Input/Output Boundary rõ | SRC02 tr.2; SRC07 s.4–10 | CP01/D04 đang trả response trực tiếp; cần đối chiếu OutputBoundary của SRC07 ở G2 | G2/G4 |
| REQ-A08 | Bắt buộc môn học | Patterns phù hợp với vấn đề; giải thích phương án đơn giản hơn | SRC02 tr.2; SRC13 mục 5 | Chưa có bằng chứng hoàn thành theo mốc mới | G2/G4 |
| REQ-A09 | Bắt buộc môn học | Để mở các tùy chọn có cơ sở | SRC02 tr.2; SRC06 s.7; SRC08 s.11 | Chưa có bằng chứng hoàn thành theo mốc mới | G2/G3 |
| REQ-A10 | Quyết định đã xác nhận | Java, Spring Boot, PostgreSQL qua Docker; Jupiter viết test | SRC14 ngày 04/11 | Đã xác nhận tên công nghệ; chưa có build website, phiên bản tương thích và cấu hình DB | G3/G4 |
| REQ-Q01 | Bắt buộc môn học | Glue code và unit tests, có ảnh thật | SRC02 tr.2 mục 3.1–3.2; SRC03 tr.1 mục 3.3 | Chưa có bằng chứng hoàn thành theo mốc mới; test/code website chưa thực hiện | G3/G4/G5 |
| REQ-Q02 | Yêu cầu kiểm soát của người dùng | BDD/TDD: red, green, refactor; business logic ngoài glue | SRC13 mục 6; SRC10 PDF 4,6–12 | Chưa có bằng chứng hoàn thành theo mốc mới; test/code website chưa thực hiện | G3/G4 |
| REQ-Q03 | Yêu cầu kiểm soát của người dùng | Phân biệt unit/integration/E2E và không suy fake test thành transaction DB thật | SRC13 mục 6; SRC11 tr.in 191–194 | Chưa có bằng chứng hoàn thành theo mốc mới; test/code website chưa thực hiện | G3/G4 |
| REQ-Q04 | Yêu cầu kiểm soát của người dùng | Truy vết REQ → BR → Scenario → UML → Test → Code → Bằng chứng | SRC13 mục 7 | Chưa có bằng chứng hoàn thành theo mốc mới; test/code website chưa thực hiện | G1–G5 |
| REQ-D01 | Bắt buộc môn học | Bố cục báo cáo, hình thức/chính tả, trích nguồn | SRC03 tr.1 mục 1–2; SRC04 tr.1–3 | Chưa có bằng chứng hoàn thành theo mốc mới | G3/G5 |
| REQ-D02 | Bắt buộc môn học | Một báo cáo/tài liệu sống duy nhất; ảnh từng feature | SRC02 tr.2 mục 4; SRC03 tr.1 mục 3.4 | Chưa có bằng chứng hoàn thành theo mốc mới | G1/G4/G5 |
| REQ-D03 | Bắt buộc môn học | Chương trình đáp ứng chức năng đề tài | SRC03 tr.1 mục 3.5; SRC01 | Chưa có bằng chứng hoàn thành theo mốc mới; test/code website chưa thực hiện | G4/G5 |
| REQ-D04 | Yêu cầu kiểm soát của người dùng | Duyệt tuần tự G0–G5, chỉ code lát cắt được cho phép | SRC13 mục 3 và 8 | Chưa có bằng chứng hoàn thành theo mốc mới | G0–G5 |

## Đối chiếu từng mục phiếu chấm

| Mục phiếu chấm SRC03 | Đầu ra để đối chiếu cuối bài | Hiện trạng G0 |
|---|---|---|
| 1 Bố cục | Báo cáo theo cấu trúc SRC02 và bìa SRC04 | Chờ duyệt phạm vi; chưa lập báo cáo cuối |
| 2 Hình thức | Font/cỡ/căn lề, chính tả, trích nguồn, kiểm render | Đã đọc mẫu; chưa có báo cáo cuối để chấm hình thức |
| 3 Nội dung | Nhóm các mục 3.1–3.5 | Không tự tính là một trọng số |
| 3.1 Đặc tả | Một feature chính, BR và tiêu chí kiểm chứng | Có nháp 138 scenario; chưa duyệt lại G1 |
| 3.2 Class UML | Lớp/thuộc tính/phương thức/interface/quan hệ; draw.io cá nhân | Chưa làm class UML và draw.io cho website |
| 3.3 Bộ kiểm thử | BDD/glue, Jupiter, integration và log thật | Chưa thực hiện; không dùng báo cáo parser làm test nghiệp vụ |
| 3.4 Tài liệu sống | Một nguồn báo cáo chính gắn feature/UML/test/code | Các review cũ là tài liệu hỗ trợ; cần thiết lập nguồn báo cáo sống tại G1 |
| 3.5 Chương trình | Website chạy được cùng môi trường và hướng dẫn | Chưa thực hiện; cố ý chưa code trước cổng cho phép |
| Tổng điểm | Do giảng viên đánh giá | Để nguyên; không tự suy trọng số hay chấm điểm |

Không có căn cứ trong nguồn đã đọc để ấn định số lượng pattern hoặc phần trăm coverage bắt buộc. “Patterns phù hợp” không đồng nghĩa phải chèn Factory Method/Abstract Factory từ bài giữa kỳ vào website.
