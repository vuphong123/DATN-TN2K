use master
go
-- Kiểm tra db TN2K4 đã tồn tạo hay chưa nếu tồn tại thì xóa nó đi
if EXISTS ( select name from sys.databases where name = N'TN2K4' )
BEGIN
    drop database TN2K4
END
ELSE
BEGIN
	create database TN2K4
END
go
use TN2K4
go
-- Bảng users (người dùng)
CREATE TABLE users (
    user_id         INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    username        NVARCHAR(255) UNIQUE NOT NULL,   -- Tên đăng nhập
    password_hash   NVARCHAR(255) NOT NULL,          -- Mật khẩu đã mã hóa
    email           NVARCHAR(255) UNIQUE NOT NULL,   -- Email người dùng
    full_name       NVARCHAR(255),                   -- Tên đầy đủ
    phone_number    NVARCHAR(15),                    -- Số điện thoại
    avatar          VARCHAR(255),                    -- Ảnh đại diện
	gender          NVARCHAR(20),                    -- Giới tính
	birth_date      DATETIME,                        -- Ngày sinh
	identity_card   INT,                             -- Số tài khoản   
    created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo tài khoản
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật thông tin
	status          VARCHAR(50)                      -- Trạng thái
);

--Bảng địa chỉ
CREATE TABLE address(
    address_id		INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
	user_id         INT,                             -- Khóa ngoại, kết nối với bảng user
	address			NVARCHAR(255),	                 -- Tên địa chỉ
	address_detail  NVARCHAR(255),                   -- Địa chỉ chi tiết( VD: số nhà, làng,..)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
);
-- Bảng roles (vai trò)
CREATE TABLE roles (
    role_id         INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    role_name       NVARCHAR(50) UNIQUE NOT NULL,    -- Tên vai trò (admin, customer, manager,...)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
);

-- Bảng user_roles (nhiều người dùng có nhiều vai trò)
CREATE TABLE user_roles (
    user_role_id    INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    user_id         INT NOT NULL,                    -- Khóa ngoại đến bảng users
    role_id         INT NOT NULL,                    -- Khóa ngoại đến bảng roles
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE CASCADE
);
-- Bảng color (màu sắc sản phẩm)
CREATE TABLE colors (
    color_id        INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    color_name      NVARCHAR(100) NOT NULL UNIQUE,   -- Tên màu sắc (Đỏ, Xanh, Đen, Trắng,...)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
);

-- Bảng size (kích cỡ sản phẩm)
CREATE TABLE sizes (
    size_id         INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    size_name       NVARCHAR(10) NOT NULL UNIQUE,    -- Kích cỡ (S, M, L, XL, XXL,...)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
);

-- Bảng origin (xuất xứ sản phẩm)
CREATE TABLE origins (
    origin_id       INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    origin_name     NVARCHAR(255) NOT NULL UNIQUE,   -- Xuất xứ (Việt Nam, Trung Quốc, Mỹ,...)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
);

-- Bảng material (chất liệu sản phẩm)
CREATE TABLE materials (
    material_id     INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    material_name   NVARCHAR(100) NOT NULL UNIQUE,   -- Tên chất liệu (Cotton, Polyester, Len,...)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
);

-- Bảng pattern (hoa văn sản phẩm)
CREATE TABLE patterns (
    pattern_id      INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    pattern_name    NVARCHAR(100) NOT NULL UNIQUE,   -- Tên kiểu dáng, hoa văn (Trơn, Sọc, In hình,...)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
);

--Bảng loại sản phẩm
CREATE TABLE categories (
    category_id     INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    category_name   NVARCHAR(100) UNIQUE NOT NULL,   -- Tên danh mục (áo thun, áo sơ mi, áo khoác,...)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
);

--Bảng sản phẩm chi tiết
CREATE TABLE product (
    product_id      INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    name            NVARCHAR(255) NOT NULL,          -- Tên sản phẩm
    description     NVARCHAR(MAX),                   -- Mô tả chi tiết sản phẩm
    stock_quantity  INT DEFAULT 0,                   -- Số lượng còn lại trong kho
    size_id         INT NULL,                        -- Kích cỡ (S, M, L, XL)
    color_id        INT NULL,                        -- Màu sắc
    material_id     INT NULL,                        -- Chất liệu (cotton, len, ...)
    pattern_id      INT NULL,                        -- Kiểu dáng hoặc hoa văn (sọc, trơn, in hình,...)
	origin_id       INT NULL,					     -- Xuất xứ
	categories_id   INT NULL,                        -- Loại sản phẩm
	price           DECIMAL(10, 2) NOT NULL,         -- Giá sản phẩm
	weigh           FLOAT,                           -- Cân nặng sản phẩm
    additional_info NVARCHAR(MAX),                   -- Các thông tin bổ sung khác
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
	FOREIGN KEY (color_id) REFERENCES colors(color_id) ON DELETE SET NULL,
    FOREIGN KEY (size_id) REFERENCES sizes(size_id) ON DELETE SET NULL,
    FOREIGN KEY (origin_id) REFERENCES origins(origin_id) ON DELETE SET NULL,
    FOREIGN KEY (material_id) REFERENCES materials(material_id) ON DELETE SET NULL,
    FOREIGN KEY (pattern_id) REFERENCES patterns(pattern_id) ON DELETE SET NULL,
	FOREIGN KEY (categories_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

--Bảng ảnh sản phẩm
CREATE TABLE images (
    image_id        INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    product_id       INT NULL,                        -- Khóa ngoại tới bảng product_details
    image_url       NVARCHAR(255),                   -- URL hình ảnh
    is_main         BIT DEFAULT 0,                   -- Ảnh chính của sản phẩm (0 hoặc 1)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
    FOREIGN KEY (product_id ) REFERENCES product(product_id) ON DELETE CASCADE
);

-- Bảng payment_methods (phương thức thanh toán)
CREATE TABLE payment_methods (
    payment_method_id  INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    method_name        NVARCHAR(100) NOT NULL UNIQUE,   -- Tên phương thức thanh toán (Tiền mặt, Thẻ tín dụng, Ví điện tử,...)
	created_at      DATETIME DEFAULT GETDATE(),			-- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),			-- Ngày cập nhật
);

--Bảng hóa đơn
CREATE TABLE orders (
    order_id         INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    user_id          INT NULL,                        -- Khóa ngoại tới bảng users
	payment_method_id INT NULL,                       -- Khóa ngoại tới bảng payment_method_id
	code             NVARCHAR(255) NOT NULL,          -- Mã hóa đơn            
    total_amount     DECIMAL(10, 2) NOT NULL,         -- Tổng số tiền của đơn hàng
    status           NVARCHAR(50),                    -- Trạng thái của đơn hàng (đang xử lý, đã giao hàng,...)
    order_date       DATETIME DEFAULT GETDATE(),      -- Ngày đặt hàng
	ship_date        DATETIME DEFAULT GETDATE(),      -- Ngày vẫn chuyển
	receive_date     DATETIME DEFAULT GETDATE(),      -- Ngày nhận hàng
	ship_fee         DECIMAL(10, 2) NOT NULL,         -- Phí ship
	note             NVARCHAR(MAX),                   -- Ghi chú 
	created_by       NVARCHAR(255),                   -- Được tạo bởi
	update_by        NVARCHAR(255),					  -- Được cập nhật bởi
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
	FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id) ON DELETE SET NULL
);

--Bảng hóa đơn chi tiết
CREATE TABLE order_items (
    order_item_id   INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    order_id        INT NOT NULL,                    -- Khóa ngoại tới bảng orders
    product_id       INT NOT NULL,                    -- Khóa ngoại tới bảng product_details
    quantity        INT NOT NULL,                    -- Số lượng sản phẩm
    price           DECIMAL(10, 2) NOT NULL,         -- Giá sản phẩm tại thời điểm mua
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE
);

--Bảng lịch sử hóa đơn
CREATE TABLE history_order (
	history_order_id  INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
	order_id        INT NOT NULL,                      -- Khóa ngoại tới bảng orders
	action          NVARCHAR(255),				       -- hành động
	created_at      DATETIME DEFAULT GETDATE(),        -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),        -- Ngày cập nhật
	FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
)

-- Bảng promotions (Chương trình khuyến mãi)
CREATE TABLE promotions (
    promotion_id    INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    promotion_name  NVARCHAR(255) NOT NULL,          -- Tên chương trình khuyến mãi
    discount_type   NVARCHAR(50) NOT NULL,           -- Loại giảm giá (phần trăm hoặc số tiền cố định)
    discount_value  DECIMAL(10, 2) NOT NULL,         -- Giá trị giảm giá (phần trăm hoặc số tiền)
    start_date      DATETIME NOT NULL,               -- Ngày bắt đầu khuyến mãi
    end_date        DATETIME NOT NULL,               -- Ngày kết thúc khuyến mãi
    status          BIT,                             -- Trạng thái hoạt động của chương trình (1: đang hoạt động, 0: không)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
);

-- Bảng product_promotions (Liên kết giữa sản phẩm và khuyến mãi)
CREATE TABLE product_promotions (
    product_promotion_id INT IDENTITY(1,1) PRIMARY KEY,  -- Khóa chính, tự động tăng
    product_id            INT NOT NULL,                   -- Khóa ngoại tới bảng product_details
    promotion_id         INT NOT NULL,                   -- Khóa ngoại tới bảng promotions
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (promotion_id) REFERENCES promotions(promotion_id) ON DELETE CASCADE
);

-- Bảng giỏ hàng của khách hàng
CREATE TABLE cart (
	cart_id		INT IDENTITY(1,1) PRIMARY KEY,		   -- Khóa chính, tự động tăng
	user_id		INT NOT NULL,						   -- Khóa ngoại tới bảng users
	product_id INT NULL,						   -- Khóa ngoại tới bảng product_details
	created_at      DATETIME DEFAULT GETDATE(),        -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),        -- Ngày cập nhật
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE CASCADE,
)

--Thêm dữ liệu vào bảng users
INSERT INTO users (username, password_hash, email, full_name, phone_number, avatar, gender, birth_date, identity_card, status) 
VALUES 
('user1', 'password1', 'user1@example.com', 'Nguyen Van A', '0912345678', 'avatar1.jpg', 'Male', '1990-01-01', 123456789, 'Active'),
('user2', 'password2', 'user2@example.com', 'Tran Thi B', '0912345679', 'avatar2.jpg', 'Female', '1992-02-02', 234567890, 'Active'),
('user3', 'password3', 'user3@example.com', 'Le Van C', '0912345680', 'avatar3.jpg', 'Male', '1994-03-03', 345678901, 'Inactive'),
('user4', 'password4', 'user4@example.com', 'Pham Thi D', '0912345681', 'avatar4.jpg', 'Female', '1996-04-04', 456789012, 'Active'),
('user5', 'password5', 'user5@example.com', 'Hoang Van E', '0912345682', 'avatar5.jpg', 'Male', '1998-05-05', 567890123, 'Active');

--Thêm dữ liệu vào bảng address
INSERT INTO address (user_id, address, address_detail) 
VALUES 
(1, '123 Main St', 'Apartment 1A'), 
(2, '456 Oak St', 'Suite B'), 
(3, '789 Pine St', 'Floor 2'), 
(4, '321 Maple St', 'House 3'), 
(5, '654 Elm St', 'Room 4C');

--Thêm dữ liệu vào bảng role
INSERT INTO roles (role_name) 
VALUES 
('Admin'), 
('Customer'), 
('Manager'), 
('Seller'), 
('Moderator');

--Thêm dữ liệu vào bảng user_roles
INSERT INTO user_roles (user_id, role_id) 
VALUES 
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5);

--Thêm dữ liệu vào bảng colors
INSERT INTO colors (color_name) 
VALUES 
('Red'), 
('Blue'), 
('Green'), 
('Black'), 
('White');

--Thêm dữ liệu vào bảng sizes
INSERT INTO sizes (size_name) 
VALUES 
('S'), 
('M'), 
('L'), 
('XL'), 
('XXL');

--Thêm dữ liệu vào bảng origins
INSERT INTO origins (origin_name) 
VALUES 
('Vietnam'), 
('China'), 
('USA'), 
('Japan'), 
('Korea');

--Thêm dữ liệu vào bảng materials
INSERT INTO materials (material_name) 
VALUES 
('Cotton'), 
('Polyester'), 
('Wool'), 
('Silk'), 
('Leather');

--Thêm dữ liệu vào bảng patterns
INSERT INTO patterns (pattern_name) 
VALUES 
('Solid'), 
('Striped'), 
('Printed'), 
('Checkered'), 
('Polka Dot');

--Thêm dữ liệu vào bảng categories
INSERT INTO categories (category_name) 
VALUES 
('T-shirt'), 
('Shirt'), 
('Jacket'), 
('Jeans'), 
('Dress');

--product
INSERT INTO product (name, description, stock_quantity, size_id, color_id, material_id, pattern_id, origin_id, categories_id, price, weigh, additional_info) 
VALUES 
('T-shirt 1', 'Comfortable cotton T-shirt', 100, 1, 1, 1, 1, 1, 1, 150000, 0.5, 'No additional info'),
('T-shirt 2', 'Stylish polyester T-shirt', 200, 2, 2, 2, 2, 2, 2, 200000, 0.4, 'Limited edition'),
('Shirt 1', 'Formal cotton shirt', 50, 3, 3, 1, 3, 3, 3, 300000, 0.6, 'Best for office wear'),
('Jacket 1', 'Winter wool jacket', 30, 4, 4, 3, 4, 4, 4, 500000, 1.2, 'Keep you warm'),
('Dress 1', 'Elegant silk dress', 20, 5, 5, 4, 5, 5, 5, 1000000, 0.8, 'Perfect for parties');

--payment_methods
INSERT INTO payment_methods (method_name) 
VALUES 
('Cash'), 
('Credit Card'), 
('Debit Card'), 
('E-wallet'), 
('Bank Transfer');

-- orders
INSERT INTO orders (user_id, payment_method_id, code, total_amount, status, ship_fee, note, created_by, update_by) 
VALUES 
(1, 1, 'ORD001', 500000, 'Processing', 50000, 'Handle with care', 'Admin', 'Admin'), 
(2, 2, 'ORD002', 1000000, 'Shipped', 60000, 'Fast shipping', 'Admin', 'Admin'), 
(3, 3, 'ORD003', 1500000, 'Delivered', 70000, 'No special request', 'Admin', 'Admin'), 
(4, 4, 'ORD004', 2000000, 'Cancelled', 80000, 'Customer request', 'Admin', 'Admin'), 
(5, 5, 'ORD005', 2500000, 'Processing', 90000, 'Urgent', 'Admin', 'Admin');

-- order_items
INSERT INTO order_items (order_id, product_id, quantity, price) 
VALUES 
(1, 1, 2, 150000), 
(2, 2, 1, 200000), 
(3, 3, 3, 300000), 
(4, 4, 1, 500000), 
(5, 5, 1, 1000000);

-- history_order
INSERT INTO history_order (order_id, action) 
VALUES 
(1, 'Order created'), 
(2, 'Order shipped'), 
(3, 'Order delivered'), 
(4, 'Order cancelled'), 
(5, 'Order created');

-- promotions
INSERT INTO promotions (promotion_name, discount_type, discount_value, start_date, end_date, status) 
VALUES 
('Summer Sale', 'Percentage', 10.00, '2024-06-01', '2024-06-30', 1), 
('Winter Sale', 'Fixed', 50000.00, '2024-12-01', '2024-12-31', 1), 
('Black Friday', 'Percentage', 20.00, '2024-11-25', '2024-11-30', 1), 
('New Year Sale', 'Fixed', 100000.00, '2024-01-01', '2024-01-07', 1), 
('Clearance Sale', 'Percentage', 30.00, '2024-09-01', '2024-09-15', 1);

-- product_promotions
INSERT INTO product_promotions (product_id, promotion_id) 
VALUES 
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5);

INSERT INTO cart (user_id, product_id) 
VALUES 
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5);


select * from cart

--delete product_details where detail_id=1
