# UML và DFD — thiết kế website bán sách

**Mở nhanh:** [Thư viện sơ đồ](index.html) · [draw.io cá nhân](Nguyen_Duy_Truong_24150180_WebBanSach.drawio) · [Hợp đồng dữ liệu](../HOP_DONG_DU_LIEU.md).

File draw.io có **7 trang Class UML** với hình/chữ/connector native chỉnh sửa được, không nhúng ảnh thành một khối. PNG/SVG của class được render từ PlantUML; draw.io dùng cùng lớp/chữ ký/quan hệ và tọa độ render. Chưa mở thử bằng ứng dụng diagrams.net.

Có **37 sơ đồ**: 7 Class, 10 Activity, 14 Sequence, 3 State, 1 Component và 2 DFD. DFD là sơ đồ dữ liệu riêng, không được gọi là UML.

## Cách đọc

- Dependency: nét đứt/mũi tên thường về kiểu được dùng. Realization: nét đứt/tam giác rỗng về interface. Association: nét liền có hướng. Composition: thoi đặc ở lớp chứa.
- Sequence: nét liền là lời gọi, nét đứt là phản hồi; alt/opt/loop/par thể hiện nhánh/tùy chọn/lặp/đồng thời. Nhãn tiếng Việt là mô tả thao tác, không khẳng định đó là tên Java method.
- Activity: các bước và điều kiện; State: sự kiện [guard] / tác động. Mũi tên của chúng không biểu diễn import mã nguồn.
- D04 hiện hành: Response qua OutputBoundary application; Presenter implements. PricingService nội bộ trả QuoteResult cho interactor.
- QD-01/02 đã chốt; P-MERGE/P-STATE/P-PRICE-DETAIL và D01–03 còn chi tiết/phương án chờ duyệt. Tất cả class là thiết kế, chưa implementation.

## Danh mục

| Mã | Loại | Nội dung | Xem và sửa |
|---|---|---|---|
| AD01 | activity | Tìm kiếm và xem sách | [PNG](AD01.png) · [SVG](AD01.svg) · [PlantUML](AD01.puml) |
| AD02 | activity | Thêm sửa bỏ dòng giỏ | [PNG](AD02.png) · [SVG](AD02.svg) · [PlantUML](AD02.puml) |
| AD03 | activity | Tính giá các hình thức bán | [PNG](AD03.png) · [SVG](AD03.svg) · [PlantUML](AD03.puml) |
| AD04 | activity | Đặt COD và giữ hàng | [PNG](AD04.png) · [SVG](AD04.svg) · [PlantUML](AD04.puml) |
| AD05 | activity | Ghi nhận giao và thu COD | [PNG](AD05.png) · [SVG](AD05.svg) · [PlantUML](AD05.puml) |
| AD06 | activity | Hủy đơn trước bàn giao | [PNG](AD06.png) · [SVG](AD06.svg) · [PlantUML](AD06.puml) |
| AD07 | activity | Nhập và kiểm kê kho | [PNG](AD07.png) · [SVG](AD07.svg) · [PlantUML](AD07.puml) |
| AD08 | activity | Đăng nhập Facebook và phân quyền | [PNG](AD08.png) · [SVG](AD08.svg) · [PlantUML](AD08.puml) |
| AD08B | activity | Đăng ký gửi mail và xác minh email | [PNG](AD08B.png) · [SVG](AD08B.svg) · [PlantUML](AD08B.puml) |
| AD09 | activity | Quản trị dữ liệu và bảo toàn lịch sử | [PNG](AD09.png) · [SVG](AD09.svg) · [PlantUML](AD09.puml) |
| SQ01 | sequence | Truy vấn danh mục và quyền quản trị | [PNG](SQ01.png) · [SVG](SQ01.svg) · [PlantUML](SQ01.puml) |
| SQ02 | sequence | Đổi giỏ và tính lại giá | [PNG](SQ02.png) · [SVG](SQ02.svg) · [PlantUML](SQ02.puml) |
| SQ03 | sequence | Giá thường sỉ bộ kèm và mã | [PNG](SQ03.png) · [SVG](SQ03.svg) · [PlantUML](SQ03.puml) |
| SQ04 | sequence | Tạo đơn COD trong một cam kết | [PNG](SQ04.png) · [SVG](SQ04.svg) · [PlantUML](SQ04.puml) |
| SQ04B | sequence | Cạnh tranh quyển cuối và lượt mã | [PNG](SQ04B.png) · [SVG](SQ04B.svg) · [PlantUML](SQ04B.puml) |
| SQ05 | sequence | COD giao thành công và thu tiền | [PNG](SQ05.png) · [SVG](SQ05.svg) · [PlantUML](SQ05.puml) |
| SQ06 | sequence | Hủy và giải phóng một lần | [PNG](SQ06.png) · [SVG](SQ06.svg) · [PlantUML](SQ06.puml) |
| SQ06B | sequence | Xem trạng thái đơn đúng chủ | [PNG](SQ06B.png) · [SVG](SQ06B.svg) · [PlantUML](SQ06B.puml) |
| SQ07 | sequence | Nhập kiểm kê và xuất giao | [PNG](SQ07.png) · [SVG](SQ07.svg) · [PlantUML](SQ07.puml) |
| SQ08 | sequence | Tài khoản xác minh mail và tác vụ gửi | [PNG](SQ08.png) · [SVG](SQ08.svg) · [PlantUML](SQ08.puml) |
| SQ08B | sequence | Facebook không tin email trùng | [PNG](SQ08B.png) · [SVG](SQ08B.svg) · [PlantUML](SQ08B.puml) |
| SQ09 | sequence | Đọc ghi quản trị theo đúng module | [PNG](SQ09.png) · [SVG](SQ09.svg) · [PlantUML](SQ09.puml) |
| ST01 | state | Vòng đời đơn hàng | [PNG](ST01.png) · [SVG](ST01.svg) · [PlantUML](ST01.puml) |
| ST02 | state | Trạng thái thanh toán COD | [PNG](ST02.png) · [SVG](ST02.svg) · [PlantUML](ST02.puml) |
| ST03 | state | Giữ chỗ tồn kho của một đơn | [PNG](ST03.png) · [SVG](ST03.svg) · [PlantUML](ST03.puml) |
| CP01 | component | Ranh giới và phụ thuộc mã nguồn dự kiến | [PNG](CP01.png) · [SVG](CP01.svg) · [PlantUML](CP01.puml) |
| DFD01 | dfd | DFD ngữ cảnh website bán sách | [PNG](DFD01.png) · [SVG](DFD01.svg) · [PlantUML](DFD01.puml) |
| DFD02 | dfd | DFD dữ liệu đặt đơn và kho | [PNG](DFD02.png) · [SVG](DFD02.svg) · [PlantUML](DFD02.puml) |
| SQ02B | sequence | Gộp giỏ sau đăng nhập | [PNG](SQ02B.png) · [SVG](SQ02B.svg) · [PlantUML](SQ02B.puml) |
| SQ06C | sequence | Hủy và bàn giao đồng thời | [PNG](SQ06C.png) · [SVG](SQ06C.svg) · [PlantUML](SQ06C.puml) |
| CL01 | class | Lát cắt sửa giỏ — Request và Output Boundary | [PNG](CL01.png) · [SVG](CL01.svg) · [PlantUML](CL01.puml) |
| CL02 | class | Danh mục và giỏ — đối tượng có trách nhiệm | [PNG](CL02.png) · [SVG](CL02.svg) · [PlantUML](CL02.puml) |
| CL03 | class | Tính giá thường, sỉ, combo, mua kèm và mã | [PNG](CL03.png) · [SVG](CL03.svg) · [PlantUML](CL03.puml) |
| CL04 | class | Đặt COD — hợp đồng của một cam kết | [PNG](CL04.png) · [SVG](CL04.svg) · [PlantUML](CL04.puml) |
| CL05 | class | Đơn, giữ chỗ và COD — invariant tách biệt | [PNG](CL05.png) · [SVG](CL05.svg) · [PlantUML](CL05.puml) |
| CL06 | class | Xác thực — dịch vụ thật nằm ngoài core | [PNG](CL06.png) · [SVG](CL06.svg) · [PlantUML](CL06.puml) |
| CL07 | class | Tài khoản và hợp đồng lưu xác minh | [PNG](CL07.png) · [SVG](CL07.svg) · [PlantUML](CL07.puml) |

## AD01 — Tìm kiếm và xem sách

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F01, REQ-F02, REQ-F08, REQ-F09, REQ-F10, REQ-F22, REQ-F23; **Rule:** REQ_ADMIN_001, REQ_CATALOG_001, REQ_CATALOG_002, REQ_CATALOG_005, REQ_CATALOG_007
**BR:** BR-001, BR-002, BR-025, BR-028, BR-031
**Scenario liên quan:** TC_CATALOG_NEW001, TC_CATALOG_NEW002, TC_CATALOG_NEW003, TC_CATALOG_NEW004, TC_CATALOG_SC001, TC_CATALOG_SC005, TC_CATALOG_SC006, TC_CATALOG_SC007, TC_ADMIN_SC051, TC_CATALOG_SC002, TC_CATALOG_SC003, TC_CATALOG_SC004, TC_CATALOG_REV005

[Xem SVG](AD01.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## AD02 — Thêm sửa bỏ dòng giỏ

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F03, REQ-F04, REQ-F07, REQ-F10, REQ-F16, REQ-F17, REQ-F20, REQ-F21, REQ-F22; **Rule:** REQ_CART_001, REQ_CART_002, REQ_CART_003, REQ_CART_004, REQ_CART_005, REQ_CHECKOUT_001, REQ_INV_004, REQ_PRICE_006
**BR:** BR-003, BR-004, BR-008, BR-012, BR-013, BR-014, BR-016, BR-018, BR-019, BR-022, BR-025, BR-026, BR-028, BR-029
**Scenario liên quan:** TC_CART_SC008, TC_CART_SC009, TC_CART_SC014, TC_CART_SC016, TC_CART_SC018, TC_CART_GH01, TC_CART_GH02, TC_CART_GH03, TC_CART_NEW008, TC_CART_SC010, TC_CART_SC011, TC_CART_SC012, TC_CART_SC013, TC_CART_SC015, TC_CART_SC017, TC_CART_SC019, TC_PRICE_BH18, TC_PRICE_BH19, TC_PRICE_BH20, TC_PRICE_BH21, TC_PRICE_BH22, TC_CHECKOUT_SC032, TC_INV_REV001

[Xem SVG](AD02.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## AD03 — Tính giá các hình thức bán

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F11, REQ-F12, REQ-F13, REQ-F14, REQ-F15, REQ-F16; **Rule:** REQ_PRICE_001, REQ_PRICE_002, REQ_PRICE_003, REQ_PRICE_004, REQ_PRICE_005, REQ_PRICE_006, REQ_PRICE_008, REQ_PRICE_009
**BR:** BR-004, BR-005, BR-006, BR-007, BR-008, BR-009, BR-010, BR-011, BR-012, BR-013, BR-014, BR-023
**Scenario liên quan:** TC_PRICE_BH01, TC_PRICE_BH02, TC_PRICE_BH03, TC_PRICE_BH05, TC_PRICE_BH06, TC_PRICE_BH07, TC_PRICE_BH08, TC_PRICE_BH09, TC_PRICE_BH12, TC_PRICE_BH13, TC_PRICE_BH15, TC_PRICE_BH18, TC_PRICE_BH20, TC_PRICE_BH10, TC_PRICE_BH14, TC_PRICE_BH19, TC_PRICE_BH21, TC_PRICE_BH22, TC_PRICE_REV003, TC_PRICE_REV011

[Xem SVG](AD03.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## AD04 — Đặt COD và giữ hàng

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F07, REQ-F10, REQ-F13, REQ-F15, REQ-F17, REQ-F18, REQ-F19, REQ-F20, REQ-F21, REQ-F22; **Rule:** REQ_AUTH_008, REQ_CHECKOUT_001, REQ_CHECKOUT_002, REQ_CHECKOUT_003, REQ_CHECKOUT_004, REQ_INV_002, REQ_ORDER_003, REQ_PRICE_003, REQ_PRICE_005
**BR:** BR-006, BR-007, BR-008, BR-009, BR-011, BR-013, BR-014, BR-015, BR-018, BR-019, BR-022, BR-023, BR-024, BR-025, BR-026, BR-027, BR-029
**Scenario liên quan:** TC_CHECKOUT_SC034, TC_CHECKOUT_SC037, TC_CHECKOUT_SC039, TC_INV_SC046, TC_ORDER_DH03, TC_ORDER_DH04, TC_ORDER_DH05, TC_CHECKOUT_NEW005, TC_CHECKOUT_NEW006, TC_CHECKOUT_NEW007, TC_CHECKOUT_NEW016, TC_PRICE_BH11, TC_PRICE_BH15, TC_PRICE_BH16, TC_PRICE_BH17, TC_CHECKOUT_SC035, TC_CHECKOUT_SC036, TC_CHECKOUT_SC038, TC_CHECKOUT_SC033, TC_AUTH_REV004, TC_CHECKOUT_REV014

[Xem SVG](AD04.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## AD05 — Ghi nhận giao và thu COD

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F09, REQ-F17, REQ-F21; **Rule:** REQ_ORDER_002, REQ_PAY_001, REQ_PAY_002
**BR:** BR-009, BR-014, BR-015, BR-019, BR-020, BR-021, BR-024, BR-028
**Scenario liên quan:** TC_PAY_TT01, TC_PAY_TT02, TC_PAY_TT03, TC_PAY_TT04, TC_PAY_TT05, TC_PAY_TT06, TC_PAY_TT07, TC_PAY_NEW012, TC_ORDER_SC070, TC_ORDER_SC072

[Xem SVG](AD05.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## AD06 — Hủy đơn trước bàn giao

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F09, REQ-F10, REQ-F17, REQ-F21, REQ-F22; **Rule:** REQ_INV_002, REQ_ORDER_002, REQ_ORDER_003, REQ_ORDER_004, REQ_ORDER_005
**BR:** BR-009, BR-013, BR-014, BR-015, BR-019, BR-022, BR-023, BR-024, BR-025, BR-028
**Scenario liên quan:** TC_ORDER_SC073, TC_INV_KHO08, TC_ORDER_DH01, TC_ORDER_DH02, TC_ORDER_DH06, TC_ORDER_NEW017, TC_ORDER_REV002

[Xem SVG](AD06.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## AD07 — Nhập và kiểm kê kho

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F09, REQ-F10, REQ-F21; **Rule:** REQ_CATALOG_003, REQ_INV_001, REQ_INV_002, REQ_INV_003, REQ_INV_005
**BR:** BR-001, BR-002, BR-004, BR-013, BR-014, BR-015, BR-019, BR-022, BR-023, BR-024, BR-028
**Scenario liên quan:** TC_INV_KHO02, TC_INV_KHO03, TC_INV_KHO04, TC_INV_KHO05, TC_INV_KHO09, TC_CATALOG_SC057, TC_INV_NEW011, TC_INV_KHO06, TC_INV_KHO07, TC_INV_REV010, TC_INV_REV013

[Xem SVG](AD07.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## AD08 — Đăng nhập Facebook và phân quyền

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F05, REQ-F06, REQ-F07, REQ-F18, REQ-F19, REQ-F22; **Rule:** REQ_AUTH_002, REQ_AUTH_003, REQ_AUTH_005, REQ_AUTH_006, REQ_ORDER_001
**BR:** BR-016, BR-017, BR-022, BR-025, BR-026, BR-027, BR-028, BR-029, BR-030
**Scenario liên quan:** TC_AUTH_SC027, TC_AUTH_SC029, TC_AUTH_SC030, TC_ORDER_SC049, TC_AUTH_XT05, TC_AUTH_XT06, TC_AUTH_XT07, TC_ORDER_SC047, TC_ORDER_SC048, TC_ORDER_SC050, TC_AUTH_SC028, TC_AUTH_SC031, TC_AUTH_SC024, TC_AUTH_SC025, TC_AUTH_SC026

[Xem SVG](AD08.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## AD08B — Đăng ký gửi mail và xác minh email

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F05, REQ-F18, REQ-F19; **Rule:** REQ_AUTH_001, REQ_AUTH_005, REQ_AUTH_007
**BR:** BR-026, BR-028, BR-029, BR-030
**Scenario liên quan:** TC_AUTH_SC020, TC_AUTH_SC021, TC_AUTH_XT01, TC_AUTH_XT02, TC_AUTH_XT03, TC_AUTH_XT04, TC_AUTH_NEW009, TC_AUTH_NEW010, TC_AUTH_SC022, TC_AUTH_SC023

[Xem SVG](AD08B.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## AD09 — Quản trị dữ liệu và bảo toàn lịch sử

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F08, REQ-F09, REQ-F10, REQ-F12, REQ-F15, REQ-F16, REQ-F17, REQ-F21, REQ-F22; **Rule:** REQ_ADMIN_001, REQ_AUTH_004, REQ_CATALOG_003, REQ_CATALOG_004, REQ_CATALOG_006, REQ_INV_001, REQ_ORDER_002, REQ_ORDER_003, REQ_PRICE_002, REQ_PRICE_007
**BR:** BR-001, BR-002, BR-004, BR-005, BR-009, BR-011, BR-012, BR-013, BR-014, BR-015, BR-019, BR-022, BR-023, BR-024, BR-025, BR-026, BR-028
**Scenario liên quan:** TC_ADMIN_SC051, TC_ADMIN_SC053, TC_CATALOG_SC054, TC_CATALOG_SC055, TC_CATALOG_SC056, TC_CATALOG_SC058, TC_CATALOG_SC059, TC_CATALOG_SC060, TC_CATALOG_SC061, TC_CATALOG_SC062, TC_CATALOG_SC063, TC_AUTH_SC064, TC_AUTH_SC065, TC_AUTH_SC066, TC_AUTH_SC067, TC_AUTH_SC068, TC_ORDER_SC069, TC_INV_KHO01, TC_PRICE_BH04, TC_PRICE_NEW013, TC_PRICE_NEW014, TC_CATALOG_NEW015, TC_ADMIN_SC052, TC_ORDER_DH07

[Xem SVG](AD09.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ01 — Truy vấn danh mục và quyền quản trị

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F01, REQ-F02, REQ-F08, REQ-F09, REQ-F10, REQ-F22, REQ-F23; **Rule:** REQ_ADMIN_001, REQ_CATALOG_001, REQ_CATALOG_002, REQ_CATALOG_005, REQ_CATALOG_007
**BR:** BR-001, BR-002, BR-025, BR-028, BR-031
**Scenario liên quan:** TC_CATALOG_NEW002, TC_CATALOG_NEW004, TC_CATALOG_SC005, TC_CATALOG_SC006, TC_CATALOG_SC007, TC_ADMIN_SC053, TC_CATALOG_NEW001, TC_CATALOG_NEW003, TC_CATALOG_SC001, TC_CATALOG_SC002, TC_CATALOG_SC003, TC_CATALOG_SC004, TC_CATALOG_REV005

[Xem SVG](SQ01.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ02 — Đổi giỏ và tính lại giá

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F03, REQ-F04, REQ-F06, REQ-F07, REQ-F10, REQ-F16, REQ-F17, REQ-F18, REQ-F19, REQ-F20, REQ-F21, REQ-F22; **Rule:** REQ_AUTH_003, REQ_AUTH_005, REQ_CART_001, REQ_CART_002, REQ_CART_003, REQ_CART_004, REQ_CART_005, REQ_CHECKOUT_001, REQ_INV_004
**BR:** BR-003, BR-004, BR-008, BR-012, BR-013, BR-014, BR-016, BR-017, BR-018, BR-019, BR-022, BR-025, BR-026, BR-028, BR-029, BR-030
**Scenario liên quan:** TC_CART_SC008, TC_CART_SC016, TC_CART_SC018, TC_CART_GH01, TC_CART_GH02, TC_CART_GH03, TC_CART_NEW008, TC_CART_SC009, TC_CART_SC010, TC_CART_SC011, TC_CART_SC012, TC_CART_SC013, TC_CART_SC014, TC_CART_SC015, TC_CART_SC017, TC_CART_SC019, TC_AUTH_SC027, TC_AUTH_SC028, TC_AUTH_SC029, TC_AUTH_SC030, TC_AUTH_SC031, TC_AUTH_XT05, TC_CHECKOUT_SC032, TC_INV_REV001

[Xem SVG](SQ02.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ03 — Giá thường sỉ bộ kèm và mã

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F04, REQ-F07, REQ-F11, REQ-F12, REQ-F13, REQ-F14, REQ-F15, REQ-F16, REQ-F17, REQ-F20, REQ-F21; **Rule:** REQ_CART_004, REQ_CHECKOUT_001, REQ_CHECKOUT_002, REQ_PRICE_001, REQ_PRICE_002, REQ_PRICE_003, REQ_PRICE_004, REQ_PRICE_005, REQ_PRICE_006, REQ_PRICE_008, REQ_PRICE_009
**BR:** BR-003, BR-004, BR-005, BR-006, BR-007, BR-008, BR-009, BR-010, BR-011, BR-012, BR-013, BR-014, BR-018, BR-019, BR-022, BR-023, BR-024, BR-026, BR-029
**Scenario liên quan:** TC_PRICE_BH01, TC_PRICE_BH02, TC_PRICE_BH05, TC_PRICE_BH06, TC_PRICE_BH08, TC_PRICE_BH09, TC_PRICE_BH12, TC_PRICE_BH13, TC_PRICE_BH15, TC_PRICE_BH17, TC_PRICE_BH18, TC_PRICE_BH20, TC_CHECKOUT_NEW005, TC_CART_GH01, TC_CART_GH02, TC_CART_GH03, TC_PRICE_BH03, TC_PRICE_BH07, TC_PRICE_BH10, TC_PRICE_BH14, TC_PRICE_BH11, TC_CHECKOUT_SC039, TC_PRICE_BH19, TC_PRICE_BH21, TC_PRICE_BH22, TC_PRICE_REV003, TC_PRICE_REV011

[Xem SVG](SQ03.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ04 — Tạo đơn COD trong một cam kết

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F07, REQ-F13, REQ-F15, REQ-F16, REQ-F17, REQ-F18, REQ-F19, REQ-F20, REQ-F21, REQ-F22; **Rule:** REQ_AUTH_008, REQ_CHECKOUT_001, REQ_CHECKOUT_002, REQ_CHECKOUT_003, REQ_CHECKOUT_004, REQ_ORDER_003, REQ_PRICE_003, REQ_PRICE_005, REQ_PRICE_006
**BR:** BR-006, BR-007, BR-008, BR-009, BR-011, BR-012, BR-013, BR-014, BR-015, BR-018, BR-019, BR-022, BR-023, BR-024, BR-025, BR-026, BR-027, BR-029
**Scenario liên quan:** TC_CHECKOUT_SC034, TC_CHECKOUT_SC037, TC_CHECKOUT_SC039, TC_ORDER_DH03, TC_ORDER_DH04, TC_ORDER_DH05, TC_CHECKOUT_NEW005, TC_CHECKOUT_NEW006, TC_CHECKOUT_NEW007, TC_CHECKOUT_NEW016, TC_PRICE_BH15, TC_PRICE_BH17, TC_PRICE_BH22, TC_PRICE_BH11, TC_PRICE_BH16, TC_PRICE_BH18, TC_PRICE_BH19, TC_PRICE_BH20, TC_PRICE_BH21, TC_CHECKOUT_SC035, TC_CHECKOUT_SC036, TC_CHECKOUT_SC038, TC_CHECKOUT_SC033, TC_AUTH_REV004, TC_CHECKOUT_REV014

[Xem SVG](SQ04.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ04B — Cạnh tranh quyển cuối và lượt mã

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F10, REQ-F20, REQ-F21, REQ-F22; **Rule:** REQ_CHECKOUT_002, REQ_INV_002, REQ_ORDER_003
**BR:** BR-009, BR-013, BR-014, BR-015, BR-018, BR-022, BR-023, BR-024, BR-025
**Scenario liên quan:** TC_INV_SC046, TC_ORDER_DH05, TC_CHECKOUT_NEW006

[Xem SVG](SQ04B.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ05 — COD giao thành công và thu tiền

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F09, REQ-F17, REQ-F21; **Rule:** REQ_ORDER_002, REQ_PAY_001, REQ_PAY_002
**BR:** BR-009, BR-014, BR-015, BR-019, BR-020, BR-021, BR-024, BR-028
**Scenario liên quan:** TC_PAY_TT01, TC_PAY_TT02, TC_PAY_TT03, TC_PAY_TT04, TC_PAY_TT05, TC_PAY_TT06, TC_PAY_TT07, TC_PAY_NEW012, TC_ORDER_SC070, TC_ORDER_SC072

[Xem SVG](SQ05.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ06 — Hủy và giải phóng một lần

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F09, REQ-F10, REQ-F17, REQ-F21, REQ-F22; **Rule:** REQ_INV_002, REQ_ORDER_002, REQ_ORDER_003, REQ_ORDER_004, REQ_ORDER_005
**BR:** BR-009, BR-013, BR-014, BR-015, BR-019, BR-022, BR-023, BR-024, BR-025, BR-028
**Scenario liên quan:** TC_ORDER_SC073, TC_INV_KHO08, TC_ORDER_DH01, TC_ORDER_DH02, TC_ORDER_DH06, TC_ORDER_NEW017, TC_ORDER_REV002

[Xem SVG](SQ06.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ06B — Xem trạng thái đơn đúng chủ

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F07, REQ-F21, REQ-F22; **Rule:** REQ_ORDER_001, REQ_ORDER_003
**BR:** BR-009, BR-015, BR-022, BR-023, BR-024, BR-025, BR-028
**Scenario liên quan:** TC_ORDER_SC047, TC_ORDER_SC048, TC_ORDER_SC049, TC_ORDER_SC050, TC_ORDER_DH07

[Xem SVG](SQ06B.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ07 — Nhập kiểm kê và xuất giao

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F09, REQ-F10, REQ-F21; **Rule:** REQ_CATALOG_003, REQ_INV_001, REQ_INV_002, REQ_INV_003, REQ_INV_005
**BR:** BR-001, BR-002, BR-004, BR-013, BR-014, BR-015, BR-019, BR-022, BR-023, BR-024, BR-028
**Scenario liên quan:** TC_INV_KHO02, TC_INV_KHO03, TC_INV_KHO04, TC_INV_KHO05, TC_INV_KHO06, TC_INV_KHO07, TC_INV_KHO09, TC_INV_NEW011, TC_CATALOG_SC057, TC_INV_REV010, TC_INV_REV013

[Xem SVG](SQ07.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ08 — Tài khoản xác minh mail và tác vụ gửi

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F05, REQ-F06, REQ-F18, REQ-F19; **Rule:** REQ_AUTH_001, REQ_AUTH_003, REQ_AUTH_005, REQ_AUTH_007, REQ_AUTH_009
**BR:** BR-016, BR-017, BR-026, BR-028, BR-029, BR-030
**Scenario liên quan:** TC_AUTH_SC020, TC_AUTH_SC021, TC_AUTH_SC027, TC_AUTH_SC030, TC_AUTH_XT01, TC_AUTH_XT02, TC_AUTH_XT03, TC_AUTH_XT04, TC_AUTH_XT05, TC_AUTH_NEW009, TC_AUTH_NEW010, TC_AUTH_SC022, TC_AUTH_SC023, TC_AUTH_SC028, TC_AUTH_SC029, TC_AUTH_SC031, TC_AUTH_REV012

[Xem SVG](SQ08.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ08B — Facebook không tin email trùng

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F05, REQ-F07, REQ-F18, REQ-F19, REQ-F22; **Rule:** REQ_AUTH_002, REQ_AUTH_006, REQ_AUTH_008, REQ_CART_005, REQ_ORDER_001
**BR:** BR-016, BR-022, BR-025, BR-026, BR-027, BR-028, BR-029
**Scenario liên quan:** TC_AUTH_SC024, TC_AUTH_SC025, TC_AUTH_SC026, TC_AUTH_XT06, TC_AUTH_XT07, TC_ORDER_SC049, TC_CART_NEW008, TC_AUTH_REV004

[Xem SVG](SQ08B.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ09 — Đọc ghi quản trị theo đúng module

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F08, REQ-F09, REQ-F10, REQ-F12, REQ-F15, REQ-F16, REQ-F17, REQ-F21, REQ-F22; **Rule:** REQ_ADMIN_001, REQ_AUTH_004, REQ_CATALOG_003, REQ_CATALOG_004, REQ_CATALOG_006, REQ_INV_001, REQ_ORDER_002, REQ_ORDER_003, REQ_PRICE_002, REQ_PRICE_007
**BR:** BR-001, BR-002, BR-004, BR-005, BR-009, BR-011, BR-012, BR-013, BR-014, BR-015, BR-019, BR-022, BR-023, BR-024, BR-025, BR-026, BR-028
**Scenario liên quan:** TC_ADMIN_SC051, TC_CATALOG_SC054, TC_CATALOG_SC056, TC_CATALOG_SC058, TC_CATALOG_SC059, TC_CATALOG_SC060, TC_CATALOG_SC063, TC_AUTH_SC064, TC_AUTH_SC065, TC_AUTH_SC066, TC_AUTH_SC067, TC_AUTH_SC068, TC_ORDER_SC069, TC_INV_KHO01, TC_PRICE_BH04, TC_PRICE_NEW013, TC_PRICE_NEW014, TC_CATALOG_NEW015, TC_ADMIN_SC052, TC_ADMIN_SC053, TC_CATALOG_SC055, TC_CATALOG_SC061, TC_CATALOG_SC062, TC_ORDER_DH07

[Xem SVG](SQ09.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## ST01 — Vòng đời đơn hàng

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F07, REQ-F09, REQ-F10, REQ-F17, REQ-F20, REQ-F21, REQ-F22; **Rule:** REQ_CHECKOUT_001, REQ_INV_002, REQ_INV_005, REQ_ORDER_002, REQ_ORDER_003, REQ_PAY_001
**BR:** BR-009, BR-013, BR-014, BR-015, BR-018, BR-019, BR-020, BR-021, BR-022, BR-023, BR-024, BR-025, BR-026, BR-028, BR-029
**Scenario liên quan:** TC_CHECKOUT_SC034, TC_ORDER_SC070, TC_ORDER_SC072, TC_ORDER_SC073, TC_INV_KHO06, TC_INV_KHO08, TC_ORDER_DH01, TC_PAY_TT01, TC_PAY_TT03, TC_PAY_TT06, TC_CHECKOUT_SC035, TC_CHECKOUT_SC036, TC_CHECKOUT_SC037, TC_CHECKOUT_SC038, TC_ORDER_DH02, TC_ORDER_DH06, TC_INV_REV009

[Xem SVG](ST01.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## ST02 — Trạng thái thanh toán COD

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F07, REQ-F17, REQ-F20, REQ-F21; **Rule:** REQ_CHECKOUT_001, REQ_PAY_001, REQ_PAY_002
**BR:** BR-009, BR-013, BR-014, BR-018, BR-019, BR-020, BR-021, BR-022, BR-024, BR-026, BR-028, BR-029
**Scenario liên quan:** TC_CHECKOUT_SC034, TC_PAY_TT01, TC_PAY_TT02, TC_PAY_TT03, TC_PAY_TT04, TC_PAY_TT05, TC_PAY_TT06, TC_PAY_TT07, TC_PAY_NEW012, TC_CHECKOUT_SC035, TC_CHECKOUT_SC036, TC_CHECKOUT_SC037, TC_CHECKOUT_SC038

[Xem SVG](ST02.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## ST03 — Giữ chỗ tồn kho của một đơn

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F07, REQ-F09, REQ-F10, REQ-F15, REQ-F17, REQ-F20, REQ-F21, REQ-F22; **Rule:** REQ_CATALOG_003, REQ_CHECKOUT_001, REQ_CHECKOUT_002, REQ_INV_001, REQ_INV_002, REQ_INV_003, REQ_INV_005, REQ_ORDER_002, REQ_ORDER_003, REQ_ORDER_005, REQ_PRICE_005
**BR:** BR-001, BR-002, BR-004, BR-009, BR-011, BR-013, BR-014, BR-015, BR-018, BR-019, BR-022, BR-023, BR-024, BR-025, BR-026, BR-028, BR-029
**Scenario liên quan:** TC_CHECKOUT_SC034, TC_INV_SC046, TC_INV_KHO06, TC_INV_KHO07, TC_ORDER_SC073, TC_ORDER_DH06, TC_CHECKOUT_NEW006, TC_PRICE_BH15, TC_PRICE_BH16, TC_PRICE_BH17, TC_CHECKOUT_SC035, TC_CHECKOUT_SC036, TC_CHECKOUT_SC037, TC_CHECKOUT_SC038, TC_ORDER_DH05, TC_ORDER_DH01, TC_ORDER_DH02, TC_INV_KHO08, TC_INV_KHO02, TC_INV_KHO03, TC_INV_KHO04, TC_INV_KHO05, TC_INV_KHO09, TC_CATALOG_SC057, TC_INV_NEW011, TC_ORDER_REV002, TC_INV_REV009

[Xem SVG](ST03.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## CP01 — Ranh giới và phụ thuộc mã nguồn dự kiến

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F07, REQ-F17, REQ-F19, REQ-F20, REQ-F21, REQ-F22; **Rule:** REQ_AUTH_007, REQ_CHECKOUT_002, REQ_ORDER_001, REQ_PAY_001
**BR:** BR-009, BR-018, BR-019, BR-020, BR-021, BR-022, BR-023, BR-024, BR-025, BR-026, BR-028, BR-030
**Scenario liên quan:** TC_CHECKOUT_NEW005, TC_CHECKOUT_NEW006, TC_AUTH_NEW009, TC_ORDER_SC049, TC_PAY_TT01

[Xem SVG](CP01.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## DFD01 — DFD ngữ cảnh website bán sách

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F07, REQ-F17, REQ-F18, REQ-F19, REQ-F20, REQ-F21, REQ-F22, REQ-F23; **Rule:** REQ_AUTH_005, REQ_AUTH_006, REQ_CATALOG_005, REQ_CHECKOUT_001, REQ_ORDER_001, REQ_PAY_001
**BR:** BR-009, BR-013, BR-014, BR-018, BR-019, BR-020, BR-021, BR-022, BR-024, BR-025, BR-026, BR-027, BR-028, BR-029, BR-030, BR-031
**Scenario liên quan:** TC_CATALOG_NEW002, TC_CHECKOUT_SC034, TC_ORDER_SC049, TC_AUTH_XT02, TC_AUTH_XT06, TC_PAY_TT01

[Xem SVG](DFD01.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## DFD02 — DFD dữ liệu đặt đơn và kho

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F07, REQ-F15, REQ-F16, REQ-F17, REQ-F20, REQ-F21, REQ-F22; **Rule:** REQ_CHECKOUT_001, REQ_CHECKOUT_002, REQ_ORDER_003, REQ_PRICE_005, REQ_PRICE_006
**BR:** BR-009, BR-011, BR-012, BR-013, BR-014, BR-015, BR-018, BR-019, BR-022, BR-023, BR-024, BR-025, BR-026, BR-029
**Scenario liên quan:** TC_CHECKOUT_SC034, TC_CHECKOUT_SC037, TC_ORDER_DH03, TC_ORDER_DH05, TC_CHECKOUT_NEW005, TC_CHECKOUT_NEW006, TC_PRICE_BH15, TC_PRICE_BH17, TC_PRICE_BH18

[Xem SVG](DFD02.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ02B — Gộp giỏ sau đăng nhập

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F04, REQ-F06, REQ-F21; **Rule:** REQ_CART_006
**BR:** BR-003, BR-016, BR-017, BR-018, BR-024
**Scenario liên quan:** TC_CART_REV006, TC_CART_REV007, TC_CART_REV008

[Xem SVG](SQ02B.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## SQ06C — Hủy và bàn giao đồng thời

Thiết kế chưa triển khai. QD-01/02 đã chốt; xem trạng thái chi tiết từng BR/scenario.

**REQ G0:** REQ-F10, REQ-F17, REQ-F21; **Rule:** REQ_INV_005
**BR:** BR-013, BR-014, BR-015, BR-019, BR-023, BR-024
**Scenario liên quan:** TC_INV_REV009

[Xem SVG](SQ06C.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## CL01 — Lát cắt sửa giỏ — Request và Output Boundary

REQ-F03/F04/F22; BR-003/016/018; TC_CART_SC008/016/NEW008; class UML là cấu trúc, đối chiếu nhánh ở Activity/Sequence.

**REQ G0:** REQ-F03, REQ-F04, REQ-F06, REQ-F16, REQ-F21, REQ-F22; **Rule:** REQ_CART_001, REQ_CART_002, REQ_CART_003, REQ_CART_004, REQ_CART_005, REQ_CART_006
**BR:** BR-003, BR-004, BR-008, BR-012, BR-013, BR-016, BR-017, BR-018, BR-024, BR-025, BR-028
**Scenario liên quan:** TC_CART_SC008, TC_CART_SC009, TC_CART_SC010, TC_CART_SC011, TC_CART_SC012, TC_CART_SC013, TC_CART_SC014, TC_CART_SC015, TC_CART_SC016, TC_CART_SC017, TC_CART_SC018, TC_CART_SC019, TC_CART_GH01, TC_CART_GH02, TC_CART_GH03, TC_CART_NEW008, TC_CART_REV006, TC_CART_REV007, TC_CART_REV008

[Xem SVG](CL01.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## CL02 — Danh mục và giỏ — đối tượng có trách nhiệm

P-EDITION/P-MERGE và cardinality còn là đề xuất; QD-01 không giữ hàng tại giỏ; class UML là cấu trúc, đối chiếu nhánh ở Activity/Sequence.

**REQ G0:** REQ-F01, REQ-F02, REQ-F03, REQ-F04, REQ-F06, REQ-F09, REQ-F10, REQ-F16, REQ-F21, REQ-F22, REQ-F23; **Rule:** REQ_CART_001, REQ_CART_002, REQ_CART_003, REQ_CART_004, REQ_CART_005, REQ_CART_006, REQ_CATALOG_001, REQ_CATALOG_002, REQ_CATALOG_003, REQ_CATALOG_004, REQ_CATALOG_005, REQ_CATALOG_006, REQ_CATALOG_007
**BR:** BR-001, BR-002, BR-003, BR-004, BR-008, BR-012, BR-013, BR-016, BR-017, BR-018, BR-022, BR-024, BR-025, BR-028, BR-031
**Scenario liên quan:** TC_CATALOG_SC001, TC_CATALOG_SC002, TC_CATALOG_SC003, TC_CATALOG_SC004, TC_CATALOG_SC005, TC_CATALOG_SC006, TC_CATALOG_SC007, TC_CART_SC008, TC_CART_SC009, TC_CART_SC010, TC_CART_SC011, TC_CART_SC012, TC_CART_SC013, TC_CART_SC014, TC_CART_SC015, TC_CART_SC016, TC_CART_SC017, TC_CART_SC018, TC_CART_SC019, TC_CATALOG_SC054, TC_CATALOG_SC055, TC_CATALOG_SC056, TC_CATALOG_SC057, TC_CATALOG_SC058, TC_CATALOG_SC059, TC_CATALOG_SC060, TC_CATALOG_SC061, TC_CATALOG_SC062, TC_CATALOG_SC063, TC_CART_GH01, TC_CART_GH02, TC_CART_GH03, TC_CATALOG_NEW001, TC_CATALOG_NEW002, TC_CATALOG_NEW003, TC_CATALOG_NEW004, TC_CART_NEW008, TC_CATALOG_NEW015, TC_CATALOG_REV005, TC_CART_REV006, TC_CART_REV007, TC_CART_REV008

[Xem SVG](CL02.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## CL03 — Tính giá thường, sỉ, combo, mua kèm và mã

QD-02 đã chốt; chọn giá thấp nhất, rounding, quota: đề xuất chưa duyệt; class UML là cấu trúc, đối chiếu nhánh ở Activity/Sequence.

**REQ G0:** REQ-F11, REQ-F12, REQ-F13, REQ-F14, REQ-F15, REQ-F16; **Rule:** REQ_PRICE_001, REQ_PRICE_002, REQ_PRICE_003, REQ_PRICE_004, REQ_PRICE_005, REQ_PRICE_006, REQ_PRICE_007, REQ_PRICE_008, REQ_PRICE_009
**BR:** BR-004, BR-005, BR-006, BR-007, BR-008, BR-009, BR-010, BR-011, BR-012, BR-013, BR-014, BR-023, BR-028
**Scenario liên quan:** TC_PRICE_BH01, TC_PRICE_BH02, TC_PRICE_BH03, TC_PRICE_BH04, TC_PRICE_BH05, TC_PRICE_BH06, TC_PRICE_BH07, TC_PRICE_BH08, TC_PRICE_BH09, TC_PRICE_BH10, TC_PRICE_BH11, TC_PRICE_BH12, TC_PRICE_BH13, TC_PRICE_BH14, TC_PRICE_BH15, TC_PRICE_BH16, TC_PRICE_BH17, TC_PRICE_BH18, TC_PRICE_BH19, TC_PRICE_BH20, TC_PRICE_BH21, TC_PRICE_BH22, TC_PRICE_NEW013, TC_PRICE_NEW014, TC_PRICE_REV003, TC_PRICE_REV011

[Xem SVG](CL03.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## CL04 — Đặt COD — hợp đồng của một cam kết

D01 transaction + D03 locking là thiết kế đề xuất; chưa có bằng chứng PostgreSQL; class UML là cấu trúc, đối chiếu nhánh ở Activity/Sequence.

**REQ G0:** REQ-F07, REQ-F17, REQ-F20, REQ-F21; **Rule:** REQ_CHECKOUT_001, REQ_CHECKOUT_002, REQ_CHECKOUT_003, REQ_CHECKOUT_004
**BR:** BR-013, BR-014, BR-018, BR-019, BR-022, BR-023, BR-024, BR-026, BR-029
**Scenario liên quan:** TC_CHECKOUT_SC032, TC_CHECKOUT_SC033, TC_CHECKOUT_SC034, TC_CHECKOUT_SC035, TC_CHECKOUT_SC036, TC_CHECKOUT_SC037, TC_CHECKOUT_SC038, TC_CHECKOUT_SC039, TC_CHECKOUT_NEW005, TC_CHECKOUT_NEW006, TC_CHECKOUT_NEW007, TC_CHECKOUT_NEW016, TC_CHECKOUT_REV014

[Xem SVG](CL04.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## CL05 — Đơn, giữ chỗ và COD — invariant tách biệt

QD-01 đã chốt; P-STATE, quyền ghi COD và lifecycle quota vẫn cần duyệt; class UML là cấu trúc, đối chiếu nhánh ở Activity/Sequence.

**REQ G0:** REQ-F07, REQ-F09, REQ-F10, REQ-F17, REQ-F21, REQ-F22; **Rule:** REQ_INV_001, REQ_INV_002, REQ_INV_003, REQ_INV_004, REQ_INV_005, REQ_ORDER_001, REQ_ORDER_002, REQ_ORDER_003, REQ_ORDER_004, REQ_ORDER_005, REQ_PAY_001, REQ_PAY_002
**BR:** BR-009, BR-013, BR-014, BR-015, BR-019, BR-020, BR-021, BR-022, BR-023, BR-024, BR-025, BR-028
**Scenario liên quan:** TC_ORDER_SC047, TC_ORDER_SC048, TC_ORDER_SC049, TC_ORDER_SC050, TC_ORDER_SC069, TC_ORDER_SC070, TC_ORDER_SC072, TC_ORDER_SC073, TC_INV_KHO01, TC_INV_KHO02, TC_INV_KHO03, TC_INV_KHO09, TC_INV_KHO04, TC_INV_KHO05, TC_INV_KHO06, TC_INV_KHO07, TC_INV_SC046, TC_INV_KHO08, TC_ORDER_DH01, TC_ORDER_DH02, TC_ORDER_DH03, TC_ORDER_DH04, TC_ORDER_DH05, TC_ORDER_DH06, TC_ORDER_DH07, TC_PAY_TT01, TC_PAY_TT02, TC_PAY_TT03, TC_PAY_TT04, TC_PAY_TT05, TC_PAY_TT06, TC_PAY_TT07, TC_INV_NEW011, TC_PAY_NEW012, TC_ORDER_NEW017, TC_INV_REV001, TC_ORDER_REV002, TC_INV_REV009, TC_INV_REV010, TC_INV_REV013

[Xem SVG](CL05.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## CL06 — Xác thực — dịch vụ thật nằm ngoài core

REQ-F18/F19; email + Facebook thật; policy linking và TTL còn mở; class UML là cấu trúc, đối chiếu nhánh ở Activity/Sequence.

**REQ G0:** REQ-F05, REQ-F06, REQ-F09, REQ-F18, REQ-F19, REQ-F22; **Rule:** REQ_AUTH_001, REQ_AUTH_002, REQ_AUTH_003, REQ_AUTH_004, REQ_AUTH_005, REQ_AUTH_006, REQ_AUTH_007, REQ_AUTH_008, REQ_AUTH_009
**BR:** BR-016, BR-017, BR-025, BR-026, BR-027, BR-028, BR-029, BR-030
**Scenario liên quan:** TC_AUTH_SC020, TC_AUTH_SC021, TC_AUTH_SC022, TC_AUTH_SC023, TC_AUTH_SC024, TC_AUTH_SC025, TC_AUTH_SC026, TC_AUTH_SC027, TC_AUTH_SC028, TC_AUTH_SC029, TC_AUTH_SC030, TC_AUTH_SC031, TC_AUTH_SC064, TC_AUTH_SC065, TC_AUTH_SC066, TC_AUTH_SC067, TC_AUTH_SC068, TC_AUTH_XT01, TC_AUTH_XT02, TC_AUTH_XT03, TC_AUTH_XT04, TC_AUTH_XT05, TC_AUTH_XT06, TC_AUTH_XT07, TC_AUTH_NEW009, TC_AUTH_NEW010, TC_AUTH_REV004, TC_AUTH_REV012

[Xem SVG](CL06.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).

## CL07 — Tài khoản và hợp đồng lưu xác minh

D02 gửi thư sau commit là đề xuất; không coi gửi thư là đã xác minh; class UML là cấu trúc, đối chiếu nhánh ở Activity/Sequence.

**REQ G0:** REQ-F05, REQ-F06, REQ-F09, REQ-F18, REQ-F19, REQ-F22; **Rule:** REQ_AUTH_001, REQ_AUTH_002, REQ_AUTH_003, REQ_AUTH_004, REQ_AUTH_005, REQ_AUTH_006, REQ_AUTH_007, REQ_AUTH_008, REQ_AUTH_009
**BR:** BR-016, BR-017, BR-025, BR-026, BR-027, BR-028, BR-029, BR-030
**Scenario liên quan:** TC_AUTH_SC020, TC_AUTH_SC021, TC_AUTH_SC022, TC_AUTH_SC023, TC_AUTH_SC024, TC_AUTH_SC025, TC_AUTH_SC026, TC_AUTH_SC027, TC_AUTH_SC028, TC_AUTH_SC029, TC_AUTH_SC030, TC_AUTH_SC031, TC_AUTH_SC064, TC_AUTH_SC065, TC_AUTH_SC066, TC_AUTH_SC067, TC_AUTH_SC068, TC_AUTH_XT01, TC_AUTH_XT02, TC_AUTH_XT03, TC_AUTH_XT04, TC_AUTH_XT05, TC_AUTH_XT06, TC_AUTH_XT07, TC_AUTH_NEW009, TC_AUTH_NEW010, TC_AUTH_REV004, TC_AUTH_REV012

[Xem SVG](CL07.svg). Nguồn dữ liệu/kiểm tra/ghi/lỗi xem [hợp đồng](../HOP_DONG_DU_LIEU.md); nhánh đối chiếu xem [review](../review_luong_du_lieu.md).
