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

---

## 4. Kiến thức Medium Level (Level-up)

### 4.1. Các "Ngạch Cấp 1" (Top-level Keys) Mở Rộng
Ngoài bộ tứ cơ bản `name`, `on`, `env`, `jobs`, ở trình độ cao hơn sẽ thường dùng:
- `concurrency`: Quản lý luồng chạy, tự động hủy các luồng cũ đang chạy dở nếu có luồng mới (giúp tiết kiệm tài nguyên server/tiền bạc).
- `permissions`: Quản lý quyền hạn của GITHUB_TOKEN (ví dụ: cấp quyền tự động tạo Release, viết Comment vào Pull Request).
- `defaults`: Đặt cấu hình mặc định cho tất cả các `run` steps (VD: luôn chạy bằng `bash` shell hoặc luôn cd vào thư mục `./src`).
- `run-name`: Tên động cho lịch sử chạy trên giao diện web (VD: `run-name: Deploy app bởi ${{ github.actor }}`).

### 4.2. Cấu Trúc Chi Tiết Bên Trong Một Job
Bên cạnh `runs-on` và `steps` là 2 thứ bắt buộc, một Job thực tế thường được trang bị thêm:
- `needs`: Móc nối thứ tự các job. (VD: `needs: [build-job]` -> Báo hiệu job này phải kiên nhẫn chờ `build-job` chạy xong và thành công mới được bắt đầu).
- `if`: Công tắc điều kiện để quyết định sinh tử của job (VD: chỉ chạy job này nếu người dùng đang push lên nhánh `main`).
- `strategy`: Tuyệt chiêu phân thân (matrix) dùng để chạy test đa môi trường. Ví dụ: test app trên Node v18, v20, v22 cùng một lúc trên các máy ảo song song.
- `outputs`: Cổng xuất dữ liệu, dùng để truyền biến/kết quả từ job này sang job khác.

### 4.3. Giải Ngố Cú Pháp YAML: Object vs Array (Bí quyết trị lỗi Duplicate Key)
- **Chỗ KHÔNG CÓ dấu `-` (Object/Bản đồ):** Dùng để khai báo các thuộc tính tĩnh (Tên: Giá trị). Mỗi cái Tên (Key) **chỉ được xuất hiện duy nhất 1 lần** trong cùng 1 cấp.
- **Chỗ CÓ dấu `-` (Array/Danh sách):** Báo hiệu bắt đầu một phần tử mới trong một danh sách các công việc. 
👉 Đó là lý do tại sao bên trong `steps` lại phải dùng `- name: ...` thay vì `name: ...`. Vì `steps` bản chất là một **chuỗi/danh sách** gồm nhiều bước thực thi nối tiếp nhau. Chữ `-` giúp máy tính phân định rạch ròi đâu là bước 1, đâu là bước 2, nhờ đó chúng ta có thể thoải mái tái sử dụng từ khóa `name` và `run` ở các bước khác nhau mà không sợ máy chửi lỗi trùng lặp (Duplicate key).

### 4.4. Các "Vũ Khí" Thực Chiến Thường Dùng (Kèm Ví Dụ)

**1. `working-directory` (Đặc trị cho Monorepo)**
Thay vì phải gõ `cd` ở mỗi lệnh, ta chốt luôn thư mục làm việc mặc định cho Job đó.
```yaml
jobs:
  build-backend:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./pickic-api # Khóa cứng mục tiêu vào thư mục backend
    steps:
      - uses: actions/checkout@v4
      - name: Chạy build Backend
        run: dotnet build # Nó tự động chạy bên trong ./pickic-api
```

**2. Cầu chì `timeout-minutes` và Kim bài `continue-on-error`**
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    timeout-minutes: 5 # Chạy quá 5 phút là tự động ngắt điện
    steps:
      - name: Quét mã độc râu ria
        run: npm run scan-lint
        continue-on-error: true # Lỡ có fail thì vứt đấy, chạy tiếp bước sau
```

**3. Khối lệnh Terminal đa dòng với dấu `|`**
```yaml
    steps:
      - name: Dọn dẹp và Build
        run: |
          echo "Bắt đầu dọn rác..."
          rm -rf node_modules
          npm install
          echo "Cài đặt hoàn tất!"
```

### 4.5. Giải phẫu Cú pháp Biểu thức `${{ }}` (Expression Syntax)
Cặp ngoặc này **KHÔNG PHẢI** chỉ để chèn biến. Nó là một bộ máy xử lý logic thực thụ của GitHub Actions. Đại ca có thể viết các phép so sánh (==, !=, &&, ||) và gọi các hàm (functions) do GitHub cung cấp ngay bên trong nó.

**Ví dụ thực tế:**
```yaml
steps:
  - name: Bước này cực kỳ kén cá chọn canh
    # Chỉ chạy nếu người dùng tên là 'ThinhTran' VÀ đang ở nhánh 'main'
    if: ${{ github.actor == 'ThinhTran2412' && github.ref == 'refs/heads/main' }}
    run: echo "Đại ca đã xuất hiện!"

  - name: Quét mã hash
    # Hàm hashFiles() cực hay dùng để kiểm tra xem file package.json có bị thay đổi không (dùng để cache)
    run: echo "Mã băm là: ${{ hashFiles('**/package.json') }}"
```
*Các hàm tích hợp sẵn lợi hại nhất:* `contains()`, `startsWith()`, `endsWith()`, `fromJson()`, `hashFiles()`, `success()`, `failure()`.

---

## 5. Quản Lý Bảo Mật: `.env` và GitHub Secrets (Tối Quan Trọng)

### 5.1. Bẫy Tử Thần: Đừng bao giờ nhét `.env` vào Docker Image
Khi GitHub chạy `docker build`, nó đóng gói mã nguồn thành cục Image (Robot). **TUYỆT ĐỐI KHÔNG** được gói file `.env` chứa mật khẩu thật vào trong Image này. Vì nếu lỡ Image bị leak ra ngoài (hoặc dùng public registry), bất kỳ ai cũng có thể đọc được sạch mật khẩu (thông qua lệnh `docker history`). Nhiệm vụ của Image chỉ là chứa Code và Thư viện.

### 5.2. Sự khác biệt giữa GitHub Secrets và `.env` local
- **Ở máy Local (Máy cá nhân & Server VPS thật):** Sử dụng file `.env` bình thường để mồi biến môi trường cho ứng dụng (hoặc container) chạy. File này luôn phải bị đưa vào `.gitignore`.
- **Ở môi trường GitHub Actions:** Vì GitHub không có file `.env`, ta dùng **GitHub Secrets** (Cài đặt trên giao diện Web: `Settings > Secrets and variables > Actions`). Nó đóng vai trò như một "Két sắt đám mây", cung cấp biến tạm thời cho máy ảo của GitHub để phục vụ quá trình Build và Deploy (Ví dụ: cần mật khẩu `DOCKER_PASS` để đăng nhập đẩy Image lên Docker Hub).

### 5.3. Chiến Thuật `.env.example` (Tiêu chuẩn công nghiệp)
Vì file `.env` không được đẩy lên Git, làm sao để người khác (hoặc chính mình lúc deploy lên VPS) nhớ được app cần truyền vào những biến môi trường nào?
👉 **Cách giải quyết:** Tạo file `.env.example` (hoặc `.env.template`) chỉ chứa Tên Biến, bỏ trống phần Giá Trị.
```env
# file .env.example (Được phép push lên GitHub)
DB_HOST=
DB_USER=
DB_PASS=
```
Khi setup lên Server VPS, chỉ cần gõ lệnh `cp .env.example .env` rồi tự tay mở file `.env` điền mật khẩu thật vào. Cực kỳ an toàn và tránh sai sót!
