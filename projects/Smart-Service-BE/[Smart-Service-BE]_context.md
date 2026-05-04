# Smart-Service-BE

## Stack
- **Frontend**: N/A (Backend only analysis)
- **Backend**: C# / ASP.NET Core (.NET 8.0)
- **Database**: PostgreSQL (Entity Framework Core)
- **GraphQL**: Hot Chocolate 13.x/14.x
- **Real-time**: SignalR
- **AI**: Ollama (Qwen2.5-7B)

## Mục tiêu
Hệ thống quản lý dịch vụ thông minh (Smart Service) tích hợp AI để phân tích yêu cầu tự động và đưa ra cảnh báo an toàn thời gian thực.

## Decisions đã chốt
- [x] Sử dụng Clean Architecture (Domain, Application, Infrastructure, WebAPI).
- [x] Áp dụng [[skills/patterns#AI — Semi-Deterministic Architecture (Reliability Layer)|Semi-Deterministic AI Architecture]] kết hợp logic keyword cứng.
- [x] Sử dụng [[skills/patterns#Architecture — Skeleton Pattern (Phased Rollout)|Skeleton Pattern]] để phát triển tính năng song song với tiến độ DB.
- [x] **New**: Hệ thống [[skills/patterns#AI Architecture — Async Analysis & Real-time Safety Alerts|Async AI Analysis]] kết hợp **SignalR Hub** để đẩy cảnh báo an toàn thời gian thực.

## Retrospective
- [[projects/Smart-Service-BE/[Smart-Service-BE]_retro|Xem bài học rút ra từ dự án]]

## Status
- [x] Distilled to Brain [2026-03-27]
