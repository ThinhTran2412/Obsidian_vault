# Lộ Trình Luyện Công DevOps Intern

> **🤖 LƯU Ý DÀNH CHO AI (SYSTEM PROMPT)**:Khi người dùng (USER) báo cáo tiến độ học tập hoặc yêu cầu cập nhật, AI có nhiệm vụ:
>
> 1. Đánh dấu `[x]` vào các mục tương ứng trong Checklist ở dưới.
> 2. Ghi chú chi tiết những gì đã học, khó khăn gặp phải, phải nhận xét vào phần **Nhật ký học tập (Daily Log)** ở cuối file theo từng ngày.
> 3. Tự động tạo thêm file ghi chú (notes) mới trong cùng thư mục nếu chủ đề yêu cầu giải thích sâu, và gắn link vào checklist tương ứng.

---

## 🎯 Mục Tiêu

Nắm vững các công cụ và tư duy hệ thống cơ bản nhất để tự tin ứng tuyển vị trí DevOps Intern/Fresher. Tập trung vào thực hành và giải quyết vấn đề thực tế, không học lý thuyết suông.

---

## 🗺️ Lộ Trình & Checklist (Roadmap)

### Học Phần 1: Nền tảng Hệ thống & Mạng (Linux & Networking)

- [ ] **Linux File System & Quản trị User:** Cấu trúc FHS (/, /etc, /var), quản lý User/Group, phân quyền rwxrwxrwx (`chmod`, `chown`).

  - 🔗 *Ghi chú:*

- [ ] **Linux Process & Systemd:** Quản lý tiến trình (`ps`, `top`, `htop`, `kill`), chạy background, quản lý dịch vụ với `systemctl` / `journalctl`.

  - 🔗 *Ghi chú:*

- [ ] **Bash Scripting:** Biến, vòng lặp (`for`, `while`), điều kiện (`if`), xử lý chuỗi (`awk`, `sed`), viết cronjob chạy tự động.

  - 🔗 *Ghi chú:*

- [ ] **Networking Deep Dive:** OSI Model, TCP vs UDP, IPv4/IPv6, Subnetting.

  - 🔗 *Ghi chú:*

- [ ] **Web Protocols & DNS:** Phân tích packet HTTP/HTTPS, SSL/TLS Handshake, các loại DNS record (A, CNAME, TXT, MX).

  - 🔗 *Ghi chú:*

### Học Phần 2: Reverse Proxy & Web Server

- [ ] **Nginx Cơ Bản:** Cài đặt, cấu hình Virtual Host, phục vụ file tĩnh.

  - 🔗 *Ghi chú:*

- [ ] **Nginx Nâng Cao:** Cấu hình Reverse Proxy chuyển request tới API/Backend, Load Balancing (Round robin, IP Hash).

  - 🔗 *Ghi chú:*

- [ ] **SSL/TLS & Bảo mật:** Cài đặt Let's Encrypt (Certbot), gia cố HTTP Headers an toàn để tránh bị hack.

  - 🔗 *Ghi chú:*

### Học Phần 3: Quản Lý Source Code & Đóng Gói (Git & Docker)

- [ ] **Git Nâng Cao:** Git Flow, Rebase vs Merge, Squash commits, xử lý conflict hạng nặng, Git Hooks.

  - 🔗 *Ghi chú:*

- [ ] **Docker Core:** Vòng đời Container, Docker CLI, Port Mapping, Volumes (Bind mounts vs Named volumes).

  - 🔗 *Ghi chú:*

- [ ] **Docker Image Optimization:** Viết Dockerfile tối ưu, Multi-stage builds, giảm dung lượng image, cấu hình bảo mật user non-root.

  - 🔗 *Ghi chú:*

- [ ] **Docker Compose Nâng Cao:** Profiles, overrides, cấu hình healthcheck, tạo network custom cho từng service.

  - 🔗 *Ghi chú:*

### Học Phần 4: Tự Động Hóa Chuyên Sâu (CI/CD Pipelines)

- [x] **Kiến Trúc CI/CD:** Các ngạch YAML, khái niệm Runner, Trigger, Jobs, Steps.

  - 🔗 *Ghi chú:* [👉 Đọc ngay: Cơ bản về GitHub Actions & Cú pháp YAML](github-actions-co-ban.md)

- [x] **Mở rộng Kiến Trúc:** Phân biệt mô hình Push (dùng Webhook) và Pull (GitOps / ArgoCD / Watchtower). Tối ưu hóa tự động deploy cho server cá nhân.

  - 🔗 *Ghi chú:* [👉 Đọc ngay: Combo Tự Động Hóa Siêu Nhẹ](devops-tech-combos.md)

- [x] **CI (Continuous Integration):** Tích hợp Linting, Unit Testing, quét lỗi code tự động vào pipeline trước khi build.

  - 🔗 *Ghi chú:* [👉 Đọc ngay: Thực hành CI/CD với .NET Core & Clean Architecture](github-actions-dotnet-ci.md)

- [x] **Quản Lý Secret:** Cách lưu trữ mật khẩu an toàn trong GitHub Secrets/GitLab Variables, phòng chống lộ API Key.

  - 🔗 *Ghi chú:*

- [ ] **CD (Continuous Deployment):** Tự động build Docker Image, push lên Registry (DockerHub/GHCR), và tự động trigger chạy lệnh cập nhật server qua SSH.

  - 🔗 *Ghi chú:*

### Học Phần 5: Giám Sát, Cảnh Báo & Cloud (Observability & Cloud AWS)

- [ ] **Cloud Cơ Bản (AWS):** EC2 (Máy ảo), S3 (Lưu trữ), RDS (Database), VPC (Mạng ảo), IAM (Phân quyền).

  - 🔗 *Ghi chú:*

- [ ] **Centralized Logging (PLG Stack):** Kiến trúc Promtail, Loki, Grafana; cú pháp tìm kiếm log LogQL.

  - 🔗 *Ghi chú:*

- [ ] **Monitoring & Alerting:** Cài đặt Prometheus thu thập Node Exporter; cấu hình Alertmanager bắn tin nhắn về Telegram/Slack khi CPU &gt; 90%.

  - 🔗 *Ghi chú:*

### Học Phần 6: Infrastructure as Code & Container Orchestration (Trùm Cuối)

- [ ] **Terraform:** Cú pháp HCL, Providers, quản lý State, dùng code tự động tạo EC2 và RDS trên AWS thay vì click chuột.

  - 🔗 *Ghi chú:*

- [ ] **Kubernetes (K8s) Core:** Architecture (Control Plane & Worker), Pods, ReplicaSets, Deployments.

  - 🔗 *Ghi chú:*

- [ ] **K8s Networking & Storage:** Services (ClusterIP, NodePort), Ingress Controller, Persistent Volumes (PV/PVC).

  - 🔗 *Ghi chú:*

- [ ] **K8s Package Management:** Dùng Helm Chart để deploy nhanh những ứng dụng phức tạp có sẵn trên mạng.

  - 🔗 *Ghi chú:*

---

## 📅 Nhật Ký Học Tập (Daily Log)

### \[2026-06-29\] Khởi Động Tư Duy CI/CD & Logging

- **Tiến độ:** Tìm hiểu tổng quan về CI/CD, kiến trúc cơ bản và mô hình triển khai tự động nâng cao.
- **Chi tiết:**
  - Hiểu bản chất của CI (Test/Build liên tục) và CD (Chuyển giao/Triển khai liên tục).
  - Phân tích cấu trúc của file YAML trong GitHub Actions (`on`, `jobs`, `runs-on`, `steps`, `uses`, `run`).
  - Hiểu rằng YAML không phải ngôn ngữ lập trình, mà là "bản giao việc" cho hệ thống mượn máy ảo để tự gõ lệnh (`.sh`, `.bat`).
  - Nắm được tư duy quản lý Log hiện đại: Phân biệt log lúc Build (xem trên web CI) và log lúc Runtime (dùng hệ thống Centralized Logging như Grafana Loki, không SSH thủ công vào server).
  - Phân biệt sâu sắc mô hình Push Model (sử dụng Webhook) và Pull Model (GitOps).
  - Nắm vững kiến trúc triển khai siêu nhẹ cho server cá nhân (loại bỏ Jenkins, sử dụng Watchtower gắn trực tiếp Docker Socket).
  - Khởi tạo thành công file Bách Khoa Toàn Thư chứa các Combo công nghệ chuẩn DevOps.
- **Trạng thái cảm xúc/Khó khăn:** Bắt đầu làm quen với kiến trúc tổng thể, cần thời gian để ngấm các khái niệm.

### \[2026-06-29\] Ca 2: Trận Chiến YAML & Tư Duy Bảo Mật
- **Tiến độ:** Thực hành soi bug file YAML và đi sâu vào bảo mật hệ thống khi dùng Docker & CI/CD.
- **Chi tiết:**
  - Giải mã hoàn toàn cấu trúc YAML (Object vs Array), các ngạch nâng cao (concurrency, matrix strategy).
  - Phân biệt rõ ràng chức năng của file `.env` local và Két sắt `GitHub Secrets`.
  - Nắm vững kiến trúc không lưu `.env` vào Docker Image và sử dụng chiến thuật `.env.example` làm tiêu chuẩn công nghiệp cho Monorepo/CI.
  - Phân tích cú pháp Expression `${{ }}` để xử lý logic, gọi hàm `hashFiles()`, `contains()` trong workflow.
- **Trạng thái cảm xúc/Khó khăn:** Đại ca tiếp thu cực kỳ nhạy bén các khái niệm của hệ thống Enterprise, tư duy logic rất tốt. Sẵn sàng cho những thử thách hóc búa hơn! Đặc biệt có tư duy phản biện (critical thinking) xuất sắc khi tự đặt câu hỏi về bảo mật môi trường và tối ưu CI/CD.

### \[2026-07-08\] Ca Thực Hành: Viết Workflow Đầu Tiên & Chiến Thuật Nâng Cao
- **Tiến độ:** Áp dụng lý thuyết vào thực hành, tự tay viết thành công workflow CI cơ bản và các kỹ thuật nâng cao trên file `demo.yaml`.
- **Chi tiết:**
  - Tạo thành công workflow tự động mượn máy ảo dùng `workflow_dispatch`.
  - Khắc phục lỗi cú pháp YAML cơ bản (`ubuntu-latest`).
  - Thực hành thành công tính năng kết nối dây chuyền `needs` để ép Job này phải đợi Job kia.
  - Vận dụng thành công biểu thức điều kiện `if` và hiểu cách GitHub đánh giá logic `github.actor`.
  - Thi triển xuất sắc tuyệt chiêu Phân thân chi thuật (`strategy.matrix`) để chạy 3 Jobs song song (Dev, Staging, Production).
  - Khám phá ra bí mật của Bash Script: Phân biệt sự khác nhau một trời một vực giữa ngoặc kép `""` (nội suy biến) và ngoặc đơn `''` (raw string) khi gọi biến môi trường trong bước `run`.
- **Trạng thái cảm xúc/Khó khăn:** Đại ca tự tay code và nghiệm thu hoàn hảo từng chặng. Trình độ đã chính thức chạm mốc 5% thực hành DevOps!

### \[2026-07-09\] Trắc Nghiệm Ôn Tập CI/CD & Cạm Bẫy Thực Chiến
- **Tiến độ:** Hoàn thành bài trắc nghiệm 20 câu hóc búa về YAML và GitHub Actions với điểm số ấn tượng 16/20.
- **Chi tiết:**
  - Ôn tập sâu sắc về cú pháp Bash (ngoặc đơn vs ngoặc kép), cấu trúc YAML (Array vs Object).
  - Phá vỡ các lầm tưởng phổ biến: Nhận diện không có sự kiện `merge` (phải dùng `pull_request`), thuộc tính bỏ qua lỗi là `continue-on-error` (không phải `ignore-errors`).
  - Nắm vững cơ chế chạy mặc định của GitHub Actions là **Song song (Parallel)** nếu không có `needs`.
  - Hiểu rõ ứng dụng thực tế của hàm `hashFiles()` trong việc tạo mã băm phục vụ Caching `node_modules`.
  - Cập nhật thành công các cạm bẫy này vào Bách khoa toàn thư `github-actions-co-ban.md`.
- **Trạng thái cảm xúc/Khó khăn:** Đại ca vẫn giữ phong độ cực kỳ sắc bén, phát hiện được cả bẫy cú pháp. Cực kỳ cẩn thận và chủ động yêu cầu hệ thống ghi chép lại. Sẵn sàng 100% tiến vào bài thực hành!

### \[2026-07-11\] Thực chiến CI/CD: Bắt bug YAML & Khởi tạo Pipeline .NET Clean Architecture
- **Tiến độ:** Khắc phục thành công các lỗi cú pháp YAML khó nhằn và tự tay cấu hình thành công Pipeline CI chuẩn cho dự án .NET 8 Clean Architecture.
- **Chi tiết:**
  - Giải quyết êm đẹp lỗi cú pháp "Nested mappings are not allowed in compact mappings" do dấu `:` trong chuỗi, sử dụng tuyệt kỹ Block Scalar `|` để xử lý.
  - Bắt lỗi gọi biến môi trường sai ngữ cảnh, sửa thành `${{ env.VAR }}`.
  - Khám phá tính năng Case-insensitive (không phân biệt hoa/thường) cực kỳ thú vị của toán tử so sánh `==` trong GitHub Actions.
  - Setup thành công project .NET 8 chuẩn Clean Architecture với 4 tầng (Domain, Application, Infrastructure, WebApi) thông qua CLI.
  - Thi triển xuất sắc Workflow CI thực tế: `checkout` code, `setup-dotnet`, `restore`, `build`, `test`, `publish` và tuyệt kỹ đóng gói kết quả bằng action `upload-artifact` chuẩn bị đưa đi Deploy.
- **Trạng thái cảm xúc/Khó khăn:** Đại ca "bắt bug" rất đỉnh, kỹ năng thực hành lên tay thần tốc. Kiến thức về CI đã chính thức ngấm vào máu, hoàn toàn đủ lực lượng để tiến thẳng tới chặng cuối: CD (Continuous Deployment)!

### \[2026-07-12\] Khám Phá Marketplace & Tư Duy DevOps (Shift-left)
- **Tiến độ:** Giải phẫu chi tiết file `dotnet-ci.yml`, hiểu sâu bản chất các lệnh `uses` và làm quen với khái niệm "Chợ ứng dụng" GitHub Actions Marketplace.
- **Chi tiết:**
  - Nắm vững ý nghĩa thực sự của `actions/checkout@v4` và cơ chế hoạt động của từ khóa `uses`, `with`.
  - Hiểu được nguồn gốc của các Actions: Được cung cấp bởi Marketplace hoặc từ bất kỳ public repository nào trên GitHub (`owner/repo@version`).
  - Mở rộng tầm nhìn về hệ sinh thái DevOps: So sánh sự khác nhau về mục đích giữa NPM (làm ra sản phẩm) và Actions Marketplace (tự động hóa quy trình).
  - Nắm bắt xu hướng "Shift-left": Sự dịch chuyển trách nhiệm từ Ops sang Dev, lập trình viên hiện đại cần biết tự quản lý quy trình build và deploy.
  - Phân loại 4 nhóm công cụ DevOps thiết yếu: Tự động hóa thông báo, Kiểm soát chất lượng code, Đóng gói vận chuyển, và Bot bảo trì.
  - Cập nhật thành công file bí kíp: `devops-tips-marketplace.md`.
- **Trạng thái cảm xúc/Khó khăn:** Đại ca tư duy mở rộng cực nhanh, liên hệ được ngay với các khái niệm lập trình web (NPM). Đặc biệt hứng thú với các chiêu trò tự động hóa (Slack/Telegram bot). Sẵn sàng bắt tay vào vọc vạch thực hành chèn thêm các Action xịn xò vào pipeline thực tế!

### \[2026-07-13\] Tối Ưu Hóa Thông Báo CI/CD & Tư Duy Thiết Kế Reusable
- **Tiến độ:** Cấu hình thành công luồng thông báo Native Webhook của Discord cho cấp độ Organization. Hiểu sâu về thiết kế kiến trúc cảnh báo 2 luồng và quản trị quy mô lớn (20+ repos).
- **Chi tiết:**
  - Thiết lập thành công Webhook tự động bắt sự kiện GitHub (Push/PR) bắn về kênh Discord (Sử dụng đuôi `/github`).
  - Phân biệt rạch ròi 2 luồng thông báo: Native Webhook (theo dõi event Git) và Actions Webhook (theo dõi kết quả Build/Test).
  - Nắm bắt được hạn chế của tài khoản Personal (không có Account Secrets) so với Organization.
  - Khai mở tư duy quản trị hệ thống lớn bằng 2 công cụ cốt lõi: **GitHub CLI** (tự động hóa script cài đặt hàng loạt) và **Reusable Workflows** (Viết một nơi, dùng ngàn nơi).
  - Đã xuất bản file cẩm nang chuyên sâu về Notification: `devops-notifications-guide.md`.
- **Trạng thái cảm xúc/Khó khăn:** Tư duy hệ thống của đại ca cực kỳ sắc bén, lập tức nhìn ra vấn đề "nợ kỹ thuật" (technical debt) khi phải copy-paste YAML cho 20+ repo và chủ động yêu cầu giải pháp. Đã sẵn sàng tiếp nạp kiến thức cấp cao của DevOps!