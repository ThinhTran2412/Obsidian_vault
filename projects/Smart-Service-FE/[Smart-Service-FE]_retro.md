# Retrospective: Smart-Service-FE

## Thành công
- Hệ thống Fallback cho Profile giúp UI không bao giờ bị trống dữ liệu.
- Cấu trúc thư mục mạch lạc, dễ tìm kiếm logic.
- Xử lý upload ảnh cùng metadata qua FormData ổn định trên mobile.

## Khó khăn & Bài học
- GraphQL `me` đôi khi không ổn định tùy môi trường -> Luôn cần fallback sang `getUserById`.
- Chờ AI phân tích ngay sau khi tạo request giúp User cảm thấy hệ thống "sống" và nhận được giá trị tức thì (Safety Advice).

## Distillation (MANDATORY)
- [x] Copy pattern "Waterfall Fallback Strategy" vào `skills/patterns.md`
- [x] Update `skills/stack-notes.md` về React Native Form và Lightweight GraphQL Client.
