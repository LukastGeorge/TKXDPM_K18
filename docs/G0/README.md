> **Hồ sơ khảo sát G0 giữ để truy vết.** Quyết định hiện hành QD-01/02 và phạm vi được phép làm tài liệu xem [sổ BR](../QUY_TAC_NGHIEP_VU.md), [báo cáo sống](../BAO_CAO_SONG.md). Nội dung “chưa chốt kho/mã” phía dưới mô tả thời điểm khảo sát trước quyết định mới.

# Hồ sơ G0 Website giới thiệu bán sách trực tuyến

**G0 – Hiểu đề: Chờ duyệt phạm vi.** Cập nhật 04/11/2026. Chủ sở hữu và người thực hiện: Nguyễn Duy Trường – MSSV 24150180, làm cá nhân.

Hồ sơ này tập hợp căn cứ và phạm vi để người dùng quyết định chuyển G1. Các lựa chọn đã xác nhận là Java/Spring Boot, PostgreSQL qua Docker, Jupiter và email/Facebook tích hợp thật. Không có code ứng dụng website, glue code hoặc test tự động được viết trong đợt G0.

## Đọc theo thứ tự

1. [Nguồn đã đọc và phần chưa đọc](01_DANH_MUC_NGUON.md).
2. [Ma trận yêu cầu và đối chiếu phiếu chấm](02_MA_TRAN_YEU_CAU.md).
3. [Phạm vi, quyền và sổ BR cần chốt](03_PHAM_VI_VA_QUY_TAC_CAN_CHOT.md).
4. [Khảo sát thư mục, môi trường và sai lệch](04_KHAO_SAT_VA_SAI_LECH.md).
5. [Kế hoạch G0–G5 và điều kiện duyệt](05_KE_HOACH_VA_DIEU_KIEN_DUYET.md).
6. [REQ → BR → Scenario → UML → Test → Code → Bằng chứng](06_TRUY_VET_VA_BANG_CHUNG.md).

## Kết quả kiểm kê

Đã mở được đủ 12 tệp đính kèm. Các tài liệu môn học ngắn được đọc đủ chữ/bảng/hình; bốn bộ slide có 52 slide, Blueprint có 13 trang ảnh. Hai sách tham khảo đã đọc chọn lọc, với chương/trang và phần chưa đọc được ghi riêng; không tuyên bố đã đọc trọn 791 trang PDF của hai sách.

Thư mục đề tài trước đợt này có 94 file, gồm bản nháp feature với 138 định nghĩa scenario và 28 sơ đồ hỗ trợ. Còn thiếu class UML và draw.io cá nhân cho website; phần kho/ưu đãi/trạng thái chưa duyệt; chưa có chương trình, build hoặc test website. Đây là khoảng phải hoàn thiện ở các mốc sau, không phải kết luận phần mềm đã thất bại khi chạy.

Ma trận có **41 yêu cầu**, sổ ứng viên **31 BR**; các mapping đều dẫn tới scenario/sơ đồ đang tồn tại khi có. G0 chưa sửa BR/Then hoặc thiết kế của bản nháp cũ. File [nguồn và hiện trạng](nguon_va_hien_trang.json) giữ metadata/hashes để đối chiếu.

## Những quyết định cần ở mốc này

Người dùng kiểm phạm vi ba vai trò, sáu nghiệp vụ bắt buộc, các xác nhận công nghệ/dịch vụ thật, các điểm còn mở và kế hoạch. **Duyệt G0 chỉ mở G1 để hoàn thiện đặc tả.** Nó không phê duyệt toàn bộ 138 scenario, không chốt P-STOCK/P-PRICE/D04 và không cho phép code.

Khi chuyển G1, hoàn thiện sổ BR/thuật ngữ, review canonical [feature hiện có](../../features/web_ban_sach_tinh_nang.feature) và trình acceptance criteria cùng danh sách lát cắt. Chỉ sau G2/G3 và cho phép lát cắt cụ thể mới thực hiện BDD/TDD, code và minh chứng chạy thật.
