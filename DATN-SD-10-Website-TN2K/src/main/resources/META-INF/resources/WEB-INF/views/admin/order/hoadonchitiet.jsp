<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/static/Admin/css/order/orderdetail.css">
<div class="chi-tiet-hoa-don">
    <h2>Chi tiết hóa đơn</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Tên sản phẩm</th>
            <th>Số lượng</th>
            <th>Giá</th>
        </tr>
        <c:forEach var="chiTiet" items="${chiTietHoaDons}">
            <tr>
                <td>${chiTiet.id}</td>
                <td>${chiTiet.sanPham.tenSanPham}</td>
                <td>${chiTiet.soLuong}</td>
                <td>${chiTiet.sanPham.gia}</td>
            </tr>
        </c:forEach>
    </table>
</div>
