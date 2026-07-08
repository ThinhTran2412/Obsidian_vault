# PRN232 - Restful Principle

## Project reference
- **Source project path:** `F:\PRN_Folder\PRN232\Management_System_(LMS)_Lab1`
- **Main solution structure:**
  - `PRN232.LMS.API`
  - `PRN232.LMS.Services`
  - `PRN232.LMS.Repositories`

---

## 1. Tổng quan triển khai
Dự án này là một Learning Management System API được tổ chức theo mô hình 3 tầng gồm API / Services / Repositories. Mục tiêu chính là xây dựng một REST-style API có cấu trúc rõ ràng, naming nhất quán, hỗ trợ query linh hoạt, response format thống nhất, và tránh circular reference trong JSON serialization.

API hiện tại đã được triển khai theo hướng RESTful thực dụng, phù hợp cho lab và có thể mở rộng thêm cho use case thực tế.

---

## 2. 3-layer Architecture

### 2.1. API layer
Thư mục `PRN232.LMS.API` chứa:
- Controllers
- Request models
- Response models
- API response wrapper
- Swagger/OpenAPI setup
- Program startup configuration

Vai trò của API layer:
- Nhận request HTTP
- Validate input ở mức cơ bản
- Gọi service layer
- Mapping giữa request/business/response model
- Trả HTTP response phù hợp

### 2.2. Services layer
Thư mục `PRN232.LMS.Services` chứa:
- Business models
- Service interfaces
- Service implementations
- Query helper
- Paging shared models
- Query params
- Mapping profile nội bộ

Vai trò của Services layer:
- Chứa nghiệp vụ ứng dụng
- Xử lý search / sort / paging / include logic
- Mapping entity sang business model
- Không phụ thuộc vào request/response của API

### 2.3. Repositories layer
Thư mục `PRN232.LMS.Repositories` chứa:
- Entity models
- DbContext
- Repository interfaces
- Repository implementations
- Migration files

Vai trò của Repositories layer:
- Truy xuất dữ liệu từ database
- Chỉ xử lý data access
- Không chứa business logic của API
- Không dùng Request/Response model

### 2.4. Kết luận kiến trúc
Mô hình 3 tầng được giữ tương đối rõ ràng:
- Controller không ôm business logic chính
- Repository chỉ lo dữ liệu
- Service là nơi xử lý logic trung gian

---

## 3. Project Naming Convention
Các project tuân theo format yêu cầu:
- `PRN232.LMS.API`
- `PRN232.LMS.Services`
- `PRN232.LMS.Repositories`

Đây là naming convention rõ ràng, nhất quán, và dễ hiểu cho lab / báo cáo.

---

## 4. Database Schema & Seed Data

### 4.1. Bảng dữ liệu chính
Project có đầy đủ các bảng:
- `Semester`
- `Course`
- `Subject`
- `Student`
- `Enrollment`

### 4.2. Quan hệ chính
- `Course` thuộc `Semester`
- `Enrollment` nối giữa `Student` và `Course`
- `Student` có nhiều `Enrollment`
- `Course` có nhiều `Enrollment`

### 4.3. Seed data
Database được seed đầy đủ theo yêu cầu:
- 5 semesters
- 10 subjects
- 20 courses
- 50 students
- 500 enrollments

### 4.4. Nhận xét
Seed data đủ lớn để demo:
- paging
- sorting
- filtering
- nested routes
- expand list API

---

## 5. 4 Model Types
Project có đủ 4 lớp model theo đúng tiêu chí tách biệt:

### 5.1. Entity
Nằm trong `PRN232.LMS.Repositories.Entities`
- `Student`
- `Course`
- `Semester`
- `Subject`
- `Enrollment`

### 5.2. Business Model
Nằm trong `PRN232.LMS.Services.BusinessModels`
- `StudentBM`
- `CourseBM`
- `SemesterBM`
- `SubjectBM`
- `EnrollmentBM`

### 5.3. Request Model
Nằm trong `PRN232.LMS.API.Models.Requests`
- `CreateStudentRequest`
- `UpdateStudentRequest`
- `PatchStudentRequest`
- `CreateCourseRequest`
- `UpdateCourseRequest`
- `PatchCourseRequest`
- `CreateSemesterRequest`
- `UpdateSemesterRequest`
- `CreateSubjectRequest`
- `UpdateSubjectRequest`
- `PatchSubjectRequest`
- `CreateEnrollmentRequest`
- `UpdateEnrollmentRequest`
- `PatchEnrollmentRequest`

### 5.4. Response Model
Nằm trong `PRN232.LMS.API.Models.Responses`
- `StudentResponse`
- `StudentLookupResponse`
- `CourseResponse`
- `CourseLookupResponse`
- `SemesterResponse`
- `SubjectResponse`
- `EnrollmentResponse`
- `EnrollmentItemResponse`

### 5.5. Tuân thủ nguyên tắc
- Repository không dùng Request/Response
- API không trả Entity trực tiếp
- API trả DTO qua mapping

---

## 6. RESTful Endpoint Naming

### 6.1. Resource-based URLs
API dùng resource name dạng danh từ số nhiều:
- `/api/students`
- `/api/courses`
- `/api/semesters`
- `/api/subjects`
- `/api/enrollments`

### 6.2. Không dùng verb trong URL
Không dùng kiểu:
- `getStudent`
- `createCourse`
- `deleteEnrollment`

### 6.3. Đánh giá
Cách đặt tên endpoint của project là đúng hướng REST:
- rõ nghĩa
- dễ đọc
- thống nhất
- phù hợp naming convention của resource-based API

---

## 7. GET by ID

### 7.1. Các endpoint chi tiết
Có các route dạng:
- `GET /api/students/{id}`
- `GET /api/courses/{id}`
- `GET /api/semesters/{id}`
- `GET /api/subjects/{id}`
- `GET /api/enrollments/{id}`

### 7.2. 404 nếu không tồn tại
Nếu resource không tìm thấy, controller trả:
- `404 Not Found`

### 7.3. Tránh circular reference
Project đã chuyển sang hướng an toàn hơn:
- chi tiết resource không nhét cây quan hệ quá sâu
- related data được tách ra qua nested routes khi cần
- lookup DTO được dùng cho quan hệ lồng nhau

### 7.4. Nested routes thay cho expand trong detail endpoint
Các route quan hệ đã được tách riêng:
- `GET /api/courses/{id}/enrollments`
- `GET /api/students/{id}/enrollments`
- `GET /api/semesters/{id}/courses`

### 7.5. Lý do chọn cách này
Cách này:
- rõ nghĩa
- RESTful hơn
- dễ tránh vòng lặp JSON
- dễ kiểm soát payload

---

## 8. List API Capabilities

### 8.1. Các khả năng list API
Danh sách resource hỗ trợ:
- search
- filter logic cơ bản
- sort
- paging
- fields selection
- expand related resources

### 8.2. Query params hiện có
Base query params gồm:
- `Search`
- `Sort`
- `Page`
- `Size`
- `Fields`
- `Expand`

### 8.3. Ví dụ sử dụng
- `GET /api/courses?Expand=semester`
- `GET /api/enrollments?Expand=student,course`
- `GET /api/enrollments?Expand=student`
- `GET /api/students?Sort=fullName_desc`

### 8.4. Kết luận
List API được thiết kế khá mạnh, phù hợp demo lab và gần với thực tế sản phẩm nhỏ.

---

## 9. Pagination Metadata

### 9.1. Metadata có trong response
Paging response chứa:
- `page`
- `pageSize`
- `totalItems`
- `totalPages`

### 9.2. Shared model
Project có `PagedResult<T>` và `PaginationMeta` để chuẩn hóa paging response.

### 9.3. Ý nghĩa
Người dùng API có thể biết:
- đang ở trang nào
- mỗi trang bao nhiêu item
- tổng số item
- tổng số trang

### 9.4. Đánh giá
Đây là thiết kế tốt và phù hợp với REST-style listing.

---

## 10. Response Format & HTTP Status

### 10.1. Response wrapper
Project dùng format thống nhất:
- `success`
- `message`
- `data`
- `errors`

### 10.2. Các status code chính
- `200 OK` cho GET/update thành công
- `201 Created` cho create thành công
- `204 No Content` cho delete thành công
- `400 Bad Request` cho input invalid
- `404 Not Found` cho resource không tồn tại
- `409 Conflict` cho lỗi trùng dữ liệu

### 10.3. Lợi ích
- frontend dễ xử lý
- response đồng nhất
- debug dễ
- phù hợp lab checklist

---

## 11. Docker Deployment

### 11.1. Thành phần Docker
Project có:
- `PRN232.LMS.API/Dockerfile`
- `docker-compose.yml`

### 11.2. Mục tiêu deployment
- database chạy trong container
- API chạy trong container
- có thể demo bằng `docker compose up`

### 11.3. Startup behavior
API có migration startup flow để chờ DB sẵn sàng rồi migrate database.

### 11.4. Đánh giá
Cấu hình đã có, phù hợp yêu cầu lab. Nếu cần demo final, nên chạy thử thực tế `docker compose up` để xác nhận runtime.

---

## 12. Swagger/OpenAPI

### 12.1. Cấu hình
Project đã bật:
- `AddSwaggerGen`
- `UseSwagger`
- `UseSwaggerUI`

### 12.2. Tính năng có sẵn
- listing endpoint
- test API trực tiếp từ Swagger UI
- hiển thị request/response schema
- hiển thị status code docs thông qua `ProducesResponseType`

### 12.3. XML comments
Swagger có hỗ trợ XML comments để mô tả endpoint.

### 12.4. Đánh giá
Swagger được triển khai đúng hướng và đủ cho demo / lab.

---

## 13. Code Quality

### 13.1. Điểm tốt
- naming rõ ràng
- tách lớp tương đối sạch
- controller gọn hơn trước
- repository không dính DTO layer
- response model được tối ưu để tránh circular reference
- có custom helper cho paging/sort/field selection

### 13.2. Error handling
Có xử lý cơ bản cho:
- invalid request
- not found
- conflict
- delete failure

### 13.3. Độ bảo trì
Cấu trúc khá dễ đọc và dễ mở rộng.

### 13.4. Điểm còn có thể cải thiện
- global exception handler chuyên nghiệp hơn
- unit/integration tests
- DTO detail/list riêng biệt hơn nữa nếu muốn production-grade

---

## 14. Nested Routes & Related Resources

### 14.1. Lý do dùng nested routes
Vì các quan hệ cha–con nên được thể hiện rõ bằng URL:
- `/api/courses/{id}/enrollments`
- `/api/students/{id}/enrollments`
- `/api/semesters/{id}/courses`

### 14.2. Lợi ích
- đúng REST hierarchy
- dễ hiểu
- dễ gọi từ frontend
- không phải lạm dụng expand ở detail endpoint

### 14.3. Định hướng hiện tại
Hướng hiện tại là:
- detail endpoint giữ gọn
- list endpoint có expand
- nested route dùng cho quan hệ riêng biệt

---

## 15. Expand Pattern in List APIs

### 15.1. Ví dụ hợp lệ
- `GET /api/enrollments?Expand=student,course`
- `GET /api/courses?Expand=semester`
- `GET /api/enrollments?Expand=student`

### 15.2. Vai trò
Expand dùng cho **list endpoint**, không phải bắt buộc cho detail endpoint.

### 15.3. Đánh giá
Đây là cách triển khai hợp lý nếu kiểm soát được depth và mapping.

---

## 16. Circular Reference Handling

### 16.1. Vấn đề
Khi dùng object graph có quan hệ 2 chiều:
- `Course -> Enrollments -> Course`
- `Student -> Enrollments -> Student`
- `Semester -> Courses -> Semester`

sẽ dễ gặp circular reference khi serialize JSON.

### 16.2. Cách xử lý đã áp dụng
- tách DTO lookup
- không trả entity trực tiếp
- không để detail response chứa relation quá sâu
- dùng nested route thay vì expand quá rộng

### 16.3. Kết quả
JSON response an toàn hơn, ít rủi ro cycle, dễ đọc hơn.

---

## 17. Các endpoint chính đang theo định hướng hiện tại

### 17.1. Courses
- `GET /api/courses`
- `GET /api/courses/{id}`
- `GET /api/courses/{id}/enrollments`
- `POST /api/courses`
- `PUT /api/courses/{id}`
- `PATCH /api/courses/{id}`
- `DELETE /api/courses/{id}`

### 17.2. Students
- `GET /api/students`
- `GET /api/students/{id}`
- `GET /api/students/{id}/enrollments`
- `POST /api/students`
- `PUT /api/students/{id}`
- `PATCH /api/students/{id}`
- `DELETE /api/students/{id}`

### 17.3. Semesters
- `GET /api/semesters`
- `GET /api/semesters/{id}`
- `GET /api/semesters/{id}/courses`
- `POST /api/semesters`
- `PUT /api/semesters/{id}`
- `DELETE /api/semesters/{id}`

### 17.4. Subjects
- `GET /api/subjects`
- `GET /api/subjects/{id}`
- `POST /api/subjects`
- `PUT /api/subjects/{id}`
- `PATCH /api/subjects/{id}`
- `DELETE /api/subjects/{id}`

### 17.5. Enrollments
- `GET /api/enrollments`
- `GET /api/enrollments/{id}`
- `POST /api/enrollments`
- `PUT /api/enrollments/{id}`
- `PATCH /api/enrollments/{id}`
- `DELETE /api/enrollments/{id}`

---

## 18. Tổng kết đánh giá RESTful
Project này là một REST-style API khá tốt cho lab và thực hành.

### Đạt tốt
- resource-based URLs
- HTTP verbs đúng
- status codes hợp lý
- paging/sort/search/expand hỗ trợ tốt
- response format thống nhất
- nested routes rõ ràng
- tránh circular reference
- có Swagger và Docker

### Gần hoàn chỉnh
- detail endpoint gọn, các quan hệ được chuyển sang nested routes
- expand chỉ dùng cho list API

### Mức maturity
Theo Richardson Maturity Model, API này đang ở mức **Level 2**, và chưa cần HATEOAS cho mục tiêu hiện tại.

---

## 19. Ghi chú cho báo cáo
Nếu cần đưa vào báo cáo ngắn gọn, có thể diễn đạt như sau:

> Hệ thống được triển khai theo mô hình 3 tầng (API / Services / Repositories), tuân theo resource-based REST naming, hỗ trợ search/sort/paging/expand cho list API, có nested routes cho resource quan hệ, trả response nhất quán theo wrapper chuẩn, và được triển khai cùng Swagger, Docker, và seed data đầy đủ.

---

## 20. Đường dẫn tham chiếu
- **Project source:** `F:\PRN_Folder\PRN232\Management_System_(LMS)_Lab1`
- **API project:** `F:\PRN_Folder\PRN232\Management_System_(LMS)_Lab1\PRN232.LMS.API`
- **Services project:** `F:\PRN_Folder\PRN232\Management_System_(LMS)_Lab1\PRN232.LMS.Services`
- **Repositories project:** `F:\PRN_Folder\PRN232\Management_System_(LMS)_Lab1\PRN232.LMS.Repositories`

---

## 21. Kết luận cuối
Project đã được tổ chức và triển khai theo hướng RESTful thực dụng, rõ ràng, dễ trình bày trong báo cáo, và có đủ các yếu tố cần thiết cho một bài lab / demo hệ thống quản lý học tập:
- cấu trúc 3 tầng
- schema + seed data đầy đủ
- API naming chuẩn
- list capabilities mạnh
- response format thống nhất
- swagger
- docker
- tránh circular reference
- nested routes cho quan hệ cha–con
