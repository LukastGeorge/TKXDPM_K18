# Bằng chứng kiểm tra tài liệu

Chỉ kiểm feature, truy vết, UML và render; không có build/test ứng dụng.

- [Log parser](gherkin_parse.log): Gherkin36.1.0/messages30.1.0, 152 định nghĩa/219 cases, 0 parse errors và 0 lỗi tag/ID/tham số.
- [Kiểm tra cấu trúc](kiem_tra_tai_lieu.json): liên kết, hình và draw.io, hash bản bàn giao.
- [Kết quả kiểm feature và UML](../verification_result.json): phạm vi đối chiếu và kiểm hình ảnh.

Lệnh thực tế, trong thư mục làm việc tài liệu riêng:

    java -Dfile.encoding=UTF-8 -cp "<private>;<private>/parser-lib/*" CheckCanonical @feature_path.txt

feature_path.txt chứa đường dẫn UTF-8 tới feature; helper tài liệu không đưa vào project. Javac25 phát AccessDeniedException khi đóng JAR lúc biên dịch trong sandbox; lớp vẫn sinh và lần chạy parser riêng kết thúc mã0. Không gọi đây là lỗi code website.

Render từ thư mục docs/uml của bản staged:

    java -Dfile.encoding=UTF-8 -jar "D:/Environment/OffloadedFromC/TruongNguyen/vscode-extensions/jebbs.plantuml-2.18.1/plantuml.jar" -charset UTF-8 -tsvg "*.puml"

Chạy cùng lệnh với -tpng để có ảnh. PlantUML1.2024.3, Java25.0.3 và Graphviz2.44.1 là công cụ tài liệu trên máy, không phải quyết định phiên bản ứng dụng. Không gửi source ra dịch vụ UML ngoài.

## Bản báo cáo Word và hồ sơ S1

[Kiểm tra báo cáo](kiem_tra_bao_cao.json) ghi hash nguồn Markdown và bản Word, 25 trang, 8 hình, cập nhật mục lục bằng Word, kiểm trực quan và các giới hạn. Báo cáo vẫn là phân tích–thiết kế; không có kết quả chạy ứng dụng.

`file_hashes.json` và `verification_result.json` giữ snapshot đợt feature/UML trước khi mở rộng báo cáo Word, không phải manifest của toàn thư mục sau mọi lần sửa. Hash báo cáo hiện tại nằm trong `kiem_tra_bao_cao.json`. Feature và 37 sơ đồ đầy đủ không đổi trong đợt này; ba hình trích lược phục vụ Word nằm riêng ở `bao_cao/hinh`.

Đã thử renderer đóng gói `render_docx.py`, lỗi do thiếu `soffice.exe`. Đã dùng Microsoft Word chạy ẩn để refresh TOC/PAGE, xuất PDF nội bộ rồi PDFium render từng trang PNG; kiểm 25/25 trang. PDF và ảnh kiểm trang là tệp QA nội bộ, không phải ảnh chương trình. Mẫu DOC gốc không bị chỉnh sửa.
