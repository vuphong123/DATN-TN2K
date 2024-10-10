<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/static/Admin/css/order/product.css">
<div class="san-pham">
    <h2>Danh sách sản phẩm</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Tên sản phẩm</th>
            <th>Giá</th>
        </tr>
        <c:forEach var="sanPham" items="${sanPhams}">
            <tr>
                <td>${sanPham.id}</td>
                <td>${sanPham.tenSanPham}</td>
                <td>${sanPham.gia}</td>
            </tr>
        </c:forEach>
    </table>
</div>
