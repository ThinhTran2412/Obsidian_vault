# Smart-Service-System

## Orchestration
- **Source Control**: Git (Multi-repo)
- **Primary Tool**: Custom Batch/Shell scripts (`setup.bat`, `setup.sh`)
- **Config**: `services.conf` (Central registry of services)

## Mục tiêu
Tự động hóa việc cài đặt và cập nhật toàn bộ hệ sinh thái Smart-Service (nhiều repo BE/FE) chỉ bằng 1 câu lệnh.

## Decisions đã chốt
- [x] Sử dụng mô hình Multi-repo để tách biệt code BE và FE.
- [x] Sử dụng script thuần để orchestration (Clone -> Build -> Update) giúp giảm dependency vào tool bên thứ 3 cho dev environment.
- [x] Hỗ trợ đa nền tảng (Windows & Linux) qua cặp script song song (.bat & .sh).

## Retrospective
- (Chưa có dữ liệu - [[projects/Smart-Service-System/retro|Khởi tạo file Retro]])

## Status
- [x] Distilled to Brain [2026-03-27]
