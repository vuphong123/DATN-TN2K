<div class="sidebar">
    <ul>
        <li><a href="${pageContext.request.contextPath}/app/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/app/products">Products</a></li>
        <li><a href="${pageContext.request.contextPath}/app/about">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/app/contact">Contact</a></li>
    </ul>
</div>

<style>
    .sidebar {
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        height: 100%;
        background-color: #333;
        padding-top: 20px;
    }
    .sidebar ul {
        list-style-type: none;
        padding: 0;
    }
    .sidebar ul li {
        padding: 8px;
        text-align: left;
    }
    .sidebar ul li a {
        color: white;
        text-decoration: none;
        display: block;
    }
    .sidebar ul li a:hover {
        background-color: #575757;
    }
</style>
