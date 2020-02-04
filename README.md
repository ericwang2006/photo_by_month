# 把照片按月份文件夹分类整理

## 使用示例

```
forfiles /p "C:\photos" /s /m *.*  /c "cmd /c c:\photo_by_month\filebydate.exe @path"
```