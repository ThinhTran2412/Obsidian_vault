# Cơ bản về GitHub Actions & Cú pháp YAML

Tài liệu này giải thích các thành phần cốt lõi của một file YAML dùng trong CI/CD (đặc biệt là GitHub Actions) để bạn có cái nhìn tổng quan và cấu trúc phân nhánh của nó.

## 0. Sơ đồ Cây (Tree List) Tổng quan
Dưới đây là sơ đồ cây gồm tất cả các "ngạch" (keys) cơ bản và hay dùng nhất. Hãy nhìn lướt qua để hình dung toàn bộ cấu trúc trước khi đi vào chi tiết bên dưới nhé:

```text
📄 workflow.yml
 ├── name: "Tên hiển thị của Workflow"
 │
 ├── on:  (Sự kiện kích hoạt - Bắt buộc)
 │    ├── push:
 │    │    └── branches: [ main, develop ]
 │    ├── pull_request:
 │    │    └── branches: [ main ]
 │    ├── schedule:
 │    │    └── cron: "0 0 * * *"
 │    └── workflow_dispatch: (Nút bấm thủ công)
 │
 ├── env: (Biến môi trường dùng chung toàn file - Tùy chọn)
 │    ├── BIEN_1: "Gia tri 1"
 │    └── BIEN_2: "Gia tri 2"
 │
 └── jobs: (Nơi chứa các đầu việc - Bắt buộc)
      │
      └── <job_id>: (Ví dụ: build-web, test-app...)
           ├── name: "Tên hiển thị của Job"
           ├── needs: [ job_id_khac ]  (Job này cần job kia chạy xong mới chạy)
           ├── runs-on: ubuntu-latest  (Loại máy ảo mượn để chạy - Bắt buộc)
           ├── env: (Biến môi trường riêng cho job này)
           │
           └── steps: (Danh sách các bước thực hiện - Bắt buộc)
                │
                ├── - name: "Bước 1: Checkout code"
                │     uses: actions/checkout@v4   (Dùng tool có sẵn)
                │
                ├── - name: "Bước 2: Cài thư viện"
                │     run: npm install            (Tự gõ lệnh Terminal)
                │     working-directory: ./src    (Thư mục thực thi lệnh)
                │
                └── - name: "Bước 3: Lấy secret"
                      env:
                        API_KEY: ${{ secrets.MY_KEY }} (Lấy biến mật từ GitHub)
                      run: echo "Đang kết nối API..."
```
---


## 1. Trả lời câu hỏi: "Cái `name` sẽ hiển thị ở đâu?"

Trong file YAML, thuộc tính `name` không có tác dụng về mặt logic chạy code. Nó hoàn toàn dành cho **Con Người (Developer)** đọc.

- `name` ở cấp cao nhất (ngoài cùng): Sẽ hiển thị làm **Tiêu đề của quy trình (Workflow)** trên giao diện web của GitHub (trong tab **Actions**).
- `name` ở bên trong `steps`: Sẽ hiển thị làm **Tên của từng bước nhỏ** khi bạn bấm vào xem log chi tiết trên GitHub. Giúp bạn biết chính xác bước nào đang chạy, hoặc nếu bị lỗi (chữ thập đỏ) thì biết ngay lỗi ở bước "name" nào.

---

## 2. Các "Ngạch" (Cấp bậc) cơ bản trong file YAML của CI/CD

File YAML cấu trúc theo dạng cây (Parent - Child) và dùng **khoảng trắng thụt lề** (spaces) để xác định ai là cha, ai là con. Dưới đây là 4 nhánh (ngạch) gốc quan trọng nhất:

### Nhánh gốc 1: `name` (Tên quy trình)
Đây là nhãn dán cho toàn bộ quy trình.

```yaml
name: Tự động Build Ứng dụng Bán Hàng
```

### Nhánh gốc 2: `on` (Sự kiện kích hoạt / Công tắc)
Nơi bạn định nghĩa **Khi nào** quy trình này được phép chạy.

**Các phần tử con thường gặp:**
- `push`: Kích hoạt khi có người đẩy code mới lên.
  - Con của push là `branches`: Chỉ định nhánh nào được áp dụng (VD: main, develop).
- `pull_request`: Kích hoạt khi có người xin gộp code.
- `schedule`: Hẹn giờ chạy (giống báo thức). VD: Chạy vào lúc 12h đêm mỗi ngày.
- `workflow_dispatch`: Tạo một cái nút trên web GitHub để bạn **bấm thủ công** (rất tiện khi test).

**Ví dụ thực tế:** (Chỉ chạy khi push lên nhánh main HOẶC khi bạn tự bấm nút)
```yaml
on:
  push:
    branches:
      - main
  workflow_dispatch: 
```

### Nhánh gốc 3: `env` (Biến môi trường - Tùy chọn)
Giống như việc bạn khai báo hằng số dùng chung cho toàn bộ quy trình.

```yaml
env:
  NODE_VERSION: "22"
  PROJECT_NAME: "PicKic App"
```

### Nhánh gốc 4: `jobs` (Các phân xưởng / Đầu việc)
Đây là "trái tim" của file. Nó định nghĩa những việc thực sự sẽ được làm. Bạn có thể có nhiều jobs chạy song song (VD: 1 job test web, 1 job test mobile).

**Các phần tử con bắt buộc của 1 Job:**
- **Job ID** (Tên biến của job, VD: `build-web`, `deploy-server`): Khai báo tên đầu việc. Không được có khoảng trắng.
  - `runs-on`: Khai báo loại máy ảo sẽ mượn (VD: `ubuntu-latest`, `windows-latest`).
  - `steps`: Danh sách các bước nhỏ cần làm. Đây là một **Mảng (Array)**, mỗi phần tử của mảng được bắt đầu bằng dấu gạch ngang `-`.

**Bên trong `steps` có gì?**
Mỗi bước (`-`) thường có một trong 2 vũ khí sau:
1. `run`: Chạy một lệnh Terminal (Command Line) y hệt như bạn gõ lệnh vào máy tính.
2. `uses`: Mượn một "công cụ" được người khác viết sẵn để xài, khỏi mắc công tự code. (Gọi là Action).

**Ví dụ thực tế:**
```yaml
jobs:
  kiem-tra-code-job: # Tên biến của Job
    runs-on: ubuntu-latest # Thuê máy ảo Linux

    steps: # Bắt đầu danh sách các việc cần làm
      # Bước 1: Dùng đồ mượn (uses) để lấy code từ GitHub về máy ảo
      - name: "Bước 1: Lấy mã nguồn"
        uses: actions/checkout@v4

      # Bước 2: Dùng đồ mượn (uses) để cài đặt NodeJS
      - name: "Bước 2: Cài NodeJS"
        uses: actions/setup-node@v4
        with:
          node-version: "22" # Dùng tham số with để cấu hình cho đồ mượn

      # Bước 3: Tự gõ lệnh (run) để cài đặt thư viện
      - name: "Bước 3: Cài thư viện NPM"
        run: npm install

      # Bước 4: Tự gõ lệnh (run) để chạy kiểm tra
      - name: "Bước 4: Chạy test"
        run: npm run test
```

---

## 3. Tổng kết bằng Ví dụ Thực tế

Bạn hãy tưởng tượng bạn là **Quản đốc nhà máy (GitHub)**:
- `on`: Bạn ra luật "Cứ 8h sáng (`schedule`) là khởi động máy".
- `jobs`: Bạn lập 2 nhóm thợ. Nhóm A (`job 1`) đóng gói sản phẩm, nhóm B (`job 2`) dán tem bảo hành. Hai nhóm này mượn 2 cái bàn làm việc khác nhau (`runs-on: ubuntu`).
- `steps`: Trưởng nhóm cầm tờ giấy có các gạch đầu dòng (`-`). Đầu tiên lấy dụng cụ có sẵn (`uses`), sau đó tự tay làm các công đoạn (`run`). Và mỗi bước đều ghi rõ đang làm gì (`name`) để quản đốc dễ theo dõi tiến độ trên bảng điện tử (Giao diện Web).
