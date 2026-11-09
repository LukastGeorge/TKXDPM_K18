# Kế hoạch kiểm thử trước triển khai

Tất cả mục dưới đây là test case dạng văn bản, **chưa viết/chưa chạy**, không phải test tự động hoặc kết quả pass. Case còn BR mở chỉ được triển khai sau khi duyệt. Bằng chứng parser ở thư mục bang_chung chỉ là kiểm cấu trúc feature.

| Mã kế hoạch | Hành vi và scenario | Cấp | Thiết lập và oracle |
|---|---|---|---|
| KT01 | Xem công khai TC_CATALOG_SC001/SC005 | Acceptance | Seed S001; không login; đúng thông tin công khai, không dữ liệu nội bộ |
| KT02 | Mã không có SC006 | Application/HTTP | Mã không tồn tại; lỗi không tìm thấy, không cho mua, không ghi |
| KT03 | Thêm hai vị trí TC_CART_SC008 | Acceptance/Web | Giỏ trống, hai Examples độc lập; một dòng qty1, 120000 |
| KT04 | Thêm lại SC009 | Domain/acceptance | qty2 thêm1 →3, một dòng; cần duyệt S1-D02 |
| KT05 | Tổng giỏ SC012/SC015 | Jupiter | Fixture 2S001+1S002=420000; sửa3S001=360000; giá server |
| KT06 | Bỏ bằng0 SC016/SC017 | Jupiter/acceptance | Chỉ dòng chọn bị bỏ, dòng khác giữ; cuối cùng giỏ rỗng |
| KT07 | Lượng sai SC018 | Domain/adapter | Âm/lẻ/ký tự; lỗi, giỏ persisted giữ nguyên; cần S1-D02 |
| KT08 | Hai chủ SC014/NEW008 | Application/HTTP | Hai session; không đọc/sửa cartId người khác |
| KT09 | Vượt khả dụng SC010/SC011 | Application | A0 hoặc yêu cầu>A; không ghi; cần S1-D03 |
| KT10 | Giỏ không giữ TC_INV_REV001 | PostgreSQL integration | Hai giỏ chọn hàng cuối; H/R không đổi sau thêm |
| KT11 | CartPort version CL01 | Contract/DB | Hai phiên bản đọc; lần ghi cũ bị conflict, dữ liệu mới giữ |
| KT12 | Thay output port CL01 | Jupiter | Cùng Request, hai implementation thu Response; cùng nghĩa status/cart/errors, present đúng1 lần |
| KT13 | Đăng ký/xác minh TC_AUTH_XT01..05 | Unit/acceptance | Token đúng/sai/hết hạn/đã dùng; chỉ hợp lệ mới verified; TTL cần duyệt |
| KT14 | Mail thật TC_AUTH_REV012 | Provider integration | Provider nhận chưa verify; nhận thư thật, dùng token; lưu bằng chứng không lộ token |
| KT15 | Facebook TC_AUTH_XT06/XT07/REV004 | Provider/HTTP | Callback thật với state; state sai không phiên; email chưa verify không đặt |
| KT16 | Giá thường/giảm TC_PRICE_BH01..04 | Unit | Fixture độc lập, đúng giá/giảm/thời điểm; công thức cần duyệt |
| KT17 | Mã và giá đặc biệt TC_PRICE_REV003 | Acceptance | Từng chế độ + thường; từ chối code toàn đơn, không tiêu lượt |
| KT18 | Coupon/voucher BH05..11/REV011 | Domain/DB | Owner, hạn, ngưỡng, quota; một lượt với hai người; phần chi tiết còn mở |
| KT19 | Bán sỉ BH12..14 | Unit/acceptance | Dưới/đúng/trên ngưỡng, ưu tiên giá; cần duyệt |
| KT20 | Combo BH15..17 | Domain/DB | Bung recipe; thiếu một SKU không giữ bất kỳ thành phần nào |
| KT21 | Mua kèm BH18..22/GH01..02 | Domain/acceptance | Chọn mua có tiền, quan hệ chính-kèm; xử lý khi bỏ dòng chính theo chính sách được duyệt |
| KT22 | Đặt COD TC_CHECKOUT_SC034 | Acceptance/DB | Đúng snapshot; H giữ nguyên, R tăng; COD chưa thu; một commit |
| KT23 | Requote SC039/NEW005/REV014 | Application/DB | Giá mới trả lại; không đơn/hold trước chấp nhận; xác nhận rồi mới lưu snapshot |
| KT24 | Hàng cuối NEW006/SQ04B | PostgreSQL | Hai connection, barrier bắt đầu; tổng R không quá H, tối đa1 đơn giữ thành công |
| KT25 | Retry NEW016 | PostgreSQL/acceptance | Commit xong mất response; cùng owner/action/key/body trả cùng orderId, không tăng R |
| KT26 | Key đổi nội dung NEW007 | Application/DB | Cùng key khác fingerprint trả conflict; đơn cũ nguyên |
| KT27 | Hủy lặp TC_ORDER_REV002 | PostgreSQL | Hai đơn đang giữ; hủy DH01 hai lần; R của DH02 giữ nguyên |
| KT28 | Hủy cùng bàn giao TC_INV_REV009 | PostgreSQL | Hai giao dịch đồng thời; một transition và một biến đổi stock hợp lệ |
| KT29 | Lỗi ledger TC_INV_REV013 | PostgreSQL | Gây lỗi tại bước ghi trước commit; rollback order/reservation/H/R/ledger |
| KT30 | COD TC_PAY_TT01..07 | Domain/DB | State, quyền, tiền khớp, key; tạo/bàn giao không tự Paid; retry không receipt thứ2 |
| KT31 | Điều chỉnh kho KHO05/REV010 | Domain/DB | actual>=R; phiếu key đổi nội dung không ghi; audit nhất quán |
| KT32 | Đơn đúng chủ TC_ORDER_SC048/SC049 | Application/HTTP | Chủ xem được; người khác không nhận nội dung; không ghi |
| KT33 | Quyền admin TC_ADMIN_SC053 | Application/HTTP | Role server, mất quyền trước usecase; không đọc/ghi tác vụ bị cấm |

## Thu thập bằng chứng

Mỗi lần chạy ghi command thật, working directory, phiên bản, scenario/test selection, số phát hiện/đạt/lỗi/bỏ qua và log. Chưa có pom hoặc runner nên không điền lệnh Maven giả là đã chạy. Khi thiết lập build, README phải nêu lệnh đã kiểm chứng trên cấu hình đó.

BDD acceptance nối Gherkin với Input Boundary. Unit Jupiter kiểm quy tắc nhỏ bằng fake đủ hợp đồng. Integration dùng PostgreSQL thật cho khóa/constraint/rollback và provider thật cho email/Facebook. E2E chọn luồng chính và lỗi quyền từ web; không cần chạy mọi phép tính qua browser.

TDD lưu Red đúng lý do hành vi thiếu, Green sau implementation, Refactor giữ hành vi và chạy lại. Lỗi hạ tầng/compile được phân loại riêng. Không đổi expected chỉ để xanh; không thêm hành vi dưới nhãn refactor. Kiểm concurrency dùng barrier/latch, không dựa may rủi vào sleep.

## Điều kiện nghiệm thu một lát cắt

- Không undefined/pending bị che giấu trong phạm vi được chọn; không dùng bộ lọc để tuyên bố toàn feature pass.
- Test phát hiện thật, không JUnit trong production; glue không chứa nghiệp vụ.
- Tác dụng phụ và rollback được kiểm ở cấp phù hợp.
- Trace REQ/BR/TC/UML/test/code/log, ảnh thật đọc được; UML tên/chữ ký khớp Java.
- Phần ngoài lát cắt vẫn ghi chưa thực hiện. Nghiệm thu từng lát cắt không đồng nghĩa duyệt cả bài.
