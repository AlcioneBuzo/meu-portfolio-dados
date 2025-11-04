-- Basic Exercises

-- 1. List all customers
SELECT * FROM customers;

-- 2. Show only the names and emails of customers
SELECT name, email
FROM customers;

-- 3. List all products with a price greater than 500
SELECT name, description, price
FROM products
WHERE price > 500;

-- 4. Show all sales with status "Delivered"
SELECT sale_date, status, total, payment_method
FROM sales
WHERE status = 'Delivered';

-- 5. Count how many customers exist in each state
SELECT state, COUNT(*) AS total_customers
FROM customers
GROUP BY state;
