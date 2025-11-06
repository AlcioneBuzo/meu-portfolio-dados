-- 9.List all products that have never been sold.
SELECT p.product_id, p.name
FROM products p
LEFT JOIN sale_items si ON p.product_id = si.product_id
WHERE si.product_id IS NULL;

-- 10. Show the top 5 customers with the highest total sales.
SELECT c.customer_id, c.name, SUM(si.unit_price * si.quantity - si.discount) AS total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN sale_items si ON s.sale_id = si.sale_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 5;

-- 11. Find the average order total per customer.
SELECT c.customer_id, c.name, AVG(s.total) AS avg_order_total
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.name;

-- 12. List all sales that happened in January 2023.
SELECT s.sale_id, s.sale_date, c.name AS customer, SUM(si.unit_price * si.quantity - si.discount) AS total_sale
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN sale_items si ON s.sale_id = si.sale_id
WHERE s.sale_date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY s.sale_id, s.sale_date, c.name;

-- 13. Show the products with stock quantity less than 10.
SELECT p.product_id, p.name, p.stock
FROM products p
WHERE p.stock < 10;

-- 14. Find the category with the highest total sales.
SELECT c.category_id, c.name, SUM(si.unit_price * si.quantity - si.discount) AS total_sales
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN sale_items si ON p.product_id = si.product_id
GROUP BY c.category_id, c.name
ORDER BY total_sales DESC
LIMIT 1;

-- 15. List the sales grouped by month and year.
SELECT YEAR(s.sale_date) AS sale_year, MONTH(s.sale_date) AS sale_month, SUM(si.unit_price * si.quantity - si.discount) AS total_sales
FROM sales s
JOIN sale_items si ON s.sale_id = si.sale_id
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;