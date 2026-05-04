# Retrospective: Smart-Service-BE

## Thành công
- Trích xuất được pattern AI Reliability cực kỳ giá trị.
- Hiểu cách triển khai Background Service xử lý batch AI task hiệu quả.
- Pattern skeleton giúp quản lý roadmap tính năng tốt.

## Khó khăn & Bài học
- AI có thể hallucinate cho các flag critical -> Cần lớp deterministic override.
- Polling Background Service là lựa chọn tốt cho AI inference vì thời gian xử lý lâu.

## Distillation (MANDATORY)
- [x] Copy pattern "Semi-Deterministic AI" vào `skills/patterns.md`
- [x] Copy pattern "Skeleton" vào `skills/patterns.md`
- [x] Update `skills/mistakes.md` về AI Hallucination flag.
