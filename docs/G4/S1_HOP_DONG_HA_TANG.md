# Hợp đồng trước implementation adapter S1

Ghi trước khi viết adapter và web: PostgreSQL lưu một giỏ/owner; owner lấy từ session server, không nhận qua form. `open` có thể tạo giỏ rỗng; đọc sách không sửa catalog. `loadOwned` không trả dữ liệu sai chủ. `save` chỉ chấp nhận cart.version == expectedVersion; CAS và thay mọi dòng trong một transaction; lỗi SQL phải rollback cả version và dòng; false không ghi. H/R không thay đổi. Ví dụ v0 → SET S001=2 → v1; hai yêu cầu cùng v1 chỉ một được ghi. Không phải kiểm thử cạnh tranh đặt đơn/giữ tồn của S3.

HTTP: GET /books, /books/{sku}, /cart; POST /cart/{id} nhận sku, quantity dạng text, mode ADD/SET, version. Sai UUID/version/mode trả 400 trước use case. Owner chỉ lấy từ HttpSession. CSRF được kiểm tra bởi Spring Security. Thành công redirect /cart; lỗi nghiệp vụ 400/403/404/409; hạ tầng 503. Không tạo endpoint đặt đơn trong S1. Giá/owner từ form không được dùng. Template tự escape dữ liệu. Mỗi request có presenter riêng, không chia sẻ response giữa người dùng.

PostgresIT phải dùng schema test_s1_<uuid> riêng trên DB của bài; cleanup đúng schema đã tạo. Kiểm tra transaction, CAS đồng thời, giỏ không giữ kho, hợp đồng qua fake/adapter. WebIT chạy HTTP thật qua Spring và DB thật, kiểm CSRF/phiên/giá/backend/lỗi. Không có DB thì verify lỗi môi trường, không bỏ qua để báo xanh.
