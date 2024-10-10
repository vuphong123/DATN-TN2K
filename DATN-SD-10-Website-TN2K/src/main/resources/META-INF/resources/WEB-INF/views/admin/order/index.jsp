<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hệ thống quản lý hóa đơn</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link rel="stylesheet" href="/static/Admin/css/order/index.css">
</head>
<body>
<div class="wrapper">
    <jsp:include page="/WEB-INF/views/admin/layout/sidebar.jsp"/>
</div>
    <div class="content">
        <div class="container">
        <!-- Container bên trái chứa bảng hóa đơn chờ và bảng sản phẩm -->
        <div class="left-container">
            <!-- Bảng hóa đơn chờ (phía trên) -->
            <div class="hoa-don-cho">
                <jsp:include page="hoadoncho.jsp"/>
            </div>

            <!-- Bảng sản phẩm (phía dưới) -->
            <div class="san-pham">
                <jsp:include page="sanpham.jsp"/>
            </div>
        </div>

        <!-- Bảng chi tiết hóa đơn (bên phải toàn bộ) -->
        <div class="chi-tiet-hoa-don">
            <jsp:include page="hoadonchitiet.jsp"/>
        </div>
    </div>
    </div>
</body>
</html>
