<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/static/Admin/css/order/order.css">
<div class="hoa-don-cho">
    <h2>Danh sách hóa đơn chờ</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Ngày tạo</th>
            <th>Trạng thái</th>
            <th>Tổng tiền</th>
        </tr>
        <c:forEach var="hoaDonCho" items="${hoaDonChos}">
            <tr>
                <td>${hoaDonCho.id}</td>
                <td>${hoaDonCho.ngayTao}</td>
                <td>${hoaDonCho.trangThai}</td>
                <td>${hoaDonCho.tongTien}</td>
            </tr>
        </c:forEach>
    </table>
    <form action="/tao-hoa-don-cho" method="post">
        <button type="submit">Tạo hóa đơn chờ mới</button>
    </form>
</div>

