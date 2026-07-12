# 💡 Bí Kíp Nhập Môn Tư Duy DevOps & Khám Phá Marketplace

Khi bước chân từ thế giới lập trình Front-end/Back-end (như NPM, Nuget) sang thế giới DevOps / GitHub Actions, tư duy của bạn cần thay đổi.

## 1. Sự Khác Biệt Cốt Lõi Về Tư Duy
- **Frontend/Backend (NPM/Nuget):** Tìm công cụ để **Làm ra sản phẩm** (Ví dụ: React để làm giao diện, Axios để gọi API).
- **DevOps/CI-CD (Actions Marketplace):** Tìm công cụ để **Tự động hóa quy trình** (Ví dụ: Tự động chạy Unit Test, tự động nén Docker, tự động Deploy lên AWS).

## 2. Xu Hướng "Shift-left" Của Lập Trình Viên
- Hiện nay ranh giới giữa Dev (người viết code) và Ops (người triển khai) đang mờ dần.
- Các công ty hiện đại thường yêu cầu lập trình viên Backend/Frontend phải biết tự viết CI/CD cơ bản để quản lý vòng đời code của mình.
- **Sức mạnh:** Giá trị của một Developer tăng lên gấp bội khi bạn không chỉ biết "sản xuất" code, mà còn biết cách "vận chuyển" tự động code đó đến tay người dùng cuối.

## 3. Bản Đồ Từ Khóa Khám Phá (Keywords)
Dưới đây là 4 nhóm "đồ chơi" bạn nên tìm hiểu trên GitHub Marketplace hoặc Youtube/Google để nâng cấp kỹ năng:

### 📢 Nhóm 1: Tự Động Hóa & Thông Báo (Vui Nhất)
- **Mục đích:** Gửi thông báo đến điện thoại/chat mỗi khi hệ thống có biến động (VD: Đẩy code mới, build thành công hay thất bại).
- **Từ khóa:** `slack notification action`, `telegram bot github actions`, `discord webhook deploy`.
- **Trò vui:** Nếu có người push code lỗi khiến quá trình Build thất bại -> Bot tự động tag tên người đó vào chửi trên group Discord công ty.

### 🔍 Nhóm 2: Kiểm Soát Chất Lượng Code (Code Quality)
- **Mục đích:** Máy tự động đọc, quét lỗi và chấm điểm code, không cần con người săm soi thủ công.
- **Từ khóa:** `sonarcloud github actions`, `code coverage`, `eslint action`, `dotnet format`.
- **Trò vui:** Cứ có Pull Request mới, hệ thống AI SonarCloud tự động bay vào comment: *"Dòng 15 có lỗ hổng bảo mật rò rỉ bộ nhớ, yêu cầu sửa lại ngay!"*.

### 📦 Nhóm 3: Đóng Gói và Vận Chuyển (Deploy & Docker)
- **Mục đích:** Đưa mã nguồn lên internet hoàn toàn tự động chỉ với 1 cú click.
- **Từ khóa:** `docker build push action`, `deploy ssh`, `aws ecs deploy`, `vercel deploy`.
- **Trò vui:** Bạn push code lên nhánh `main`, 2 phút sau khách hàng F5 trang web và thấy giao diện mới nhất. Phía sau cánh gà, GitHub đã tự đăng nhập server, kéo code mới, khởi động Docker.

### 🤖 Nhóm 4: Tự Động Bảo Trì (Bot Trợ Lý)
- **Mục đích:** Các con bot (Agent) tự động quét và bảo trì mã nguồn dự án định kỳ mà bạn không cần đụng tay.
- **Từ khóa:** `dependabot`, `stale issue`, `auto label pr`.
- **Trò vui:** Dependabot tự quét thấy thư viện `axios` bạn đang dùng có phiên bản mới. Nó tự động tạo PR nâng cấp mã nguồn của bạn và gửi email: *"Đại ca hãy review và Merge em đi"*.

## 4. Cách Học & Cập Nhật Kiến Thức DevOps
- **YouTube:** Ưu tiên xem các kênh chuyên về hạ tầng dễ hiểu như **TechWorld with Nana**, **Hussein Nasser**, **NetworkChuck**.
- **GitHub:** Tìm kiếm các repository tổng hợp những món đồ chơi đỉnh nhất bằng keyword `awesome github actions` (ví dụ repo `sdras/awesome-actions`).
- **TikTok/Shorts:** Dùng hashtag `#devops`, `#githubactions`, `#cicd` để xem các clip biểu diễn ảo thuật tự động hóa ngắn gọn mỗi ngày.
