-- EXERCÍCIOS BÁSICOS / BASIC EXERCISES

-- 1. List all customers / Listar todos os clientes
SELECT * 
FROM customers;

-- 2. Show only the names and emails of customers / Mostrar apenas os nomes e emails dos clientes
SELECT name, email
FROM customers;

-- 3. List all products with a price greater than 500 / Listar todos os produtos com preço maior que 500
SELECT name, description, price
FROM products
WHERE price > 500;

-- 4. Show all sales with status "Delivered" / Mostrar todas as vendas com status "Delivered"
SELECT sale_id, customer_id, seller_id, sale_date, status, total, payment_method
FROM sales
WHERE status = 'Delivered';

-- 5. Count how many customers exist in each state / Contar quantos clientes existem em cada estado
SELECT state, COUNT(*) AS total_customers
FROM customers
GROUP BY state;
