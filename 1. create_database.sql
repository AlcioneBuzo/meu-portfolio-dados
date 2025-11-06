CREATE DATABASE sales_company;
USE sales_company;

-- Customers
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

-- Sellers
CREATE TABLE sellers (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE,
    base_salary DECIMAL(10,2)
);

-- Categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Products
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Sales
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

-- Sale Items
CREATE TABLE sale_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Product Log
CREATE TABLE product_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    operation VARCHAR(100),
    log_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- INSERÇÃO DE DADOS

-- Customers (15)
INSERT INTO customers (name, email, phone, city, state, customer_type) VALUES
('John Smith', 'john@email.com', '(11) 9000-0001', 'São Paulo', 'SP', 'Individual'),
('Mary Johnson', 'mary@email.com', '(21) 9000-0002', 'Rio de Janeiro', 'RJ', 'Individual'),
('Carlos Silva', 'carlos@email.com', '(31) 9000-0003', 'Belo Horizonte', 'MG', 'Individual'),
('Anna Costa', 'anna@email.com', '(41) 9000-0004', 'Curitiba', 'PR', 'Individual'),
('Paulo Almeida', 'paulo@email.com', '(51) 9000-0005', 'Porto Alegre', 'RS', 'Individual'),
('Empresa A', 'contatoA@email.com', '(11) 9100-0010', 'São Paulo', 'SP', 'Company'),
('Empresa B', 'contatoB@email.com', '(21) 9100-0011', 'Rio de Janeiro', 'RJ', 'Company'),
('Empresa C', 'contatoC@email.com', '(31) 9100-0012', 'Belo Horizonte', 'MG', 'Company'),
('Empresa D', 'contatoD@email.com', '(41) 9100-0013', 'Curitiba', 'PR', 'Company'),
('Empresa E', 'contatoE@email.com', '(51) 9100-0014', 'Porto Alegre', 'RS', 'Company'),
('Lucas Mendes', 'lucas@email.com', '(11) 9222-0001', 'São Paulo', 'SP', 'Individual'),
('Fernanda Lima', 'fernanda@email.com', '(21) 9222-0002', 'Rio de Janeiro', 'RJ', 'Individual'),
('Bruno Rocha', 'bruno@email.com', '(31) 9222-0003', 'Belo Horizonte', 'MG', 'Individual'),
('Patricia Souza', 'patricia@email.com', '(41) 9222-0004', 'Curitiba', 'PR', 'Individual'),
('Rafael Gomes', 'rafael@email.com', '(51) 9222-0005', 'Porto Alegre', 'RS', 'Individual');

-- Sellers (15)
INSERT INTO sellers (name, email, phone, hire_date, base_salary) VALUES
('Peter Alves', 'peter@company.com', '(11) 9600-0101', '2020-05-15', 2500.00),
('Fernanda Lima', 'fernanda@company.com', '(11) 9600-0102', '2021-02-10', 2800.00),
('Richard Santos', 'richard@company.com', '(11) 9600-0103', '2019-11-20', 3200.00),
('Marcia Alves', 'marcia@company.com', '(11) 9600-0104', '2018-03-12', 2400.00),
('Roberto Dias', 'roberto@company.com', '(11) 9600-0105', '2022-01-22', 2600.00),
('Sofia Pinto', 'sofia@company.com', '(21) 9600-0106', '2020-06-30', 2900.00),
('Lucas Rocha', 'lucas@company.com', '(21) 9600-0107', '2021-08-15', 2700.00),
('Camila Martins', 'camila@company.com', '(21) 9600-0108', '2019-09-10', 3100.00),
('Tiago Souza', 'tiago@company.com', '(21) 9600-0109', '2018-12-01', 2550.00),
('Patricia Costa', 'patricia@company.com', '(31) 9600-0110', '2022-02-28', 2850.00),
('Renato Lima', 'renato@company.com', '(31) 9600-0111', '2020-11-20', 2650.00),
('Julia Gomes', 'julia@company.com', '(31) 9600-0112', '2019-04-18', 2950.00),
('Fabio Alves', 'fabio@company.com', '(41) 9600-0113', '2021-03-05', 2750.00),
('Carolina Dias', 'carolina@company.com', '(41) 9600-0114', '2020-07-07', 2800.00),
('Andre Souza', 'andre@company.com', '(41) 9600-0115', '2018-05-25', 2600.00);

-- Categories (5)
INSERT INTO categories (name, description) VALUES
('Electronics', 'General electronic products'),
('Computers', 'Computers, notebooks and accessories'),
('Furniture', 'Office and home furniture'),
('Office Supplies', 'Basic office materials'),
('Games', 'Board games, video games, and accessories');

-- Products (15)
INSERT INTO products (name, description, price, stock, category_id) VALUES
('Dell i7 Notebook', 'Dell Inspiron Notebook with i7', 4500.00, 10, 2),
('Wireless Mouse', 'Optical wireless mouse', 120.00, 50, 2),
('Mechanical Keyboard', 'RGB mechanical keyboard', 350.00, 30, 2),
('24" Monitor', '24-inch Full HD LED monitor', 899.00, 15, 1),
('Executive Chair', 'Swivel chair with height adjustment', 1200.00, 8, 3),
('Office Desk', 'Rectangular desk 1.40m', 750.00, 12, 3),
('Pen Pack', 'Set of 10 ballpoint pens', 25.00, 100, 4),
('Stapler', 'Desktop stapler', 18.50, 40, 4),
('PlayStation 5', 'Next-gen console', 5000.00, 20, 5),
('Xbox Series X', 'Microsoft next-gen console', 4800.00, 15, 5),
('Board Game Catan', 'Classic board game', 150.00, 60, 5),
('iMac 27"', 'Apple desktop', 12000.00, 5, 2),
('Laptop HP', 'HP Pavilion 15"', 3500.00, 10, 2),
('Office Chair Premium', 'Ergonomic chair', 1600.00, 7, 3),
('Printer Laser', 'High-speed printer', 700.00, 8, 4);

-- Sales (15)
INSERT INTO sales (customer_id, seller_id, sale_date, status, total, payment_method) VALUES
(1, 1, '2023-01-15 10:30:00', 'Delivered', 4500.00, 'Credit Card'),
(2, 2, '2023-01-16 14:15:00', 'Shipped', 1049.00, 'PIX'),
(3, 3, '2023-01-17 09:45:00', 'Processing', 1950.00, 'Invoice'),
(4, 4, '2023-01-18 16:20:00', 'Pending', 350.00, 'Debit Card'),
(5, 5, '2023-01-19 11:10:00', 'Delivered', 43.50, 'Cash'),
(6, 6, '2023-01-20 12:00:00', 'Delivered', 5000.00, 'Credit Card'),
(7, 7, '2023-01-21 13:10:00', 'Shipped', 4800.00, 'PIX'),
(8, 8, '2023-01-22 14:25:00', 'Processing', 150.00, 'Invoice'),
(9, 9, '2023-01-23 15:40:00', 'Pending', 1200.00, 'Debit Card'),
(10, 10, '2023-01-24 16:50:00', 'Delivered', 750.00, 'Cash'),
(11, 11, '2023-01-25 17:00:00', 'Shipped', 350.00, 'Credit Card'),
(12, 12, '2023-01-26 18:20:00', 'Delivered', 25.00, 'PIX'),
(13, 13, '2023-01-27 19:15:00', 'Processing', 18.50, 'Invoice'),
(14, 14, '2023-01-28 20:05:00', 'Pending', 1200.00, 'Debit Card'),
(15, 15, '2023-01-29 21:30:00', 'Delivered', 1600.00, 'Cash');

-- Sale Items (15)
INSERT INTO sale_items (sale_id, product_id, quantity, unit_price, discount) VALUES
(1, 1, 1, 4500.00, 0.00),
(2, 4, 1, 899.00, 0.00),
(2, 2, 1, 150.00, 30.00),
(3, 5, 1, 1200.00, 0.00),
(3, 6, 1, 750.00, 0.00),
(4, 3, 1, 350.00, 0.00),
(5, 7, 1, 25.00, 0.00),
(6, 9, 1, 5000.00, 0.00),
(7, 10, 1, 4800.00, 0.00),
(8, 11, 1, 150.00, 0.00),
(9, 5, 1, 1200.00, 0.00),
(10, 6, 1, 750.00, 0.00),
(11, 8, 1, 18.50, 0.00),
(12, 7, 1, 25.00, 0.00),
(13, 8, 1, 18.50, 0.00);
