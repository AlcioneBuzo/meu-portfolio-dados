# My Quick SQL Tips / Minhas Dicas Rápidas de SQL

## JOIN / INNER JOIN
-- EN: Joins two tables showing **only the matching rows in both**.  
-- PT: Junta duas tabelas mostrando **só o que bate nas duas**.
```sql
FROM sales s
JOIN products p ON s.product_id = p.product_id

## LEFT JOIN
-- EN: Joins two tables showing all rows from the left table, even if there’s no match on the right.
-- PT: Junta duas tabelas mostrando todas as linhas da tabela da esquerda, mesmo se não houver correspondência na direita.
sql
FROM products p
LEFT JOIN sale_items si ON p.product_id = si.product_id

## GROUP BY
-- EN: Groups identical rows and allows calculating sum, average, count, etc.
-- PT: Agrupa linhas iguais e permite calcular soma, média, contagem, etc.
sql
GROUP BY c.name

## ORDER BY
-- EN: Sorts the results, ascending (ASC) or descending (DESC).
-- PT: Ordena os resultados, ascendente (ASC) ou descendente (DESC).
sql
ORDER BY total_sales DESC

## LIMIT
-- EN: Limits how many rows appear in the result.
-- PT: Limita quantas linhas aparecem no resultado.

sql
LIMIT 5