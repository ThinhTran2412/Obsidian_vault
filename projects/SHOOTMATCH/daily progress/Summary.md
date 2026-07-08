# SHOOTMATCH — Daily Progress Summary

## Mục đích của file này
File này dùng để giúp bất kỳ AI nào bắt đầu làm việc với dự án SHOOTMATCH nắm nhanh:
- dự án đang ở giai đoạn nào
- đã làm gì rồi
- đang thiếu gì
- cần ưu tiên gì tiếp theo
- phải cập nhật gì sau mỗi lần hoàn thành công việc

## Trạng thái dự án hiện tại
SHOOTMATCH đang là một dự án matching cho ngành nhiếp ảnh, gồm:
- ứng dụng mobile cho khách hàng và nhiếp ảnh gia
- backend API/GraphQL/SignalR
- tài liệu dự án và nhật ký tiến độ trong vault Obsidian

## Những gì đã triển khai gần đây
### Mobile app
- Thiết kế lại màn `ServiceManagementScreen` theo hướng nghệ thuật hơn, rõ ràng hơn.
- Sửa màn `PProfileScreen` để hiển thị quote tốt hơn và cập nhật lại sau khi lưu.
- Tối ưu giao diện phần quote và các section hồ sơ nhiếp ảnh gia.

### Backend
- Sửa luồng cập nhật hồ sơ nhiếp ảnh gia để tránh ghi đè `PasswordHash` thành null.
- Sửa repository để giữ nguyên dữ liệu nhạy cảm khi upsert hồ sơ.
- Làm cho Swagger dễ truy cập hơn trong môi trường phát triển.
- Sửa lỗi Swagger liên quan upload file multipart/form-data.

### Tài liệu / Vault
- Cập nhật `README.md` bằng tiếng Việt.
- Thêm link trực tiếp tới các tài liệu trong `Vault_ShootMatch`.
- Tạo thư mục `daily progress` để ghi lại tiến độ theo ngày.

## Những điểm cần lưu ý khi tiếp tục làm việc
- Phải kiểm tra kỹ các luồng update profile để tránh mất dữ liệu trong DB.
- UI của nhiếp ảnh gia cần giữ phong cách tối, nghệ thuật nhưng vẫn dễ đọc.
- Khi sửa xong tính năng nào, cần cập nhật lại file tiến độ trong thư mục này.
- Nếu thay đổi API hoặc dữ liệu, cần đồng bộ lại mobile, backend và tài liệu vault.

## Cách cập nhật sau mỗi lần hoàn thành việc
Sau khi làm xong một task, AI tiếp theo nên cập nhật file này theo mẫu:

### YYYY-MM-DD
- Làm gì:
- Sửa file nào:
- Kết quả:
- Vấn đề còn lại:
- Việc tiếp theo:

## Checklist cho AI mới vào project
- Đọc `README.md`.
- Đọc các file trong `Vault_ShootMatch/manual` để hiểu kiến trúc.
- Đọc các file log trong `Vault_ShootMatch` để nắm lịch sử thay đổi.
- Kiểm tra các màn chính trong `ShootMatch.Mobile`.
- Kiểm tra backend API và GraphQL khi cần sửa dữ liệu.

## Ghi chú cuối
File này là điểm vào nhanh cho mọi AI làm việc tiếp trên dự án. Mục tiêu là luôn giữ nó ngắn gọn, chính xác và cập nhật sau mỗi đợt triển khai.
