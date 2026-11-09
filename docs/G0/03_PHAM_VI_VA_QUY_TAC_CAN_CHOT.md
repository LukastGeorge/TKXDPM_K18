> **Hồ sơ khảo sát G0 giữ để truy vết.** Quyết định hiện hành QD-01/02 và phạm vi được phép làm tài liệu xem [sổ BR](../QUY_TAC_NGHIEP_VU.md), [báo cáo sống](../BAO_CAO_SONG.md). Nội dung “chưa chốt kho/mã” phía dưới mô tả thời điểm khảo sát trước quyết định mới.

# Phạm vi và sổ quy tắc cần chốt

## Thông tin đã xác nhận

Nguyễn Duy Trường, MSSV 24150180, làm cá nhân. Ngành Công nghệ thông tin, chuyên ngành Kỹ thuật phần mềm; giảng viên Lê Huỳnh Phước. Học phần Thiết kế và xây dựng phần mềm. Thông tin ngành/chuyên ngành và mã lớp 241401 – 020100138702 được lấy từ trao đổi trước; tên giảng viên cũng có trong SRC03. Không bịa thêm người cùng nhóm hoặc phân công đóng góp.

| Quyết định | Căn cứ duyệt | Tác động |
|---|---|---|
| Làm trong thư mục website người dùng đã tạo | Xác nhận trực tiếp 04/11 | Không đổi tên thư mục bài tích hai số, không chuyển sang TL |
| Làm cá nhân | Xác nhận 04/11 | Chuẩn bị một file .drawio cá nhân khi sang G2 |
| Java + Spring Boot | Xác nhận 04/11 | Core Java độc lập với các kiểu HTTP/JPA ở ranh giới |
| PostgreSQL chạy bằng Docker | Xác nhận 04/11 | Cần integration test với DB thật trước khi khẳng định transaction/concurrency |
| Jupiter viết unit test | Xác nhận 04/11 | Chưa tự thêm Mockito/AssertJ/TestNG; công cụ chạy Gherkin được đề xuất riêng ở G3 |
| Email và Facebook tích hợp thật | Xác nhận 04/11 | Fake chỉ hỗ trợ unit test; không thay cho bằng chứng tích hợp thật |
| COD; online là hướng mở rộng | Xác nhận trước, chưa bị thu hồi | Không vẽ online như đã triển khai hoặc tự thêm cổng thanh toán |
| Xác minh email trước đặt; bộ=combo; mua kèm có tính tiền | Xác nhận trước | Chi tiết thời hạn/công thức/giới hạn vẫn cần G1 |

Các quyết định riêng đã được người dùng xác nhận; **chưa đồng nghĩa G0, G1 hoặc G2 đã được duyệt**.

## Phạm vi chức năng đề nghị duyệt G0

Giữ đủ sáu nhóm bắt buộc: kho; bán thường/giảm giá/voucher/coupon/sỉ/combo/mua kèm; giỏ; xác thực tài khoản/email/Facebook; đơn; COD. Không coi sỉ, combo hay mua kèm là tùy chọn để bỏ. “Chưa chốt quy tắc” có nghĩa cần hoàn thiện ở G1, không có nghĩa được loại nghiệp vụ khỏi bài.

| Hành động | Guest | Customer | Admin |
|---|---|---|---|
| Xem danh sách/chi tiết, chọn mua từ hai vị trí, xem/sửa giỏ | Có | Có | Có |
| Sửa qty=0 để bỏ sản phẩm | Có | Có | Có |
| Đăng ký bằng thông tin/email/mạng xã hội | Có | Theo trạng thái tài khoản | Theo trạng thái tài khoản |
| Đăng nhập/đăng xuất | Guest bắt đầu đăng nhập | Có | Có |
| Đặt/thanh toán COD, xem trạng thái đơn cá nhân | Không | Có | Có, theo quyền Customer |
| Tìm kiếm sách/loại/tài khoản/đơn ở quản trị | Không | Không | Có |
| Quản lý sách/loại/tài khoản/đơn | Không | Không | Có |
| Nhập/điều chỉnh/bàn giao kho, xác nhận COD | Không | Không | Quyền chi tiết cần duyệt G1 |

Giới thiệu và tìm/lọc công khai được giữ trong phạm vi theo yêu cầu trước của người dùng (SRC16 mục 2), không tự loại bỏ. SRC01 chỉ liệt kê tìm kiếm rõ ràng cho Admin; vì vậy phân loại phần tìm/lọc công khai là yêu cầu bổ sung của người dùng, không tự gọi là dòng bắt buộc được viết trong SRC01. Chi tiết bộ lọc/cách so khớp chờ G1.

Ngoài phần đã xác nhận: online, hoàn tiền/trả hàng sau thu, đối soát vận chuyển hoặc các mạng xã hội khác phải có quyết định phạm vi riêng. Không tự mở rộng microservices, marketplace, quản lý nhà cung cấp đầy đủ hoặc hệ thống vận chuyển.

## Sổ BR để hoàn thiện tại G1

Các mã dưới được cấp để truy vết. Một dòng có thể chứa phần đã có căn cứ và phần còn chờ; ví dụ số chỉ là fixture/thảo luận. G0 chưa biến toàn bộ BR thành đặc tả được duyệt.

| Mã | Chủ đề và mô tả | Ví dụ | Từ chối/giữ dữ liệu | Trạng thái |
|---|---|---|---|---|
| BR-001 | **Định danh sách/ấn bản:** Chưa chốt SKU/ISBN/ấn bản và cách phân biệt bản dịch, bìa, năm xuất bản. | Hai ấn bản cùng tên có thể là hai SKU; đây chỉ là đề xuất. | Không được tự gộp tồn chỉ vì trùng tên. | Chờ duyệt G1 |
| BR-002 | **Tác giả/NXB/thể loại và công khai:** Có sách/loại trong phạm vi; cardinality và điều kiện ngừng bán chưa chốt. | Một sách có hai tác giả là ví dụ cần xác nhận. | Sách bị ẩn không hiện cho guest theo phương án nháp. | Chờ duyệt G1 |
| BR-003 | **Số lượng giỏ:** Chỉnh về 0 bỏ sản phẩm là yêu cầu gốc; miền số nguyên/giới hạn trên phải đặc tả. | qty=0 bỏ dòng; qty=-1 dự kiến bị từ chối. | Đề xuất giữ nguyên giỏ nếu qty sai. | Đã có căn cứ cho 0; chi tiết chờ G1 |
| BR-004 | **Giá thường và tiền tệ:** Có bán thường; cách tính tiền/phí/tiền tệ chưa chốt đầy đủ. | Fixture 2 × 120000 VND = 240000 VND; không tự suy miễn phí vận chuyển. | Đề xuất từ chối cấu hình đơn giá âm. | Chờ duyệt G1 |
| BR-005 | **Giảm giá sản phẩm:** Phải có; công thức, làm tròn và biên thời gian chưa duyệt. | Giảm 10% trên 120000 → 108000 chỉ là phương án. | Ví dụ giảm >100% hoặc hết hạn phải có kết quả được duyệt. | Chờ duyệt G1 |
| BR-006 | **Ý nghĩa coupon:** Ảnh chỉ nêu tên; giảm % là quy ước nháp chưa duyệt. | Coupon 10% không tự trở thành quy tắc chính thức. | Mã sai/hết hạn cần báo lý do, không tự làm đổi giỏ. | Chờ duyệt G1 |
| BR-007 | **Ý nghĩa voucher:** Voucher tiền cố định gắn tài khoản là phương án chưa duyệt. | Voucher 50000 VND cho KH01 là fixture. | Mã của KH02 không được áp nếu quy tắc gắn chủ được duyệt. | Chờ duyệt G1 |
| BR-008 | **Thứ tự/cộng dồn ưu đãi:** Giảm sản phẩm, sỉ, combo, mua kèm, voucher/coupon đều cần bảng ưu tiên. | Tối đa một mã/không cộng dồn chỉ là P-PRICE nháp. | Không âm tổng tiền là đề xuất invariant cần duyệt. | Chờ duyệt G1 |
| BR-009 | **Hạn/lượt/khách/hủy mã:** Cần xác định thời hạn, số lượt, mỗi khách và lúc giữ/tiêu/hoàn lượt. | Mã còn 1 lượt và hai người dùng đồng thời. | Không tiêu cùng lượt hai lần theo yêu cầu chống lặp; thời điểm cụ thể chưa chốt. | Chờ duyệt G1 |
| BR-010 | **Giá sỉ:** Phải có; ngưỡng, theo SKU hay tổng giỏ và giá chọn chưa chốt. | Mua 10 quyển cùng mã có giá khác là ví dụ. | Không áp giá sỉ dưới ngưỡng nếu quy tắc đó được duyệt. | Chờ duyệt G1 |
| BR-011 | **Combo:** Bộ là combo đã xác nhận; công thức giá và trừ tồn từng thành phần chưa duyệt. | 2 bộ {S001×1,S002×1} cần 2 mỗi SKU theo phương án nháp. | Thiếu thành phần thì không giữ dở nếu chọn P-STOCK/D01. | Đã xác nhận nghĩa; chi tiết chờ G1 |
| BR-012 | **Mua kèm:** Là sách/phụ kiện khách mua thêm có tính tiền; không mặc định là quà. | Khách chọn phụ kiện đi kèm sách; tỷ lệ/giá còn mở. | Đề xuất không tự thêm món khách chưa chọn. | Đã xác nhận nghĩa; chi tiết chờ G1 |
| BR-013 | **Tồn kho:** Phải có; H thực tế, R giữ chỗ, A=H−R là phương án. | H=10,R=3,A=7 là fixture theo P-STOCK. | Không cho H/R âm hoặc R>H nếu duyệt invariant này. | Chờ duyệt G1 |
| BR-014 | **Giữ và xuất:** Giỏ không giữ, đặt giữ, bàn giao xuất là P-STOCK chưa duyệt. | Đặt 2 quyển dự kiến R+2; bàn giao H−2,R−2. | Đề xuất không xuất lại khi bàn giao lặp. | Chờ duyệt G1 |
| BR-015 | **Hủy và hoàn tồn:** Điều kiện hủy/giải phóng và sau bàn giao chưa chốt. | Hủy trước giao chỉ R−2, H không đổi là phương án. | Không hoàn lần hai theo yêu cầu chống lặp. | Chờ duyệt G1 |
| BR-016 | **Chủ giỏ Guest/Customer:** Giỏ thuộc người đang thao tác; cách định danh, thời hạn và phục hồi chưa chốt. | Hai phiên guest có hai giỏ riêng theo nháp. | Đề xuất từ chối sửa cartId của người khác. | Chờ duyệt G1 |
| BR-017 | **Gộp giỏ khi đăng nhập:** SC031 mới nói giữ giỏ cùng phiên; chưa quy định khi customer đã có giỏ khác. | Guest có S001×1, customer cũ có S001×2: chưa chọn cộng/gỡ/ghi đè. | Không tự chọn một giỏ rồi làm mất hàng đã chọn. | Chờ duyệt G1 |
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

## Các chi tiết cần chốt trước khi thiết kế và code phần liên quan

G1 phải duyệt BR-001–BR-031 theo từng chủ đề, đặc biệt sách/ấn bản, giá/ưu đãi, kho, gộp giỏ, trạng thái/hủy/COD và hợp đồng dịch vụ ngoài. P-STOCK/P-PRICE cũ tiếp tục là phương án; không hỏi lại như thể người dùng đã chưa từng trả lời.

G3 mới chốt phiên bản Java/Spring Boot/PostgreSQL tương thích, công cụ build, runner Gherkin, cách cấp cấu hình mail và Facebook, môi trường callback và thông tin kết nối. Không yêu cầu gửi mật khẩu/app secret vào chat; cấu hình nhạy cảm phải ở biến môi trường hoặc cấu hình local không đưa vào Git/báo cáo.

Đề xuất kỹ thuật để xem xét sau G0: một ứng dụng triển khai chung với ranh giới module rõ; port cho lưu trữ và dịch vụ ngoài; fixture/fake để unit test, adapter thật để integration. Đánh đổi là ít vận hành nhưng cần transaction và ownership được thiết kế rõ. Đây chưa phải quyết định kiến trúc được duyệt.
