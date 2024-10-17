<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý hóa đơn</title>
    <link rel="stylesheet" href="/static/Admin/css/order/giaodien.css">
</head>

<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>
</div>
<div class="container" id="container">
    <h2>Quản lý hóa đơn</h2>
    <div class="invoice-list">
        <h3>Danh sách hóa đơn chờ</h3>
        <table>
            <thead>
            <tr>
                <th>STT</th>
                <th>Mã hóa đơn</th>
                <th>Ngày tạo</th>
                <th>Khách hàng</th>
                <th>Chọn</th>
                <th>Xóa</th>
            </tr>
            </thead>
            <tbody id="invoice-table">
            </tbody>
        </table>
        <button id="create-invoice">Tạo hóa đơn chờ</button>
    </div>

    <!-- Bảng chi tiết sản phẩm của hóa đơn -->
    <div class="invoice-detail">
        <h3>Chi tiết hóa đơn</h3>
        <table class="product-table">
            <thead>
            <tr>
                <th>STT</th>
                <th>Tên sản phẩm</th>
                <th>Ảnh</th>
                <th>Size</th>
                <th>Màu sắc</th>
                <th>Số lượng</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody id="product-list">
            <!-- Sản phẩm sẽ được thêm vào đây -->
            </tbody>
        </table>
    </div>

    <button id="btn-choose-product">Chọn sản phẩm</button>

    <div class="invoice-summary">
        <h3>Thông tin hóa đơn</h3>
        <div class="summary-content">
            <div class="summary-row">
                <label for="invoice-code">Mã hóa đơn:</label>
                <span id="invoice-code">HDxxxx</span>
            </div>
            <div class="summary-row">
                <label for="customer-name">Khách hàng:</label>
                <input type="text" id="customer-name" placeholder="Nhập tên khách hàng" readonly>
                <button id="btn-choose-customer">Chọn khách hàng</button>
            </div>

            <div class="summary-row">
                <label for="salesperson">Nhân viên bán hàng:</label>
                <input type="text" id="salesperson" placeholder="Nhập tên nhân viên" readonly>
                <button id="btn-choose-salesperson">Chọn nhân viên</button>
            </div>

            <div class="summary-row">
                <label for="order-note">Ghi chú đơn hàng:</label>
                <textarea id="order-note" placeholder="Ghi chú thêm đơn hàng"></textarea>
            </div>

            <div class="summary-row">
                <label for="payment-method">Hình thức thanh toán:</label>
                <select id="payment-method">
                    <option value="cash">Trả tiền mặt tại quầy</option>
                    <option value="card">Thẻ ngân hàng</option>
                    <option value="online">Thanh toán online</option>
                </select>
            </div>

            <div class="summary-row">
                <label for="promo-code">Khuyến mãi:</label>
                <input type="text" id="promo-code" placeholder="Nhập mã khuyến mãi" readonly>
                <button id="btn-choose-promo">Chọn khuyến mãi</button>
            </div>

            <div class="summary-row">
                <strong>Tổng cộng thanh toán:</strong>
                <span id="total-payment" class="total-price">= 0 VNĐ</span>
            </div>

            <div class="summary-row">
                <label for="customer-payment">Khách hàng đưa tiền:</label>
                <input type="number" id="customer-payment" placeholder="0" min="0">
            </div>

            <div class="summary-row">
                <strong>Trả lại khách:</strong>
                <span id="return-money" class="return-money">= 0 VNĐ</span>
            </div>

            <div class="summary-row">
                <strong>Khách hàng còn thiếu:</strong>
                <span id="remaining-money" class="remaining-money">= 0 VNĐ</span>
            </div>
        </div>
    </div>

    <div class="save-order">
        <button id="save-order-btn">Lưu đơn hàng</button>
    </div>

    <div id="product-modal" class="modal hidden">
        <div class="modal-table">
            <h3>Danh sách sản phẩm</h3>
            <input type="text" id="product-search" placeholder="Tìm kiếm sản phẩm...">
            <table class="product-list-table">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên sản phẩm</th>
                    <th>Ảnh</th>
                    <th>Size</th>
                    <th>Số lượng</th>
                    <th>Màu sắc</th>
                    <th>Đơn giá</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody id="product-table">
                <tr>
                    <td>1</td>
                    <td>Giày thể thao nam</td>
                    <td></td>
                    <td>XL</td>
                    <td>10</td>
                    <td>Đen</td>
                    <td>850,000đ</td>
                    <td><button class="btn-add-product" data-id="1" data-name="Giày thể thao nam"
                                data-price="850000" data-size="XL" data-color="Đen">Chọn</button></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Giày chạy bộ nữ</td>
                    <td></td>
                    <td>XXL</td>
                    <td>1</td>
                    <td>Trắng</td>
                    <td>970,000đ</td>
                    <td><button class="btn-add-product" data-id="2" data-name="Giày chạy bộ nữ"
                                data-price="970000" data-size="XXL" data-color="Tráng">Chọn</button></td>
                </tr>

                </tbody>
            </table>
            <button id="btn-close-product-modal">Đóng</button>
        </div>
    </div>

    <div id="customer-modal" class="modal hidden">
        <div class="modal-table">
            <h3>Danh sách khách hàng</h3>
            <table class="customer-list-table">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên khách hàng</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody id="customer-table">
                <tr>
                    <td>1</td>
                    <td>Nguyễn Văn A</td>
                    <td><button class="btn-add-customer" data-name="Nguyễn Văn A">Chọn</button></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Trần Thị B</td>
                    <td><button class="btn-add-customer" data-name="Trần Thị B">Chọn</button></td>
                </tr>

                </tbody>
            </table>
            <button id="btn-close-customer-modal">Đóng</button>
        </div>
    </div>

    <div id="salesperson-modal" class="modal hidden">
        <div class="modal-table">
            <h3>Danh sách nhân viên</h3>
            <table class="salesperson-list-table">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên nhân viên</th>
                    <th>Ảnh</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody id="salesperson-table">
                <tr>
                    <td>1</td>
                    <td>Nguyễn Văn C</td>
                    <td></td>
                    <td><button class="btn-add-salesperson" data-name="Nguyễn Văn C">Chọn</button></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Trần Thị D</td>
                    <td></td>
                    <td><button class="btn-add-salesperson" data-name="Trần Thị D">Chọn</button></td>
                </tr>

                </tbody>
            </table>
            <button id="btn-close-salesperson-modal">Đóng</button>
        </div>
    </div>

    <div id="promo-modal" class="modal hidden">
        <div class="modal-table">
            <h3>Danh sách khuyến mãi</h3>
            <table class="promo-list-table">
                <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã khuyến mãi</th>
                    <th>Giảm giá (%)</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody id="promo-table">
                <tr>
                    <td>1</td>
                    <td>KM10</td>
                    <td>10%</td>
                    <td><button class="btn-add-promo" data-code="KM10">Chọn</button></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>KM20</td>
                    <td>20%</td>
                    <td><button class="btn-add-promo" data-code="KM20">Chọn</button></td>
                </tr>
                </tbody>
            </table>
            <button id="btn-close-promo-modal">Đóng</button>
        </div>
    </div>
</div>

<script src="/static/Admin/js/giaodien.js"></script>
</body>

</html>