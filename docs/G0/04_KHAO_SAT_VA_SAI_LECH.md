> **Hồ sơ khảo sát G0 giữ để truy vết.** Quyết định hiện hành QD-01/02 và phạm vi được phép làm tài liệu xem [sổ BR](../QUY_TAC_NGHIEP_VU.md), [báo cáo sống](../BAO_CAO_SONG.md). Nội dung “chưa chốt kho/mã” phía dưới mô tả thời điểm khảo sát trước quyết định mới.

# Khảo sát hiện trạng và sai lệch

## Thư mục được kiểm tra

Thư mục thật là `E:\Workspace\TKXDPM_K18_2\Website giới thiệu, bán sách trực tuyến`. Đường dẫn workspace cấu hình có `_02` không tồn tại; các thao tác G0 dùng thư mục thật do người dùng xác nhận. Không đọc nội dung `.backups`.

Trước khi thêm hồ sơ G0 có **94 file**, gồm một feature chính, tài liệu review, 28 source PlantUML cùng PNG/SVG, trang xem, dữ liệu truy vết và README. Hash của cả 94 file khớp bản bàn giao 29/10. Không tìm thấy source ứng dụng website, glue code, test tự động, build descriptor, Docker Compose hoặc `.drawio` trong thư mục đề tài. Không tìm thấy AGENTS.md áp dụng trong các thư mục cha đã kiểm tra hoặc thư mục đề tài. Thư mục cha không là Git repository và đề tài không có `.git`.

Feature hiện có 1 Feature, 38 Rule, **138 định nghĩa scenario**, trong đó **117 mang needs_confirmation**. Bản kiểm tra tài liệu ngày 29/10 ghi 201 case mở rộng, 177 case cần xác nhận. G0 đọc lại cấu trúc và đối chiếu hash; không gọi con số đó là số test pass, không chạy lại phần mềm chưa có.

Thư mục cùng cấp `serenity-cucumber-tkxpm-2` là bài tích hai số: `MultiplicationDemo.main`, `nhan_hai_so.feature`, Maven/Gradle và unit tests. Nó không phải module website. G0 chỉ đọc phần nhận diện và cấu hình liên quan, không sửa hoặc chạy bộ test của bài đó.

## Môi trường quan sát được

| Lệnh/thao tác | Kết quả thật | Giới hạn |
|---|---|---|
| `Get-Command java,mvn,docker` | Có cả ba executable | Có file không chứng minh project build được |
| `java -version` | OpenJDK Microsoft 25.0.3 | Không tự chọn Java 25 làm version cuối kỳ |
| `mvn -version` | Apache Maven 3.9.16, dùng Java 25.0.3 | Có dòng Access is denied trước phần version; chưa chạy build website |
| `docker --version` | Docker client 29.6.2 | Có warning không đọc được `.docker/config.json` trong quyền hiện tại |
| `docker compose version` | Docker Compose v5.3.1 | Chưa kiểm engine, chưa tạo/pull/chạy container PostgreSQL |
| `git -C E:\Workspace\TKXDPM_K18_2 status --short --branch` | fatal: not a git repository | Không có trạng thái Git để suy ra clean/dirty |
| Đọc DOCX/PPTX, PDF và render | Tất cả 12 file đầu vào mở được; Word render thành công sau khi cấp quyền đọc/render | Không sửa bản gốc; ảnh/notes được đối chiếu riêng |

Không có lệnh build/test website được thử trong G0; vì chưa có source/build nên trạng thái là **chưa thực hiện**, không phải test thất bại. Không viết implementation, glue code, test tự động hoặc Compose ở mốc này.

## Khoảng thiếu so với hồ sơ cuối kỳ

| Mã | Bằng chứng hiện tại | Ảnh hưởng | Cách xử lý đề nghị | Mốc |
|---|---|---|---|---|
| GAP-01 | `docs/uml` chỉ có Activity/Sequence/State/Component/DFD; không có class UML hoặc .drawio website | Chưa có đầu ra đúng SRC02 tr.2 và SRC03 mục 3.2 | Vẽ class UML chỉnh sửa được trong file draw.io cá nhân; dùng 28 hình làm hỗ trợ | G2 |
| GAP-02 | Feature có REQ/TC; chưa có sổ BR và chuỗi truy vết đầy đủ trong bản cũ | Khó kiểm quyết định nghiệp vụ và thay đổi | Sổ BR ứng viên G0; G1 gắn BR vào scenario/tiêu chí, không tự duyệt | G1 |
| GAP-03 | 117 scenario còn needs_confirmation, nhất là kho/ưu đãi/trạng thái | Không thể coi Then có điều kiện là quy tắc đã chốt | Duyệt nhóm BR trước khi thiết kế/triển khai liên quan | G1 |
| GAP-04 | `CP01.puml` và D04 trong review cũ trả ResponseModel qua InputBoundary, formatter ở controller | Khác mô hình OutputBoundary được minh họa rõ trong SRC07 s.6–10 | G2 đề nghị InputBoundary → Interactor → OutputBoundary → Presenter; cập nhật đồng bộ sequence/contract. Không kết luận D04 luôn sai Clean Architecture | G2 |
| GAP-05 | Cũ có email/Facebook ports/lifeline nhưng chưa có adapter/code/config chạy thật | Không đáp ứng xác nhận tích hợp thật nếu chỉ dùng fake | Thiết kế lỗi/contract; chuẩn bị quyền cấu hình; tích hợp và lưu bằng chứng thực sau duyệt | G1/G3/G4 |
| GAP-06 | Chưa có invariant/entity/value object/aggregate website hoặc UML lớp chi tiết | Tên Domain trên CP01 chưa chứng minh DDD | Dùng BR và thuật ngữ xác định trách nhiệm/ranh giới nhất quán; không tạo lớp chỉ để đủ tên | G1/G2 |
| GAP-07 | Chưa có chương trình, build, Jupiter, glue hoặc DB website | Chưa có bằng chứng mục 3.3/3.5; đây là trạng thái đúng trước code | Chỉ thực hiện sau cổng G3 cho từng lát cắt | G3/G4 |
| GAP-08 | Bản cũ chưa chọn nguồn báo cáo sống, chưa đồng bộ theo stack và dịch vụ thật mới chốt | Có nguy cơ các mô tả khác phiên bản | G1 chọn một nguồn báo cáo chính; các review chỉ bổ trợ; G4 cập nhật từng lát cắt | G1–G5 |
| GAP-09 | SC031 chỉ giữ giỏ guest cùng phiên; fixture chưa phân biệt ấn bản | Thiếu quyết định ảnh hưởng entity/ID và gộp giỏ | BR-001, BR-017; không tự chọn thay người dùng | G1 |
| GAP-10 | Bài tích hai số cùng cấp có cả Maven/Gradle, Serenity khác version; pom skip Surefire rồi dùng Failsafe | Sao chép nguyên khung dễ hiểu nhầm `mvn test` hoặc kết quả chạy | Không dùng kết quả bài khác; G3 chốt một build chuẩn và kiểm discovery khi được cho phép | G3 |

Không yêu cầu mọi đầu ra G2–G5 phải có ngay tại G0. Bảng này ghi việc phải hoàn thành về sau, không dùng thiếu code hiện tại để gọi G0 thất bại.

## Điểm mâu thuẫn hoặc dễ hiểu sai giữa nguồn

| Mã | Hai nguồn/vị trí | Khác biệt và ảnh hưởng | Phương án trình người dùng |
|---|---|---|---|
| CON-01 | SRC04 tr.2 và SRC03 tr.1 | Mẫu có hàng Tiêu chí 1..5 chung; phiếu thực có mục 1/2/3.1–3.5 | Dùng SRC04 cho bìa/bố trí; dùng SRC03 cho tiêu chí đối chiếu. Chưa tự sửa bản gốc |
| CON-02 | SRC10 PDF 9–10 và SRC13 mục 6 | Blueprint nói giải quyết logic ở Refactor/mở rộng edge cases; dễ bị hiểu là thêm hành vi không có test đỏ | Mỗi hành vi/biên mới đi qua Red–Green riêng; refactor chỉ đổi cấu trúc, giữ hành vi. Tuân theo chỉ dẫn trực tiếp SRC13 |
| CON-03 | CP01/D04 cũ, SRC11 tr.in 123–128 và SRC07 s.6–10 | Response trả trực tiếp là một biến thể; slide môn học thể hiện OutputBoundary/presenter | Ưu tiên mô hình môn học trong đề xuất G2, trình duyệt rồi cập nhật mọi biểu diễn; không âm thầm chọn một bên |
| CON-04 | SRC02 ghi SOLD; SRC13 ghi SOLID | Khác chữ có thể gây trích sai | Giữ nguyên tên/ghi nhận cách viết trong danh mục; dùng SOLID làm cách hiểu theo yêu cầu trực tiếp |
| CON-05 | SRC09 s.11–12 và SRC13 bảng G0–G3 | Slide khuyến khích code sớm; quy trình hiện tại cấm code trước cho phép | Áp dụng Tracer Bullet tại G4 sau phê duyệt. Không xem lời khuyên slide là giấy phép code ngay |
| CON-06 | Tên tệp SRC12 và trang copyright PDF 5 | Filename 2017, copyright 2018 | Ghi thông tin ấn bản đã nhìn thấy và ISBN; chưa tự suy năm thư mục chỉ từ filename |

G0 đã ghi nhận và đề xuất cách xử lý; chưa tự đánh dấu các quyết định thiết kế hoặc mốc đã được người dùng duyệt.
