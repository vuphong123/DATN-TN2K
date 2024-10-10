<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Application Layout</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="/static/Admin/css/layout/sidebar.css">
</head>
<body>
<div class="sidebar">
    <div class="logo">
        <img src="/images/logoMenu.jpg" alt="logo" class="logo">
    </div>
    <ul>
        <li><a href="<c:url value='/pages?page=home'/>"><i class="fa-solid fa-house"></i>Home</a></li>
        <li><a href="<c:url value='/pages?page=nhanvien'/>"><i class="fa-solid fa-user"></i>  Quản lý nhân viên</a></li>
        <li><a href="<c:url value='/pages?page=khachhang'/>"><i class="fa-duotone fa-solid fa-users"></i>Quản lý khách hàng</a></li>
        <li><a href="<c:url value='/pages?page=products'/>"><i class="fa-sharp fa-solid fa-shirt"></i> Quản lý sản phẩm</a></li>
        <li class="nav-item">
            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePages1"
               aria-expanded="false" aria-controls="collapsePages1">
                <i class="fa-solid fa-tag"></i>
                <span> Quản lý danh mục</span>
            </a>
            <div id="collapsePages1" class="collapse" aria-labelledby="headingPages" data-bs-parent="#accordionSidebar">
                <div class="bg-white py-2 collapse-inner rounded">
                    <a class="collapse-item" href="<c:url value='/pages?page=danhmuc'/>">Quản lý danh mục</a><br>
                    <a class="collapse-item" href="<c:url value='/pages?page=thuonghieu'/>">Quản lý kiểu dáng</a><br>
                    <a class="collapse-item" href="<c:url value='/pages?page=thuonghieu'/>"></i>Quản lý thương hiệu</a><br>
                    <a class="collapse-item" href="<c:url value='/pages?page=kichthuoc'/>"></i>Quản lý kích thước</a><br>
                    <a class="collapse-item" href="<c:url value='/pages?page=thuonghieu'/>"></i>Quản lý màu sắc</a><br>
                </div>
            </div>
        </li>
        <li><a href="<c:url value='/pages?page=giamgia'/>"><i class="fa-solid fa-percent"></i> Quản lý giảm giá</a></li>
        <li><a href="/index"><i class="fa-solid fa-cart-shopping"></i>Quản lý đơn hàng</a></li>

    </ul>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>

