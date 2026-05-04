# Agent instructions — D:\Obsidian\Brain

## QUY TẮC LẬP KẾ HOẠCH (PLANNING RULES) — IMPORTANT!
- **Ngôn ngữ**: Mọi kế hoạch (Implementation Plan), danh sách công việc (Task List) và báo cáo (Walkthrough) phải được viết **HOÀN TOÀN BẰNG TIẾNG VIỆT**.
- **Mô tả**: Kế hoạch phải có mô tả đầy đủ, chi tiết từng bước, nêu rõ lý do thực hiện và tác động của thay đổi.
- **Tính minh bạch**: Chia nhỏ các thay đổi theo từng file và thư mục.

## Bước 1: Tư duy hệ thống (Personas & Distilled)
Trước khi bắt đầu bất cứ task nào, hãy đọc để hiểu vai trò và các kiến thức đã chắt lọc:
- [[_agents/personas|Personas]] → Lựa chọn mode làm việc (Architect, Dev, hay Learner).
- [[memory/distilled|Distilled Knowledge]] → Nắm bắt các tinh hoa và bài học cốt lõi từ các dự án trước.

## Bước 2: Kỹ năng và Lỗi cần tránh (Skills)
Internalize các file sau để đảm bảo chất lượng code:
- [[skills/patterns|patterns.md]]      → Áp dụng pattern phù hợp.
- [[skills/mistakes|mistakes.md]]      → Tránh lặp lại lỗi cũ.
- [[skills/decisions|decisions.md]]     → Nhất quán với các quyết định kiến trúc cũ.
- [[skills/stack-notes|stack-notes.md]]   → Các lưu ý về C# / EF Core / GraphQL / React / Ollama.

## Bước 3: Đọc bối cảnh dự án (Context)
Truy cập vào đúng file context của dự án đang thực hiện:
- [[projects/Smart-Service-BE/[Smart-Service-BE]_context|Smart-Service-BE Context]]
- [[projects/Smart-Service-FE/[Smart-Service-FE]_context|Smart-Service-FE Context]]
- [[projects/Smart-Service-System/[Smart-Service-System]_context|Smart-Service-System Context]]
- [[projects/OJT-Deploy/[OJT-Deploy]_context|OJT-Deploy Context]]
- [[projects/OJT-Laboratory/[OJT-Laboratory]_context|OJT-Laboratory Context]]
- [[projects/SWP-BloodLine/[SWP-BloodLine]_context|SWP-BloodLine Context]]
- [[projects/_template/[Template]_context|Dự án mới (Template)]]

## Stack mặc định
- **Backend**: C# / ASP.NET Core (.NET 8+)
- **ORM**: Entity Framework Core
- **GraphQL**: Hot Chocolate 14.x
- **Frontend**: React (Vite / Next.js)
- **Auth**: JWT + Refresh Token
- **Validation**: FluentValidation
- **Logging**: Serilog
- **AI/LLM**: Ollama (local)

## Rules khi sinh code C#
- Luôn dùng async/await — không dùng .Result hoặc .Wait()
- Luôn truyền CancellationToken xuống async method
- **Architecture Standard**: Tuân thủ nghiêm ngặt [[skills/patterns#Architecture — Standardized Microservice Layering (Clean Architecture)|Clean Architecture]] và [[skills/patterns#Engineering — Dependency Injection (DI) Extension Pattern|DI Extension Pattern]].
- Không inject DbContext vào Singleton service — dùng IDbContextFactory
- Dùng AsNoTracking() cho read-only query
- Dùng ApiResponse<T> wrapper cho mọi REST endpoint
- Không expose exception detail ra client trong production
- Không dùng magic strings — tạo static class constants

## Rules khi làm GraphQL
- Luôn dùng DataLoader cho related entities — không resolve trực tiếp
- Trả IQueryable (không ToListAsync) khi dùng [UseProjection]
- Mutation chỉ trả payload tối giản (ID + status), không trả full entity
- Cấu hình depth limit và complexity limit từ đầu

## Rules khi làm React
- Dùng Functional Components + Hooks
- Ưu tiên Tailwind CSS cho styling
- Quản lý state đúng chỗ (Local state, Context API, hoặc Redux/Zustand nếu cần)
- Handle loading/error states cho mọi async call

## Rules khi review code
- Check xem có N+1 query không (xem mistakes.md)
- Check middleware order trong Program.cs
- Check SaveChangesAsync có bị gọi trong loop không
- Cảnh báo nếu thấy pattern có trong mistakes.md

## Bước 4: Sau khi xong task (MANDATORY)
1. **Append vào Memory**: [[memory/session-log|session-log.md]]
   ```
   ## [YYYY-MM-DD] [PROJECT] — [tóm tắt việc đã làm]
   Lesson: [nếu học được gì mới]
   ```
2. **Update Skills**: Nếu phát hiện pattern mới hoặc lỗi mới → ghi vào `skills/` tương ứng.
3. **Cập nhật Retrospective**: Nếu hoàn thành một milestone lớn, cập nhật vào node `[Tên project]_retro.md` tương ứng.
4. **Confirm with User**: LUÔN hỏi user: **"Tôi đã hoàn thành task này. Bạn có muốn tôi ghi nhận lại kiến thức, cách fix hoặc pattern mới nào từ quá trình này vào Brain không?"**

---
Quay lại tương ứng: [[Brain]]
