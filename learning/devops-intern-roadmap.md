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

- [ ] **CI (Continuous Integration):** Tích hợp Linting, Unit Testing, quét lỗi code tự động vào pipeline trước khi build.

  - 🔗 *Ghi chú:*

- [ ] **Quản Lý Secret:** Cách lưu trữ mật khẩu an toàn trong GitHub Secrets/GitLab Variables, phòng chống lộ API Key.

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
- **Trạng thái cảm xúc/Khó khăn:** Đại ca tiếp thu cực kỳ nhạy bén các khái niệm của hệ thống Enterprise, tư duy logic rất tốt. Sẵn sàng cho những thử thách hóc búa hơn!