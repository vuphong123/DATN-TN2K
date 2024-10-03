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

--Bảng sản phẩm
CREATE TABLE products (
    product_id      INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    name            NVARCHAR(255) NOT NULL,          -- Tên sản phẩm
    description     NVARCHAR(MAX),                   -- Mô tả chi tiết sản phẩm
    stock_quantity  INT DEFAULT 0,                   -- Số lượng còn lại trong kho
    created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo sản phẩm
    updated_at      DATETIME DEFAULT GETDATE()       -- Ngày cập nhật sản phẩm
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
CREATE TABLE product_details (
    detail_id       INT IDENTITY(1,1) PRIMARY KEY,   -- Khóa chính, tự động tăng
    product_id      INT NULL,                        -- Khóa ngoại tới bảng products
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
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
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
    detail_id       INT NULL,                        -- Khóa ngoại tới bảng product_details
    image_url       NVARCHAR(255),                   -- URL hình ảnh
    is_main         BIT DEFAULT 0,                   -- Ảnh chính của sản phẩm (0 hoặc 1)
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
    FOREIGN KEY (detail_id ) REFERENCES product_details(detail_id) ON DELETE CASCADE
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
    detail_id       INT NOT NULL,                    -- Khóa ngoại tới bảng product_details
    quantity        INT NOT NULL,                    -- Số lượng sản phẩm
    price           DECIMAL(10, 2) NOT NULL,         -- Giá sản phẩm tại thời điểm mua
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (detail_id) REFERENCES product_details(detail_id) ON DELETE CASCADE
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
    detail_id            INT NOT NULL,                   -- Khóa ngoại tới bảng product_details
    promotion_id         INT NOT NULL,                   -- Khóa ngoại tới bảng promotions
	created_at      DATETIME DEFAULT GETDATE(),      -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),      -- Ngày cập nhật
    FOREIGN KEY (detail_id) REFERENCES product_details(detail_id) ON DELETE CASCADE,
    FOREIGN KEY (promotion_id) REFERENCES promotions(promotion_id) ON DELETE CASCADE
);

-- Bảng giỏ hàng của khách hàng
CREATE TABLE cart (
	cart_id		INT IDENTITY(1,1) PRIMARY KEY,		   -- Khóa chính, tự động tăng
	user_id		INT NOT NULL,						   -- Khóa ngoại tới bảng users
	product_detail_id INT NULL,						   -- Khóa ngoại tới bảng product_details
	created_at      DATETIME DEFAULT GETDATE(),        -- Ngày tạo
    updated_at      DATETIME DEFAULT GETDATE(),        -- Ngày cập nhật
	FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
	FOREIGN KEY (product_detail_id) REFERENCES product_details(detail_id) ON DELETE CASCADE,
)

--Thêm dữ liệu vào bảng users
INSERT INTO users (username, password_hash, email, full_name, phone_number, avatar, gender, birth_date, identity_card, status)
VALUES 
('user1', 'hashed_password1', 'user1@example.com', 'Nguyen Van A', '0123456789', 'avatar1.png', 'Nam', '1990-01-01', 123456789, 'active'),
('user2', 'hashed_password2', 'user2@example.com', 'Tran Thi B', '0987654321', 'avatar2.png', 'Nu', '1992-02-02', 987654321, 'active'),
('user3', 'hashed_password3', 'user3@example.com', 'Le Van C', '0345678901', 'avatar3.png', 'Nam', '1994-03-03', 192837465, 'active'),
('user4', 'hashed_password4', 'user4@example.com', 'Pham Thi D', '0456789012', 'avatar4.png', 'Nu', '1988-04-04', 564738291, 'inactive'),
('user5', 'hashed_password5', 'user5@example.com', 'Vo Van E', '0567890123', 'avatar5.png', 'Nam', '1985-05-05', 384756192, 'active');

--Thêm dữ liệu vào bảng address
INSERT INTO address (user_id, address, address_detail)
VALUES 
(1, 'Hanoi', '123 Street Name, District 1'),
(2, 'Ho Chi Minh City', '456 Avenue Name, District 2'),
(3, 'Da Nang', '789 Boulevard Name, District 3'),
(4, 'Hai Phong', '321 Road Name, District 4'),
(5, 'Nha Trang', '654 Lane Name, District 5');

--Thêm dữ liệu vào bảng role
INSERT INTO roles (role_name)
VALUES 
('admin'),
('customer'),
('manager'),
('editor'),
('support');

--Thêm dữ liệu vào bảng user_roles
INSERT INTO user_roles (user_id, role_id)
VALUES 
(1, 1),  -- user1 là admin
(2, 2),  -- user2 là customer
(3, 1),  -- user3 là admin
(4, 3),  -- user4 là manager
(5, 2);  -- user5 là customer

--Thêm dữ liệu vào bảng products
INSERT INTO products (name, description, stock_quantity)
VALUES 
('Áo thun nam cổ tròn', 'Áo thun cotton mềm mại, thoáng mát, thích hợp cho mùa hè.', 100),
('Áo sơ mi nam', 'Áo sơ mi dài tay, chất liệu vải cotton, phù hợp cho công sở.', 50),
('Áo khoác nam', 'Áo khoác gió chống nước, thích hợp cho mùa đông.', 30),
('Áo polo nam', 'Áo polo cổ bẻ, thiết kế trẻ trung, dễ phối đồ.', 75),
('Áo hoodie nam', 'Áo hoodie ấm áp, có mũ, phù hợp cho thời tiết lạnh.', 20);

--Thêm dữ liệu vào bảng colors
INSERT INTO colors (color_name) VALUES 
('Đỏ'),
('Xanh'),
('Đen'),
('Trắng'),
('Vàng');

--Thêm dữ liệu vào bảng sizes
INSERT INTO sizes (size_name) VALUES 
('S'),
('M'),
('L'),
('XL'),
('XXL');

--Thêm dữ liệu vào bảng origins
INSERT INTO origins (origin_name) VALUES 
('Việt Nam'),
('Trung Quốc'),
('Mỹ'),
('Nhật Bản'),
('Ấn Độ');

--Thêm dữ liệu vào bảng materials
INSERT INTO materials (material_name) VALUES 
('Cotton'),
('Polyester'),
('Len'),
('Vải thun'),
('Da');

--Thêm dữ liệu vào bảng patterns
INSERT INTO patterns (pattern_name) VALUES 
('Trơn'),
('Sọc'),
('In hình'),
('Kiểu dáng đặc biệt'),
('Chấm bi');

--Thêm dữ liệu vào bảng categories
INSERT INTO categories (category_name) VALUES 
('Áo thun'),
('Áo sơ mi'),
('Áo khoác'),
('Quần'),
('Giày dép');

--product_details
INSERT INTO product_details (product_id, size_id, color_id, material_id, pattern_id, origin_id, categories_id, price, weigh, additional_info)
VALUES 
(1, 1, 1, 1, 1, 1, 1, 300.00, 0.5, 'Áo thun nam cotton, màu đỏ, size M'),
(2, 2, 2, 2, 2, 1, 1, 450.00, 0.6, 'Áo sơ mi nam linen, màu xanh, size L'),
(3, 1, 3, 1, 3, 2, 1, 600.00, 0.7, 'Áo khoác nam polyester, màu đen, size S'),
(4, 3, 1, 2, 1, 1, 1, 400.00, 0.4, 'Áo polo nam cotton, màu trắng, size XL'),
(5, 2, 2, 1, 2, 3, 1, 550.00, 0.5, 'Áo hoodie nam, màu xanh dương, size M');

--payment_methods
INSERT INTO payment_methods (method_name)
VALUES 
('Tiền mặt'),
('Thẻ tín dụng'),
('Thẻ ghi nợ'),
('Ví điện tử'),
('Chuyển khoản ngân hàng');

-- orders
INSERT INTO orders (user_id, payment_method_id, code, total_amount, status, ship_fee, note, created_by)
VALUES 
(1, 1, 'HD001', 500.00, 'Đang xử lý', 20.00, 'Ghi chú đơn hàng 1', 'Admin'),
(2, 2, 'HD002', 1000.00, 'Đã giao hàng', 15.00, 'Ghi chú đơn hàng 2', 'Admin'),
(3, 3, 'HD003', 750.00, 'Đang xử lý', 25.00, 'Ghi chú đơn hàng 3', 'Admin'),
(1, 4, 'HD004', 300.00, 'Đang xử lý', 10.00, 'Ghi chú đơn hàng 4', 'Admin'),
(2, 5, 'HD005', 850.00, 'Đã giao hàng', 5.00, 'Ghi chú đơn hàng 5', 'Admin');

-- order_items
INSERT INTO order_items (order_id, detail_id, quantity, price)
VALUES 
(1, 1, 2, 150.00),  -- 2 áo thun
(1, 2, 1, 350.00),  -- 1 áo sơ mi
(2, 3, 1, 500.00),  -- 1 áo khoác
(3, 4, 1, 1200.00), -- 1 áo polo
(4, 5, 3, 250.00);  -- 3 áo hoodie

-- history_order
INSERT INTO history_order (order_id, action)
VALUES 
(1, 'Đặt hàng'),
(1, 'Đã thanh toán'),
(1, 'Đang xử lý'),
(2, 'Đã giao hàng'),
(3, 'Hủy đơn');

-- promotions
INSERT INTO promotions (promotion_name, discount_type, discount_value, start_date, end_date, status)
VALUES 
('Khuyến mãi mùa hè', 'Phần trăm', 20.00, '2024-06-01', '2024-06-30', 1),
('Giảm giá cuối năm', 'Số tiền', 50.00, '2024-12-01', '2024-12-31', 1),
('Mua 1 tặng 1', 'Phần trăm', 100.00, '2024-05-01', '2024-05-15', 1),
('Giảm giá cho đơn hàng đầu tiên', 'Phần trăm', 15.00, '2024-01-01', '2024-12-31', 1),
('Khuyến mãi sinh nhật', 'Số tiền', 30.00, '2024-09-01', '2024-09-30', 1);

-- product_promotions
INSERT INTO product_promotions (detail_id, promotion_id)
VALUES 
(1, 1),  -- Áo thun nam áp dụng khuyến mãi mùa hè
(2, 2),  -- Áo sơ mi nam áp dụng giảm giá cuối năm
(3, 3),  -- Áo khoác nam áp dụng chương trình mua 1 tặng 1
(4, 4),  -- Áo polo nam áp dụng khuyến mãi cho đơn hàng đầu tiên
(5, 5);  -- Áo hoodie nam áp dụng khuyến mãi sinh nhật

INSERT INTO cart (user_id, product_detail_id)
VALUES 
(1, 1),
(1, 2),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

select * from cart
select * from product_details

--delete product_details where detail_id=1