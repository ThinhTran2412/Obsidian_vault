# Patterns

---

## REST API — Response wrapper chuẩn
**Dùng khi**: mọi API endpoint
**Tránh khi**: streaming response, file download
**Implementation**:
```csharp
public class ApiResponse<T>
{
    public bool Success { get; set; }
    public T? Data { get; set; }
    public string? Message { get; set; }
    public List<string>? Errors { get; set; }

    public static ApiResponse<T> Ok(T data) =>
        new() { Success = true, Data = data };

    public static ApiResponse<T> Fail(string message) =>
        new() { Success = false, Message = message };
}
```
**Học từ**: baseline pattern — dùng ngay từ đầu mọi project

---

## REST API — Global exception handler
**Dùng khi**: mọi project ASP.NET Core
**Tránh khi**: không cần — luôn dùng
**Implementation**:
```csharp
// Program.cs
app.UseExceptionHandler(err => err.Run(async ctx =>
{
    var ex = ctx.Features.Get<IExceptionHandlerFeature>()?.Error;
    ctx.Response.StatusCode = ex switch
    {
        NotFoundException => 404,
        UnauthorizedException => 401,
        ValidationException => 422,
        _ => 500
    };
    await ctx.Response.WriteAsJsonAsync(ApiResponse<object>.Fail(ex?.Message ?? "Server error"));
}));
```
**Học từ**: tránh try-catch lặp ở mọi controller

---

## GraphQL — DataLoader tránh N+1
**Dùng khi**: resolve related entities trong GraphQL (luôn cần)
**Tránh khi**: không — N+1 là lỗi phổ biến nhất GraphQL
**Implementation**:
```csharp
public class UserByIdDataLoader : BatchDataLoader<int, User>
{
    private readonly IDbContextFactory<AppDbContext> _factory;

    public UserByIdDataLoader(
        IDbContextFactory<AppDbContext> factory,
        IBatchScheduler scheduler,
        DataLoaderOptions options) : base(scheduler, options)
    {
        _factory = factory;
    }

    protected override async Task<IReadOnlyDictionary<int, User>> LoadBatchAsync(
        IReadOnlyList<int> keys, CancellationToken ct)
    {
        await using var db = await _factory.CreateDbContextAsync(ct);
        return await db.Users
            .Where(u => keys.Contains(u.Id))
            .ToDictionaryAsync(u => u.Id, ct);
    }
}
```
**Học từ**: bắt buộc nếu dùng GraphQL với EF Core

---

## React — Custom Hook for Data Fetching
**Dùng khi**: Gọi API từ component React
**Tránh khi**: simple fetch không cần re-use
**Implementation**:
```javascript
export const useFetch = (url) => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch(url)
      .then(res => res.json())
      .then(data => setData(data))
      .catch(err => setError(err))
      .finally(() => setLoading(false));
  }, [url]);

  return { data, loading, error };
};
```
**Học từ**: baseline React pattern.

---

## AI — Semi-Deterministic Architecture (Reliability Layer)
**Dùng khi**: AI output cần độ tin cậy tuyệt đối cho các flag quan trọng (security, safety).
**Tránh khi**: task sáng tạo không cần tính chính xác tuyệt đối.
**Implementation**:
Không tin hoàn toàn vào AI result. Kết hợp AI output với logic nghiệp vụ cứng:
1. **AI Output**: Lấy phân tích sơ bộ.
2. **Deterministic Check**: Kiểm tra keywords (ví dụ: "cháy", "nổ") hoặc query metadata từ DB.
3. **Override**: Nếu 1 trong 2 điều kiện trên thỏa mãn -> Force set flag = true bất kể AI nói gì.
**Học từ**: [[projects/Smart-Service-BE/context|Smart-Service-BE]] [2026-03]

---

## Architecture — Skeleton Pattern (Phased Rollout)
**Dùng khi**: Muốn build logic trước khi dependency (migartion, API ngoài) sẵn sàng.
**Tránh khi**: Project nhỏ, làm xong ngay được.
**Implementation**:
Viết code logic hoàn chỉnh nhưng:
1. Comment out các phần liên quan đến DB migration chưa có.
2. Trả về giá trị trung tính (ví dụ: `return 0` cho distance) ở các method chưa kích hoạt.
3. Thêm ghi chú chuẩn bị cho bước "Uncomment" tiếp theo.
**Học từ**: [[projects/Smart-Service-BE/context|Smart-Service-BE]] [2026-03]

---

## UI/UX — Waterfall Fallback Strategy (High Availability Data)
**Dùng khi**: Hiển thị thông tin quan trọng (ví dụ: profile user) mà API có thể không ổn định hoặc có nhiều nguồn dữ liệu.
**Tránh khi**: Dữ liệu cần real-time tuyệt đối và không có nguồn thay thế.
**Implementation**:
Thực hiện load dữ liệu theo thứ tự ưu tiên giảm dần:
1. **Primary Source**: Gọi API chính (ví dụ: GraphQL `me`).
2. **Secondary Source**: Nếu primary fail/null, gọi API fallback (ví dụ: `getUserById(id)`).
3. **Local Cache/Session**: Nếu cả 2 fail, dùng dữ liệu đã lưu trong auth session hoặc local storage.
**Học từ**: [[projects/Smart-Service-FE/context|Smart-Service-FE]] [2026-03]

---

## AI Architecture — Async Analysis & Real-time Safety Alerts
**Dùng khi**: Phân tích AI tốn thời gian (5-30s) nhưng cần phản hồi kết quả khẩn cấp (cảnh báo an toàn) ngay khi xong.
**Tránh khi**: AI output không quan trọng hoặc cần phản hồi tức thì (dưới 1s).
**Implementation**:
1. **Async Queue**: Lưu request với status `AwaitingAnalysis`, trả về `202 Accepted` ngay.
2. **BackgroundWorker**: Polling hoặc Job Queue (Hangfire/RabbitMQ) gọi AI phân tích.
3. **SignalR Push**: Ngay khi AI xong, dùng SignalR để push `SafetyAdviceReceived` trực tiếp theo `GroupId = RequestId`.
4. **Client-side**: Lắng nghe event và hiển thị Pop-up cảnh báo ngay lập tức.
**Học từ**: [[projects/Smart-Service-BE/context|Smart-Service-BE]] [2026-03]

---

## Architecture — Hybrid Fetching & Reliability Fallback
**Dùng khi**: Sử dụng GraphQL cho read-heavy screens nhưng cần đảm bảo module "Account/Profile" luôn chạy kể cả khi GraphQL server gặp lỗi context.
**Tránh khi**: Chỉ có 1 nguồn data duy nhất.
**Implementation**:
1. **Primary**: Gọi GraphQL (ví dụ: query `me`).
2. **Secondary**: Nếu GraphQL trả về null/error, gọi REST API hoặc Query direct `getUserById(id)`.
3. **Tertiary**: Nếu tất cả fail, dùng dữ liệu cached trong Auth Session.
**Học từ**: [[projects/Smart-Service-FE/context|Smart-Service-FE]] [2026-03]

---

## DevOps — Multi-Repo Orchestration (Script-based)
**Dùng khi**: Quản lý nhiều microservices hoặc project riêng biệt (BE, FE) trong môi trường local/dev mà không muốn dùng công cụ nặng nề (Docker Compose cho mọi thứ).
**Tránh khi**: Production environment lớn — nên dùng CI/CD chuẩn (Github Actions, K8s).
**Implementation**:
1. **Config File**: Dùng 1 file `.conf` hoặc `.csv` lưu list: `FolderName|RepoURL|Branch`.
2. **Setup Script**: Viết script (.bat/.sh) để:
   - Loop qua config file.
   - `git clone` hoặc `git pull` tự động.
   - **Auto-build**: Check sự hiện diện của `*.csproj` (để chạy `dotnet`) hoặc `package.json` (để chạy `npm`) để thực hiện build tự động.
**Học từ**: [[projects/Smart-Service-System/context|Smart-Service-System]] [2026-03]

---

## DevOps — API Gateway (Nginx Regex Routing)
**Dùng khi**: Microservices architecture. Cần một entry point duy nhất cho Frontend.
**Tránh khi**: Project đơn lẻ (monolith).
**Implementation**:
Dùng `location` vớiRegex trong Nginx để điều hướng request về đúng service:
```nginx
location ~ ^/api/(Auth|User|Roles)(/.*|$) {
    proxy_pass http://iam_service$request_uri;
    # ... standard proxy headers ...
}
```
Giúp Frontend chỉ cần gọi `http://domain/api/...` mà không cần quan tâm service nào xử lý.
**Học từ**: [[projects/OJT-Deploy/context|OJT-Deploy]] [2026-03]

---

## DevOps — gRPC & REST Coexistence (Docker)
**Dùng khi**: Service cần cả REST API (cho FE/Public) và gRPC (cho Inter-service communication).
**Tránh khi**: Chỉ dùng một loại giao thức.
**Implementation**:
1. **Expose ports**: REST trên 8080, gRPC trên 8081.
2. **Nginx**: Chỉ proxy port 8080 ra ngoài.
3. **Internal gRPC**: Các service gọi nhau qua `http://service-name:8081`.
4. **C# Config**: Force HTTP/2 unencrypted cho gRPC nội bộ:
   `DOTNET_SYSTEM_NET_HTTP_SOCKETSHTTPHANDLER_HTTP2UNENCRYPTEDSUPPORT=1`
**Học từ**: [[projects/OJT-Deploy/context|OJT-Deploy]] [2026-03]

---

## DevOps — Distributed Migration (Multi-service EF Core)
**Dùng khi**: Microservices với databases riêng biệt. Cần đồng bộ migration cho tất cả services.
**Tránh khi**: Chỉ có 1 database duy nhất.
**Implementation**:
Viết script (.bat/.sh) thực hiện "Build -> Update" tuần tự:
```batch
dotnet ef database update ^
  --project MyService.Infrastructure/MyService.Infrastructure.csproj ^
  --startup-project MyService.API/MyService.API.csproj ^
  --configuration Development
```
Lợi ích:
1. Đảm bảo đúng thứ tự migration (nếu có dependency).
2. Tự động kiểm tra Tooling (dotnet-ef) và cài đặt nếu thiếu.
3. Báo cáo Success/Fail tập trung cho toàn bộ hệ thống.
**Học từ**: [[projects/OJT-Deploy/context|OJT-Deploy]] [2026-03]

---

## AI Architecture — Human-in-the-loop (HITL) Review
**Dùng khi**: AI thực hiện các task quan trọng (Y tế, Tài chính). Cần con người kiểm chứng trước khi commit.
**Tránh khi**: Task không quan trọng (recommendation engine).
**Implementation**:
1. **Trigger**: Backend gọi AI API (Python/FastAPI) truyền data.
2. **Intermediate Status**: Backend cập nhật status là "Reviewed By AI" và lưu kết quả vào vùng tạm (TempData).
3. **Manual Action**: Nhân viên (Staff/Doctor) xem kết quả AI -> Chỉnh sửa hoặc nhấn "Confirm".
4. **Final Commit**: Khi confirm mới chính thức cập nhật database chính.
**Học từ**: [[projects/OJT-Laboratory/context|OJT-Laboratory]] [2026-03]

---

## Architecture — Event-driven Monitoring (RabbitMQ)
**Dùng khi**: Cần tách biệt logic xử lý chính và logic monitoring/logging để không làm chậm hệ thống.
**Tránh khi**: Hệ thống quá nhỏ, thêm MQ làm tăng độ phức tạp.
**Implementation**:
1. **Publisher**: Main service (Lab) bắn event lên RabbitMQ ngay sau khi thực hiện action.
2. **Consumer**: Monitoring service lắng nghe event để ghi log, phân tích hoặc phát cảnh báo.
Giúp hệ thống Lab chạy "mượt" hơn vì không phải đợi logging hoàn tất.
**Học từ**: [[projects/OJT-Laboratory/context|OJT-Laboratory]] [2026-03]

---

## AI Architecture — Local RAG (Retrieval Augmented Generation)
**Dùng khi**: Cần xây dựng chatbot hỏi đáp dựa trên bộ tài liệu nội bộ mà không muốn lộ dữ liệu ra ngoài (Data Privacy).
**Tránh khi**: Dữ liệu quá lớn (hàng triệu bản ghi) — cần VectorDB chuyên dụng (Chroma, Pinecone).
**Implementation**:
1. **Embeddings**: Dùng `GPT4AllEmbeddings` (chạy local) để vector hóa văn bản.
2. **Vector Store**: Dùng `FAISS` để lưu trữ và search similarity cực nhanh.
3. **Prompt**: Truyền đoạn văn bản tìm được làm `Context` vào prompt gửi LLM.
4. **LLM**: Dùng các model nhỏ như `phi-2`, `tinyllama` qua Ollama để latency thấp.
**Học từ**: [[projects/SWP-BloodLine/context|SWP-BloodLine]] [2026-03]

---

## Algorithm — Fairness-based Scheduling
**Dùng khi**: Phân công ca làm việc (Shift Assignment) đảm bảo công bằng và không bị kiệt sức.
**Tránh khi**: Ưu tiên năng suất/kỹ năng hơn là sự công bằng.
**Implementation**:
1. **Conflict Check**: Loại nhân viên trùng ngày hoặc làm ca liên tiếp (Afternoon ngày trước -> Morning ngày sau).
2. **Fairness Sort**: `OrderBy(u => u.TotalShiftsInMonth)`. Luôn ưu tiên người có tổng số ca (đã gán + gợi ý) thấp nhất.
3. **Round-Robin**: Kết hợp index để xoay tua nếu tổng số ca bằng nhau.
**Học từ**: [[projects/SWP-BloodLine/context|SWP-BloodLine]] [2026-03]

---

## Architecture — Standardized Microservice Layering (Clean Architecture)
**Dùng khi**: Xây dựng hệ thống microservice quy mô vừa và lớn, yêu cầu bảo trì cao và dễ testing.
**Trình tự Layer**:
1. **Domain**: Chứa Entities, Value Objects, Domain Exceptions. Không phụ thuộc bất kỳ layer nào.
2. **Application**: Chứa Commands/Queries (MediatR), Handlers, DTOs, Mappers, và Interfaces (IRepository, IService).
3. **Infrastructure**: Implement các Interfaces từ Application (EF Core Context, Repositories, gRPC Clients, AI Clients).
4. **WebAPI/Presentation**: Controllers, Hubs, Middlewares, Program.cs. Phụ thuộc vào tất cả các layer trên.

---

## Engineering — Dependency Injection (DI) Extension Pattern
**Dùng khi**: Để giữ cho `Program.cs` gọn gàng và phân tách trách nhiệm đăng ký service cho từng layer.
**Implementation**:
1. Mỗi layer (Application, Infrastructure) tạo một class `DependencyInjection.cs`.
2. Sử dụng `IServiceCollection` extension method.
**Cấu trúc chuẩn**:
```csharp
// Application Layer
public static IServiceCollection AddApplication(this IServiceCollection services) {
    services.AddMediatR(cfg => cfg.RegisterServicesFromAssembly(typeof(DependencyInjection).Assembly));
    services.AddAutoMapper(Assembly.GetExecutingAssembly());
    services.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());
    return services;
}

// Infrastructure Layer
public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration) {
    services.AddDbContext<AppDbContext>(options => ...);
    services.AddScoped<IUserRepository, UserRepository>(); // Luôn dùng Scoped cho Repository
    return services;
}
```
**Quy tắc Lifetime**:
- `Transient`: Services nhẹ, không giữ state, MediatR handlers.
- `Scoped`: Repository, DbContext, Services nghiệp vụ.
- `Singleton`: Cache, Configuration, Background Workers.
**Học từ**: [[projects/OJT-Laboratory/context|OJT-Laboratory]] & [[projects/Smart-Service-BE/context|Smart-Service-BE]] [2026-03]

---

## Database — Multi-Schema Isolation Pattern
**Dùng khi**: Nhiều microservices dùng chung 1 database instance để tiết kiệm chi phí nhưng cần cô lập dữ liệu về mặt luận lý (Logical Isolation).
**Implementation**:
1. Đặt `SchemaName` vào static property hoặc configuration.
2. Tại `OnModelCreating`, cấu hình `modelBuilder.HasDefaultSchema(schemaName)`.
3. Chỉ định schema cho Migration History Table để tránh ghi đè lịch sử của service khác.
**Học từ**: [[projects/OJT-Laboratory/context|OJT-Laboratory]] [2026-03]

---

## Algorithm — Greedy Fairness Selection
**Dùng khi**: Phân bổ tài nguyên hoặc công việc sao cho số lượng công việc của các cá thể trong tập hợp luôn ở mức chênh lệch thấp nhất.
**Implementation**:
1. **Dynamic Counting**: Luôn tính toán số lượng công việc hiện tại dựa trên `Database + Future Suggestions`.
2. **Greedy Sort**: `SortBy(totalCount)`. Luôn gán cho đối tượng có count thấp nhất.
3. **Round-Robin Tiebreak**: Nếu count bằng nhau, dùng vòng lặp index để xoay tua.
**Học từ**: [[projects/SWP-BloodLine/context|SWP-BloodLine]] [2026-03]
