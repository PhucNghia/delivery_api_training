# delivery_api_training
## Ý tưởng
Xây dựng một api giao hàng, dành cho các lập trình viên khi làm các website bán hàng.
## Các chức năng
* Xác thực tài khoản
* Quản lý đơn hàng
* Thay đổi trạng thái đơn hàng bằng webhook
## Hướng xử lý
* Xác thực tài khoản
  * Người dùng gửi yêu cầu lấy token, yêu cầu bao gồm username, password
  * Xác thực bằng gem devise, và tạo token bằng gem jwt
* Quản lý đơn hàng
  * Thêm, sửa, xóa đơn hàng
  * Lấy danh sách các đơn hàng
  * Một đơn hàng có các thông tin:
    1. Thông tin điểm gửi hàng
    2. Thông tin điểm nhận hàng
    3. Danh sách các sản phẩm
* Thay đổi trạng thái đơn hàng bằng webhook
  * Người dùng cập nhật callback link.
  * Dùng sidekiq đặt một khoảng thời gian sẽ thay đổi trạng thái của đơn hàng.
  * Gửi kết quả đến người dùng.
