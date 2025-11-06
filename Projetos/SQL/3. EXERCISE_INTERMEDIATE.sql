-- EXERCISE INTERMEDIATE / EXERCICIOS INTERMEDIÁRIOS

-- 6. List all customers who have placed more than 5 orders / Listar todos os clientes que fizeram mais de 5 pedidos
SELECT c.customer_id, c.name, COUNT(s.sale_id) AS total_orders
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.name
HAVING total_orders > 5;

-- 7. Show the 5 most expensive products / Mostrar os 5 produtos mais caros
SELECT product_id, name AS product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- 8. Get the total quantity sold for each product / Obter a quantidade total vendida de cada produto
SELECT p.product_id, p.name, SUM(si.quantity) AS total_sold
FROM products p
JOIN sale_items si ON p.product_id = si.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC;

-- 9. List all products that have never been sold / Listar todos os produtos que nunca foram vendidos
SELECT p.product_id, p.name
FROM products p
LEFT JOIN sale_items si ON p.product_id = si.product_id
WHERE si.product_id IS NULL;

-- 10. Show the top 5 customers with the highest total sales / Mostrar os 5 clientes com maior total de vendas
SELECT c.customer_id, c.name, SUM(si.unit_price * si.quantity - si.discount) AS total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN sale_items si ON s.sale_id = si.sale_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 5;

-- 11. Find the average order total per customer / Encontrar a média do total de pedidos por cliente
SELECT c.customer_id, c.name, AVG(s.total) AS avg_order_total
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.name;

-- 12. List all sales that happened in January 2023 / Listar todas as vendas que ocorreram em Janeiro de 2023
SELECT s.sale_id, s.sale_date, c.name AS customer_name, SUM(si.unit_price * si.quantity - si.discount) AS total_sale
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN sale_items si ON s.sale_id = si.sale_id
WHERE s.sale_date BETWEEN '2023-01-01' AND '2023-01-31'
GROUP BY s.sale_id, s.sale_date, c.name;

-- 13. Show the products with stock quantity less than 10 / Mostrar os produtos com quantidade em estoque menor que 10
SELECT product_id, name, stock
FROM products
WHERE stock < 10;

-- 14. Find the category with the highest total sales / Encontrar a categoria com maior total de vendas
SELECT c.category_id, c.name AS category_name, SUM(si.unit_price * si.quantity - si.discount) AS total_sales
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN sale_items si ON p.product_id = si.product_id
GROUP BY c.category_id, c.name
ORDER BY total_sales DESC
LIMIT 1;

-- 15. List the sales grouped by month and year / Listar as vendas agrupadas por mês e ano
SELECT YEAR(s.sale_date) AS sale_year, MONTH(s.sale_date) AS sale_month, SUM(si.unit_price * si.quantity - si.discount) AS total_sales
FROM sales s
JOIN sale_items si ON s.sale_id = si.sale_id
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;