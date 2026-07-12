# 🔔 Hướng Dẫn Tích Hợp Thông Báo (Discord/Slack/Telegram) Vào DevOps

Tài liệu này lưu trữ các cấu hình chuẩn để gửi thông báo từ GitHub về các nền tảng chat, giúp theo dõi trạng thái dự án (Code push, CI/CD) theo thời gian thực một cách tự động.

## 1. Bản Chất Của Thông Báo Trong DevOps
Các bot thông báo (Discord, Slack, Telegram) trong quy trình CI/CD hoàn toàn **không sử dụng Trí Tuệ Nhân Tạo (AI)** nên không tiêu tốn phí API (như OpenAI hay Claude).
Chúng hoạt động dựa trên cơ chế **Webhook** (gửi một HTTP POST Request mang theo một chuỗi JSON được định dạng sẵn) từ máy chủ GitHub sang máy chủ của ứng dụng chat.

## 2. Kiến Trúc 2 Luồng Thông Báo Tối Ưu (Enterprise Standard)
Để hệ thống hoạt động hiệu quả mà không bị spam, hãy áp dụng chiến thuật tách biệt 2 luồng:

### Luồng 1: GitHub Native Webhook (Chuyên theo dõi hành vi)
- **Mục đích:** Báo cáo chi tiết ai vừa tạo nhánh, push code lên những file nào, hay mở Pull Request mới.
- **Ưu điểm:** KHÔNG cần viết code YAML. Cài đặt 1 lần ăn luôn. Hỗ trợ cho toàn bộ Organization.
- **Cách cài đặt với Discord:**
  1. Lấy link Webhook từ Discord (VD: `https://discord.com/api/webhooks/123/abc`).
  2. Thêm `/github` vào **cuối** link (Thành `.../abc/github`).
  3. Vào GitHub > Settings của Organization (hoặc Repo) > Webhooks > Add webhook.
  4. Paste link vừa chế vào ô *Payload URL*.
  5. Content type chọn: `application/json`. Xong!

### Luồng 2: GitHub Actions (Chuyên chốt sổ CI/CD)
- **Mục đích:** Chỉ lên tiếng khi quy trình Build/Test (CI/CD) đã hoàn tất (Thành công/Thất bại).
- **Cách cài đặt:**
  1. Tạo Secret có tên `DISCORD_WEBHOOK_URL` trong GitHub (Nên tạo ở cấp Organization nếu dùng chung cho nhiều repo).
  2. Dán link Webhook gốc (Không có đuôi `/github`) vào giá trị của Secret.
  3. Copy đoạn code sau vào **bước cuối cùng** trong file YAML CI/CD của bạn:

```yaml
    # Bước chốt sổ: Báo cáo kết quả CI/CD về Discord
    - name: 📢 Báo cáo trạng thái CI/CD
      uses: sarisia/actions-status-discord@v1
      if: always() # Kim bài miễn tử: Các bước trên lỗi thì bước này vẫn được chạy
      with:
        webhook: ${{ secrets.DISCORD_WEBHOOK_URL }}
        status: ${{ job.status }}
        title: "Trạng thái CI/CD: ${{ github.repository }}"
        description: |
          **Đại ca thi triển:** `${{ github.actor }}`
          **Nhánh:** `${{ github.ref_name }}`
          👉 Bấm vào tiêu đề màu xanh bên trên để xem log chi tiết (nếu lỗi).
```

## 3. Quản Lý Quy Mô Lớn (Scale-up cho 20+ Repositories)
Đối với tài khoản cá nhân (Personal Account), GitHub không hỗ trợ tính năng "Account Secrets". Điều đó có nghĩa là bạn phải add Secret bằng tay 20 lần cho 20 repo. Để giải quyết nỗi đau này, giới DevOps dùng 2 tuyệt chiêu sau:

### Tuyệt Chiêu 1: Reusable Workflows (Workflow Dùng Chung)
- **Bản chất:** Giống như viết hàm (Function) trong lập trình.
- **Cách làm:** Tạo 1 kho chứa trung tâm (Centralized Repo) tên là `devops-templates`. Viết toàn bộ luồng CI/CD chuẩn vào đó.
- Ở 20 repo con còn lại, không cần viết lại mã YAML dài dòng, chỉ cần viết 3 dòng "gọi hàm":
```yaml
jobs:
  call-workflow:
    uses: ThinhTran2412/devops-templates/.github/workflows/chuẩn-ci.yml@main
    secrets: inherit # Từ khóa quan trọng: Cho phép mượn Secret truyền sang repo trung tâm
```
- **Lợi ích:** Khi cần đổi chữ thông báo hay đổi màu tin nhắn Discord, chỉ cần sửa 1 dòng code ở `devops-templates`, lập tức 20 repo kia tự động được ăn theo luồng mới nhất.

### Tuyệt Chiêu 2: Tự Động Gắn Secret Bằng CLI (Dành cho Local)
Sử dụng sức mạnh của vòng lặp Bash và GitHub CLI (`gh`) để bắn Secret vào hàng loạt repo cùng lúc.
```bash
# 1. Định nghĩa link Webhook
MY_WEBHOOK="https://discord.com/api/webhooks/123/abc"

# 2. Vòng lặp lấy danh sách 100 repo của tài khoản ThinhTran2412 và nhét Secret vào từng repo một
gh repo list ThinhTran2412 --limit 100 --json nameWithOwner -q ".[].nameWithOwner" | \
xargs -I {} gh secret set DISCORD_WEBHOOK_URL -b "$MY_WEBHOOK" -R {}
```
Chỉ mất 5 giây để máy tính tự động thay bạn click chuột vào 20 repo!
