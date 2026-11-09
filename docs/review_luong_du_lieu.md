# Review luồng dữ liệu

Review tĩnh 04/11/2026. Lần theo các scenario trọng tâm từ Given → When → nhánh → Then. Không chạy hệ thống; không suy UML hợp lệ thành phần mềm đúng.

| Mã scenario | Sơ đồ | Luồng mong đợi | Phát hiện | Mức độ | Cách sửa | Kết quả đối chiếu lại |
|---|---|---|---|---|---|---|
| TC_CART_SC008/016, NEW008 | CL01, AD02, SQ02 | Guest thêm/qty0 → owner → Cart → save version → output; kho không đổi | D04 cũ trả response trực tiếp | Cao | Qua OutputBoundary; core không biết Presenter | Phù hợp nhánh đã đối chiếu; kèm chi tiết còn mở |
| TC_AUTH_SC031, TC_CART_REV006–008 | CL02, SQ02B | SC031 giỏ Customer rỗng; hai giỏ khác thì gộp một lần hoặc giữ cả hai | Thiếu hai giỏ có sẵn | Cao | Thêm tiền điều kiện + ba scenario | Nhất quán P-MERGE chưa duyệt |
| TC_CHECKOUT_SC034 | CL04/05, SQ04, ST01/02/03 | 2S001+1S002 →420000; H giữ, R2/R1, COD chưa thu, snapshot/giỏ/key cùng commit | Phải trả success sau commit | Cao | D01 và OutputBoundary | Phù hợp QD-01; trạng thái chi tiết còn đề xuất |
| TC_CHECKOUT_SC037/NEW006 | AD04, SQ04 | Thiếu tồn/lỗi trước commit → không đơn/giữ dở; giữ giỏ | Không coi save riêng lẻ là atomic | Cao | UoW rollback toàn bộ | Đủ bước hợp đồng; chưa kiểm DB |
| TC_CHECKOUT_SC039/REV014 | SQ03, SQ04 | 120000→130000 → requote không ghi; xác nhận mới tạo đơn130000 | Thiếu invariant lúc giá đổi | Cao | Sửa feature và response newQuote | Phù hợp P-REQUOTE chưa duyệt |
| TC_CHECKOUT_NEW005 | SQ03, SQ04, DFD02 | total frontend sai → dùng catalog server | Nguồn giá phải rõ | Cao | PricingContext backend | Dữ liệu có nguồn, không tin browser |
| TC_CHECKOUT_NEW007/NEW016 | AD04, SQ04, CL05 | Commit mất phản hồi → lookup key trước giỏ; không tạo lần hai | Unknown outcome khác rollback | Cao | Nhánh tra key và chờ kết quả ổn định | Phù hợp chống lặp; retention còn mở |
| TC_INV_SC046 | SQ04B, CL05, ST03 | Còn1; hai request → tối đa một giữ1; bên thua không đơn | Sơ đồ không chứng minh khóa DB | Cao | D03 khóa/version; cần G4 integration | Invariant rõ, chưa có runtime |
| TC_ORDER_DH04 | SQ04, CL05 | Key cũ/digest mới → conflict, đơn cũ giữ | Key cần scope owner+action | Cao | Claim/RequestRecord | Không thay nội dung đơn qua retry |
| TC_PRICE_BH05/06/08/09, REV003 | CL03, AD03, SQ03 | Một mã, đúng loại/chủ; giỏ đặc biệt không cộng mã | Không tự duyệt cả giá chi tiết | Vừa | QD-02 riêng với quota/rounding | Phù hợp phần đã chốt |
| TC_PRICE_BH12/13 | CL03, SQ03 | Ngưỡng9/10/11; chọn giá thấp nhất theo phương án | Giá sỉ so giảm chưa chốt | Mở | Giữ P-PRICE-DETAIL | Nhất quán có điều kiện |
| TC_PRICE_BH15/16/17/22 | CL03/05, SQ03/04, ST03 | Gộp SKU lẻ+combo+kèm; thiếu SKU không giữ phần còn lại | Không trừ kho combo lần hai | Cao | Recipe snapshot, gộp trước khóa | Phù hợp phương án recipe |
| TC_ORDER_REV002/NEW017 | SQ06, CL05, ST03 | Hủy R đúng đơn; retry no-op; lỗi rollback trạng thái/lượng giữ | Không giải phóng đơn khác | Cao | Reservation orderId; D01 | Phù hợp QD-01 |
| TC_INV_REV009 | SQ06C, ST01/03 | Hủy thắng H10/R0 hoặc giao thắng H8/R0 | Đọc trạng thái sau khóa | Cao | Sequence riêng hai lịch | Phù hợp QD-01 + P-STATE |
| TC_INV_KHO06/07/REV013 | AD07, SQ07, CL05 | n từ reservation; lỗi phiếu rollback H/R/đơn; lặp no-op | SQ07 trả output hai lần ở SKU sai | Vừa | Một response chung sau kiểm SKU | Đã bỏ nhánh trả hai lần |
| TC_PAY_TT01/02/04/07 | SQ05, ST02 | Giao+thu đủ→Đãthu; thiếu không đổi;0 không tiền giả; retry no-op | Key không phải cash receipt | Cao | Lưu kết quả riêng receipt | Nhất quán COD đề xuất; quyền/thời điểm còn mở |
| TC_ORDER_SC049 | SQ06B | orderId AND owner → không lộ đơn khác | Không trả lỗi kèm dữ liệu riêng | Cao | Query scope owner | Phù hợp quyền đã yêu cầu |
| TC_AUTH_XT02/03/04, REV012 | SQ08, CL07 | Token hợp lệ consume+verify; mail Accepted chưa verify | Gửi thư không xác nhận chủ email | Cao | Tách trạng thái gửi và emailVerified | Phù hợp; TTL/D02 còn mở |
| TC_AUTH_XT07/REV004 | SQ08B, SQ04, CL06 | Sai state không phiên; phiên FB chưa verify không đặt | Không tin frontend role/email | Cao | Server provider/subject và kiểm email ở checkout | Phù hợp phạm vi thật; chưa gọi provider |
| TC_ADMIN_SC053 | SQ09, CP01 | Quyền server; mất quyền trước xử lý → không đọc/ghi | Thiếu nhánh dừng quyền bị thu hồi | Cao | alt Forbidden trong usecase | Đã có nhánh không chạm dữ liệu |

## Phân biệt ba hướng

- Mã nguồn: controller→InputBoundary; interactor→OutputBoundary/ports/domain; concrete presenter/adapter implements. CP01 và Class UML biểu diễn hướng này.
- Lời gọi: controller→interactor→port→adapter/presenter. Sequence là thứ tự chạy; gọi ra presenter qua interface không làm core import concrete presenter.
- Dữ liệu: Request đi vào, Response đi ra; giá/tồn từ backend. DFD01/02 chỉ nguồn/đích/kho dữ liệu, không là dependency hay trình tự gọi.

## Transaction và dịch vụ ngoài

D01 đề xuất một PostgreSQL transaction cho đơn/snapshot, reserve, quota theo chính sách được duyệt, giỏ và request key. D03 khóa/version có điều kiện, thứ tự khóa thống nhất; hủy/bàn giao đọc lại trạng thái dưới khóa. Chưa triển khai SQL/isolation/constraint.

D02 gửi thư thật sau commit qua job; provider nhận rồi mất phản hồi có thể khiến thư được gửi lại. Token chỉ verify một lần. Facebook callback không phải callback thanh toán; online ngoài phạm vi.

## Kết luận có giới hạn

**Luồng thiết kế phù hợp với các scenario đã đối chiếu trong bảng, trong phạm vi và điều kiện ghi tại từng dòng.** Không coi các quy tắc còn mở là đã duyệt.

Các scenario khác có chỉ mục Given–When–Then và liên kết ở [case_walkthrough.csv](uml/case_walkthrough.csv). Đây là truy vết cấu trúc, không khẳng định đã chạy hoặc review sâu từng case. Chưa có app/unit/integration/E2E, PostgreSQL transaction thật, mail thật hoặc Facebook callback thật.
