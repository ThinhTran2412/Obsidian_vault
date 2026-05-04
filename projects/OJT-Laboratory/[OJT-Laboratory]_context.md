# OJT Laboratory Project

## Ecosystem Overview
Hệ thống quản lý phòng xét nghiệm y khoa với quy trình AI Review và giám sát tự động.
**Chi tiết kỹ thuật**: [[projects/OJT-Laboratory/[OJT-Laboratory]_architecture|Chi tiết Kiến trúc Microservices]]

## Key Components
1.  **Front_End**: React/Vite/Tailwind. UI tập trung vào Dashboard (`recharts`, `mui/x-charts`). Quản lý state bằng `zustand`.
2.  **IAM_Service**: Identity & Access Management. JWT Auth + Refresh Token. RBAC chi tiết.
3.  **Laboratory_Service**: Core business. Quản lý bệnh nhân, chỉ định xét nghiệm và kết quả. Tích hợp AI Review.
4.  **Monitoring_Service**: Theo dõi hệ thống qua RabbitMQ events.
5.  **Simulator_Service**: Giả lập dữ liệu xét nghiệm cho Testing/Demo.
6.  **WareHouse_Service**: Quản lý vật tư y tế.

## Tech Stack Patterns
- **CQRS**: Phân tách Command/Query sử dụng MediatR.
- **Clean Architecture**: Domain -> Application -> Infrastructure -> API.
- **AI Bridge**: C# Http Client <-> Python FastAPI (AI Engine).
- **Communication**: Sync (gRPC), Async (RabbitMQ), Edge (Nginx Gateway).

## Decisions đã chốt
- [x] Áp dụng mô hình [[skills/patterns#AI Architecture — Human-in-the-loop (HITL) Review|Human-in-the-loop]] cho kết quả AI xét nghiệm.
- [x] Sử dụng gRPC internal cho hiệu năng cao giữa các service.
- [x] [[skills/patterns#Architecture — Event-driven Monitoring (RabbitMQ)|Event-driven monitoring]] qua RabbitMQ.

## Retrospective
- (Chưa có dữ liệu - [[projects/OJT-Laboratory/retro|Khởi tạo file Retro]])

## Status
- [x] Deep Distilled to Brain [2026-03-27]
