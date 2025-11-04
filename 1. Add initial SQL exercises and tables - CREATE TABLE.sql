-- Criação do banco de dados
CREATE DATABASE sales_company;
USE sales_company;
-- Tabela de Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    city VARCHAR(50),
    state CHAR(2),
    customer_type ENUM('Individual', 'Company') DEFAULT 'Individual'
);

-- Tabela de Sellers
CREATE TABLE sellers (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE,
    base_salary DECIMAL(10,2)
);

-- Tabela de Product Categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Tabela de Products
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Tabela de Sales
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    seller_id INT,
    sale_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total DECIMAL(12,2),
    payment_method ENUM('Cash', 'Credit Card', 'Debit Card', 'Invoice', 'PIX'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- Tabela de Sale Items
CREATE TABLE sale_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Inserção de dados de exemplo

-- Customers
INSERT INTO customers (name, email, phone, city, state, customer_type) VALUES
('John Smith', 'john@email.com', '(11) 9999-8888', 'São Paulo', 'SP', 'Individual'),
('Mary Johnson', 'mary@email.com', '(21) 7777-6666', 'Rio de Janeiro', 'RJ', 'Individual'),
('ABC Ltd.', 'contact@abc.com', '(31) 5555-4444', 'Belo Horizonte', 'MG', 'Company'),
('Carlos Souza', 'carlos@email.com', '(41) 3333-2222', 'Curitiba', 'PR', 'Individual'),
('Anna Costa', 'anna@email.com', '(51) 1111-0000', 'Porto Alegre', 'RS', 'Individual');

-- Sellers
INSERT INTO sellers (name, email, phone, hire_date, base_salary) VALUES
('Peter Alves', 'peter@company.com', '(11) 2222-3333', '2020-05-15', 2500.00),
('Fernanda Lima', 'fernanda@company.com', '(11) 4444-5555', '2021-02-10', 2800.00),
('Richard Santos', 'richard@company.com', '(11) 6666-7777', '2019-11-20', 3200.00);

-- Categories
INSERT INTO categories (name, description) VALUES
('Electronics', 'General electronic products'),
('Computers', 'Computers, notebooks and accessories'),
('Furniture', 'Office and home furniture'),
('Office Supplies', 'Basic office materials');

-- Products
INSERT INTO products (name, description, price, stock, category_id) VALUES
('Dell i7 Notebook', 'Dell Inspiron Notebook with i7 processor', 4500.00, 10, 2),
('Wireless Mouse', 'Optical wireless mouse', 120.00, 50, 2),
('Mechanical Keyboard', 'RGB mechanical keyboard', 350.00, 30, 2),
('24" Monitor', '24-inch Full HD LED monitor', 899.00, 15, 1),
('Executive Chair', 'Swivel chair with height adjustment', 1200.00, 8, 3),
('Office Desk', 'Rectangular desk 1.40m', 750.00, 12, 3),
('Pen Pack', 'Set of 10 ballpoint pens', 25.00, 100, 4),
('Stapler', 'Desktop stapler', 18.50, 40, 4);

-- Sales
INSERT INTO sales (customer_id, seller_id, sale_date, status, total, payment_method) VALUES
(1, 1, '2023-01-15 10:30:00', 'Delivered', 4500.00, 'Credit Card'),
(2, 2, '2023-01-16 14:15:00', 'Shipped', 1049.00, 'PIX'),
(3, 1, '2023-01-17 09:45:00', 'Processing', 1950.00, 'Invoice'),
(4, 3, '2023-01-18 16:20:00', 'Pending', 350.00, 'Debit Card'),
(1, 2, '2023-01-19 11:10:00', 'Delivered', 43.50, 'Cash');

-- Sale Items
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price, discount) VALUES
(1, 1, 1, 4500.00, 0.00),
(2, 4, 1, 899.00, 0.00),
(2, 2, 1, 120.00, 30.00),
(3, 5, 1, 1200.00, 0.00),
(3, 6, 1, 750.00, 0.00),
(4, 3, 1, 350.00, 0.00),
(5, 7, 1, 25.00, 0.00),
(5, 8, 1, 18.50, 0.00);
