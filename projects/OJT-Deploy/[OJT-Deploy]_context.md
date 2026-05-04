# OJT-Deploy (Microservices)

## Stack
- **Orchestration**: Docker Compose
- **Reverse Proxy**: Nginx (Alpine)
- **Messaging**: RabbitMQ
- **Database**: PostgreSQL (External - Render)
- **Inter-service**: gRPC + REST

## Mục tiêu
Triển khai hệ thống Microservices phức tạp với khả năng mở rộng và giao tiếp nội bộ hiệu quả.

## Decisions đã chốt
- [x] Sử dụng Nginx làm [[skills/patterns#DevOps — API Gateway (Nginx Regex Routing)|API Gateway]] điều hướng Regex (Regex Routing).
- [x] Tách biệt kênh Communication: Public (REST) via Nginx, Internal ([[skills/patterns#DevOps — gRPC & REST Coexistence (Docker)|gRPC]]) via Docker Network.
- [x] Sử dụng Health Checks (`service_healthy`) để kiểm soát thứ tự khởi động (IAM -> Lab -> ...).
- [x] Mount trực tiếp `dist` folder của FE vào Nginx để hot-deploy giao diện.
- [x] Tự động hóa Migration liên dịch vụ (Distributed Migration).

## Tunneling (ngrok)
- Dùng ngrok để expose port 80 (Nginx) ra môi trường public để test mobile hoặc integration bên ngoài.

## Retrospective
- (Chưa có dữ liệu - [[projects/OJT-Deploy/retro|Khởi tạo file Retro]])

## Status
- [x] Distilled to Brain [2026-03-27]
