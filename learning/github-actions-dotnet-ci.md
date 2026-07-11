# Thực hành CI/CD với .NET Core & Clean Architecture trên GitHub Actions

## 1. Mục tiêu
Tạo một quy trình CI (Continuous Integration) thực tế và hoàn chỉnh cho một dự án .NET 8 được thiết kế theo chuẩn Clean Architecture. Các bước trong Pipeline bao gồm:
- Tải source code từ repository về máy ảo (runner).
- Cài đặt môi trường .NET 8 SDK.
- Khôi phục thư viện (Restore Nuget Packages).
- Biên dịch (Build) toàn bộ solution.
- Chạy kiểm thử tự động (Unit Tests).
- Đóng gói ứng dụng (Publish) phần WebApi để sẵn sàng lên Production.
- Lưu trữ file đã đóng gói (Upload Artifact) để chuyển giao cho quá trình Deploy.

## 2. Cấu trúc Project Mẫu
Solution `CleanApi` được chia làm 4 dự án con (Projects):
- **CleanApi.Domain**: Lớp cốt lõi, không phụ thuộc vào bất cứ tầng nào khác, chứa các Entities và Interfaces cơ bản.
- **CleanApi.Application**: Chứa logic nghiệp vụ (ví dụ: CQRS, Use Cases).
- **CleanApi.Infrastructure**: Lớp cơ sở hạ tầng đảm nhiệm việc giao tiếp với Database (DbContext), các dịch vụ bên ngoài, API,...
- **CleanApi.WebApi**: Lớp ngoài cùng giao tiếp với Client thông qua các Controllers / Endpoints.

## 3. Phân tích File Workflow (`dotnet-ci.yml`)
Dưới đây là một số Actions & Flags quan trọng được sử dụng trong bài thực hành:

- `uses: actions/checkout@v4`: Action chính chủ của GitHub, có nhiệm vụ clone toàn bộ source code của nhánh hiện tại về thư mục làm việc của máy ảo (runner).
- `uses: actions/setup-dotnet@v4`: Cài đặt bộ SDK của .NET theo version chỉ định (ở đây là `8.0.x`).
- `uses: actions/upload-artifact@v4`: Action gom tất cả các file trong thư mục đã publish thành một tệp nén (zip) và đính kèm nó vào bản ghi chạy của workflow trên GitHub. Tính năng này dùng để chia sẻ file giữa các job với nhau (ví dụ truyền file thực thi cho job Deploy).
- `Cờ (Flag) --no-restore`: Áp dụng trong bước `dotnet build` và `dotnet test`. Nó ra lệnh cho .NET bỏ qua việc check và tải thư viện vì bước `dotnet restore` đã làm việc đó rồi, giúp tiến trình chạy nhanh và kiểm soát lỗi rõ ràng từng bước một.

## 4. Những mẹo & lỗi cần tránh rút ra từ bài thực hành trước
- **Lỗi Nested mapping trong YAML:** Nếu một chuỗi bắt đầu bằng chữ cái thường (không có ngoặc kép bọc ngoài) mà bên trong lại xuất hiện cú pháp dấu hai chấm và khoảng trắng `: `, YAML Parser sẽ báo lỗi vì nó tưởng bạn đang khai báo biến (Key-Value) lồng nhau. Để giải quyết, hãy dùng block nhiều dòng với dấu `|` hoặc đặt nguyên cụm trong ngoặc `'...'`.
- **Gọi biến môi trường (env):** Trong ngữ cảnh của GitHub Actions, để gọi một biến được khai báo ở block `env`, bạn bắt buộc phải dùng prefix `env.` (Ví dụ: `${{ env.SERVER_PORT }}`). Nếu gọi trần trụi `${{ SERVER_PORT }}`, hệ thống sẽ trả về một khoảng trắng.
- **Tính năng Case-insensitive:** Toán tử kiểm tra chuỗi `==` trong expressions của GitHub Actions (ví dụ `if: github.actor == 'Thinhtran2412'`) là dạng không phân biệt chữ hoa chữ thường. Dù user name là gì đi nữa, miễn đọc giống nhau thì đều bypass qua thành công.
