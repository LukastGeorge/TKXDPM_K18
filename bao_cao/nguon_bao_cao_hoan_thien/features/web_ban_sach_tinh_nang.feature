# language: en
# Chính sách hiện hành đã được chủ đề tài duyệt triển khai liên tục.
# Giỏ không giữ tồn; tạo đơn giữ R; bàn giao trừ H/R; hủy trước giao giải phóng R một lần.
# Một mã trên giỏ giá thường; chọn giá hợp lệ thấp nhất, giảm phần trăm làm tròn xuống VND.
# Quota, recipe, tỷ lệ, gộp giỏ, trạng thái, TTL 30 phút và chống tự liên kết Facebook đã duyệt.
# @approved_policy là trạng thái chính sách, KHÔNG phải kết quả test.
# @design_decision là phương án kỹ thuật; phải kiểm chứng riêng.
# Runner hiện chọn @s1; các scenario khác là đặc tả cần gắn glue/test, không được coi là đạt.
# Mã TC/REQ/BR dùng truy vết. Phí 0, tài khoản .example.test và mật khẩu thử là fixture.
# Các scenario độc lập; không kế thừa kết quả của scenario trước.

@bookshop @approved_scope
Feature: Khách mua sách và cửa hàng quản lý việc bán giao và thu tiền
  Để khách chọn đúng sách với giá được xác nhận và theo dõi đơn của chính mình
  Khách và quản trị dùng các nghiệp vụ danh mục, giỏ, giá, kho, xác thực, đơn và COD
  Các quy tắc nghiệp vụ được duyệt; trạng thái chạy test được quản lý riêng, không suy từ tag


  # REQ_CATALOG_001 | Mục tiêu: Người chưa đăng nhập xem được danh sách sách đang giới thiệu
  # Tác nhân/quyền: guest hoặc người đăng nhập cho dữ liệu công khai
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @catalog @REQ_CATALOG_001 @REQ-F01 @BR-002 @BR-031
  Rule: [Danh mục] Người chưa đăng nhập xem được danh sách sách đang giới thiệu

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @catalog @REQ_CATALOG_001 @TC_CATALOG_SC001 @SC001 @REQ-F01 @BR-002 @BR-031 @s1
    Scenario: Xem danh sách sách mà không cần đăng nhập
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S003 tên "Truyện ngắn chọn lọc", giá niêm yết 90000 VND, tồn ban đầu 0, giữ chỗ 0, tác giả 3, NXB thử, thể loại TL02 và ảnh mô tả đang hiển thị
      And tôi là guest chưa đăng nhập
      When tôi mở danh sách sách
      Then tôi thấy các sách "S001", "S002" và "S003"
      And mỗi sách có mã, tên, ảnh đại diện, giá và trạng thái còn hàng hoặc hết hàng
      And hệ thống không yêu cầu tôi đăng nhập để xem danh sách

    # SC002 -> TC_CATALOG_SC002; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_001 @TC_CATALOG_SC002 @SC002 @assumption_P_DETAIL @approved_policy @REQ-F01 @BR-002 @BR-031
    Scenario: Sách ngừng hiển thị không xuất hiện trong danh sách công khai
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S003 tên "Truyện ngắn chọn lọc", giá niêm yết 90000 VND, tồn ban đầu 0, giữ chỗ 0, tác giả 3, NXB thử, thể loại TL02 và ảnh mô tả đang hiển thị
      And sách "S002" đã được chuyển sang trạng thái ngừng hiển thị
      When guest mở danh sách sách
      Then danh sách có "S001" và "S003"
      But danh sách không có "S002"

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @catalog @REQ_CATALOG_001 @TC_CATALOG_SC003 @SC003 @REQ-F01 @BR-002 @BR-031 @s1
    Scenario: Danh mục chưa có sách hiển thị
      Given tất cả sách trong danh mục đã ngừng hiển thị
      When guest mở danh sách sách
      Then hệ thống thông báo chưa có sách
      And không hiển thị lỗi hệ thống hoặc một sản phẩm giả

    # SC004 -> TC_CATALOG_SC004; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_001 @TC_CATALOG_SC004 @SC004 @assumption_P_DETAIL @approved_policy @REQ-F01 @BR-002 @BR-031
    Scenario: Chuyển trang khi có nhiều sách
      Given danh mục thử có đúng 13 sách đang hiển thị với mã và tên khác nhau
      And cấu hình phân trang thử là 12 sách mỗi trang
      And guest đang xem trang 1 chứa 12 sách khác nhau và đã lưu tập mã sách của trang này
      When guest chuyển sang trang 2
      Then trang 2 có đúng 1 sách
      And mã sách đó không nằm trong tập mã của trang 1


  # REQ_CATALOG_002 | Mục tiêu: Người xem mở được thông tin chi tiết của một sách
  # Tác nhân/quyền: guest hoặc người đăng nhập cho dữ liệu công khai
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @catalog @REQ_CATALOG_002 @REQ-F02 @BR-001 @BR-002
  Rule: [Danh mục] Người xem mở được thông tin chi tiết của một sách

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @catalog @REQ_CATALOG_002 @TC_CATALOG_SC005 @SC005 @REQ-F02 @BR-001 @BR-002 @s1
    Scenario: Mở chi tiết từ danh sách sách
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      When guest chọn xem chi tiết sách "S001" từ danh sách
      Then hệ thống hiển thị đúng sách "S001"
      And hiển thị tên, tác giả, nhà xuất bản, thể loại, mô tả, ảnh, giá và tình trạng hàng
      And giá hiển thị là 120000 VND

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @catalog @REQ_CATALOG_002 @TC_CATALOG_SC006 @SC006 @REQ-F02 @BR-001 @BR-002 @s1
    Scenario: Xem một mã sách không tồn tại
      Given danh mục thử không có mã sách KHONG_TON_TAI
      When guest mở chi tiết sách có mã "KHONG_TON_TAI"
      Then hệ thống thông báo không tìm thấy sách
      And không cho thêm mã sách đó vào giỏ

    # SC007 -> TC_CATALOG_SC007; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_002 @TC_CATALOG_SC007 @SC007 @assumption_P_DETAIL @approved_policy @REQ-F02 @BR-001 @BR-002
    Scenario: Mở lại đường dẫn của sách đã ngừng hiển thị
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And sách "S001" đã ngừng hiển thị
      When guest mở trực tiếp đường dẫn chi tiết sách "S001"
      Then hệ thống thông báo sách không còn được giới thiệu
      And không cho mua sách "S001"


  # REQ_CART_001 | Mục tiêu: Chọn mua sách từ danh sách hoặc chi tiết sẽ đưa sách vào giỏ
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @cart @REQ_CART_001 @REQ-F03 @BR-003 @BR-004 @BR-013 @BR-016
  Rule: [Giỏ hàng] Chọn mua sách từ danh sách hoặc chi tiết sẽ đưa sách vào giỏ

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_001 @TC_CART_SC008 @SC008 @REQ-F03 @BR-003 @BR-004 @BR-013 @BR-016 @s1
    Scenario Outline: Thêm một sách từ hai vị trí được đề yêu cầu [<case_id>]
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có giỏ hàng trống
      When guest chọn mua 1 quyển "S001" từ <vị trí>
      Then giỏ có đúng một dòng sách "S001" với số lượng 1
      And thành tiền của dòng là 120000 VND
      And hệ thống không bắt guest đăng nhập để thêm vào giỏ

      Examples:
        | case_id | vị trí            |
        | TC_CART_SC008_R01 | danh sách sách    |
        | TC_CART_SC008_R02 | màn hình chi tiết |

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_001 @TC_CART_SC009 @SC009 @REQ-F03 @BR-003 @BR-004 @BR-013 @BR-016 @s1
    Scenario: Thêm lại sách đã có trong giỏ
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có 2 quyển "S001" trong giỏ
      When guest chọn mua thêm 1 quyển "S001"
      Then giỏ chỉ có một dòng "S001" với số lượng 3
      And thành tiền của dòng là 360000 VND

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_001 @TC_CART_SC010 @SC010 @REQ-F03 @BR-003 @BR-004 @BR-013 @BR-016 @s1
    Scenario: Không thêm được sách hết hàng
      Given dữ liệu gốc sách S003 tên "Truyện ngắn chọn lọc", giá niêm yết 90000 VND, tồn ban đầu 0, giữ chỗ 0, tác giả 3, NXB thử, thể loại TL02 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có giỏ hàng trống
      When guest chọn mua 1 quyển "S003"
      Then hệ thống thông báo sách hết hàng
      And giỏ vẫn trống

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_001 @TC_CART_SC011 @SC011 @REQ-F03 @BR-003 @BR-004 @BR-013 @BR-016 @s1
    Scenario: Thêm sách làm tổng số lượng vượt tồn kho
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có 10 quyển "S001" trong giỏ
      When guest chọn mua thêm 1 quyển "S001"
      Then hệ thống thông báo số lượng vượt tồn kho khả dụng 10
      And giỏ vẫn có đúng 10 quyển "S001"


  # REQ_CART_002 | Mục tiêu: Giỏ hàng thể hiện đúng các sách người dùng đã chọn
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @cart @REQ_CART_002 @REQ-F04 @BR-003 @BR-004 @BR-016
  Rule: [Giỏ hàng] Giỏ hàng thể hiện đúng các sách người dùng đã chọn

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_002 @TC_CART_SC012 @SC012 @REQ-F04 @BR-003 @BR-004 @BR-016 @s1
    Scenario: Xem giỏ và tổng tiền của nhiều sách
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có giỏ hàng
        | mã sách | số lượng |
        | S001    | 2        |
        | S002    | 1        |
      When guest mở giỏ hàng
      Then giỏ hiển thị 2 dòng sách với tổng số lượng 3
      And dòng "S001" có thành tiền 240000 VND
      And dòng "S002" có thành tiền 180000 VND
      And tổng tiền sách là 420000 VND

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_002 @TC_CART_SC013 @SC013 @REQ-F04 @BR-003 @BR-004 @BR-016 @s1
    Scenario: Xem giỏ chưa có sách
      Given cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có giỏ hàng trống
      When guest mở giỏ hàng
      Then hệ thống thông báo giỏ hàng trống
      And tổng tiền sách là 0 VND
      And không cho tạo đơn từ giỏ trống

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_002 @TC_CART_SC014 @SC014 @REQ-F04 @BR-003 @BR-004 @BR-016 @s1
    Scenario: Hai guest không dùng chung giỏ hàng
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest A và guest B dùng hai phiên truy cập độc lập
      And guest A đã thêm 1 quyển "S001" vào giỏ
      When guest B mở giỏ hàng của phiên B
      Then giỏ của guest B trống
      And giỏ của guest A vẫn có 1 quyển "S001"


  # REQ_CART_003 | Mục tiêu: Sửa số lượng bằng không sẽ bỏ sách khỏi giỏ
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @cart @REQ_CART_003 @REQ-F04 @BR-003 @BR-013 @BR-016
  Rule: [Giỏ hàng] Sửa số lượng bằng không sẽ bỏ sách khỏi giỏ

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_003 @TC_CART_SC015 @SC015 @REQ-F04 @BR-003 @BR-013 @BR-016 @s1
    Scenario: Đổi số lượng và tính lại thành tiền
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có 1 quyển "S001" trong giỏ
      When guest cập nhật số lượng "S001" thành 3
      Then giỏ có 3 quyển "S001"
      And thành tiền và tổng tiền sách đều là 360000 VND

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_003 @TC_CART_SC016 @SC016 @REQ-F04 @BR-003 @BR-013 @BR-016 @s1
    Scenario: Số lượng bằng 0 chỉ bỏ dòng sách được chọn
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có 2 quyển "S001" và 1 quyển "S002" trong giỏ
      When guest cập nhật số lượng "S001" thành 0
      Then giỏ không còn dòng "S001"
      And giỏ vẫn có 1 quyển "S002"
      And tổng tiền sách là 180000 VND

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_003 @TC_CART_SC017 @SC017 @REQ-F04 @BR-003 @BR-013 @BR-016 @s1
    Scenario: Bỏ sách cuối cùng khỏi giỏ bằng số lượng 0
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest chỉ có 1 quyển "S001" trong giỏ
      When guest cập nhật số lượng "S001" thành 0
      Then giỏ trở thành trống
      And tổng tiền sách là 0 VND

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_003 @TC_CART_SC018 @SC018 @REQ-F04 @BR-003 @BR-013 @BR-016 @s1
    Scenario Outline: Từ chối số lượng không hợp lệ mà giữ nguyên giỏ [<case_id>]
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có 2 quyển "S001" trong giỏ
      When guest gửi yêu cầu đổi số lượng "S001" thành "<số lượng>"
      Then hệ thống thông báo "<lý do>"
      And giỏ vẫn có 2 quyển "S001" với thành tiền 240000 VND

      Examples:
        | case_id | số lượng | lý do                             |
        | TC_CART_SC018_R01 | -1       | Số lượng không được âm            |
        | TC_CART_SC018_R02 | 1.5      | Số lượng phải là số nguyên        |
        | TC_CART_SC018_R03 | abc      | Số lượng phải là số nguyên        |
        | TC_CART_SC018_R04 |          | Số lượng không được để trống      |
        | TC_CART_SC018_R05 | 11       | Số lượng vượt tồn kho khả dụng 10 |

    # S1 đã duyệt theo xác nhận tiếp tục triển khai; tag không phải kết quả test.
    @cart @REQ_CART_003 @TC_CART_SC019 @SC019 @REQ-F04 @BR-003 @BR-013 @BR-016 @s1
    Scenario: Chấp nhận số lượng đúng bằng tồn kho
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có 1 quyển "S001" trong giỏ
      When guest cập nhật số lượng "S001" thành 10
      Then giỏ có 10 quyển "S001" với thành tiền 1200000 VND
      And thao tác sửa giỏ không làm tồn kho giảm


  # REQ_AUTH_001 | Mục tiêu: Guest đăng ký tài khoản bằng email
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @auth @REQ_AUTH_001 @REQ-F05 @REQ-F18 @REQ-F19 @BR-026 @BR-028 @BR-030
  Rule: [Xác thực] Guest đăng ký tài khoản bằng email

    # SC020 -> TC_AUTH_SC020; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_001 @TC_AUTH_SC020 @SC020 @assumption_P_DETAIL @approved_policy @REQ-F05 @REQ-F18 @REQ-F19 @BR-026 @BR-028 @BR-030
    Scenario: Đăng ký email với thông tin hợp lệ
      Given đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And chưa có tài khoản dùng email "banmoi@example.test"
      When guest đăng ký với thông tin
        | họ tên             | email               | mật khẩu  | xác nhận mật khẩu |
        | Người mua kiểm thử | banmoi@example.test | Sach#2026 | Sach#2026         |
      Then đúng một tài khoản customer đang hoạt động được tạo
      And hệ thống thông báo đăng ký thành công
      And email mới chưa được xác minh trước khi người dùng mở liên kết xác minh
      And phản hồi đăng ký không hiển thị lại mật khẩu

    # SC021 -> TC_AUTH_SC021; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_001 @TC_AUTH_SC021 @SC021 @assumption_P_DETAIL @approved_policy @REQ-F05 @REQ-F18 @REQ-F19 @BR-026 @BR-028 @BR-030
    Scenario: Email đã có tài khoản sau khi chuẩn hóa
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      When guest đăng ký với email "  KH01@EXAMPLE.TEST  " và các trường còn lại hợp lệ
      Then hệ thống thông báo email đã được sử dụng
      And không tạo tài khoản mới
      And thông tin tài khoản "KH01" không thay đổi

    # SC022 -> TC_AUTH_SC022; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_001 @TC_AUTH_SC022 @SC022 @assumption_P_DETAIL @approved_policy @REQ-F05 @REQ-F18 @REQ-F19 @BR-026 @BR-028 @BR-030
    Scenario Outline: Kiểm tra các trường đăng ký email [<case_id>]
      Given các email mới trong bảng đăng ký chưa được sử dụng
      When guest đăng ký với họ tên "<họ tên>", email "<email>", mật khẩu "<mật khẩu>" và xác nhận "<xác nhận>"
      Then hệ thống thông báo "<lý do>"
      And không tạo tài khoản mới

      Examples:
        | case_id | họ tên    | email              | mật khẩu  | xác nhận  | lý do                        |
        | TC_AUTH_SC022_R01 |           | moi@example.test   | Sach#2026 | Sach#2026 | Họ tên là bắt buộc           |
        | TC_AUTH_SC022_R02 | Người mua |                    | Sach#2026 | Sach#2026 | Email là bắt buộc            |
        | TC_AUTH_SC022_R03 | Người mua | email-khong-hop-le | Sach#2026 | Sach#2026 | Email không đúng định dạng   |
        | TC_AUTH_SC022_R04 | Người mua | moi@example.test   |           |           | Mật khẩu là bắt buộc         |
        | TC_AUTH_SC022_R05 | Người mua | moi@example.test   | Abc1234   | Abc1234   | Mật khẩu cần ít nhất 8 ký tự |
        | TC_AUTH_SC022_R06 | Người mua | moi@example.test   | Sach#2026 | Sach#2027 | Xác nhận mật khẩu không khớp |

    # SC023 -> TC_AUTH_SC023; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_001 @TC_AUTH_SC023 @SC023 @assumption_P_DETAIL @approved_policy @REQ-F05 @REQ-F18 @REQ-F19 @BR-026 @BR-028 @BR-030
    Scenario: Không tự đăng ký thành admin bằng dữ liệu bị sửa
      Given website đang hoạt động với dữ liệu độc lập và người truy cập là guest
      When guest gửi đăng ký hợp lệ kèm giá trị vai trò "admin" do guest tự thêm
      Then hệ thống từ chối yêu cầu gán quyền admin
      And không tạo tài khoản admin
      And guest không truy cập được chức năng quản trị


  # REQ_AUTH_002 | Mục tiêu: Guest đăng ký qua tài khoản mạng xã hội được website hỗ trợ
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @auth @REQ_AUTH_002 @REQ-F05 @REQ-F19 @BR-026 @BR-027 @BR-028
  Rule: [Xác thực] Guest đăng ký qua tài khoản mạng xã hội được website hỗ trợ

    # SC024 -> TC_AUTH_SC024; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_002 @TC_AUTH_SC024 @SC024 @assumption_P_DETAIL @approved_policy @REQ-F05 @REQ-F19 @BR-026 @BR-027 @BR-028
    Scenario: Đăng ký bằng nhà cung cấp xã hội đã cấu hình
      Given đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And chưa có tài khoản cho định danh "SOCIAL-001" của nhà cung cấp được cấu hình
      When guest chọn đăng ký qua nhà cung cấp đó và đồng ý cấp quyền
      And nhà cung cấp trả thông tin định danh hợp lệ và email chưa được sử dụng
      Then hệ thống tạo đúng một tài khoản customer liên kết với định danh "SOCIAL-001"
      And người dùng có phiên đăng nhập customer
      And website không yêu cầu hoặc lưu mật khẩu của tài khoản mạng xã hội

    # SC025 -> TC_AUTH_SC025; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_002 @TC_AUTH_SC025 @SC025 @assumption_P_DETAIL @approved_policy @REQ-F05 @REQ-F19 @BR-026 @BR-027 @BR-028
    Scenario Outline: Không tạo tài khoản khi luồng đăng ký xã hội chưa thành công [<case_id>]
      Given guest bắt đầu đăng ký qua nhà cung cấp được cấu hình
      When kết quả xác thực là "<kết quả>"
      Then hệ thống thông báo không hoàn tất đăng ký xã hội
      And không tạo tài khoản mới hoặc phiên đăng nhập
      And guest có thể chọn lại cách đăng ký

      Examples:
        | case_id | kết quả                              |
        | TC_AUTH_SC025_R01 | Người dùng hủy cấp quyền             |
        | TC_AUTH_SC025_R02 | Nhà cung cấp tạm thời không phản hồi |
        | TC_AUTH_SC025_R03 | Dữ liệu xác thực không hợp lệ        |

    # SC026 -> TC_AUTH_SC026; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_002 @TC_AUTH_SC026 @SC026 @assumption_P_DETAIL @approved_policy @REQ-F05 @REQ-F19 @BR-026 @BR-027 @BR-028
    Scenario: Không chiếm tài khoản email bằng đăng ký xã hội
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And tài khoản "KH01" chưa liên kết với định danh xã hội "SOCIAL-MOI"
      When đăng ký xã hội trả email "kh01@example.test" và định danh "SOCIAL-MOI"
      Then hệ thống không tự liên kết định danh mới vào "KH01"
      And không cấp phiên đăng nhập của "KH01"
      And thông báo cần xác minh quyền sở hữu tài khoản hiện có


  # REQ_AUTH_003 | Mục tiêu: Đăng nhập đúng tài khoản và đăng xuất kết thúc quyền truy cập của phiên
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @auth @REQ_AUTH_003 @REQ-F06 @BR-016 @BR-017 @BR-026 @BR-028
  Rule: [Xác thực] Đăng nhập đúng tài khoản và đăng xuất kết thúc quyền truy cập của phiên

    # SC027 -> TC_AUTH_SC027; có căn cứ/đã chốt trong phạm vi mô tả
    @auth @REQ_AUTH_003 @TC_AUTH_SC027 @SC027 @REQ-F06 @BR-016 @BR-017 @BR-026 @BR-028
    Scenario Outline: Đăng nhập tài khoản đang hoạt động [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tôi chưa đăng nhập
      When tôi đăng nhập bằng "<email>" và mật khẩu "MatKhau#2026"
      Then tôi có phiên đăng nhập với vai trò "<vai trò>"
      And hệ thống nhận diện đúng tài khoản "<mã tài khoản>"

      Examples:
        | case_id | email              | vai trò  | mã tài khoản |
        | TC_AUTH_SC027_R01 | kh01@example.test  | customer | KH01         |
        | TC_AUTH_SC027_R02 | admin@example.test | admin    | QT01         |

    # SC028 -> TC_AUTH_SC028; có căn cứ/đã chốt trong phạm vi mô tả
    @auth @REQ_AUTH_003 @TC_AUTH_SC028 @SC028 @REQ-F06 @BR-016 @BR-017 @BR-026 @BR-028
    Scenario Outline: Không đăng nhập được bằng thông tin không đúng [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      When guest đăng nhập bằng "<email>" và mật khẩu "<mật khẩu>"
      Then hệ thống thông báo không đăng nhập được
      And không cấp phiên đăng nhập

      Examples:
        | case_id | email                   | mật khẩu     |
        | TC_AUTH_SC028_R01 | kh01@example.test       | SaiMatKhau   |
        | TC_AUTH_SC028_R02 | chuatontai@example.test | MatKhau#2026 |

    # SC029 -> TC_AUTH_SC029; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_003 @TC_AUTH_SC029 @SC029 @assumption_P_DETAIL @approved_policy @REQ-F06 @BR-016 @BR-017 @BR-026 @BR-028
    Scenario: Tài khoản bị khóa không đăng nhập được
      Given tài khoản KH03 có email khoa@example.test, vai trò customer, mật khẩu thử MatKhau#2026, bị khóa
      When guest đăng nhập bằng "khoa@example.test" và mật khẩu đúng
      Then hệ thống thông báo tài khoản không được phép đăng nhập
      And không cấp phiên đăng nhập

    # SC030 -> TC_AUTH_SC030; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_003 @TC_AUTH_SC030 @SC030 @assumption_P_DETAIL @approved_policy @REQ-F06 @BR-016 @BR-017 @BR-026 @BR-028
    Scenario: Đăng xuất làm phiên hiện tại mất quyền customer
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản "KH01" đang đăng nhập
      When tôi đăng xuất
      Then phiên hiện tại đã bị thu hồi và không còn quyền customer
      And yêu cầu riêng tư dùng phiên cũ bị từ chối với yêu cầu đăng nhập lại
      But danh mục sách công khai vẫn cho guest truy cập

    # SC031 -> TC_AUTH_SC031; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_003 @TC_AUTH_SC031 @SC031 @assumption_P_DETAIL @approved_policy @REQ-F06 @BR-016 @BR-017 @BR-026 @BR-028
    Scenario: Giữ giỏ guest khi đăng nhập trong cùng phiên
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And guest có 2 quyển "S001" trong giỏ của phiên hiện tại
      And tài khoản "KH01" chưa có giỏ đã lưu chứa sản phẩm
      When guest đăng nhập thành công bằng tài khoản "KH01"
      Then giỏ trong phiên vẫn có đúng 2 quyển "S001"
      And không tự thêm sách từ phiên của khách hàng khác


  # REQ_CHECKOUT_001 | Mục tiêu: Tài khoản đăng nhập được lập đơn từ giỏ hợp lệ
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @checkout @REQ_CHECKOUT_001 @REQ-F07 @REQ-F17 @REQ-F20 @BR-013 @BR-014 @BR-018 @BR-019 @BR-022 @BR-026 @BR-029
  Rule: [Đặt hàng] Tài khoản đăng nhập được lập đơn từ giỏ hợp lệ

    # SC032 -> TC_CHECKOUT_SC032; có căn cứ/đã chốt trong phạm vi mô tả
    @checkout @REQ_CHECKOUT_001 @TC_CHECKOUT_SC032 @SC032 @confirmed_stock @REQ-F07 @REQ-F17 @REQ-F20 @BR-013 @BR-014 @BR-018 @BR-019 @BR-022 @BR-026 @BR-029
    Scenario Outline: Customer và admin được mua vào giỏ như guest [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And tài khoản "<tài khoản>" đang đăng nhập
      When tôi chọn mua 1 quyển "S001" từ màn hình chi tiết
      Then giỏ của tôi có 1 quyển "S001" với thành tiền 120000 VND

      Examples:
        | case_id | tài khoản |
        | TC_CHECKOUT_SC032_R01 | KH01      |
        | TC_CHECKOUT_SC032_R02 | QT01      |

    # SC033 -> TC_CHECKOUT_SC033; có căn cứ/đã chốt trong phạm vi mô tả
    @checkout @REQ_CHECKOUT_001 @TC_CHECKOUT_SC033 @SC033 @confirmed_stock @REQ-F07 @REQ-F17 @REQ-F20 @BR-013 @BR-014 @BR-018 @BR-019 @BR-022 @BR-026 @BR-029
    Scenario: Guest cần đăng nhập trước khi thanh toán
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And guest có 1 quyển "S001" trong giỏ
      When guest yêu cầu thanh toán
      Then hệ thống yêu cầu đăng nhập
      And không tạo giao dịch thanh toán cho guest
      And giỏ vẫn giữ 1 quyển "S001"

    # SC034 -> TC_CHECKOUT_SC034; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @checkout @REQ_CHECKOUT_001 @TC_CHECKOUT_SC034 @SC034 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F07 @REQ-F17 @REQ-F20 @BR-013 @BR-014 @BR-018 @BR-019 @BR-022 @BR-026 @BR-029
    Scenario Outline: Lập đơn COD giữ hàng trước khi giao và chưa ghi nhận đã thu tiền [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And tài khoản "<tài khoản>" đang đăng nhập và có 2 quyển "S001", 1 quyển "S002" trong giỏ
      When tôi đặt đơn COD với thông tin nhận hàng hợp lệ và mã yêu cầu mới
      Then hệ thống tạo đúng một đơn thuộc tài khoản "<tài khoản>"
      And đơn lưu đúng sách, số lượng, đơn giá và thông tin người nhận đã xác nhận
      And tổng tiền phải thu là 420000 VND
      And trạng thái xử lý là "Chờ xác nhận", phương thức "COD", thanh toán "Chưa thu"
      And tồn thực tế "S001" vẫn là 10, giữ chỗ 2, khả dụng 8
      And tồn thực tế "S002" vẫn là 5, giữ chỗ 1, khả dụng 4
      And các dòng đã đặt được bỏ khỏi giỏ của tài khoản đó

      Examples:
        | case_id | tài khoản |
        | TC_CHECKOUT_SC034_R01 | KH01      |
        | TC_CHECKOUT_SC034_R02 | QT01      |

    # SC035 -> TC_CHECKOUT_SC035; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @checkout @REQ_CHECKOUT_001 @TC_CHECKOUT_SC035 @SC035 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F07 @REQ-F17 @REQ-F20 @BR-013 @BR-014 @BR-018 @BR-019 @BR-022 @BR-026 @BR-029
    Scenario: Không lập đơn từ giỏ rỗng
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đang đăng nhập và giỏ hàng trống
      When tôi gửi yêu cầu đặt hàng với thông tin nhận hàng hợp lệ
      Then hệ thống thông báo cần có sách trong giỏ
      And không tạo đơn hoặc giao dịch thanh toán

    # SC036 -> TC_CHECKOUT_SC036; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @checkout @REQ_CHECKOUT_001 @TC_CHECKOUT_SC036 @SC036 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F07 @REQ-F17 @REQ-F20 @BR-013 @BR-014 @BR-018 @BR-019 @BR-022 @BR-026 @BR-029
    Scenario Outline: Thiếu trường bắt buộc trong thông tin nhận hàng [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đang đăng nhập và có 1 quyển "S001" trong giỏ
      When tôi đặt hàng với trường "<trường>" để trống và các trường khác hợp lệ
      Then hệ thống thông báo trường "<trường>" là bắt buộc
      And không tạo đơn hoặc giao dịch thanh toán
      And giỏ không thay đổi

      Examples:
        | case_id | trường            |
        | TC_CHECKOUT_SC036_R01 | Họ tên người nhận |
        | TC_CHECKOUT_SC036_R02 | Số điện thoại     |
        | TC_CHECKOUT_SC036_R03 | Địa chỉ nhận hàng |

    # SC037 -> TC_CHECKOUT_SC037; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @checkout @REQ_CHECKOUT_001 @TC_CHECKOUT_SC037 @SC037 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F07 @REQ-F17 @REQ-F20 @BR-013 @BR-014 @BR-018 @BR-019 @BR-022 @BR-026 @BR-029
    Scenario: Tồn kho giảm sau khi khách thêm sách vào giỏ
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đang đăng nhập và có 5 quyển "S002" trong giỏ
      And tồn khả dụng của "S002" hiện chỉ còn 2 quyển
      When tôi xác nhận đặt hàng
      Then hệ thống thông báo "S002" chỉ còn 2 quyển
      And không âm thầm giảm số lượng rồi tạo đơn
      And không tạo giao dịch thanh toán

    # SC038 -> TC_CHECKOUT_SC038; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @checkout @REQ_CHECKOUT_001 @TC_CHECKOUT_SC038 @SC038 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F07 @REQ-F17 @REQ-F20 @BR-013 @BR-014 @BR-018 @BR-019 @BR-022 @BR-026 @BR-029
    Scenario: Sách trong giỏ đã ngừng bán trước khi đặt hàng
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đang đăng nhập và có 1 quyển "S001" trong giỏ
      And "S001" đã ngừng hiển thị
      When tôi xác nhận đặt hàng
      Then hệ thống thông báo sách không còn được bán
      And không tạo đơn hoặc giao dịch thanh toán

    # SC039 -> TC_CHECKOUT_SC039; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @checkout @REQ_CHECKOUT_001 @TC_CHECKOUT_SC039 @SC039 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F07 @REQ-F17 @REQ-F20 @BR-013 @BR-014 @BR-018 @BR-019 @BR-022 @BR-026 @BR-029
    Scenario: Giá thay đổi phải được xác nhận lại trước thanh toán
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đã xem giỏ có 1 quyển "S001" giá 120000 VND
      And giá "S001" vừa đổi thành 130000 VND trước khi xác nhận đặt hàng
      When tôi gửi xác nhận đặt hàng theo mức giá cũ
      Then hệ thống thông báo đơn giá mới và yêu cầu xác nhận lại
      And chưa tạo đơn, chưa giữ kho, chưa giữ lượt mã và giỏ đã lưu không thay đổi


  # REQ_ORDER_001 | Mục tiêu: Khách hàng xem được trạng thái các đơn thuộc tài khoản của mình
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @order @REQ_ORDER_001 @REQ-F07 @REQ-F22 @BR-022 @BR-025 @BR-028
  Rule: [Đơn hàng] Khách hàng xem được trạng thái các đơn thuộc tài khoản của mình

    # SC047 -> TC_ORDER_SC047; có căn cứ/đã chốt trong phạm vi mô tả
    @order @REQ_ORDER_001 @TC_ORDER_SC047 @SC047 @confirmed_stock @REQ-F07 @REQ-F22 @BR-022 @BR-025 @BR-028
    Scenario: Xem danh sách và chi tiết trạng thái đơn COD của mình
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đang đăng nhập và có đơn COD "DH01" đang giao nhưng chưa thu tiền
      When tôi mở danh sách đơn cá nhân rồi chọn "DH01"
      Then tôi thấy đúng mã đơn, sách, số lượng, tổng tiền và thông tin nhận hàng của "DH01"
      And trạng thái xử lý là "Đang giao"
      And trạng thái thanh toán là "Chưa thu", phương thức là "COD"

    # SC048 -> TC_ORDER_SC048; có căn cứ/đã chốt trong phạm vi mô tả
    @order @REQ_ORDER_001 @TC_ORDER_SC048 @SC048 @confirmed_stock @REQ-F07 @REQ-F22 @BR-022 @BR-025 @BR-028
    Scenario: Khách hàng chưa có đơn
      Given tài khoản KH02 có email kh02@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH02" đang đăng nhập và chưa có đơn nào
      When tôi mở danh sách đơn cá nhân
      Then hệ thống thông báo chưa có đơn hàng
      And không hiển thị đơn của tài khoản khác

    # SC049 -> TC_ORDER_SC049; có căn cứ/đã chốt trong phạm vi mô tả
    @order @REQ_ORDER_001 @TC_ORDER_SC049 @SC049 @confirmed_stock @REQ-F07 @REQ-F22 @BR-022 @BR-025 @BR-028
    Scenario: Customer không xem được đơn của customer khác qua mã đơn
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản KH02 có email kh02@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đang đăng nhập và "DH02" thuộc "KH02"
      When "KH01" yêu cầu xem trực tiếp "DH02"
      Then hệ thống không trả thông tin đơn hoặc thông tin người nhận của "DH02"
      And thông báo không có quyền truy cập hoặc không tìm thấy đơn trong phạm vi tài khoản

    # SC050 -> TC_ORDER_SC050; có căn cứ/đã chốt trong phạm vi mô tả
    @order @REQ_ORDER_001 @TC_ORDER_SC050 @SC050 @confirmed_stock @REQ-F07 @REQ-F22 @BR-022 @BR-025 @BR-028
    Scenario: Xem mã đơn không tồn tại
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đang đăng nhập
      When tôi xem trạng thái mã đơn "DH-KHONG-TON-TAI"
      Then hệ thống thông báo không tìm thấy đơn
      And không hiển thị lỗi nội bộ


  # REQ_ADMIN_001 | Mục tiêu: Admin tìm kiếm được sách thể loại tài khoản và đơn hàng
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @admin @REQ_ADMIN_001 @REQ-F08 @REQ-F09 @REQ-F22 @BR-002 @BR-025 @BR-028
  Rule: [Quản trị] Admin tìm kiếm được sách thể loại tài khoản và đơn hàng

    # SC051 -> TC_ADMIN_SC051; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @admin @REQ_ADMIN_001 @TC_ADMIN_SC051 @SC051 @assumption_P_DETAIL @approved_policy @REQ-F08 @REQ-F09 @REQ-F22 @BR-002 @BR-025 @BR-028
    Scenario Outline: Tìm đúng thông tin trong từng nhóm quản trị [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And thể loại TL01 là Kỹ thuật và TL02 là Văn học đang tồn tại
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập quản trị
      And có đơn "DH01" thuộc tài khoản "KH01"
      When admin tìm "<từ khóa>" trong mục "<nhóm>"
      Then kết quả chứa "<bản ghi>" thuộc đúng nhóm đã chọn
      And admin mở được chi tiết của bản ghi đó

      Examples:
        | case_id | nhóm      | từ khóa           | bản ghi |
        | TC_ADMIN_SC051_R01 | Sách      | java căn bản      | S001    |
        | TC_ADMIN_SC051_R02 | Thể loại  | KỸ THUẬT          | TL01    |
        | TC_ADMIN_SC051_R03 | Tài khoản | kh01@example.test | KH01    |
        | TC_ADMIN_SC051_R04 | Đơn hàng  | DH01              | DH01    |

    # SC052 -> TC_ADMIN_SC052; có căn cứ/đã chốt trong phạm vi mô tả
    @admin @REQ_ADMIN_001 @TC_ADMIN_SC052 @SC052 @REQ-F08 @REQ-F09 @REQ-F22 @BR-002 @BR-025 @BR-028
    Scenario: Tìm kiếm không có kết quả
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And "QT01" đang đăng nhập quản trị
      When admin tìm "TU_KHOA_KHONG_TON_TAI" trong mục Sách
      Then hệ thống hiển thị danh sách kết quả trống và thông báo phù hợp
      And dữ liệu danh mục không thay đổi

    # SC053 -> TC_ADMIN_SC053; có căn cứ/đã chốt trong phạm vi mô tả
    @admin @REQ_ADMIN_001 @TC_ADMIN_SC053 @SC053 @REQ-F08 @REQ-F09 @REQ-F22 @BR-002 @BR-025 @BR-028
    Scenario Outline: Guest và customer không dùng được chức năng quản trị [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And người truy cập có trạng thái "<trạng thái>"
      When người đó yêu cầu trực tiếp chức năng "<chức năng>"
      Then hệ thống không trả dữ liệu quản trị hoặc thực hiện thay đổi
      And thông báo cần đăng nhập hoặc không có quyền tương ứng

      Examples:
        | case_id | trạng thái              | chức năng                    |
        | TC_ADMIN_SC053_R01 | Chưa đăng nhập          | Tìm tài khoản trong quản trị |
        | TC_ADMIN_SC053_R02 | Customer KH01 đăng nhập | Tìm tài khoản trong quản trị |
        | TC_ADMIN_SC053_R03 | Customer KH01 đăng nhập | Thêm sách                    |
        | TC_ADMIN_SC053_R04 | Customer KH01 đăng nhập | Sửa thể loại                 |
        | TC_ADMIN_SC053_R05 | Customer KH01 đăng nhập | Khóa tài khoản               |
        | TC_ADMIN_SC053_R06 | Customer KH01 đăng nhập | Sửa trạng thái đơn bất kỳ    |
        | TC_ADMIN_SC053_R07 | Customer KH01 đăng nhập | Nhập hoặc điều chỉnh kho     |
        | TC_ADMIN_SC053_R08 | Customer KH01 đăng nhập | Cấu hình giá sỉ và combo     |
        | TC_ADMIN_SC053_R09 | Customer KH01 đăng nhập | Tạo voucher hoặc coupon      |


  # REQ_CATALOG_003 | Mục tiêu: Admin quản lý thông tin sách và khả năng xuất hiện trên website
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @catalog @REQ_CATALOG_003 @REQ-F09 @BR-001 @BR-002 @BR-004 @BR-013 @BR-022 @BR-028
  Rule: [Danh mục] Admin quản lý thông tin sách và khả năng xuất hiện trên website

    # SC054 -> TC_CATALOG_SC054; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_003 @TC_CATALOG_SC054 @SC054 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F09 @BR-001 @BR-002 @BR-004 @BR-013 @BR-022 @BR-028
    Scenario: Tạo sách mới chưa tự phát sinh hàng trong kho
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And thể loại TL01 là Kỹ thuật và TL02 là Văn học đang tồn tại
      And "QT01" đang đăng nhập quản trị
      When admin thêm sách mới với thông tin
        | mã sách | tên sách          | tác giả   | nhà xuất bản | thể loại | giá VND | hiển thị |
        | S004    | Kiểm thử phần mềm | Tác giả D | NXB D        | TL01     | 150000  | Có       |
      And cung cấp mô tả và ảnh đại diện hợp lệ cho "S004"
      Then hệ thống lưu đúng một sách "S004" với các thông tin đã nhập
      And tồn thực tế, giữ chỗ, khả dụng của "S004" đều bằng 0
      And guest xem được sách với tình trạng hết hàng

    # SC055 -> TC_CATALOG_SC055; có căn cứ/đã chốt trong phạm vi mô tả
    @catalog @REQ_CATALOG_003 @TC_CATALOG_SC055 @SC055 @REQ-F09 @BR-001 @BR-002 @BR-004 @BR-013 @BR-022 @BR-028
    Scenario: Sửa thông tin sách và công khai thông tin mới
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập quản trị
      When admin đổi tên "S001" thành "Java căn bản bản cập nhật" và giá thành 130000 VND
      Then danh sách và chi tiết công khai thể hiện đúng tên và giá mới
      And mã sách vẫn là "S001"
      And không tạo một sách khác thay cho bản ghi đã sửa

    # SC056 -> TC_CATALOG_SC056; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_003 @TC_CATALOG_SC056 @SC056 @assumption_P_DETAIL @approved_policy @REQ-F09 @BR-001 @BR-002 @BR-004 @BR-013 @BR-022 @BR-028
    Scenario Outline: Không lưu dữ liệu sách không hợp lệ [<case_id>]
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập quản trị
      When admin thêm sách với trường "<trường>" bằng "<giá trị>" và các trường còn lại hợp lệ
      Then hệ thống thông báo "<lý do>"
      And không tạo sách mới hoặc ghi dở các thay đổi

      Examples:
        | case_id | trường   | giá trị       | lý do                     |
        | TC_CATALOG_SC056_R01 | Mã sách  | S001          | Mã sách đã tồn tại        |
        | TC_CATALOG_SC056_R02 | Tên sách |               | Tên sách là bắt buộc      |
        | TC_CATALOG_SC056_R03 | Giá      | 0             | Giá phải lớn hơn 0        |
        | TC_CATALOG_SC056_R04 | Giá      | -1000         | Giá phải lớn hơn 0        |
        | TC_CATALOG_SC056_R05 | Giá      | 1000.5        | Giá phải là số nguyên VND |
        | TC_CATALOG_SC056_R06 | Thể loại | KHONG_TON_TAI | Thể loại không tồn tại    |

    # SC057 -> TC_CATALOG_SC057; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_003 @TC_CATALOG_SC057 @SC057 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F09 @BR-001 @BR-002 @BR-004 @BR-013 @BR-022 @BR-028
    Scenario: Kiểm kê về 0 được ghi nhận bằng nghiệp vụ kho có lý do
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập và "S001" có tồn thực tế 10, giữ chỗ 0
      When admin xác nhận kiểm kê "S001" còn 0 với lý do "Điều chỉnh theo kiểm đếm thực tế"
      Then tồn thực tế và khả dụng của "S001" đều bằng 0
      And có đúng một bản ghi điều chỉnh giảm 10 với người thực hiện và lý do tương ứng
      And sách vẫn được giới thiệu là hết hàng và không thể mua mới

    # SC058 -> TC_CATALOG_SC058; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_003 @TC_CATALOG_SC058 @SC058 @assumption_P_DETAIL @approved_policy @REQ-F09 @BR-001 @BR-002 @BR-004 @BR-013 @BR-022 @BR-028
    Scenario: Ngừng hiển thị sách mà giữ lịch sử đơn
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And "QT01" đang đăng nhập và "S001" đã nằm trong đơn "DH01" giá 120000 VND
      When admin xóa sách "S001" khỏi danh mục bán công khai
      Then "S001" chuyển sang ngừng hiển thị
      And guest không mua mới được "S001"
      And chi tiết "DH01" vẫn giữ tên, số lượng và đơn giá tại thời điểm đặt đơn

    # SC059 -> TC_CATALOG_SC059; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_003 @TC_CATALOG_SC059 @SC059 @assumption_P_DETAIL @approved_policy @REQ-F09 @BR-001 @BR-002 @BR-004 @BR-013 @BR-022 @BR-028
    Scenario: Sửa giá sách không làm thay đổi đơn đã tạo
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập và "DH01" có 1 quyển "S001" đơn giá 120000 VND
      When admin đổi giá hiện hành của "S001" thành 130000 VND
      Then đơn "DH01" vẫn giữ đơn giá 120000 VND và tổng tiền ban đầu
      And giá áp dụng cho việc đặt mới là 130000 VND


  # REQ_CATALOG_004 | Mục tiêu: Admin quản lý thể loại dùng để phân loại sách
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @catalog @REQ_CATALOG_004 @REQ-F09 @BR-002 @BR-028
  Rule: [Danh mục] Admin quản lý thể loại dùng để phân loại sách

    # SC060 -> TC_CATALOG_SC060; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_004 @TC_CATALOG_SC060 @SC060 @assumption_P_DETAIL @approved_policy @REQ-F09 @BR-002 @BR-028
    Scenario: Thêm thể loại mới để phân loại sách
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And "QT01" đang đăng nhập quản trị
      When admin tạo thể loại mã "TL03" tên "Kinh tế"
      Then thể loại được lưu và có thể chọn khi thêm sách

    # SC061 -> TC_CATALOG_SC061; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_004 @TC_CATALOG_SC061 @SC061 @assumption_P_DETAIL @approved_policy @REQ-F09 @BR-002 @BR-028
    Scenario Outline: Từ chối thể loại không hợp lệ [<case_id>]
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And thể loại TL01 là Kỹ thuật và TL02 là Văn học đang tồn tại
      And "QT01" đang đăng nhập quản trị
      When admin tạo thể loại với mã "<mã>" và tên "<tên>"
      Then hệ thống thông báo "<lý do>"
      And không tạo thể loại mới

      Examples:
        | case_id | mã   | tên      | lý do                    |
        | TC_CATALOG_SC061_R01 | TL01 | Loại mới | Mã thể loại đã tồn tại   |
        | TC_CATALOG_SC061_R02 | TL03 |          | Tên thể loại là bắt buộc |

    # SC062 -> TC_CATALOG_SC062; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_004 @TC_CATALOG_SC062 @SC062 @assumption_P_DETAIL @approved_policy @REQ-F09 @BR-002 @BR-028
    Scenario: Xóa thể loại chưa có sách sử dụng
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And "QT01" đang đăng nhập và thể loại "TL03" tồn tại nhưng không có sách nào sử dụng
      When admin xóa "TL03"
      Then thể loại đó không còn trong danh sách quản lý hoặc lựa chọn khi thêm sách
      And các thể loại khác không thay đổi

    # SC063 -> TC_CATALOG_SC063; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_004 @TC_CATALOG_SC063 @SC063 @assumption_P_DETAIL @approved_policy @REQ-F09 @BR-002 @BR-028
    Scenario: Không xóa thể loại đang có sách
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And thể loại TL01 là Kỹ thuật và TL02 là Văn học đang tồn tại
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And "QT01" đang đăng nhập và "S001", "S002" thuộc "TL01"
      When admin xóa thể loại "TL01"
      Then hệ thống thông báo cần chuyển sách sang thể loại khác trước
      And "TL01", "S001", "S002" không bị xóa hoặc mất liên kết


  # REQ_AUTH_004 | Mục tiêu: Admin xem và quản lý thông tin tài khoản customer
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @auth @REQ_AUTH_004 @REQ-F09 @REQ-F22 @BR-025 @BR-026 @BR-028
  Rule: [Xác thực] Admin xem và quản lý thông tin tài khoản customer

    # SC064 -> TC_AUTH_SC064; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_004 @TC_AUTH_SC064 @SC064 @assumption_P_DETAIL @approved_policy @REQ-F09 @REQ-F22 @BR-025 @BR-026 @BR-028
    Scenario: Xem và sửa thông tin cơ bản của customer
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And "QT01" đang đăng nhập quản trị
      When admin mở tài khoản "KH01" rồi sửa họ tên thành "Khách hàng cập nhật"
      Then hệ thống lưu họ tên mới cho "KH01"
      And giữ nguyên email, vai trò, đơn hàng và trạng thái đăng nhập hợp lệ của tài khoản
      And màn hình quản trị không hiển thị mật khẩu của customer

    # SC065 -> TC_AUTH_SC065; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_004 @TC_AUTH_SC065 @SC065 @assumption_P_DETAIL @approved_policy @REQ-F09 @REQ-F22 @BR-025 @BR-026 @BR-028
    Scenario: Khóa customer ngăn đăng nhập và sử dụng phiên cũ
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And "QT01" đang đăng nhập quản trị và "KH01" đang có phiên customer
      When admin khóa tài khoản "KH01"
      Then trạng thái "KH01" thành "Bị khóa"
      And "KH01" không đăng nhập mới được
      And phiên cũ của "KH01" không thể tạo đơn hoặc thanh toán mới
      And lịch sử đơn của "KH01" vẫn còn để admin quản lý

    # SC066 -> TC_AUTH_SC066; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_004 @TC_AUTH_SC066 @SC066 @assumption_P_DETAIL @approved_policy @REQ-F09 @REQ-F22 @BR-025 @BR-026 @BR-028
    Scenario: Mở khóa customer
      Given tài khoản KH03 có email khoa@example.test, vai trò customer, mật khẩu thử MatKhau#2026, bị khóa
      And tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And "QT01" đang đăng nhập quản trị và "KH03" bị khóa
      When admin mở khóa "KH03"
      Then trạng thái "KH03" thành "Hoạt động"
      And "KH03" đăng nhập được bằng thông tin hợp lệ
      And không tự tạo thêm tài khoản hoặc đặt lại mật khẩu của "KH03"

    # SC067 -> TC_AUTH_SC067; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_004 @TC_AUTH_SC067 @SC067 @assumption_P_DETAIL @approved_policy @REQ-F09 @REQ-F22 @BR-025 @BR-026 @BR-028
    Scenario: Không xóa cứng customer có lịch sử đơn
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And "QT01" đang đăng nhập và tài khoản "KH01" có đơn "DH01"
      When admin yêu cầu xóa cứng "KH01"
      Then hệ thống từ chối xóa và cho biết có thể khóa tài khoản
      And tài khoản và đơn hàng cũ vẫn có thể được admin tra cứu

    # SC068 -> TC_AUTH_SC068; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_004 @TC_AUTH_SC068 @SC068 @assumption_P_DETAIL @approved_policy @REQ-F09 @REQ-F22 @BR-025 @BR-026 @BR-028
    Scenario: Sửa tài khoản không tồn tại
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And "QT01" đang đăng nhập quản trị
      When admin cập nhật tài khoản "KH-KHONG-TON-TAI"
      Then hệ thống thông báo không tìm thấy tài khoản
      And không tạo tài khoản mới từ yêu cầu cập nhật đó


  # REQ_ORDER_002 | Mục tiêu: Admin quản lý đơn trực tuyến mà giữ đúng nội dung và quyền sở hữu đơn
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @order @REQ_ORDER_002 @REQ-F09 @REQ-F17 @BR-014 @BR-015 @BR-019 @BR-028
  Rule: [Đơn hàng] Admin quản lý đơn trực tuyến mà giữ đúng nội dung và quyền sở hữu đơn

    # SC069 -> TC_ORDER_SC069; có căn cứ/đã chốt trong phạm vi mô tả
    @order @REQ_ORDER_002 @TC_ORDER_SC069 @SC069 @confirmed_stock @REQ-F09 @REQ-F17 @BR-014 @BR-015 @BR-019 @BR-028
    Scenario: Admin xem đơn của các customer để xử lý
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản KH02 có email kh02@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "QT01" đang đăng nhập quản trị
      And có "DH01" của "KH01", "DH02" của "KH02"
      When admin mở danh sách quản lý đơn rồi xem chi tiết từng đơn
      Then admin xem được cả hai đơn và đúng tài khoản sở hữu tương ứng
      And xem được các sách, số lượng, tổng tiền, thông tin nhận hàng và hai trạng thái của đơn

    # SC070 -> TC_ORDER_SC070; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_002 @TC_ORDER_SC070 @SC070 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F09 @REQ-F17 @BR-014 @BR-015 @BR-019 @BR-028
    Scenario: Xác nhận đơn COD không đòi khách trả tiền trước
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "QT01" đang đăng nhập và "DH01" là đơn COD "Chờ xác nhận", "Chưa thu"
      And "DH01" đã giữ chỗ hợp lệ cho toàn bộ hàng cần giao
      When admin xác nhận xử lý "DH01"
      Then trạng thái xử lý của đơn là "Đã xác nhận"
      And thanh toán vẫn là "Chưa thu"
      And customer sở hữu đơn xem được trạng thái mới và tổng tiền không thay đổi
      And tồn thực tế và lượng giữ chỗ chưa thay đổi

    # SC072 -> TC_ORDER_SC072; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_002 @TC_ORDER_SC072 @SC072 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F09 @REQ-F17 @BR-014 @BR-015 @BR-019 @BR-028
    Scenario Outline: Không chuyển trạng thái COD ngược hoặc bỏ qua bước [<case_id>]
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "QT01" đang đăng nhập và đơn COD "DH01" đang "<hiện tại>", thanh toán "<tiền>"
      When admin yêu cầu chuyển "DH01" sang "<mới>"
      Then hệ thống thông báo chuyển trạng thái không hợp lệ
      And trạng thái xử lý, thanh toán và tồn kho của đơn không thay đổi

      Examples:
        | case_id | hiện tại     | tiền     | mới          |
        | TC_ORDER_SC072_R01 | Chờ xác nhận | Chưa thu | Hoàn tất     |
        | TC_ORDER_SC072_R02 | Đang giao    | Chưa thu | Đã xác nhận  |
        | TC_ORDER_SC072_R03 | Hoàn tất     | Đã thu   | Chờ xác nhận |

    # SC073 -> TC_ORDER_SC073; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_002 @TC_ORDER_SC073 @SC073 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F09 @REQ-F17 @BR-014 @BR-015 @BR-019 @BR-028
    Scenario: Hủy đơn COD trước khi bàn giao sẽ trả lại lượng hàng giữ chỗ
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "QT01" đang đăng nhập và "DH01" là đơn COD "Chờ xác nhận", "Chưa thu"
      And đơn giữ 1 quyển "S001" nên tồn thực tế là 10, giữ chỗ 1, khả dụng 9
      When admin hủy "DH01" với lý do "Khách yêu cầu dừng đơn trước khi giao"
      Then trạng thái xử lý của đơn là "Đã hủy" và thanh toán vẫn "Chưa thu"
      And tồn thực tế "S001" vẫn là 10, giữ chỗ 0, khả dụng 10
      And mọi lượt ưu đãi đang giữ cho đơn được giải phóng đúng một lần
      And lý do hủy được lưu và customer sở hữu đơn xem được
      And đơn vẫn còn trong lịch sử và không phát sinh khoản tiền đã thu


  # REQ_INV_001 | Mục tiêu: Kho phân biệt hàng thực tế hàng giữ chỗ và hàng còn được bán
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @inventory @REQ_INV_001 @REQ-F10 @BR-013 @BR-024 @BR-028
  Rule: [Kho] Kho phân biệt hàng thực tế hàng giữ chỗ và hàng còn được bán

    # KHO01 -> TC_INV_KHO01; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_001 @TC_INV_KHO01 @KHO01 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @BR-013 @BR-024 @BR-028
    Scenario: Xem số lượng có thể bán khi một phần hàng đã giữ cho đơn
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập và "S001" có tồn thực tế 10, giữ chỗ 3 cho các đơn chưa giao
      When admin tra cứu kho của "S001"
      Then thấy tồn thực tế 10, giữ chỗ 3 và khả dụng 7
      And khách chỉ được đặt thêm tối đa 7 quyển theo tồn khả dụng tại lúc đặt

    # KHO02 -> TC_INV_KHO02; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_001 @TC_INV_KHO02 @KHO02 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @BR-013 @BR-024 @BR-028
    Scenario: Ghi nhận nhập thêm sách bằng phiếu nhập
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập và "S001" có tồn thực tế 10, giữ chỗ 0
      When admin xác nhận phiếu nhập "PN001" cho 5 quyển "S001" với lý do "Nhập bổ sung"
      Then tồn thực tế và khả dụng đều là 15, giữ chỗ vẫn là 0
      And lịch sử kho có một lần nhập tăng 5 gắn với "PN001", người thực hiện và lý do

    # KHO03 -> TC_INV_KHO03; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_001 @TC_INV_KHO03 @KHO03 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @BR-013 @BR-024 @BR-028
    Scenario: Gửi lại phiếu nhập đã xác nhận không tăng hàng lần nữa
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And phiếu "PN001" đã nhập 5 quyển "S001" làm tồn thực tế tăng từ 10 lên 15
      When admin gửi lại xác nhận đúng phiếu "PN001" với cùng nội dung
      Then tồn thực tế vẫn là 15
      And lịch sử chỉ có một lần nhập cho "PN001"

    # KHO09 -> TC_INV_KHO09; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_001 @TC_INV_KHO09 @KHO09 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @BR-013 @BR-024 @BR-028
    Scenario: Nhập kho cho mã chưa có trong danh mục bị từ chối
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And "QT01" đang đăng nhập và danh mục chưa có mã "SKU-KHONG-TON-TAI"
      When admin xác nhận phiếu nhập cho mã đó
      Then hệ thống yêu cầu tạo thông tin sản phẩm hợp lệ trước
      And không tạo tồn kho hoặc phiếu nhập thành công cho mã không tồn tại

    # KHO04 -> TC_INV_KHO04; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_001 @TC_INV_KHO04 @KHO04 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @BR-013 @BR-024 @BR-028
    Scenario Outline: Từ chối số lượng nhập không hợp lệ [<case_id>]
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập và "S001" có tồn thực tế 10, giữ chỗ 0
      When admin nhập "<số lượng>" quyển "S001" vào phiếu mới
      Then hệ thống thông báo số lượng nhập phải là số nguyên lớn hơn 0
      And tồn thực tế vẫn là 10 và không phát sinh lần nhập kho

      Examples:
        | case_id | số lượng |
        | TC_INV_KHO04_R01 | 0        |
        | TC_INV_KHO04_R02 | -1       |
        | TC_INV_KHO04_R03 | 1.5      |
        | TC_INV_KHO04_R04 | abc      |

    # KHO05 -> TC_INV_KHO05; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_001 @TC_INV_KHO05 @KHO05 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @BR-013 @BR-024 @BR-028
    Scenario: Kiểm kê không được làm tồn thực tế nhỏ hơn số hàng đã giữ
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập và "S001" có tồn thực tế 10, giữ chỗ 3
      When admin yêu cầu xác nhận kiểm kê chỉ còn 2 quyển
      Then hệ thống yêu cầu xử lý chênh lệch và các đơn giữ hàng trước
      And chưa ghi giảm tồn xuống 2
      And tồn thực tế 10, giữ chỗ 3, khả dụng 7 không thay đổi


  # REQ_INV_002 | Mục tiêu: Chỉ bàn giao vận chuyển mới xuất hàng đã giữ cho đơn
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @inventory @REQ_INV_002 @REQ-F10 @REQ-F21 @BR-013 @BR-014 @BR-015 @BR-023 @BR-024
  Rule: [Kho] Chỉ bàn giao vận chuyển mới xuất hàng đã giữ cho đơn

    # KHO06 -> TC_INV_KHO06; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_002 @TC_INV_KHO06 @KHO06 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @REQ-F21 @BR-013 @BR-014 @BR-015 @BR-023 @BR-024
    Scenario: Bàn giao đơn COD làm giảm tồn thực tế và lượng giữ của cùng đơn
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "QT01" đang đăng nhập và đơn COD "DH01" đã xác nhận giữ 3 quyển "S001"
      And "S001" có tồn thực tế 10, giữ chỗ 3, khả dụng 7
      When admin xác nhận bàn giao "DH01" với mã bàn giao "BG001"
      Then đơn chuyển thành "Đang giao" và thanh toán vẫn là "Chưa thu"
      And tồn thực tế "S001" thành 7, giữ chỗ 0, khả dụng 7
      And lịch sử có đúng một phiếu xuất 3 quyển gắn với "DH01" và "BG001"

    # KHO07 -> TC_INV_KHO07; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_002 @TC_INV_KHO07 @KHO07 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @REQ-F21 @BR-013 @BR-014 @BR-015 @BR-023 @BR-024
    Scenario: Xác nhận bàn giao lặp không xuất kho hai lần
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "DH01" đã bàn giao bằng "BG001" làm tồn thực tế "S001" giảm từ 10 xuống 7
      When admin gửi lại xác nhận bàn giao "BG001" với cùng nội dung
      Then tồn thực tế vẫn là 7 và đơn vẫn "Đang giao"
      And không phát sinh phiếu xuất hoặc lần thu tiền mới

    # SC046 -> TC_INV_SC046; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_002 @TC_INV_SC046 @SC046 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @REQ-F21 @BR-013 @BR-014 @BR-015 @BR-023 @BR-024
    Scenario: Hai khách đồng thời đặt quyển sách cuối chỉ một đơn được giữ hàng
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản KH02 có email kh02@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "S002" có tồn thực tế 1, giữ chỗ 0, khả dụng 1
      And "KH01" và "KH02" đều đã xác minh và cùng có 1 quyển "S002" trong giỏ riêng
      When hai khách gửi hai yêu cầu đặt COD độc lập đồng thời
      Then đúng một yêu cầu tạo được đơn và giữ chỗ 1 quyển "S002"
      And yêu cầu còn lại nhận thông báo không đủ hàng và giữ nguyên giỏ
      And tồn thực tế là 1, giữ chỗ 1, khả dụng 0
      And không tài khoản nào bị ghi nhận đã trả tiền khi mới đặt COD

    # KHO08 -> TC_INV_KHO08; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @inventory @REQ_INV_002 @TC_INV_KHO08 @KHO08 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F10 @REQ-F21 @BR-013 @BR-014 @BR-015 @BR-023 @BR-024
    Scenario: Hủy sau khi bàn giao không được giả lập trả hàng vào kho
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And "DH01" đã bàn giao 2 quyển "S001", đang giao và tồn thực tế đã giảm từ 10 xuống 8
      When admin yêu cầu hủy bằng luồng hủy trước bàn giao
      Then hệ thống từ chối và yêu cầu xử lý giao thất bại hoặc nhận hàng trả riêng
      And tồn thực tế vẫn là 8
      And không tự tạo phiếu nhập lại hoặc khẳng định đã hoàn tiền


  # REQ_PRICE_001 | Mục tiêu: Bán giá thường tính tiền theo đúng đơn giá và số lượng khách chọn
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @pricing @REQ_PRICE_001 @REQ-F11 @BR-004 @BR-014
  Rule: [Giá và khuyến mãi] Bán giá thường tính tiền theo đúng đơn giá và số lượng khách chọn

    # BH01 -> TC_PRICE_BH01; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_001 @TC_PRICE_BH01 @BH01 @confirmed_stock @confirmed_price_detail @approved_policy @REQ-F11 @BR-004 @BR-014
    Scenario: Mua sách theo giá thường không có ưu đãi
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And khách có 2 quyển "S001" và chưa áp dụng ưu đãi nào
      When khách xem báo giá giỏ hàng
      Then đơn giá là 120000 VND và thành tiền là 240000 VND
      And tiền giảm là 0 VND và số tiền phải trả là 240000 VND
      And báo giá chưa giữ hàng hoặc ghi nhận tiền đã thu


  # REQ_PRICE_002 | Mục tiêu: Giảm giá sản phẩm chỉ áp dụng trong khoảng thời gian đã cấu hình
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @pricing @REQ_PRICE_002 @REQ-F12 @BR-004 @BR-005
  Rule: [Giá và khuyến mãi] Giảm giá sản phẩm chỉ áp dụng trong khoảng thời gian đã cấu hình

    # BH02 -> TC_PRICE_BH02; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_002 @TC_PRICE_BH02 @BH02 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F12 @BR-004 @BR-005
    Scenario Outline: Kiểm tra chính xác thời điểm bắt đầu và kết thúc giảm giá [<case_id>]
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And "S001" có giảm giá 10 phần trăm từ "2026-10-29T09:00:00+07:00" đến trước "2026-10-30T09:00:00+07:00"
      And khách chọn mua 2 quyển "S001"
      When báo giá tại thời điểm "<thời điểm>"
      Then đơn giá bán là <đơn giá> VND và thành tiền là <thành tiền> VND
      And hiển thị giá niêm yết 120000 VND để khách biết mức giá đã áp dụng

      Examples:
        | case_id | thời điểm                 | đơn giá | thành tiền |
        | TC_PRICE_BH02_R01 | 2026-10-29T08:59:59+07:00 | 120000  | 240000     |
        | TC_PRICE_BH02_R02 | 2026-10-29T09:00:00+07:00 | 108000  | 216000     |
        | TC_PRICE_BH02_R03 | 2026-10-30T08:59:59+07:00 | 108000  | 216000     |
        | TC_PRICE_BH02_R04 | 2026-10-30T09:00:00+07:00 | 120000  | 240000     |

    # BH03 -> TC_PRICE_BH03; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_002 @TC_PRICE_BH03 @BH03 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F12 @BR-004 @BR-005
    Scenario: Làm tròn xuống số VND tiền giảm
      Given cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And một sách có giá niêm yết 99999 VND và đang giảm 15 phần trăm
      When khách báo giá 1 quyển sách đó
      Then tiền giảm là 14999 VND
      And giá bán là 85000 VND

    # BH04 -> TC_PRICE_BH04; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_002 @TC_PRICE_BH04 @BH04 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F12 @BR-004 @BR-005
    Scenario Outline: Không kích hoạt cấu hình giảm giá không hợp lệ [<case_id>]
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And "QT01" đang đăng nhập quản trị
      When admin tạo chương trình giảm sản phẩm với dữ liệu "<sai lệch>"
      Then hệ thống từ chối và nêu dữ liệu cần sửa
      And giá bán hiện hành không thay đổi

      Examples:
        | case_id | sai lệch                             |
        | TC_PRICE_BH04_R01 | Phần trăm giảm bằng -10              |
        | TC_PRICE_BH04_R02 | Phần trăm giảm lớn hơn 100           |
        | TC_PRICE_BH04_R03 | Thời điểm kết thúc không sau bắt đầu |
        | TC_PRICE_BH04_R04 | Mã sách không tồn tại                |


  # REQ_PRICE_003 | Mục tiêu: Coupon và voucher giảm tiền theo quy ước riêng và điều kiện công khai
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @pricing @REQ_PRICE_003 @REQ-F13 @BR-006 @BR-007 @BR-008 @BR-009
  Rule: [Giá và khuyến mãi] Coupon và voucher giảm tiền theo quy ước riêng và điều kiện công khai

    # BH05 -> TC_PRICE_BH05; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_003 @TC_PRICE_BH05 @BH05 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F13 @BR-006 @BR-007 @BR-008 @BR-009
    Scenario: Coupon giảm phần trăm cho giỏ đạt giá trị tối thiểu
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And "KH01" có 2 quyển "S001" giá thường với tổng 240000 VND
      And coupon "CP20" đang hiệu lực, giảm 20 phần trăm, tối thiểu 200000 VND và còn lượt
      When khách áp dụng "CP20" để xem báo giá
      Then tiền giảm là 48000 VND và tiền phải trả là 192000 VND
      And báo giá ghi rõ mã "CP20" và điều kiện áp dụng
      And chưa tiêu hoặc giữ lượt dùng mã chỉ vì xem báo giá

    # BH06 -> TC_PRICE_BH06; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_003 @TC_PRICE_BH06 @BH06 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F13 @BR-006 @BR-007 @BR-008 @BR-009
    Scenario: Voucher cố định chỉ dùng cho tài khoản được cấp
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And "KH01" có 2 quyển "S001" giá thường với tổng 240000 VND
      And voucher "VC50" được cấp cho "KH01", giảm 50000 VND, tối thiểu 200000 VND, còn hạn và chưa dùng
      When "KH01" áp dụng "VC50" để xem báo giá
      Then tiền giảm là 50000 VND và tiền phải trả là 190000 VND
      And chưa ghi nhận voucher đã sử dụng

    # BH07 -> TC_PRICE_BH07; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_003 @TC_PRICE_BH07 @BH07 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F13 @BR-006 @BR-007 @BR-008 @BR-009
    Scenario Outline: Từ chối mã không đủ điều kiện và giữ nguyên giá giỏ [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản KH02 có email kh02@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And "KH01" có giỏ giá thường trị giá 240000 VND chưa áp dụng mã
      And mã "MA-THU" có điều kiện "<điều kiện>"
      When "KH01" thử áp dụng "MA-THU"
      Then hệ thống thông báo "<lý do>"
      And tiền phải trả vẫn là 240000 VND
      And không giữ hoặc tiêu lượt mã

      Examples:
        | case_id | điều kiện                           | lý do                        |
        | TC_PRICE_BH07_R01 | Mã không tồn tại                    | Không tìm thấy mã ưu đãi     |
        | TC_PRICE_BH07_R02 | Mã đã hết hạn                       | Mã đã hết hạn                |
        | TC_PRICE_BH07_R03 | Mã chưa đến ngày bắt đầu            | Mã chưa có hiệu lực          |
        | TC_PRICE_BH07_R04 | Mức mua tối thiểu 300000 VND        | Chưa đạt giá trị tối thiểu   |
        | TC_PRICE_BH07_R05 | Voucher được cấp cho KH02           | Mã không thuộc tài khoản này |
        | TC_PRICE_BH07_R06 | Tài khoản đã dùng hết lượt cho phép | Đã hết lượt sử dụng          |
        | TC_PRICE_BH07_R07 | Chiến dịch hết hạn mức khả dụng     | Mã đã hết hạn mức            |

    # BH08 -> TC_PRICE_BH08; có căn cứ/đã chốt trong phạm vi mô tả
    @pricing @REQ_PRICE_003 @TC_PRICE_BH08 @BH08 @REQ-F13 @BR-006 @BR-007 @BR-008 @BR-009
    Scenario: Không cộng dồn coupon và voucher trên một đơn
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" có giỏ 240000 VND đang áp dụng hợp lệ "CP20", phải trả 192000 VND
      When khách yêu cầu áp dụng thêm voucher "VC50" đồng thời giữ "CP20"
      Then hệ thống thông báo chỉ được dùng một mã
      And giữ nguyên "CP20" cùng mức phải trả 192000 VND
      And khách có thể chủ động bỏ mã cũ rồi báo giá lại với mã khác

    # BH09 -> TC_PRICE_BH09; có căn cứ/đã chốt trong phạm vi mô tả
    @pricing @REQ_PRICE_003 @TC_PRICE_BH09 @BH09 @REQ-F13 @BR-006 @BR-007 @BR-008 @BR-009
    Scenario Outline: Chính sách cơ sở không cộng mã với chế độ giá đặc biệt [<case_id>]
      Given cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And giỏ đang sử dụng "<chế độ>" và có báo giá hợp lệ trước khi nhập mã
      When khách áp coupon hoặc voucher giảm thêm
      Then hệ thống thông báo chính sách không cộng dồn
      And báo giá ban đầu không thay đổi và không giữ lượt mã

      Examples:
        | case_id | chế độ            |
        | TC_PRICE_BH09_R01 | Giảm giá sản phẩm |
        | TC_PRICE_BH09_R02 | Giá sỉ            |
        | TC_PRICE_BH09_R03 | Combo             |
        | TC_PRICE_BH09_R04 | Mua đính kèm      |

    # BH10 -> TC_PRICE_BH10; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_003 @TC_PRICE_BH10 @BH10 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F13 @BR-006 @BR-007 @BR-008 @BR-009
    Scenario: Voucher không tạo số tiền phải trả âm hoặc tiền thừa được hoàn
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" có giỏ giá thường 120000 VND
      And voucher hợp lệ của "KH01" giảm 150000 VND, tối thiểu 100000 VND
      When khách áp dụng voucher đó
      Then tiền giảm thực tế là 120000 VND và tiền phải trả là 0 VND
      And không phát sinh khoản hoàn 30000 VND hoặc số dư voucher mới

    # BH11 -> TC_PRICE_BH11; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_003 @TC_PRICE_BH11 @BH11 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F13 @BR-006 @BR-007 @BR-008 @BR-009
    Scenario: Mã hết hạn sau báo giá phải được xác nhận lại trước tạo đơn
      Given cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And khách đã xem báo giá 240000 VND còn 190000 VND với voucher còn hạn
      And voucher đã hết hạn trước khi khách đặt đơn
      When khách gửi yêu cầu đặt theo báo giá cũ
      Then hệ thống yêu cầu xác nhận báo giá mới không có voucher
      And không âm thầm tăng số tiền thu rồi tạo đơn
      And giỏ, tồn kho và lượt voucher chưa thay đổi


  # REQ_PRICE_004 | Mục tiêu: Giá sỉ theo tổng số lượng của cùng một mã sách trong giỏ
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @pricing @REQ_PRICE_004 @REQ-F14 @BR-005 @BR-008 @BR-010
  Rule: [Giá và khuyến mãi] Giá sỉ theo tổng số lượng của cùng một mã sách trong giỏ

    # BH12 -> TC_PRICE_BH12; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_004 @TC_PRICE_BH12 @BH12 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F14 @BR-005 @BR-008 @BR-010
    Scenario Outline: Áp dụng đúng ngưỡng số lượng bán sỉ [<case_id>]
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "S001" có tồn khả dụng 30 và giá sỉ 100000 VND từ 10 quyển trở lên
      When khách báo giá <số lượng> quyển "S001"
      Then đơn giá là <đơn giá> VND và thành tiền là <thành tiền> VND
      And báo giá cho biết số lượng đã hoặc chưa đạt ngưỡng sỉ

      Examples:
        | case_id | số lượng | đơn giá | thành tiền |
        | TC_PRICE_BH12_R01 | 9        | 120000  | 1080000    |
        | TC_PRICE_BH12_R02 | 10       | 100000  | 1000000    |
        | TC_PRICE_BH12_R03 | 11       | 100000  | 1100000    |

    # BH13 -> TC_PRICE_BH13; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_004 @TC_PRICE_BH13 @BH13 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F14 @BR-005 @BR-008 @BR-010
    Scenario: Không nhân chồng giảm giá sản phẩm lên đơn giá sỉ
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "S001" có giá thường 120000 VND, giảm sản phẩm còn 108000 VND và giá sỉ 100000 VND từ 10 quyển
      When khách báo giá 10 quyển "S001"
      Then hệ thống chọn mức hợp lệ thấp nhất là 100000 VND mỗi quyển
      And thành tiền là 1000000 VND
      And không giảm thêm 10 phần trăm lên đơn giá sỉ

    # BH14 -> TC_PRICE_BH14; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_004 @TC_PRICE_BH14 @BH14 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F14 @BR-005 @BR-008 @BR-010
    Scenario: Giảm số lượng xuống dưới ngưỡng sỉ phải báo lại giá
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And giỏ có 10 quyển "S001" đang hưởng giá sỉ 100000 VND mỗi quyển
      When khách đổi số lượng thành 9 và không có giảm sản phẩm khác
      Then giá đơn vị trở về 120000 VND và thành tiền là 1080000 VND
      And hệ thống thông báo giỏ không còn đạt ngưỡng sỉ trước khi khách đặt đơn


  # REQ_PRICE_005 | Mục tiêu: Combo có giá riêng nhưng dùng tồn của tất cả sách thành phần
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @pricing @REQ_PRICE_005 @REQ-F15 @BR-011 @BR-013 @BR-014 @BR-023
  Rule: [Giá và khuyến mãi] Combo có giá riêng nhưng dùng tồn của tất cả sách thành phần

    # BH15 -> TC_PRICE_BH15; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_005 @TC_PRICE_BH15 @BH15 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F15 @BR-011 @BR-013 @BR-014 @BR-023
    Scenario: Mua hai combo giữ đúng số sách thành phần
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And combo "CB01" gồm 1 quyển "S001" và 1 quyển "S002", giá 250000 VND mỗi bộ
      And "KH01" đang đăng nhập và có 2 bộ "CB01" trong giỏ
      When khách đặt đơn COD hợp lệ
      Then đơn có 2 bộ với tổng tiền 500000 VND và lưu thành phần của combo tại lúc đặt
      And "S001" có tồn thực tế 10, giữ chỗ 2, khả dụng 8
      And "S002" có tồn thực tế 5, giữ chỗ 2, khả dụng 3
      And không tạo một kho combo độc lập để trừ thêm lần nữa

    # BH16 -> TC_PRICE_BH16; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_005 @TC_PRICE_BH16 @BH16 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F15 @BR-011 @BR-013 @BR-014 @BR-023
    Scenario: Thiếu một thành phần thì không giữ dở các thành phần còn lại
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S003 tên "Truyện ngắn chọn lọc", giá niêm yết 90000 VND, tồn ban đầu 0, giữ chỗ 0, tác giả 3, NXB thử, thể loại TL02 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And combo "CB01" gồm 1 quyển "S001" và 1 quyển "S003", giá 190000 VND
      And "KH01" muốn đặt 1 bộ trong khi "S003" hết hàng
      When khách đặt đơn COD cho combo đó
      Then hệ thống báo combo thiếu thành phần "S003" và không tạo đơn
      And "S001" vẫn có tồn thực tế 10, giữ chỗ 0, khả dụng 10
      And giỏ vẫn giữ lựa chọn combo để khách điều chỉnh

    # BH17 -> TC_PRICE_BH17; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_005 @TC_PRICE_BH17 @BH17 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F15 @BR-011 @BR-013 @BR-014 @BR-023
    Scenario: Cộng gộp cùng SKU khi vừa mua lẻ vừa mua trong combo
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And combo "CB01" gồm 1 quyển "S001" và 1 quyển "S002"
      And "KH01" có 9 quyển "S001" mua lẻ và 2 bộ "CB01" trong giỏ
      When khách đặt đơn COD
      Then hệ thống nhận ra đơn cần tổng cộng 11 quyển "S001" nhưng khả dụng chỉ là 10
      And không tạo đơn hoặc giữ dở "S002"


  # REQ_PRICE_006 | Mục tiêu: Mua đính kèm là dòng có tính tiền và cần khách chủ động chọn
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @pricing @REQ_PRICE_006 @REQ-F16 @BR-012 @BR-013 @BR-014
  Rule: [Giá và khuyến mãi] Mua đính kèm là dòng có tính tiền và cần khách chủ động chọn

    # BH18 -> TC_PRICE_BH18; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_006 @TC_PRICE_BH18 @BH18 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F16 @BR-012 @BR-013 @BR-014
    Scenario Outline: Khách chủ động mua thêm sách hoặc phụ kiện theo sách chính [<case_id>]
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And phụ kiện PK01 có giá thường 30000 VND, tồn ban đầu 20 và lựa chọn mua kèm S001 giá 20000 VND tối đa 1 món mỗi quyển chính
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And món "<món kèm>" có giá thường <giá thường> VND và tồn khả dụng 20
      And có lựa chọn mua kèm "S001" cho món đó giá <giá kèm> VND, tối đa 1 món mỗi quyển chính
      When khách chọn 1 quyển "S001" và chủ động chọn mua kèm 1 "<món kèm>"
      Then giỏ có hai dòng liên kết, thành tiền lần lượt là 120000 và <giá kèm> VND
      And tổng tiền là <tổng> VND và chưa giữ kho

      Examples:
        | case_id | món kèm | giá thường | giá kèm | tổng   |
        | TC_PRICE_BH18_R01 | PK01    | 30000      | 20000   | 140000 |
        | TC_PRICE_BH18_R02 | S002    | 180000     | 150000  | 270000 |

    # BH19 -> TC_PRICE_BH19; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_006 @TC_PRICE_BH19 @BH19 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F16 @BR-012 @BR-013 @BR-014
    Scenario: Không tự thêm món đính kèm khi khách chưa chọn
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And phụ kiện PK01 có giá thường 30000 VND, tồn ban đầu 20 và lựa chọn mua kèm S001 giá 20000 VND tối đa 1 món mỗi quyển chính
      And "S001" đang có lựa chọn mua kèm "PK01"
      When khách chỉ thêm 1 quyển "S001" vào giỏ
      Then giỏ chỉ có sách chính với tổng tiền 120000 VND
      And không thêm dòng hoặc tính tiền "PK01"

    # BH20 -> TC_PRICE_BH20; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_006 @TC_PRICE_BH20 @BH20 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F16 @BR-012 @BR-013 @BR-014
    Scenario: Không lấy giá mua kèm khi không có sách chính
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And phụ kiện PK01 có giá thường 30000 VND, tồn ban đầu 20 và lựa chọn mua kèm S001 giá 20000 VND tối đa 1 món mỗi quyển chính
      And ưu đãi "PK01" giá 20000 VND yêu cầu có sách chính "S001" trong giỏ
      When khách yêu cầu thêm "PK01" giá ưu đãi nhưng giỏ không có "S001"
      Then hệ thống từ chối mức giá mua kèm và không thêm dòng đó
      And không tự chuyển thành mua giá thường nếu khách chưa xác nhận

    # BH21 -> TC_PRICE_BH21; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_006 @TC_PRICE_BH21 @BH21 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F16 @BR-012 @BR-013 @BR-014
    Scenario: Không mua kèm vượt tỷ lệ hoặc số lượng tồn khả dụng
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And phụ kiện PK01 có giá thường 30000 VND, tồn ban đầu 20 và lựa chọn mua kèm S001 giá 20000 VND tối đa 1 món mỗi quyển chính
      And giỏ có 1 quyển "S001" và chương trình chỉ cho mua kèm 1 "PK01" mỗi quyển
      When khách yêu cầu mua kèm 2 "PK01"
      Then hệ thống thông báo vượt số lượng mua kèm tối đa 1
      And giỏ không bị tăng số tiền hoặc số lượng mua kèm

    # BH22 -> TC_PRICE_BH22; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_006 @TC_PRICE_BH22 @BH22 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F16 @BR-012 @BR-013 @BR-014
    Scenario: Món đính kèm hết hàng không được ghi vào đơn như đã có hàng
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And phụ kiện PK01 có giá thường 30000 VND, tồn ban đầu 20 và lựa chọn mua kèm S001 giá 20000 VND tối đa 1 món mỗi quyển chính
      And "KH01" đã chọn 1 quyển "S001" và 1 "PK01" mua kèm hợp lệ trong giỏ
      And "PK01" đã hết hàng trước lúc đặt đơn
      When khách xác nhận đặt đơn COD có cả hai dòng
      Then hệ thống yêu cầu khách điều chỉnh món mua kèm và không tạo đơn thiếu món đã xác nhận
      And không giữ dở "S001" hoặc tính tiền món không thể giao


  # REQ_CART_004 | Mục tiêu: Sửa giỏ phải tính lại ưu đãi và giữ quan hệ giữa món chính và món mua kèm
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @cart @REQ_CART_004 @REQ-F04 @REQ-F16 @BR-003 @BR-008 @BR-012 @BR-018
  Rule: [Giỏ hàng] Sửa giỏ phải tính lại ưu đãi và giữ quan hệ giữa món chính và món mua kèm

    # GH01 -> TC_CART_GH01; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @cart @REQ_CART_004 @TC_CART_GH01 @GH01 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F04 @REQ-F16 @BR-003 @BR-008 @BR-012 @BR-018
    Scenario: Giảm sách chính làm giảm số món mua kèm tối đa với thông báo rõ ràng
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And phụ kiện PK01 có giá thường 30000 VND, tồn ban đầu 20 và lựa chọn mua kèm S001 giá 20000 VND tối đa 1 món mỗi quyển chính
      And giỏ có 2 quyển "S001" giá 120000 VND và 2 "PK01" mua kèm giá 20000 VND mỗi món
      And mỗi quyển "S001" chỉ cho mua kèm 1 "PK01"
      When khách giảm số lượng "S001" thành 1
      Then giỏ có 1 "S001" và 1 "PK01", tổng tiền là 140000 VND
      And hệ thống thông báo số lượng mua kèm đã giảm theo sách chính
      And chưa giữ kho hoặc thu tiền

    # GH02 -> TC_CART_GH02; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @cart @REQ_CART_004 @TC_CART_GH02 @GH02 @assumption_P_DETAIL @approved_policy @REQ-F04 @REQ-F16 @BR-003 @BR-008 @BR-012 @BR-018
    Scenario: Bỏ món chính bằng số lượng 0 đồng thời bỏ dòng mua kèm phụ thuộc
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And phụ kiện PK01 có giá thường 30000 VND, tồn ban đầu 20 và lựa chọn mua kèm S001 giá 20000 VND tối đa 1 món mỗi quyển chính
      And giỏ chỉ có 1 "S001" và 1 "PK01" mua kèm phụ thuộc vào "S001"
      When khách đổi số lượng "S001" thành 0
      Then giỏ không còn cả hai dòng và tổng tiền là 0 VND
      And hệ thống thông báo món mua kèm cũng bị bỏ theo món chính
      And không tự chuyển "PK01" thành món mua giá thường

    # GH03 -> TC_CART_GH03; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @cart @REQ_CART_004 @TC_CART_GH03 @GH03 @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F04 @REQ-F16 @BR-003 @BR-008 @BR-012 @BR-018
    Scenario: Sửa giỏ làm mất điều kiện tối thiểu thì gỡ mã và báo lại tổng tiền
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And giỏ có 2 quyển "S001" giá thường với coupon "CP20" giảm 20 phần trăm từ 200000 VND
      And tiền trước giảm là 240000 VND, sau giảm là 192000 VND
      When khách đổi số lượng "S001" thành 1
      Then hệ thống gỡ "CP20" vì không còn đủ điều kiện
      And hiển thị lý do cùng tổng tiền mới 120000 VND trước khi đặt đơn
      And chưa tiêu lượt mã hoặc tạo giao dịch thu tiền


  # REQ_AUTH_005 | Mục tiêu: Email được xác minh bằng liên kết đúng tài khoản dùng một lần có hạn
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @auth @REQ_AUTH_005 @REQ-F18 @REQ-F19 @BR-026 @BR-029 @BR-030
  Rule: [Xác thực] Email được xác minh bằng liên kết đúng tài khoản dùng một lần có hạn

    # XT01 -> TC_AUTH_XT01; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_005 @TC_AUTH_XT01 @XT01 @assumption_P_AUTH_TTL @approved_policy @REQ-F18 @REQ-F19 @BR-026 @BR-029 @BR-030
    Scenario: Đăng ký email phát sinh yêu cầu xác minh tài khoản mới
      Given đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And email "moi@example.test" chưa được sử dụng và kênh mail mô phỏng đang hoạt động
      When guest đăng ký hợp lệ bằng email đó
      Then tạo đúng một tài khoản customer đang hoạt động nhưng email chưa xác minh
      And có một thư xác minh gửi đến "moi@example.test" với liên kết dùng một lần có hạn 30 phút
      And thư không chứa mật khẩu người dùng

    # XT02 -> TC_AUTH_XT02; có căn cứ/đã chốt trong phạm vi mô tả
    @auth @REQ_AUTH_005 @TC_AUTH_XT02 @XT02 @REQ-F18 @REQ-F19 @BR-026 @BR-029 @BR-030
    Scenario: Xác minh bằng liên kết hợp lệ trước khi hết hạn
      Given đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And tài khoản "KH-MOI" chưa xác minh email và có liên kết hợp lệ chưa dùng
      When người dùng mở liên kết trước thời điểm hết hạn
      Then email của đúng tài khoản "KH-MOI" được đánh dấu đã xác minh
      And liên kết đó được đánh dấu đã dùng
      And không tạo tài khoản mới hoặc nâng vai trò lên admin

    # XT03 -> TC_AUTH_XT03; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_005 @TC_AUTH_XT03 @XT03 @assumption_P_DETAIL @assumption_P_AUTH_TTL @approved_policy @REQ-F18 @REQ-F19 @BR-026 @BR-029 @BR-030
    Scenario Outline: Không xác minh bằng liên kết sai hoặc hết hạn [<case_id>]
      Given đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And "KH-MOI" chưa xác minh email
      When người dùng mở liên kết "<trường hợp>"
      Then hệ thống không đánh dấu email của "KH-MOI" đã xác minh
      And thông báo liên kết không hợp lệ hoặc hết hạn cùng khả năng yêu cầu gửi lại

      Examples:
        | case_id | trường hợp                    |
        | TC_AUTH_XT03_R01 | Bị sửa mã xác minh            |
        | TC_AUTH_XT03_R02 | Đã đến đúng thời điểm hết hạn |

    # XT04 -> TC_AUTH_XT04; có căn cứ/đã chốt trong phạm vi mô tả
    @auth @REQ_AUTH_005 @TC_AUTH_XT04 @XT04 @REQ-F18 @REQ-F19 @BR-026 @BR-029 @BR-030
    Scenario: Mở lại liên kết đã dùng không thực hiện xác minh lần hai
      Given đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And "KH-MOI" đã xác minh thành công bằng liên kết "TOKEN-01"
      When người dùng mở lại "TOKEN-01"
      Then hệ thống thông báo liên kết đã dùng hoặc tài khoản đã xác minh
      And tài khoản vẫn đã xác minh với vai trò customer
      And không tạo thêm tài khoản hoặc thư xác minh tự động

    # XT05 -> TC_AUTH_XT05; có căn cứ/đã chốt trong phạm vi mô tả
    @auth @REQ_AUTH_005 @TC_AUTH_XT05 @XT05 @confirmed_stock @confirmed_email_before_checkout @REQ-F18 @REQ-F19 @BR-026 @BR-029 @BR-030
    Scenario: Tài khoản chưa xác minh vẫn đăng nhập được nhưng chưa được đặt đơn
      Given một customer đang hoạt động, đã đăng nhập nhưng chưa xác minh email và có giỏ hợp lệ
      When customer đó yêu cầu đặt đơn
      Then hệ thống yêu cầu hoàn tất xác minh email
      And không tạo đơn, giữ hàng hoặc giữ lượt ưu đãi
      And giỏ vẫn giữ nguyên


  # REQ_AUTH_006 | Mục tiêu: Facebook xác thực theo định danh nhà cung cấp và dữ liệu trả về được kiểm tra
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @auth @REQ_AUTH_006 @REQ-F19 @BR-026 @BR-027
  Rule: [Xác thực] Facebook xác thực theo định danh nhà cung cấp và dữ liệu trả về được kiểm tra

    # XT06 -> TC_AUTH_XT06; có căn cứ/đã chốt trong phạm vi mô tả
    @auth @REQ_AUTH_006 @TC_AUTH_XT06 @XT06 @REQ-F19 @BR-026 @BR-027
    Scenario: Facebook nhận diện lại tài khoản đã liên kết mà không tạo bản sao
      Given đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And customer "KH-FB" đã liên kết với định danh Facebook "FB-001"
      And "KH-FB" đang hoạt động và đã có email được xác minh
      When khách đăng nhập Facebook và nhà cung cấp mô phỏng trả đúng định danh hợp lệ "FB-001"
      Then khách có phiên customer của chính "KH-FB"
      And không tạo tài khoản thứ hai dù tên hiển thị Facebook đã thay đổi
      And website không yêu cầu mật khẩu Facebook

    # XT07 -> TC_AUTH_XT07; có căn cứ/đã chốt trong phạm vi mô tả
    @auth @REQ_AUTH_006 @TC_AUTH_XT07 @XT07 @REQ-F19 @BR-026 @BR-027
    Scenario: Kết quả Facebook không thuộc phiên bắt đầu xác thực bị từ chối
      Given guest đã bắt đầu đăng nhập Facebook trong phiên A
      When kết quả xác thực bị sửa hoặc không khớp yêu cầu đã bắt đầu từ phiên A
      Then hệ thống không cấp phiên đăng nhập hoặc tạo tài khoản mới
      And thông báo xác thực không hợp lệ để người dùng bắt đầu lại


  # REQ_ORDER_003 | Mục tiêu: Tạo hủy và giữ quyền ưu đãi của đơn phải nhất quán
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @order @REQ_ORDER_003 @REQ-F21 @REQ-F22 @BR-009 @BR-015 @BR-022 @BR-023 @BR-024 @BR-025
  Rule: [Đơn hàng] Tạo hủy và giữ quyền ưu đãi của đơn phải nhất quán

    # DH01 -> TC_ORDER_DH01; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_003 @TC_ORDER_DH01 @DH01 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F21 @REQ-F22 @BR-009 @BR-015 @BR-022 @BR-023 @BR-024 @BR-025
    Scenario Outline: Khách hủy đơn của mình trước khi bàn giao vận chuyển [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đang đăng nhập và sở hữu đơn COD "DH01" đang "<trạng thái>", "Chưa thu"
      And đơn giữ 2 quyển "S001" làm tồn thực tế 10, giữ chỗ 2, khả dụng 8
      When "KH01" hủy đơn và cung cấp lý do
      Then đơn chuyển thành "Đã hủy" và lý do được lưu
      And "S001" có tồn thực tế 10, giữ chỗ 0, khả dụng 10
      And không phát sinh phiếu nhập kho hoặc tiền đã thu

      Examples:
        | case_id | trạng thái   |
        | TC_ORDER_DH01_R01 | Chờ xác nhận |
        | TC_ORDER_DH01_R02 | Đã xác nhận  |

    # DH02 -> TC_ORDER_DH02; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_003 @TC_ORDER_DH02 @DH02 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F21 @REQ-F22 @BR-009 @BR-015 @BR-022 @BR-023 @BR-024 @BR-025
    Scenario: Khách không được hủy đơn của người khác
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản KH02 có email kh02@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đăng nhập và "DH02" thuộc "KH02" đang giữ hàng
      When "KH01" gửi yêu cầu hủy trực tiếp "DH02"
      Then hệ thống từ chối truy cập
      And đơn, kho và quyền ưu đãi của "DH02" không thay đổi

    # DH03 -> TC_ORDER_DH03; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_003 @TC_ORDER_DH03 @DH03 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F21 @REQ-F22 @BR-009 @BR-015 @BR-022 @BR-023 @BR-024 @BR-025
    Scenario: Nhấn đặt COD hai lần cùng mã yêu cầu chỉ tạo một đơn và một lần giữ hàng
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đã xác minh có 2 quyển "S001" trong giỏ
      When yêu cầu đặt COD hợp lệ "REQ-COD-01" với cùng nội dung được gửi hai lần
      Then cả hai phản hồi nhận cùng một mã đơn và chỉ có một đơn mới
      And "S001" có tồn thực tế 10, giữ chỗ 2, khả dụng 8
      And giỏ không chứa các dòng đã đặt và không có tiền đã thu

    # DH04 -> TC_ORDER_DH04; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_003 @TC_ORDER_DH04 @DH04 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F21 @REQ-F22 @BR-009 @BR-015 @BR-022 @BR-023 @BR-024 @BR-025
    Scenario: Trùng mã yêu cầu nhưng nội dung khác không sửa đơn đã tạo
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "REQ-COD-01" đã tạo đơn "DH01" với 1 quyển "S001"
      When khách gửi lại "REQ-COD-01" nhưng đổi thành 2 quyển "S002"
      Then hệ thống thông báo mã yêu cầu đã dùng cho nội dung khác
      And giữ nguyên "DH01", tổng tiền và lượng giữ kho ban đầu
      And không tạo thêm đơn

    # DH05 -> TC_ORDER_DH05; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_003 @TC_ORDER_DH05 @DH05 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F21 @REQ-F22 @BR-009 @BR-015 @BR-022 @BR-023 @BR-024 @BR-025
    Scenario: Hai khách tranh lượt coupon cuối không cùng nhận ưu đãi vượt hạn mức
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản KH02 có email kh02@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And coupon "CP20" đang hiệu lực, giảm 20 phần trăm, tối thiểu 200000 VND, chỉ còn 1 lượt khả dụng và chưa ai giữ lượt đó
      And "KH01" và "KH02" đã xác minh đều có giỏ giá thường 240000 VND đủ điều kiện
      When hai khách đồng thời đặt COD với coupon "CP20"
      Then đúng một đơn được tạo với giá sau giảm 192000 VND và giữ lượt cuối
      And yêu cầu còn lại nhận thông báo hết hạn mức và yêu cầu xác nhận lại giá
      And yêu cầu không được tạo đơn không làm thay đổi giỏ hoặc giữ kho
      And hệ thống không tạo đơn thứ hai theo giá cao hơn khi khách chưa đồng ý

    # DH06 -> TC_ORDER_DH06; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_003 @TC_ORDER_DH06 @DH06 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F21 @REQ-F22 @BR-009 @BR-015 @BR-022 @BR-023 @BR-024 @BR-025
    Scenario: Hủy đơn giải phóng đúng một lần lượt voucher đang giữ
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" có đơn COD "DH01" chưa giao, chưa thu và đang giữ một lượt "VC50"
      And đơn giữ 2 quyển "S001" làm tồn thực tế 10, giữ chỗ 2, khả dụng 8
      When khách hủy "DH01" hợp lệ rồi gửi lại cùng yêu cầu hủy
      Then đơn vẫn "Đã hủy", voucher còn đúng 1 lượt khả dụng cho "KH01" và chưa bị đánh dấu đã dùng
      And "S001" có tồn thực tế 10, giữ chỗ 0, khả dụng 10
      And không có lần giải phóng làm tăng lượt voucher hoặc tồn khả dụng quá mức ban đầu

    # DH07 -> TC_ORDER_DH07; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_003 @TC_ORDER_DH07 @DH07 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F21 @REQ-F22 @BR-009 @BR-015 @BR-022 @BR-023 @BR-024 @BR-025
    Scenario: Sửa chương trình sau khi đặt không sửa giá khách đã chấp nhận
      Given cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And đơn COD "DH01" đã tạo hợp lệ với tiền hàng 240000 VND, voucher giảm 50000 VND, phải thu 190000 VND
      When admin đổi giá sách và dừng chương trình voucher sau thời điểm tạo đơn
      Then đơn "DH01" vẫn hiển thị các mức giá và số tiền phải thu ban đầu
      And thay đổi mới chỉ ảnh hưởng báo giá và đơn tạo sau đó


  # REQ_PAY_001 | Mục tiêu: COD chỉ được ghi đã thu khi xác nhận giao thành công và đúng số tiền
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @payment @REQ_PAY_001 @REQ-F17 @REQ-F21 @BR-009 @BR-019 @BR-020 @BR-021 @BR-024 @BR-028
  Rule: [Thanh toán COD] COD chỉ được ghi đã thu khi xác nhận giao thành công và đúng số tiền

    # TT01 -> TC_PAY_TT01; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @payment @REQ_PAY_001 @TC_PAY_TT01 @TT01 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F17 @REQ-F21 @BR-009 @BR-019 @BR-020 @BR-021 @BR-024 @BR-028
    Scenario: Giao COD thành công ghi nhận tiền một lần và không xuất kho lần nữa
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đơn COD "DH01" có 1 quyển "S001", đang giao, chưa thu, cần thu 120000 VND
      And đơn đã xuất kho nên "S001" có tồn thực tế 9, giữ chỗ 0, khả dụng 9
      When admin ghi nhận giao thành công và đã thu đủ 120000 VND với mã thu "COD-001"
      Then đơn chuyển "Hoàn tất" và thanh toán thành "Đã thu"
      And có đúng một bản ghi thu COD 120000 VND gắn với "COD-001" và "DH01"
      And mọi lượt ưu đãi đang giữ cho đơn được chuyển sang đã dùng đúng một lần
      And tồn thực tế "S001" vẫn là 9, giữ chỗ 0, khả dụng 9

    # TT02 -> TC_PAY_TT02; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @payment @REQ_PAY_001 @TC_PAY_TT02 @TT02 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F17 @REQ-F21 @BR-009 @BR-019 @BR-020 @BR-021 @BR-024 @BR-028
    Scenario Outline: Không xác nhận đã thu đủ bằng số tiền không khớp [<case_id>]
      Given cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đơn COD "DH01" đang giao, chưa thu và cần thu 120000 VND
      When admin yêu cầu xác nhận đã thu đủ nhưng nhập số tiền <số tiền> VND
      Then hệ thống từ chối xác nhận đủ tiền và hiển thị chênh lệch cần xử lý
      And đơn chưa được chuyển "Hoàn tất" hoặc "Đã thu"
      And không tự sửa tổng tiền của đơn hoặc phát sinh lần xuất kho mới

      Examples:
        | case_id | số tiền |
        | TC_PAY_TT02_R01 | 0       |
        | TC_PAY_TT02_R02 | 119999  |
        | TC_PAY_TT02_R03 | 120001  |

    # TT03 -> TC_PAY_TT03; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @payment @REQ_PAY_001 @TC_PAY_TT03 @TT03 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F17 @REQ-F21 @BR-009 @BR-019 @BR-020 @BR-021 @BR-024 @BR-028
    Scenario: Giao COD không thành công không được ghi nhận đã thu hoặc tự nhập hàng trả
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đơn COD "DH01" đang giao, chưa thu và 1 quyển "S001" đã xuất làm tồn thực tế còn 9
      When admin ghi nhận lần giao thất bại với lý do "Khách không nhận được hàng"
      Then lịch sử đơn ghi nhận lần giao thất bại và lý do
      And đơn vẫn chưa hoàn tất và thanh toán vẫn là "Chưa thu"
      And tồn thực tế "S001" vẫn là 9 cho tới khi có nghiệp vụ nhận hàng trả riêng

    # TT04 -> TC_PAY_TT04; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @payment @REQ_PAY_001 @TC_PAY_TT04 @TT04 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F17 @REQ-F21 @BR-009 @BR-019 @BR-020 @BR-021 @BR-024 @BR-028
    Scenario: Gửi lại cùng xác nhận thu COD không thu tiền hoặc dùng ưu đãi hai lần
      Given dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "DH01" đã hoàn tất, đã ghi nhận thu 120000 VND bằng "COD-001"
      And tồn thực tế "S001" là 9 và các lượt ưu đãi của đơn đã dùng
      When admin gửi lại đúng "COD-001" với cùng số tiền và cùng đơn
      Then vẫn chỉ có một bản ghi thu 120000 VND
      And trạng thái đơn, tồn kho và số lượt ưu đãi đã dùng không thay đổi

    # TT05 -> TC_PAY_TT05; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @payment @REQ_PAY_001 @TC_PAY_TT05 @TT05 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F17 @REQ-F21 @BR-009 @BR-019 @BR-020 @BR-021 @BR-024 @BR-028
    Scenario: Khách không tự đánh dấu đơn COD của mình đã thu tiền
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "KH01" đang đăng nhập và sở hữu "DH01" đang giao, chưa thu
      When "KH01" gửi yêu cầu trực tiếp đổi thanh toán thành "Đã thu"
      Then hệ thống từ chối vì customer không có quyền xác nhận thu COD
      And đơn và thanh toán không thay đổi

    # TT06 -> TC_PAY_TT06; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @payment @REQ_PAY_001 @TC_PAY_TT06 @TT06 @confirmed_stock @assumption_P_DETAIL @approved_policy @REQ-F17 @REQ-F21 @BR-009 @BR-019 @BR-020 @BR-021 @BR-024 @BR-028
    Scenario: Đơn COD chưa xuất giao không được báo hoàn tất và đã thu
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And "QT01" đang đăng nhập và "DH01" là đơn COD "Chờ xác nhận", "Chưa thu"
      When admin yêu cầu ghi nhận giao thành công và đã thu tiền ngay
      Then hệ thống từ chối vì đơn chưa qua xác nhận và bàn giao hợp lệ
      And không ghi tiền đã thu hoặc xuất kho để bỏ qua các bước còn thiếu

    # TT07 -> TC_PAY_TT07; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @payment @REQ_PAY_001 @TC_PAY_TT07 @TT07 @confirmed_stock @confirmed_price_detail @assumption_P_DETAIL @approved_policy @REQ-F17 @REQ-F21 @BR-009 @BR-019 @BR-020 @BR-021 @BR-024 @BR-028
    Scenario: Đơn được giảm về 0 không phát sinh khoản thu COD giả
      Given cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And đơn "DH01" có snapshot tiền phải trả 0 VND và thanh toán "Không cần thu"
      And đơn đã được xác nhận, giữ hàng và xuất giao hợp lệ
      When admin ghi nhận giao thành công đơn đó
      Then đơn chuyển "Hoàn tất" và vẫn là "Không cần thu"
      And không tạo bản ghi đã thu tiền mặt hoặc khoản tiền hoàn từ phần giảm dư
      And các lượt ưu đãi của đơn được dùng đúng một lần


  # REQ_CATALOG_005 | Mục tiêu: Khách được tìm và xem sách công khai theo thông tin đã xuất bản
  # Tác nhân/quyền: guest hoặc người đăng nhập cho dữ liệu công khai
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @catalog @REQ_CATALOG_005 @REQ-F23 @BR-031
  Rule: [Danh mục] Khách được tìm và xem sách công khai theo thông tin đã xuất bản

    # NEW001 -> TC_CATALOG_NEW001; có căn cứ/đã chốt trong phạm vi mô tả
    @catalog @REQ_CATALOG_005 @TC_CATALOG_NEW001 @NEW001 @REQ-F23 @BR-031
    Scenario: Xem thông tin giới thiệu website đã công khai
      Given thông tin giới thiệu đã xuất bản ghi tên "Nhà sách thử nghiệm" và email "lienhe@example.test"
      When guest mở trang giới thiệu
      Then thấy đúng tên và email đã xuất bản
      And không thấy thông tin quản trị hoặc dữ liệu tài khoản nội bộ

    # NEW002 -> TC_CATALOG_NEW002; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_005 @TC_CATALOG_NEW002 @NEW002 @assumption_P_SEARCH @approved_policy @REQ-F23 @BR-031
    Scenario: Tìm sách theo tên và lọc theo thể loại
      Given thể loại TL01 là Kỹ thuật và TL02 là Văn học đang tồn tại
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S003 tên "Truyện ngắn chọn lọc", giá niêm yết 90000 VND, tồn ban đầu 0, giữ chỗ 0, tác giả 3, NXB thử, thể loại TL02 và ảnh mô tả đang hiển thị
      And danh mục có S001 tên "Java căn bản" thuộc TL01 và S002 tên "Thiết kế phần mềm" thuộc TL01
      And danh mục có S003 tên "Truyện ngắn chọn lọc" thuộc TL02
      When guest tìm tên "Java" trong thể loại "TL01"
      Then kết quả chỉ có S001 với giá niêm yết 120000 VND
      And không có sách đã ngừng hiển thị hoặc dữ liệu của tài khoản

    # NEW003 -> TC_CATALOG_NEW003; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_005 @TC_CATALOG_NEW003 @NEW003 @assumption_P_SEARCH @approved_policy @REQ-F23 @BR-031
    Scenario: Tìm và lọc không có kết quả không phải lỗi hệ thống
      Given thể loại TL01 là Kỹ thuật và TL02 là Văn học đang tồn tại
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S003 tên "Truyện ngắn chọn lọc", giá niêm yết 90000 VND, tồn ban đầu 0, giữ chỗ 0, tác giả 3, NXB thử, thể loại TL02 và ảnh mô tả đang hiển thị
      And danh mục công khai có các sách S001 S002 S003
      When guest tìm "TenKhongTonTai" trong thể loại TL01
      Then kết quả trống và có thông báo không tìm thấy sách
      And danh mục và giỏ hàng không thay đổi

    # NEW004 -> TC_CATALOG_NEW004; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @catalog @REQ_CATALOG_005 @TC_CATALOG_NEW004 @NEW004 @assumption_P_SEARCH @approved_policy @REQ-F23 @BR-031
    Scenario: Từ chối bộ lọc có khoảng giá không hợp lệ
      Given guest đang xem danh mục công khai
      When guest gửi giá tối thiểu 200000 VND lớn hơn giá tối đa 100000 VND
      Then hệ thống thông báo khoảng giá không hợp lệ
      And không đọc hoặc trả dữ liệu riêng tư hay thay đổi danh mục


  # REQ_CHECKOUT_002 | Mục tiêu: Backend xác minh lại báo giá và dữ liệu trước khi cam kết tạo đơn
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @checkout @REQ_CHECKOUT_002 @REQ-F20 @REQ-F21 @BR-018 @BR-022 @BR-023 @BR-024
  Rule: [Đặt hàng] Backend xác minh lại báo giá và dữ liệu trước khi cam kết tạo đơn

    # NEW005 -> TC_CHECKOUT_NEW005; có căn cứ/đã chốt trong phạm vi mô tả
    @checkout @REQ_CHECKOUT_002 @TC_CHECKOUT_NEW005 @NEW005 @confirmed_stock @REQ-F20 @REQ-F21 @BR-018 @BR-022 @BR-023 @BR-024
    Scenario: Giá frontend bị sửa không được dùng làm giá đơn
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And KH01 đã xác minh email có giỏ gồm 2 quyển S001 giá thường 120000 VND mỗi quyển
      And phí của cấu hình thử bằng 0 VND và báo giá backend là 240000 VND
      When khách đặt COD nhưng sửa tổng tiền gửi từ frontend thành 1000 VND
      Then backend yêu cầu xác nhận báo giá đúng 240000 VND
      And chưa tạo đơn, giữ kho, giữ lượt mã hoặc xóa giỏ

    # NEW006 -> TC_CHECKOUT_NEW006; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @checkout @REQ_CHECKOUT_002 @TC_CHECKOUT_NEW006 @NEW006 @confirmed_stock @assumption_D_TRANSACTION_ASYNC @approved_policy @design_decision @REQ-F20 @REQ-F21 @BR-018 @BR-022 @BR-023 @BR-024
    Scenario: Lỗi giữa giữ kho và ghi đơn không để lại dữ liệu dở dang
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And phương án P-STOCK và ranh giới cam kết D01 đang được mô phỏng
      And KH01 đã xác minh có giỏ 2 quyển S001 với số phải thu 240000 VND
      And S001 có tồn thực tế 10, giữ chỗ 0
      When lỗi lưu dữ liệu xảy ra trước khi toàn bộ đơn và lượng giữ được cam kết
      Then không có đơn mới hoặc lượng giữ hay lượt mã bị tiêu dở
      And giỏ vẫn có 2 quyển S001 và tồn thực tế 10, giữ chỗ 0
      And khách nhận lỗi có thể thử lại, không nhận xác nhận đã đặt đơn

    # NEW007 -> TC_CHECKOUT_NEW007; có căn cứ/đã chốt trong phạm vi mô tả
    @checkout @REQ_CHECKOUT_002 @TC_CHECKOUT_NEW007 @NEW007 @confirmed_stock @REQ-F20 @REQ-F21 @BR-018 @BR-022 @BR-023 @BR-024
    Scenario: Mất phản hồi sau cam kết rồi thử lại chỉ nhận lại đơn đã tạo
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And yêu cầu COD REQ-RETRY của KH01 đã cam kết đơn DH-RETRY giữ 2 quyển S001
      And phản hồi cho khách bị mất sau cam kết
      When cùng KH01 gửi lại REQ-RETRY với đúng nội dung ban đầu
      Then khách nhận lại DH-RETRY dù giỏ đã bỏ các dòng của đơn
      And chỉ có một đơn, một lần giữ 2 quyển và không có tiền COD đã thu


  # REQ_CART_005 | Mục tiêu: Chỉ chủ sở hữu giỏ được sửa giỏ của mình
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @cart @REQ_CART_005 @REQ-F22 @BR-016 @BR-025 @BR-028
  Rule: [Giỏ hàng] Chỉ chủ sở hữu giỏ được sửa giỏ của mình

    # NEW008 -> TC_CART_NEW008; có căn cứ/đã chốt trong phạm vi mô tả
    @cart @REQ_CART_005 @TC_CART_NEW008 @NEW008 @REQ-F22 @BR-016 @BR-025 @BR-028
    Scenario: Không sửa giỏ tài khoản khác bằng cách thay mã giỏ
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And tài khoản KH02 có email kh02@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And KH01 và KH02 có hai giỏ độc lập
      And giỏ KH02 có 1 quyển S001
      When KH01 gửi yêu cầu đổi số lượng trên mã giỏ của KH02
      Then backend từ chối quyền sở hữu mà không trả nội dung riêng tư của giỏ KH02
      And giỏ của cả hai tài khoản không thay đổi


  # REQ_AUTH_007 | Mục tiêu: Gửi thư xác minh được theo dõi và phục hồi khi dịch vụ mail lỗi
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @auth @REQ_AUTH_007 @REQ-F19 @BR-026 @BR-030
  Rule: [Xác thực] Gửi thư xác minh được theo dõi và phục hồi khi dịch vụ mail lỗi

    # NEW009 -> TC_AUTH_NEW009; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_007 @TC_AUTH_NEW009 @NEW009 @assumption_D_TRANSACTION_ASYNC @approved_policy @design_decision @REQ-F19 @BR-026 @BR-030
    Scenario: Mail tạm lỗi không làm tài khoản mới mất hoặc được xác minh giả
      Given email moi@example.test chưa tồn tại và dịch vụ mail mô phỏng tạm không hoạt động
      When guest đăng ký tài khoản email hợp lệ
      Then tài khoản mới tồn tại nhưng email chưa xác minh
      And có yêu cầu gửi thư đang chờ và người dùng được báo chưa gửi được thư
      And không trả mật khẩu hoặc cấp quyền đặt đơn cho tài khoản chưa xác minh

    # NEW010 -> TC_AUTH_NEW010; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @auth @REQ_AUTH_007 @TC_AUTH_NEW010 @NEW010 @assumption_D_TRANSACTION_ASYNC @approved_policy @design_decision @REQ-F19 @BR-026 @BR-030
    Scenario: Gửi lại thư đang chờ không tạo thêm tài khoản
      Given tài khoản KH-MOI chưa xác minh và yêu cầu gửi thư MAIL01 đang chờ do lần gửi trước thất bại
      And dịch vụ mail mô phỏng đã hoạt động lại
      When cùng yêu cầu MAIL01 được thử gửi lại
      Then có thư xác minh gửi đến đúng email của KH-MOI
      And không tạo tài khoản mới hoặc đánh dấu email đã xác minh chỉ vì gửi thư
      And trạng thái yêu cầu gửi được cập nhật theo phản hồi dịch vụ mail


  # REQ_INV_003 | Mục tiêu: Kiểm kê yêu cầu dữ liệu và quyền hợp lệ trước khi thay đổi kho
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @inventory @REQ_INV_003 @REQ-F10 @BR-013 @BR-028
  Rule: [Kho] Kiểm kê yêu cầu dữ liệu và quyền hợp lệ trước khi thay đổi kho

    # NEW011 -> TC_INV_NEW011; có căn cứ/đã chốt trong phạm vi mô tả
    @inventory @REQ_INV_003 @TC_INV_NEW011 @NEW011 @confirmed_stock @REQ-F10 @BR-013 @BR-028
    Scenario: Không điều chỉnh kho thiếu lý do
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And QT01 có quyền quản trị kho và S001 có tồn thực tế 10, giữ chỗ 0
      When admin yêu cầu kiểm kê tồn thành 8 nhưng không nêu lý do
      Then hệ thống yêu cầu bổ sung lý do
      And tồn thực tế và giữ chỗ không thay đổi, không phát sinh bản ghi điều chỉnh


  # REQ_PAY_002 | Mục tiêu: Xác nhận thu COD phải đúng đơn và đúng nội dung yêu cầu
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @payment @REQ_PAY_002 @REQ-F17 @REQ-F21 @BR-020 @BR-024
  Rule: [Thanh toán COD] Xác nhận thu COD phải đúng đơn và đúng nội dung yêu cầu

    # NEW012 -> TC_PAY_NEW012; có căn cứ/đã chốt trong phạm vi mô tả
    @payment @REQ_PAY_002 @TC_PAY_NEW012 @NEW012 @confirmed_stock @REQ-F17 @REQ-F21 @BR-020 @BR-024
    Scenario: Mã thu COD đã dùng không được ghi lại với đơn hoặc số tiền khác
      Given cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And COD001 đã ghi thu 120000 VND cho đơn DH01
      When admin gửi lại COD001 nhưng thay đơn hoặc số tiền
      Then hệ thống báo mã thu đã dùng cho nội dung khác
      And không ghi thêm khoản thu hoặc thay đổi trạng thái đơn và tồn kho


  # REQ_PRICE_007 | Mục tiêu: Cấu hình các hình thức bán được quản trị và công bố trước khi khách chọn
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @pricing @REQ_PRICE_007 @REQ-F15 @REQ-F16 @BR-011 @BR-012 @BR-028
  Rule: [Giá và khuyến mãi] Cấu hình các hình thức bán được quản trị và công bố trước khi khách chọn

    # NEW013 -> TC_PRICE_NEW013; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_007 @TC_PRICE_NEW013 @NEW013 @confirmed_price_detail @approved_policy @REQ-F15 @REQ-F16 @BR-011 @BR-012 @BR-028
    Scenario: Admin cấu hình combo có thành phần và giá hợp lệ
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And dữ liệu gốc sách S002 tên "Thiết kế phần mềm", giá niêm yết 180000 VND, tồn ban đầu 5, giữ chỗ 0, tác giả 2, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And QT01 có quyền quản trị và S001 S002 là sách tồn tại
      When admin lưu combo CB01 gồm 1 S001 và 1 S002 với giá 250000 VND
      Then cấu hình combo lưu đúng thành phần và giá đã nhập
      And khách xem được thông tin từng thành phần và giá bộ trước khi thêm giỏ
      And chưa tạo tồn combo riêng hoặc giữ tồn thành phần

    # NEW014 -> TC_PRICE_NEW014; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @pricing @REQ_PRICE_007 @TC_PRICE_NEW014 @NEW014 @confirmed_price_detail @approved_policy @REQ-F15 @REQ-F16 @BR-011 @BR-012 @BR-028
    Scenario: Không tạo quan hệ mua kèm không có sản phẩm chính hợp lệ
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And phụ kiện PK01 tồn tại, giá thường 30000 VND, chưa có quan hệ mua kèm
      And QT01 có quyền quản trị và phụ kiện PK01 tồn tại
      When admin tạo giá mua kèm PK01 nhưng mã sản phẩm chính không tồn tại
      Then hệ thống yêu cầu chọn sản phẩm chính tồn tại
      And không lưu quan hệ mua kèm hoặc thay đổi giá bán hiện tại


  # REQ_CATALOG_006 | Mục tiêu: Sửa thể loại giữ nguyên mã và liên kết đang sử dụng
  # Tác nhân/quyền: guest hoặc người đăng nhập cho dữ liệu công khai
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @catalog @REQ_CATALOG_006 @REQ-F09 @BR-002 @BR-028
  Rule: [Danh mục] Sửa thể loại giữ nguyên mã và liên kết đang sử dụng

    # NEW015 -> TC_CATALOG_NEW015; có căn cứ/đã chốt trong phạm vi mô tả
    @catalog @REQ_CATALOG_006 @TC_CATALOG_NEW015 @NEW015 @REQ-F09 @BR-002 @BR-028
    Scenario: Đổi tên thể loại không thay mã hoặc mất liên kết sách
      Given tài khoản QT01 có email admin@example.test, vai trò admin, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And đồng hồ thử được kiểm soát tại 2026-10-29T10:00:00+07:00 trừ mốc thời gian nêu riêng trong kịch bản
      And QT01 có quyền quản trị và thể loại TL03 tên "Kinh tế" đã tồn tại
      When admin đổi tên TL03 thành "Kinh tế và kinh doanh"
      Then tên mới được lưu cho chính mã TL03
      And không tạo thể loại khác hoặc làm mất liên kết sách đã gắn TL03


  # REQ_CHECKOUT_003 | Mục tiêu: Kết quả cam kết chưa biết được giải quyết qua cùng khóa yêu cầu
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @checkout @REQ_CHECKOUT_003 @REQ-F21 @BR-024
  Rule: [Đặt hàng] Kết quả cam kết chưa biết được giải quyết qua cùng khóa yêu cầu

    # NEW016 -> TC_CHECKOUT_NEW016; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @checkout @REQ_CHECKOUT_003 @TC_CHECKOUT_NEW016 @NEW016 @confirmed_stock @assumption_D_TRANSACTION_ASYNC @approved_policy @design_decision @REQ-F21 @BR-024
    Scenario Outline: Retry sau mất kết quả cam kết không tạo nhiều hơn một đơn [<case_id>]
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And KH01 đã xác minh đặt COD bằng REQ-UNKNOWN cho 2 quyển S001, tổng 240000 VND
      And kết quả thực tế lần đầu là "<commit_state>" nhưng phản hồi cam kết bị mất
      When cùng KH01 thử lại cùng REQ-UNKNOWN và đúng nội dung ban đầu
      Then backend tra khóa yêu cầu trước khi quyết định thực hiện lại
      And cuối cùng chỉ có một đơn cho REQ-UNKNOWN và một lượng giữ 2 quyển S001
      And không có khoản tiền COD đã thu và khách nhận mã của đơn duy nhất đó

      Examples:
        | case_id | commit_state  |
        | TC_CHECKOUT_NEW016_R01 | Đã cam kết    |
        | TC_CHECKOUT_NEW016_R02 | Chưa cam kết  |


  # REQ_ORDER_004 | Mục tiêu: Lỗi hủy trước cam kết không để trạng thái và lượng giữ lệch nhau
  # Tác nhân/quyền: xác định theo Given của từng scenario; thao tác quản trị đòi admin
  # Input/ràng buộc: các trường và fixture trong Given; When là hành động chính.
  # Hậu điều kiện: Then/And; lỗi phải giữ dữ liệu hoặc hoàn tác như mô tả.
  @order @REQ_ORDER_004 @REQ-F21 @BR-009 @BR-015 @BR-024
  Rule: [Đơn hàng] Lỗi hủy trước cam kết không để trạng thái và lượng giữ lệch nhau

    # NEW017 -> TC_ORDER_NEW017; chính sách đã được chủ đề tài duyệt; không đồng nghĩa test đã chạy
    @order @REQ_ORDER_004 @TC_ORDER_NEW017 @NEW017 @confirmed_stock @confirmed_price_detail @assumption_D_TRANSACTION_ASYNC @approved_policy @design_decision @REQ-F21 @BR-009 @BR-015 @BR-024
    Scenario: Lỗi sau dự kiến giải phóng nhưng trước cam kết hủy giữ nguyên đơn gốc
      Given tài khoản KH01 có email kh01@example.test, vai trò customer, mật khẩu thử MatKhau#2026, hoạt động và email đã xác minh
      And dữ liệu gốc sách S001 tên "Java căn bản", giá niêm yết 120000 VND, tồn ban đầu 10, giữ chỗ 0, tác giả 1, NXB thử, thể loại TL01 và ảnh mô tả đang hiển thị
      And cấu hình thử không có phí giao hàng hoặc phí COD và không có ưu đãi khác ngoài mô tả của kịch bản
      And quy tắc kho QD-01 và phương án transaction D01 được dùng làm tiền điều kiện thiết kế
      And KH01 sở hữu đơn COD DH01 Chờ xác nhận chưa thu, đang giữ 2 quyển S001
      And S001 có tồn thực tế 10, giữ chỗ 2, khả dụng 8
      When lỗi lưu xảy ra trong thao tác hủy trước khi toàn bộ thay đổi được cam kết
      Then đơn vẫn Chờ xác nhận chưa thu và lượng giữ vẫn là 2
      And tồn thực tế 10, khả dụng 8 và lượt ưu đãi đang giữ không thay đổi
      And khách nhận lỗi có thể thử lại, không nhận xác nhận hủy thành công


  @inventory @REQ_INV_004
  Rule: Bổ sung hợp đồng REQ_INV_004 — Hai giỏ cùng chọn hàng không giữ hoặc làm giảm tồn

    @inventory @REQ_INV_004 @TC_INV_REV001 @REQ-F10 @REQ-F21 @BR-013 @BR-014 @confirmed_scope @s1
    Scenario: Hai giỏ cùng chọn hàng không giữ hoặc làm giảm tồn
      Given S001 có tồn thực tế 1, giữ chỗ 0 và hai guest A B có giỏ riêng trống
      And guest A đã thêm 1 S001 vào giỏ A, kho vẫn thực tế 1 và giữ chỗ 0
      When guest B thêm 1 S001 vào giỏ B
      Then giỏ A và giỏ B mỗi giỏ có 1 S001
      And kho vẫn thực tế 1, giữ chỗ 0 và khả dụng 1
      And chưa có đơn hàng hoặc cam kết bán hàng cho bất kỳ guest nào

  @order @REQ_ORDER_005
  Rule: Bổ sung hợp đồng REQ_ORDER_005 — Hủy lặp không cộng hàng thực tế hoặc giải phóng giữ chỗ lần hai

    @order @REQ_ORDER_005 @TC_ORDER_REV002 @REQ-F21 @BR-013 @BR-014 @BR-015 @BR-024 @confirmed_scope
    Scenario: Hủy lặp không cộng hàng thực tế hoặc giải phóng giữ chỗ lần hai
      Given KH01 đang đăng nhập và sở hữu đơn COD DH01 đã hủy trước bàn giao, không có ưu đãi
      And DH01 trước khi hủy giữ 2 S001, lượng giữ đó đã được giải phóng một lần
      And S001 hiện có tồn thực tế 10, giữ chỗ 1 thuộc đơn khác DH02
      When KH01 gửi lại yêu cầu hủy DH01
      Then trả trạng thái DH01 là "Đã hủy"
      And S001 vẫn có tồn thực tế 10, giữ chỗ 1 và khả dụng 9
      And giữ chỗ của DH02 không thay đổi và không thêm bút toán giải phóng

  @pricing @REQ_PRICE_008
  Rule: Bổ sung hợp đồng REQ_PRICE_008 — Giỏ có cả giá thường và giá đặc biệt không nhận thêm mã

    @pricing @REQ_PRICE_008 @TC_PRICE_REV003 @REQ-F13 @REQ-F14 @REQ-F15 @REQ-F16 @BR-006 @BR-007 @BR-008 @confirmed_scope
    Scenario Outline: Giỏ có cả giá thường và giá đặc biệt không nhận thêm mã [<case_id>]
      Given KH01 có giỏ gồm một dòng giá thường 120000 VND và một dòng "<chế độ>" đã có báo giá hợp lệ
      And "<loại mã>" đang hiệu lực, đủ lượt và thuộc KH01 nếu là voucher
      When KH01 yêu cầu áp dụng mã đó lên giỏ hiện tại
      Then hệ thống từ chối vì đơn có giá đặc biệt không được cộng mã
      And toàn bộ báo giá và giỏ đã lưu không thay đổi
      And không giữ hoặc tiêu lượt mã

      Examples:
        | case_id | chế độ | loại mã |
        | TC_PRICE_REV003_R01 | Giảm sản phẩm | Coupon |
        | TC_PRICE_REV003_R02 | Giá sỉ | Voucher |
        | TC_PRICE_REV003_R03 | Combo | Coupon |
        | TC_PRICE_REV003_R04 | Mua kèm | Voucher |

  @auth @REQ_AUTH_008
  Rule: Bổ sung hợp đồng REQ_AUTH_008 — Facebook đăng nhập thành công không bỏ qua xác minh email trước đặt đơn

    @auth @REQ_AUTH_008 @TC_AUTH_REV004 @REQ-F18 @REQ-F19 @BR-026 @BR-027 @BR-029 @confirmed_scope
    Scenario: Facebook đăng nhập thành công không bỏ qua xác minh email trước đặt đơn
      Given KH01 có phiên đăng nhập hợp lệ do Facebook thật xác thực và chưa xác minh email trong website
      And KH01 có giỏ hợp lệ và kho còn đủ hàng
      When KH01 gửi yêu cầu tạo đơn COD
      Then hệ thống yêu cầu xác minh email trước khi đặt đơn
      And không tạo đơn, giữ kho, dùng lượt mã hoặc thay đổi giỏ
      And không tự đánh dấu email đã xác minh chỉ từ dữ liệu frontend

  @catalog @REQ_CATALOG_007
  Rule: Bổ sung hợp đồng REQ_CATALOG_007 — Hai ấn bản trùng tên được quản lý bằng hai SKU riêng

    @catalog @REQ_CATALOG_007 @TC_CATALOG_REV005 @REQ-F02 @REQ-F09 @REQ-F10 @BR-001 @BR-002 @approved_policy @assumption_P_EDITION
    Scenario: Hai ấn bản trùng tên được quản lý bằng hai SKU riêng
      Given đề xuất P-EDITION dùng SKU làm định danh bán và tồn của từng ấn bản
      And sách S101 và S102 cùng tên "Lập trình Java", khác ấn bản và có giá 100000 và 150000 VND
      And S101 có tồn 3 còn S102 có tồn 7
      When guest xem chi tiết S102
      Then hiển thị đúng ấn bản S102, giá 150000 VND và tồn khả dụng 7
      And không gộp thông tin hoặc tồn S101 chỉ vì trùng tên

  @cart @REQ_CART_006
  Rule: Bổ sung hợp đồng REQ_CART_006 — Gộp hai giỏ sau đăng nhập giữ đủ lựa chọn và báo giá lại

    @cart @REQ_CART_006 @TC_CART_REV006 @REQ-F04 @REQ-F06 @BR-003 @BR-016 @BR-017 @BR-018 @approved_policy @assumption_P_MERGE
    Scenario: Gộp hai giỏ sau đăng nhập giữ đủ lựa chọn và báo giá lại
      Given đề xuất P-MERGE cộng số lượng các dòng cùng SKU và cùng chế độ giá, giữ riêng dòng khác chế độ hoặc khác liên kết món chính
      And guest có 1 S001 giá thường và KH01 có giỏ đã lưu 2 S001 giá thường
      And KH01 hoạt động, xác thực đúng và S001 có tồn khả dụng 10, giá hiện hành 120000 VND
      When guest đăng nhập thành công thành KH01 trong phiên đó
      Then giỏ KH01 có một dòng S001 giá thường, số lượng 3, báo giá 360000 VND
      And đánh dấu nguồn giỏ guest đã được chuyển đúng một lần
      And không giữ kho và không đưa giỏ của người khác vào kết quả

    @cart @REQ_CART_006 @TC_CART_REV007 @REQ-F04 @REQ-F06 @BR-003 @BR-016 @BR-017 @BR-018 @approved_policy @assumption_P_MERGE
    Scenario: Gộp giỏ vượt khả dụng không tự cắt hoặc mất lựa chọn
      Given đề xuất P-MERGE kiểm toàn bộ trước khi gộp, nếu vượt khả dụng thì giữ hai bản giỏ để chủ giỏ điều chỉnh
      And guest có 2 S001 và giỏ đã lưu KH01 có 3 S001, S001 chỉ còn khả dụng 4
      When guest đăng nhập thành công thành KH01 và yêu cầu gộp giỏ
      Then phiên đăng nhập được tạo nhưng kết quả gộp yêu cầu điều chỉnh S001 từ tổng 5 so với khả dụng 4
      And giỏ đã lưu KH01 vẫn 3 và nguồn giỏ guest vẫn 2, chỉ KH01 trong phiên đó được xử lý
      And không tự cắt một quyển, không mất dòng và không giữ hàng

    @cart @REQ_CART_006 @TC_CART_REV008 @REQ-F04 @REQ-F06 @REQ-F21 @BR-016 @BR-017 @BR-024 @approved_policy @assumption_P_MERGE
    Scenario: Thử lại gộp giỏ đã cam kết không cộng số lượng lần nữa
      Given đề xuất P-MERGE định danh nguồn giỏ guest và tài khoản đích cho một lần chuyển
      And nguồn guest G01 có 1 S001 đã gộp vào giỏ KH01 có 2 S001 thành 3 S001
      And kết quả đã cam kết nhưng phản hồi bị mất
      When cùng KH01 trong phiên sở hữu G01 gửi lại yêu cầu gộp đúng G01
      Then nhận giỏ KH01 có 3 S001 và nguồn G01 đã chuyển
      And không cộng thành 4 S001 hoặc tạo giỏ mới

  @inventory @REQ_INV_005
  Rule: Bổ sung hợp đồng REQ_INV_005 — Hủy và bàn giao đồng thời chỉ một chuyển trạng thái được cam kết

    @inventory @REQ_INV_005 @TC_INV_REV009 @REQ-F10 @REQ-F17 @REQ-F21 @BR-013 @BR-014 @BR-015 @BR-019 @BR-023 @BR-024 @approved_policy @assumption_P_STATE
    Scenario: Hủy và bàn giao đồng thời chỉ một chuyển trạng thái được cam kết
      Given đề xuất P-STATE cho phép chủ đơn hủy trước bàn giao và admin bàn giao đơn đã xác nhận
      And đơn DH01 đã xác nhận, giữ 2 S001, S001 có thực tế 10 và giữ chỗ 2
      When chủ đơn hủy và admin bàn giao DH01 đồng thời
      Then chỉ một chuyển trạng thái được cam kết
      And nếu hủy thắng thì DH01 đã hủy, thực tế 10, giữ chỗ 0, khả dụng 10
      And nếu bàn giao thắng thì DH01 đang giao, thực tế 8, giữ chỗ 0, khả dụng 8
      And thao tác thua nhận xung đột hoặc trạng thái hiện tại và không ghi biến động kho thứ hai

    @inventory @REQ_INV_005 @TC_INV_REV010 @REQ-F10 @REQ-F21 @BR-013 @BR-024 @BR-028 @approved_policy @assumption_P_DETAIL
    Scenario: Nhập kho lặp mã nhưng đổi nội dung bị từ chối
      Given QT01 đang có quyền quản trị kho
      And PN001 đã nhập 5 S001, tồn thực tế hiện là 15, giữ chỗ 0
      When QT01 dùng lại PN001 để yêu cầu nhập 6 S001
      Then trả lỗi mã phiếu đã dùng cho nội dung khác
      And tồn thực tế vẫn 15, giữ chỗ 0, chỉ có bút toán nhập 5 ban đầu

    @inventory @REQ_INV_005 @TC_INV_REV013 @REQ-F10 @REQ-F21 @BR-013 @BR-014 @BR-019 @BR-024 @approved_policy @assumption_P_STATE
    Scenario: Lỗi ghi bàn giao không để tồn và đơn lệch trạng thái
      Given phương án D01 cam kết đồng thời trạng thái đơn, giữ chỗ, tồn và lịch sử bàn giao
      And QT01 có quyền bàn giao, DH01 đã xác nhận giữ 2 S001, tồn thực tế 10 và giữ chỗ 2
      When lỗi ghi lịch sử bàn giao xảy ra trước cam kết
      Then DH01 vẫn đã xác nhận và giữ 2 S001
      And tồn thực tế vẫn 10, giữ chỗ 2, không có phiếu xuất đã cam kết
      And QT01 nhận lỗi có thể thử lại, không nhận xác nhận bàn giao thành công

  @pricing @REQ_PRICE_009
  Rule: Bổ sung hợp đồng REQ_PRICE_009 — Coupon kiểm tra ngưỡng tối thiểu tại hai phía biên

    @pricing @REQ_PRICE_009 @TC_PRICE_REV011 @REQ-F13 @BR-006 @BR-009 @approved_policy @assumption_P_PROMO_DETAIL
    Scenario Outline: Coupon kiểm tra ngưỡng tối thiểu tại hai phía biên [<case_id>]
      Given đề xuất P-PROMO-DETAIL quy định ngưỡng áp dụng gồm đúng mức tối thiểu
      And KH01 có giỏ giá thường <tổng> VND, không phí và không ưu đãi khác
      And coupon CP10 giảm 10 phần trăm, ngưỡng 200000 VND, đang hiệu lực và còn lượt
      When KH01 áp CP10 để xem báo giá
      Then kết quả là "<kết quả>" với tổng phải trả <phải trả> VND
      And chưa giữ hoặc tiêu lượt mã, chưa giữ kho

      Examples:
        | case_id | tổng | kết quả | phải trả |
        | TC_PRICE_REV011_R01 | 199999 | Chưa đạt ngưỡng | 199999 |
        | TC_PRICE_REV011_R02 | 200000 | Áp dụng thành công | 180000 |

  @auth @REQ_AUTH_009
  Rule: Bổ sung hợp đồng REQ_AUTH_009 — Email thật được nhận gửi vẫn không đồng nghĩa đã xác minh

    @auth @REQ_AUTH_009 @TC_AUTH_REV012 @REQ-F18 @REQ-F19 @BR-026 @BR-030 @confirmed_scope
    Scenario: Email thật được nhận gửi vẫn không đồng nghĩa đã xác minh
      Given tài khoản KH01 được tạo hợp lệ nhưng chưa xác minh email
      And yêu cầu gửi liên kết xác minh cho KH01 đã cam kết
      When dịch vụ email thật trả kết quả chấp nhận yêu cầu gửi
      Then ghi nhận kết quả gửi thư và KH01 vẫn chưa xác minh email
      And chưa có đơn hàng, giữ kho hoặc thanh toán phát sinh
      And chỉ việc kiểm tra liên kết xác minh hợp lệ mới có thể đổi trạng thái email

  @checkout @REQ_CHECKOUT_004
  Rule: Bổ sung hợp đồng REQ_CHECKOUT_004 — Giá được xác nhận lại mới được dùng để tạo đơn

    @checkout @REQ_CHECKOUT_004 @TC_CHECKOUT_REV014 @REQ-F07 @REQ-F20 @BR-014 @BR-018 @BR-022 @approved_policy @assumption_P_REQUOTE
    Scenario: Giá được xác nhận lại mới được dùng để tạo đơn
      Given đề xuất P-REQUOTE không tự tạo đơn khi báo giá thay đổi
      And KH01 đã xác minh email, có giỏ 1 S001 và đã nhận báo giá mới 130000 VND thay báo giá cũ 120000 VND
      And báo giá mới còn hợp lệ, phiên bản giỏ đúng, kho đủ 1 S001, không phí và không ưu đãi
      When KH01 xác nhận báo giá mới bằng yêu cầu đặt COD mới
      Then tạo một đơn lưu giá 130000 VND và phải thu 130000 VND
      And giữ 1 S001, không ghi khoản COD đã thu
      And không tạo thêm đơn cho yêu cầu báo giá cũ bị từ chối

  @cart @REQ_CART_006 @REQ-F22 @BR-016
  Rule: S1 bảo vệ chủ giỏ guest và phiên bản đã đọc

    @s1 @TC_CART_S1_OWNER @REQ-F22 @BR-016
    Scenario: Guest không sửa giỏ của phiên khác bằng mã giỏ
      Given guest A có 2 quyển S001 và guest B có giỏ riêng trống
      When guest B gửi thay số lượng trên mã giỏ A thành 1
      Then phản hồi từ chối không chứa dữ liệu giỏ A
      And giỏ A vẫn có 2 S001 và giỏ B vẫn trống

    @s1 @TC_CART_S1_VERSION @REQ-F04 @BR-003 @BR-024
    Scenario: Phiên bản giỏ cũ không ghi đè thay đổi đã lưu
      Given guest có giỏ S001 số lượng 2 ở phiên bản 1
      And một yêu cầu khác đã đổi S001 thành 3 ở phiên bản 2
      When guest gửi thay S001 thành 4 với phiên bản 1
      Then phản hồi xung đột yêu cầu tải lại giỏ
      And giỏ vẫn có 3 S001 ở phiên bản 2
