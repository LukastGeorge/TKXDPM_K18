# Quy tắc nghiệp vụ hiện hành

Nguyễn Duy Trường — 24150180. Cập nhật 04/11/2026. Đây là nguồn trạng thái BR hiện hành; G0 giữ lịch sử khảo sát.

## Quyết định

| Mã | Phạm vi đã xác nhận | Căn cứ |
|---|---|---|
| QD-00 | Được sửa feature và tạo UML; chưa code | Yêu cầu “sửa hoàn thiện lại file feature và cho tôi sơ đồ UML”, tiếp theo “làm tiếp đê” |
| QD-01 | Giỏ không giữ; đặt giữ; bàn giao xuất; hủy trước bàn giao giải phóng một lần | Người dùng trả lời “Chốt cả hai phương án” 04/11/2026 |
| QD-02 | Coupon giảm %, voucher cố định cho tài khoản; tối đa 1 mã/đơn giá thường, không cộng giảm sản phẩm/sỉ/combo/mua kèm | Cùng xác nhận trên |

QD-00 cho phép làm G1/G2, không phải duyệt bản cuối hoặc G3. QD-02 không tự duyệt làm tròn/ngưỡng/quota/giá sỉ so với giảm sản phẩm hoặc số tiền về 0. Các trường hợp còn chi tiết mở giữ tag @needs_confirmation.

## Sổ BR

| Mã | Hợp đồng / phương án | Ví dụ | Từ chối và dữ liệu giữ nguyên | Trạng thái |
|---|---|---|---|---|
| BR-001 | **Định danh sách/ấn bản:** Chưa chốt SKU/ISBN/ấn bản và cách phân biệt bản dịch, bìa, năm xuất bản. | Hai ấn bản cùng tên có thể là hai SKU; đây chỉ là đề xuất. | Không được tự gộp tồn chỉ vì trùng tên. | Chờ duyệt G1 |
| BR-002 | **Tác giả/NXB/thể loại và công khai:** Có sách/loại trong phạm vi; cardinality và điều kiện ngừng bán chưa chốt. | Một sách có hai tác giả là ví dụ cần xác nhận. | Sách bị ẩn không hiện cho guest theo phương án nháp. | Chờ duyệt G1 |
| BR-003 | **Số lượng giỏ:** Chỉnh về 0 bỏ sản phẩm là yêu cầu gốc; miền số nguyên/giới hạn trên phải đặc tả. | qty=0 bỏ dòng; qty=-1 dự kiến bị từ chối. | Đề xuất giữ nguyên giỏ nếu qty sai. | Đã có căn cứ cho 0; chi tiết chờ G1 |
| BR-004 | **Giá thường và tiền tệ:** Có bán thường; cách tính tiền/phí/tiền tệ chưa chốt đầy đủ. | Fixture 2 × 120000 VND = 240000 VND; không tự suy miễn phí vận chuyển. | Đề xuất từ chối cấu hình đơn giá âm. | Chờ duyệt G1 |
| BR-005 | **Giảm giá sản phẩm:** Phải có; công thức, làm tròn và biên thời gian chưa duyệt. | Giảm 10% trên 120000 → 108000 chỉ là phương án. | Ví dụ giảm >100% hoặc hết hạn phải có kết quả được duyệt. | Chờ duyệt G1 |
| BR-006 | **Coupon:** Giảm phần trăm đã chốt QD-02; ngưỡng/trần/lượt/hạn còn đề xuất. | Coupon 20% trên 240000 giảm 48000 chỉ là fixture. | Mã không hợp lệ không đổi báo giá hoặc tiêu lượt. | Cốt lõi đã chốt; chi tiết còn mở |
| BR-007 | **Voucher:** Tiền cố định cấp cho tài khoản đã chốt QD-02; mức giảm tối đa về 0 còn đề xuất. | VC50 của KH01 giảm 50000. | KH02 không dùng voucher KH01. | Cốt lõi đã chốt; chi tiết còn mở |
| BR-008 | **Mã và giá đặc biệt:** Tối đa một mã/đơn chỉ giá thường; có dòng giảm sản phẩm/sỉ/combo/kèm thì không áp mã toàn đơn. Chọn giá thấp nhất giữa sỉ/giảm chưa chốt. | Giỏ sách thường+combo không thêm coupon. | Không tự đổi mã cũ/giá khi mã mới bị từ chối. | QD-02 đã chốt phần mã; cách chọn giá còn mở |
| BR-009 | **Hạn/lượt/khách/hủy mã:** Cần xác định thời hạn, số lượt, mỗi khách và lúc giữ/tiêu/hoàn lượt. | Mã còn 1 lượt và hai người dùng đồng thời. | Không tiêu cùng lượt hai lần theo yêu cầu chống lặp; thời điểm cụ thể chưa chốt. | Chờ duyệt G1 |
| BR-010 | **Giá sỉ:** Phải có; ngưỡng, theo SKU hay tổng giỏ và giá chọn chưa chốt. | Mua 10 quyển cùng mã có giá khác là ví dụ. | Không áp giá sỉ dưới ngưỡng nếu quy tắc đó được duyệt. | Chờ duyệt G1 |
| BR-011 | **Combo:** Bộ là combo đã xác nhận; công thức giá và trừ tồn từng thành phần chưa duyệt. | 2 bộ {S001×1, S002×1} cần 2 mỗi SKU theo phương án nháp. | Thiếu thành phần thì không giữ dở nếu chọn P-STOCK/D01. | Đã xác nhận nghĩa; chi tiết chờ G1 |
| BR-012 | **Mua kèm:** Là sách/phụ kiện khách mua thêm có tính tiền; không mặc định là quà. | Khách chọn phụ kiện đi kèm sách; tỷ lệ/giá còn mở. | Đề xuất không tự thêm món khách chưa chọn. | Đã xác nhận nghĩa; chi tiết chờ G1 |
| BR-013 | **H/R/A:** H thực tế, R đang giữ, A=H−R; invariant không âm và R<=H diễn đạt QD-01. Quyền/phiếu kiểm kê chưa chốt. | H10, R2, A8. | Kiểm kê không phá lượng giữ của đơn khác. | Cốt lõi theo QD-01; chi tiết còn mở |
| BR-014 | **Giữ/xuất:** Giỏ không giữ; tạo đơn R+=n; bàn giao H-=n, R-=n, n lấy từ reservation/snapshot. | Đặt 2 khi H=10→H10, R2; bàn giao→H8, R0. | Bàn giao lặp không xuất lại; không giữ dở nếu thiếu hàng. | Đã chốt QD-01 |
| BR-015 | **Hủy:** Trước bàn giao chỉ giải phóng đúng reservation một lần, R-=n, H không đổi. Quyền chủ đơn/admin và trạng thái cụ thể chờ P-STATE. | DH01 hủy 2 không đụng lượng giữ1 của DH02. | Không hoàn lần hai hoặc giả lập nhập trả sau bàn giao. | Cốt lõi đã chốt QD-01; quyền còn mở |
| BR-016 | **Chủ giỏ Guest/Customer:** Giỏ thuộc người đang thao tác; cách định danh, thời hạn và phục hồi chưa chốt. | Hai phiên guest có hai giỏ riêng theo nháp. | Đề xuất từ chối sửa cartId của người khác. | Chờ duyệt G1 |
| BR-017 | **Gộp giỏ P-MERGE:** Cộng dòng cùng SKU/chế độ/liên kết; báo lại giá. Vượt khả dụng thì giữ hai bản và cho chủ điều chỉnh. Transfer nguồn một lần. | Guest 1 + Customer 2 = 3; tổng 5 > 4 thì chưa gộp. | Không cắt/làm mất lựa chọn, không cộng lần hai khi retry. | Đề xuất chưa duyệt; REV006–008 |
| BR-018 | **Giá/tồn thay đổi:** Backend cần kiểm lại; cách yêu cầu xác nhận/requote là phương án. | Giá mới 130000 thay vì 120000 sau khi thêm giỏ. | Không dùng tổng frontend giả để tạo khoản phải thu. | Chờ duyệt G1 |
| BR-019 | **Trạng thái đơn/tiền:** Phải phân biệt; bộ trạng thái và quyền chuyển cần duyệt. | Đơn COD Chờ xác nhận và tiền Chưa thu là phương án nháp. | Đề xuất chặn chuyển từ Chờ xác nhận thẳng Hoàn tất. | Chờ duyệt G1 |
| BR-020 | **Ghi nhận COD:** COD đã xác nhận; lúc ghi đã thu và người có quyền còn cần duyệt. | Phương án admin ghi giao thành công và tiền khớp snapshot. | COD tạo đơn không mặc định đã thu tiền. | Phương thức đã xác nhận; chi tiết chờ G1 |
| BR-021 | **Hủy sau thu/hoàn tiền:** Chưa có phạm vi được duyệt cho trả hàng/hoàn tiền/đối soát sau thu. | Đơn đã bàn giao bị trả là ví dụ cần quyết định riêng. | Không tự gộp trả hàng vào hủy trước giao. | Chờ xác nhận phạm vi tại G1 |
| BR-022 | **Snapshot đơn:** Cần lưu giá/giảm/thông tin đã chấp nhận; tập trường phải duyệt. | Đơn đã chốt 190000 không đổi khi cấu hình giá mới thay. | Không lấy giá catalog mới để sửa ngầm đơn cũ. | Chờ duyệt G1 |
| BR-023 | **Hai khách mua hàng cuối:** Không bán vượt lượng có thể bán; cơ chế khóa/version chưa chọn. | Còn 1, hai yêu cầu độc lập: tối đa một bên được giữ. | Bên còn lại không tạo đơn giữ dở. | Yêu cầu kiểm soát đã nêu; cơ chế chờ G2/G3 |
| BR-024 | **Yêu cầu lặp:** Không tạo đơn/trừ/hoàn thêm; key/fingerprint/thời gian lưu cần duyệt. | Mất phản hồi sau commit rồi gửi lại cùng key. | Cùng key đổi nội dung dự kiến báo xung đột. | Yêu cầu kiểm soát đã nêu; chi tiết chờ G1/G2 |
| BR-025 | **Xem đơn đúng chủ:** Người dùng kiểm soát bắt buộc quyền xem đơn riêng. | KH01 xem đơn KH01; admin theo quyền quản trị. | KH01 không được nhận nội dung đơn KH02. | Căn cứ SRC13; chi tiết lỗi chờ G1 |
| BR-026 | **Email/mật khẩu/xác minh:** Email thật và xác minh trước đặt đã xác nhận; TTL/mật khẩu/chuẩn hóa chưa chốt. | Email chưa xác minh bị chặn đặt; TTL 30 phút chỉ là fixture nháp. | Token sai/hết hạn không làm tài khoản thành đã xác minh. | Phạm vi đã xác nhận; chi tiết chờ G1 |
| BR-027 | **Facebook thật:** Phải dùng provider thật; cách liên kết, quyền và xử lý email trùng chưa chốt. | Đăng nhập lại định danh provider cũ không tạo tài khoản trùng theo đề xuất. | Không tự ghép hai tài khoản chỉ từ email frontend. | Phạm vi đã xác nhận; chi tiết chờ G1/G3 |
| BR-028 | **Phân vai:** Guest, Customer, Admin; Admin được các chức năng Customer theo đề. | Admin vẫn có thể mua vào giỏ riêng. | Guest không được quản trị; không lấy role tự gửi để cấp quyền. | Có căn cứ SRC01; hợp đồng lỗi chờ G1 |
| BR-029 | **Không guest checkout:** Thanh toán thuộc Customer; không thêm guest checkout theo SRC13. | Guest có giỏ chọn đặt sẽ được yêu cầu đăng nhập. | Không tạo đơn/thanh toán cho guest ở luồng này. | Có căn cứ SRC01/SRC13 |
| BR-030 | **Lỗi dịch vụ mail thật:** Phải có xử lý khi dịch vụ ngoài thất bại; outbox/worker là đề xuất, không bắt buộc. | Provider gửi lỗi: chưa xác minh; có thể giữ yêu cầu gửi để retry theo D02. | Không báo đã xác minh chỉ vì gọi send thành công. | Chờ duyệt G1/G2 |
| BR-031 | **Giới thiệu/tìm lọc công khai:** Có trong yêu cầu người dùng trước; trường tìm, bộ lọc và cách khớp chưa duyệt chi tiết. | Tìm theo từ khóa và lọc loại sách là phương án nháp. | Khoảng giá đảo ngược dự kiến trả lỗi và không sửa dữ liệu. | Phạm vi giữ lại; chi tiết chờ G1 |

## Thuật ngữ và dữ liệu mẫu

| Thuật ngữ | Ý nghĩa |
|---|---|
| SKU | Đề xuất định danh tồn/bán riêng từng ấn bản; không dùng tên sách làm khóa |
| Offer / chế độ bán | Thường, giảm sản phẩm, sỉ, combo, mua kèm; cùng SKU có thể xuất hiện ở các chế độ khác nhau |
| Quote | Backend báo giá hiện tại; chưa cam kết hàng hoặc lượt mã |
| Snapshot đơn | Bản giá/giảm/phí/recipe/thông tin nhận đã được chấp nhận, không đổi ngầm theo catalog |
| Reservation | Lượng SKU giữ theo orderId, khác tồn thực tế |
| H / R / A | Thực tế / đang giữ / khả dụng=H−R; số nguyên theo sản phẩm |
| Idempotency | Cùng owner+action+key+fingerprint chỉ một tác dụng phụ |
| Request/Response | Dữ liệu use case, không mang đối tượng HTTP/ORM |
| Port / boundary | Hợp đồng ở application, adapter bên ngoài thực hiện |

Các mã KH01/QT01/S001, email .example.test, mật khẩu, giờ thử và giá đều là fixture. “Thông tin nhận hàng hợp lệ” trong scenario cũ là fixture: người nhận Nguyễn An, điện thoại 0900000001, địa chỉ “12 Đường Sách, Phường Thử, TP Thử”. Không phải khách thật. Phí 0 chỉ cho fixture, không suy ra miễn phí toàn website.

## Những nhóm chi tiết còn mở

P-EDITION/cardinality; P-MERGE; chọn giá sỉ/giảm/làm tròn; quota/hạn/giữ-tiêu-hoàn lượt; giá và tỷ lệ combo/kèm; P-STATE/quyền COD; phí; auth TTL/mật khẩu/linking. Feature mô tả các phương án để review, không gọi chúng là đã duyệt.

Java/Spring Boot, PostgreSQL qua Docker, Jupiter, email/Facebook thật, COD là các quyết định trước tiếp tục có hiệu lực. Không tự thêm online, hoàn tiền/trả hàng hoặc microservices.
