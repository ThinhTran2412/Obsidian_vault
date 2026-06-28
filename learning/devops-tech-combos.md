# Bách Khoa Toàn Thư: Các Combo Công Nghệ DevOps "Bất Bại"

> **🤖 LƯU Ý DÀNH CHO AI (SYSTEM PROMPT & WRITING GUIDELINES)**:
> Bất cứ khi nào người dùng yêu cầu bổ sung một "Combo" hoặc Kỹ thuật mới vào file này, AI **PHẢI TUÂN THỦ NGHIÊM NGẶT** các quy tắc sau:
> 1. **Độ sâu kỹ thuật (Deep Tech):** Tuyệt đối không giải thích hời hợt (ví dụ: "Nginx dùng để làm proxy"). Phải giải thích sâu ở tầng mạng/hệ thống (ví dụ: "Nginx nhận HTTP packet ở port 80, bóc tách header, terminate SSL ở layer 7, rồi forward request dưới dạng TCP packet tới port nội bộ của container").
> 2. **Kiến trúc & Luồng dữ liệu (Data Flow):** Phải có mô tả luồng đi của dữ liệu từng bước 1 -> 2 -> 3 một cách logic.
> 3. **Cấu hình mẫu (Template Code):** Bắt buộc phải có file cấu hình mẫu (YAML, Nginx conf, Dockerfile...) chuẩn chỉ, thực tế và có comment giải thích từng dòng quan trọng.
> 4. **Sao chép y hệt cấu trúc của Template dưới đây** cho các bài viết mới.

---

## 📋 [TEMPLATE CỐ ĐỊNH CHUẨN CHO AI MỖI KHI VIẾT BÀI MỚI]

### 🚀 Combo [Số]: [Tên Combo - Ví dụ: Tên Công Nghệ A + Công Nghệ B]
**1. Mục đích giải quyết bài toán gì?**
- Phân tích nỗi đau (Pain point) của hệ thống thông thường nếu không dùng combo này.
- Combo này giải quyết triệt để nỗi đau đó ra sao.

**2. Giải phẫu kiến trúc & Luồng dữ liệu (Data Flow):**
- **Bước 1:** Dữ liệu/Lệnh bắt đầu từ đâu?
- **Bước 2:** Thành phần A làm gì với dữ liệu đó (Giao thức nào? Port bao nhiêu?).
- **Bước 3:** Thành phần B nhận kết quả và thực thi như thế nào?

**3. Tại sao chúng sinh ra là dành cho nhau? (Technical Fit):**
- Giải thích độ tương thích về mặt kỹ thuật (Ví dụ: Đều dùng giao thức gRPC, đều tối ưu bộ nhớ chia sẻ...).

**4. Source Code / Cấu hình Mẫu (Có tính thực chiến cao):**
- (Chèn các block code YAML, Bash, JSON... kèm chú thích chi tiết).

---

## 🚀 Combo 1: Tự Động Hóa Triển Khai Siêu Nhẹ (Lightweight Pull-Model GitOps)
**Công nghệ:** GitHub Actions (CI) + Docker Registry + Watchtower (CD) + Docker Compose

**1. Mục đích giải quyết bài toán gì?**
- **Nỗi đau:** Jenkins quá nặng (ngốn >1GB RAM chỉ để đứng chực chờ code). Việc dùng Webhook bắt server mở port (NAT/Firewall) nhận lệnh từ ngoài vào gây rủi ro bảo mật (DDoS, lộ endpoint).
- **Giải pháp:** Bẩy toàn bộ việc biên dịch (Build) nặng nhọc lên mây (GitHub Actions). Server chỉ làm đúng 1 việc nhẹ nhất là KÉO (Pull) image đã đóng gói sẵn về chạy. Máy ảo 1GB RAM vẫn gánh mượt mà.

**2. Giải phẫu kiến trúc & Luồng dữ liệu (Data Flow):**
- **Bước 1 (CI - Trên Mây):** Dev gõ lệnh `git push`. GitHub Actions trigger, tự động cấp phát máy ảo `ubuntu-latest`, chạy `docker build` ra một cục Image, rồi gọi API (HTTPS/Layer 7) đẩy cục Image đó vào kho lưu trữ (Docker Hub hoặc GHCR).
- **Bước 2 (Kho lưu trữ):** Docker Hub lưu trữ Image với một cái thẻ tag mới (ví dụ: `my-app:v1.2` hoặc `my-app:latest`).
- **Bước 3 (CD - Dưới Local Server):** Container **Watchtower** đang chạy ngầm trên Server Ubuntu của bạn. Cứ mỗi 5 phút (tùy chỉnh), nó gọi HTTP GET qua API của Docker Hub để đối chiếu mã SHA256 của Image đang chạy và Image trên mạng.
- **Bước 4 (Thực thi):** Nếu mã SHA256 khác nhau, Watchtower tự động gửi tín hiệu `SIGTERM` (mã ngắt hệ thống Linux) để tắt app cũ một cách duyên dáng (Graceful Shutdown), tải Image mới về, và gọi Docker Engine (qua file sock `/var/run/docker.sock`) khởi động lại app y hệt cấu hình `docker-compose.yml` ban đầu. Mọi thứ tự động 100%.

**3. Tại sao chúng sinh ra là dành cho nhau?**
- Watchtower sinh ra chuyên để "nhìn trộm" Docker Registry. Bằng cách mount (gắn) trực tiếp socket của Docker (`/var/run/docker.sock`) vào trong Watchtower, nó có đặc quyền tối cao của Docker Daemon để điều khiển mọi container khác mà không cần cài đặt thêm phần mềm quản lý nào. Nó biến một máy Ubuntu bình thường thành một hệ thống tự auto-update cực kỳ lười biếng nhưng hiệu quả.

**4. Source Code / Cấu hình Mẫu:**

**File `docker-compose.yml` (Đặt trên Server Ubuntu):**
```yaml
services:
  # 1. Ứng dụng của bạn
  api-service:
    image: thinhdev/my-api:latest  # Tên image trên DockerHub
    container_name: pickic_api
    ports:
      - "8080:80"
    restart: unless-stopped

  # 2. Vệ binh Watchtower (Sát thủ giấu mặt)
  watchtower:
    image: containrrr/watchtower
    container_name: watchtower
    volumes:
      # BẮT BUỘC: Cấp quyền cho Watchtower điều khiển Docker Engine
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      # Thời gian đi tuần tra (Tính bằng giây) - Ví dụ: 300s = 5 phút
      - WATCHTOWER_POLL_INTERVAL=300
      # Dọn dẹp rác (Image cũ) sau khi update để tránh đầy ổ cứng server
      - WATCHTOWER_CLEANUP=true
      # Chỉ định rõ tên container nó cần theo dõi (nếu bỏ dòng này nó sẽ quét toàn bộ máy)
      - WATCHTOWER_SCOPE=pickic_api
    restart: always
```

**File `.github/workflows/deploy.yml` (Đặt trên source code GitHub):**
```yaml
name: Build and Push Docker Image

on:
  push:
    branches:
      - main # Khi merge/push lên main thì chạy

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Đăng nhập vào DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build và Push Image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          # Đẩy lên với tag latest, Watchtower dưới server sẽ tự nhận diện bản latest mới
          tags: thinhdev/my-api:latest 
```
