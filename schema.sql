-- Simple E-commerce Database Setup
-- Run this in MySQL
DROP DATABASE ecommerce;

CREATE DATABASE ecommerce;
USE ecommerce;

-- 1. Users table (simple)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);

-- 2. Admin table (simple)
CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL
);

-- 3. Products table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    stock INT DEFAULT 0,
    image VARCHAR(500)
);

-- 4. Cart table
CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 5. Orders table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'Pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 6. Order items table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert sample admin
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');

-- Insert sample products
INSERT INTO products (name, price, description, stock, image) VALUES
('Laptop', 145999.00, 'Gaming Laptop with high performance', 10, 'LAPTOP.jpg'),
('Smartphone', 115999.00, 'Latest Android smartphone', 25, 'SMARTPHONE.jpg'),
('Headphones', 2999.00, 'Wireless headphones with premium sound', 50, 'HEADPHONE.jpg'),
('Watch', 118999.00, 'Smart fitness tracking watch', 30, 'WATCH.jpg'),
('Camera', 35999.00, 'Professional DSLR camera', 5, 'CAMERA.jpg'),
('Tablet', 19999.00, 'High-performance Android tablet', 15, 'TABLET.jpg');




-- Insert sample user
INSERT INTO users (name, email, password, phone) VALUES
('John Doe', 'john@email.com', 'password123', '9876543210');
select*from orders;
select*from order_items;
select*from users;
select*from products;
select*from cart;
select*from admin;
SELECT id, name FROM products;

UPDATE products SET image = 'camera.jpg' WHERE id = 5;
UPDATE products SET image = 'laptop.jpeg' WHERE id = 1;
UPDATE products SET image = 'phone.jpeg' WHERE id = 2;
UPDATE products SET image = 'headphones.jpeg' WHERE id = 3;
UPDATE products SET image = 'watch.jpeg' WHERE id = 4;
select*from order_items;
drop database jdbc_demo;

