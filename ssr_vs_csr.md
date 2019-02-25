|| SERVER-SIDE RENDERING        | CLIENT-SIDE RENDERING  |
|---| ------------- |:-------------:|
|Cách hoạt động| Server sẽ xử lý các request của người dùng và trả về nội dung phù hợp, Trình duyệt chỉ cần hiển thị nội dung được trả về | Server chỉ cần trả về  mã nguồn js và các dữ liệu thô, Trình duyệt sẽ đảm nhận việc xử lý dữ liệu và hiển thị |
|Ưu điểm|Tải trang ban đầu nhanh hơn|Ứng dụng hoạt động mượt mà hơn, vì code chạy trên trình duyệt, không cần load đi loại lại nhiều lần |
||Công cụ tìm kiếm có thể thu thập dữ liệu trang web dễ  dàng để SEO tốt hơn.|Giảm tải việc xử lý trên server |
|Nhược điểm|Lượng request lên server rất nhiều, do mọi tác vụ đều phải xử lý lại trên server và render lại HTML |Thời gian tải trang ban đầu lâu |
||Tương tác với trang web không phong phú |SEO trang web kém nế |
