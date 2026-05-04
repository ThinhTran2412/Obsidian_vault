# SWP - BloodLine DNA

## Overview
Nền tảng quản lý và phân tích dữ liệu di truyền (DNA), tích hợp quản lý nhân sự và chatbot AI.
**Chi tiết kỹ thuật**: [[projects/SWP-BloodLine/[SWP-BloodLine]_architecture|Chi tiết Kiến trúc DNA & AI]]

## Stack
- **Backend**: ASP.NET Core (.NET 8)
- **Frontend**: Vite + React
- **AI**: Python FastAPI + LangChain + Ollama (phi-2)
- **Database**: SQL Server
- **CI/CD**: GitHub Actions

## Key Features & Patterns
- **[[skills/patterns#Algorithm — Fairness-based Scheduling|Fairness Scheduling]]**: Thuật toán phân ca tự động cân bằng workload cho nhân viên lab.
- **[[skills/patterns#AI Architecture — Local RAG (Retrieval Augmented Generation)|Local RAG Chatbot]]**: Tra cứu kiến thức di truyền từ tài liệu nội bộ bằng LangChain và FAISS.
- **Google OAuth**: Tích hợp đăng nhập bên thứ 3.

## Decisions đã chốt
- [x] Sử dụng model AI nhỏ (`phi-2`) chạy local để đảm bảo quyền riêng tư dữ liệu DNA.
- [x] Không giới hạn số ca tối đa/tháng nhưng bắt buộc phải ưu tiên người ít ca nhất trước.
- [x] Tách biệt logic AI sang một microservice riêng (`ai_service`).

## Retrospective
- (Chưa có dữ liệu - [[projects/SWP-BloodLine/retro|Khởi tạo file Retro]])

## Status
- [x] Distilled to Brain [2026-03-27]
