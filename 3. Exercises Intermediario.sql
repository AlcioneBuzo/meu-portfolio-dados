-- List all products in a specific category (e.g., “Computers”)
-- Usando JOIN com a tabela categories
-- SELECT P.NAME, P.DESCRIPTION, P.PRICE, C.NAME AS CATEGORY_NAME
-- FROM PRODUCTS P
-- JOIN CATEGORIES C ON P.CATEGORY_ID = C.CATEGORY_ID
-- WHERE C.NAME = 'Computers';
-- Show the total sales per customer. Mostre o total de vendas por cliente.
-- SHOW TABLES;
-- select * from cUstomers;

-- select * from sales;

SELECT C.NAME, SUM(S.TOTAL) AS TOTAL_SALES
FROM SALES S
JOIN CUSTOMERS C ON S.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY C.NAME;
