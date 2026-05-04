# Stack notes — quirks & tips

---

## ASP.NET Core & EF Core
- **Middleware Order**: ExceptionHandler -> HttpsRedirection -> Routing -> Cors -> Auth -> Authorization -> MapControllers.
- **DbContext Factory**: Use `IDbContextFactory` for Singletons (like BackgroundServices).
- **AsNoTracking**: Mặc định cho GET requests để tăng performance.

---

## GraphQL (Hot Chocolate)
- **Projections**: Cần trả `IQueryable<T>` để Hot Chocolate tự generate SQL SELECT tối ưu.
- **Complexity**: Luôn giới hạn `MaxExecutionDepthRule` và `Complexity` từ đầu.

---

## Ollama
- **Local API**: Chạy mặc định tại `http://localhost:11434`.
- **Model Management**: Dùng `ollama run llama3` để tải và test model.
- **Inference**: Có thể dùng qua `LangChain` hoặc gọi trực tiếp HTTP API.

---

## React
- **Vite**: Nhanh hơn Create React App (CRA), ưu tiên dùng.
- **StrictMode**: Luôn bật để phát hiện side-effects.

---

## Background Services
- **Polling Loop**: Dùng `while (!stoppingToken.IsCancellationRequested)` kết hợp `Task.Delay()`.
- **Scope Management**: Luôn tạo `IServiceScope` bên trong `ExecuteAsync` để giải quyết các scoped services (như `DbContext`) trong một singleton background service.
- **Batch Processing**: Dùng `.Take(N)` khi query pending tasks để tránh overload AI/DB.

---

## SignalR
- **Targeting**: Dùng `Groups` với format `EntityName_{Id}` để push notification đúng đối tượng mà không lãng phí traffic broadcast.
- **Interface**: Định nghĩa interface cho notification service trong layer Application, nhưng implement (SignalR) ở layer WebAPI/Infrastructure.

---

## React Native (Expo)
- **Form State**: Dùng `useMemo` để tính toán `canSubmit` từ nhiều điều kiện -> Code sạch hơn là check trong `render`.
- **Image Upload**: Dùng `FormData` kết hợp với `expo-image-picker`. Lưu ý chuẩn hóa `uri`, `name`, và `type` khi append vào FormData trên mobile.
- **Lightweight GraphQL**: Thay vì dùng Apollo, có thể dùng `fetch` wrapper đơn giản để giảm bundle size và kiểm soát headers (JWT) dễ hơn.

---

## Frontend Architecture
- **Feature-based Structure**: Chia thư mục theo `features/[name]/` gồm `api`, `screens`, `components`. Giúp scale project lớn mà không bị rối.
