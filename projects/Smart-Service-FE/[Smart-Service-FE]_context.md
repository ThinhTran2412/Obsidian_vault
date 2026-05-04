# Smart-Service-FE

## Stack
- **Framework**: React Native (Expo SDK 54)
- **Navigation**: React Navigation 7
- **API**: GraphQL (Lightweight Fetch) + REST (Multipart/FormData)
- **State**: React Hooks + Context API
- **Form**: LabeledInput, ActionButton (Custom UI)

## Mục tiêu
Dự án mobile dành cho 3 đối tượng (Customer, Staff, Agent) với các flow riêng biệt trên cùng một codebase.

## Decisions đã chốt
- [x] Sử dụng- [[skills/patterns#UI/UX — Waterfall Fallback Strategy (High Availability Data)|Waterfall Fallback Strategy]] (nhiều nguồn data cho profile).
- **New**: Cơ chế [[skills/patterns#Architecture — Hybrid Fetching & Reliability Fallback|Hybrid Fetching]] (GraphQL -> REST Fallback) cho màn hình tài khoản.
- Tổ chức code theo [[skills/stack-notes#Frontend (React Native / Expo)|Feature-based Architecture]].
" (Clean Frontend).
- [x] Tích hợp kết quả phân tích AI ngay trên Success Screen của form tạo yêu cầu.

## Retrospective
- [[projects/Smart-Service-FE/[Smart-Service-FE]_retro|Xem bài học rút ra từ dự án]]

## Status
- [x] Distilled to Brain [2026-03-27]
