# Mistakes & lessons

---

## [C# / EF Core] N+1 query — lỗi phổ biến nhất

**Triệu chứng**: API chậm khi có related data, SQL Profiler thấy hàng trăm query giống nhau
**Nguyên nhân**: loop qua list rồi query từng item, hoặc GraphQL resolve từng field riêng
**Fix REST**:
```csharp
// SAI — N+1
var orders = await _db.Orders.ToListAsync();
foreach (var o in orders)
    o.Customer = await _db.Customers.FindAsync(o.CustomerId); // query mỗi vòng!

// ĐÚNG — 1 query
var orders = await _db.Orders
    .Include(o => o.Customer)
    .ToListAsync();
```
**Fix GraphQL**: luôn dùng DataLoader (xem patterns.md#graphql--dataloader)
**Phòng tránh**: bật EF Core logging trong dev, check số lượng query trước khi merge

---

## [C#] Async deadlock — .Result hoặc .Wait() trong sync context

**Triệu chứng**: API hang hoàn toàn, không có exception, timeout sau vài giây
**Nguyên nhân**: gọi `.Result` hoặc `.Wait()` trên Task trong ASP.NET context
**Fix**:
```csharp
// SAI — deadlock
var result = _service.GetDataAsync().Result; // DEADLOCK

// ĐÚNG
var result = await _service.GetDataAsync();
```
**Phòng tránh**: cấm `.Result` và `.Wait()` trong codebase, dùng Roslyn analyzer

---

## [EF Core] SaveChanges trong loop

**Triệu chứng**: import 1000 records mất 30 giây
**Nguyên nhân**: gọi SaveChangesAsync() trong vòng lặp — mỗi lần là 1 round-trip DB
**Fix**:
```csharp
// SAI
foreach (var item in items)
{
    _db.Products.Add(item);
    await _db.SaveChangesAsync(); // 1000 round-trips!
}

// ĐÚNG — batch
_db.Products.AddRange(items);
await _db.SaveChangesAsync(); // 1 round-trip
```
**Phòng tránh**: SaveChangesAsync chỉ gọi 1 lần sau khi xong tất cả thay đổi trong unit of work

---

## [AI] Tin tưởng hoàn toàn vào AI Flags (Hallucination)

**Triệu chứng**: Hệ thống bỏ sót các trường hợp nguy cấp (safety/security) vì AI không nhận diện được.
**Nguyên nhân**: Quá phụ thuộc vào `IsDanger` flag trả về từ LLM (vốn có tính xác suất/hallucination).
**Fix**: Dùng deterministic override (xem patterns.md#ai--semi-deterministic-architecture). Kết hợp keyword matching và database metadata.
**Phòng tránh**: Coi AI output là "hint", không phải "fact" cho các quyết định critical.
