# My Quick SQL Tips / Minhas Dicas Rápidas de SQL

## JOIN / INNER JOIN
-- EN: Joins two tables showing **only the matching rows in both**.  
-- PT: Junta duas tabelas mostrando **só o que bate nas duas**.
```sql
FROM sales s
JOIN products p ON s.product_id = p.product_id;

-- LEFT JOIN
-- EN: Joins two tables showing all rows from the left table, even if there’s no match on the right.
-- PT: Junta duas tabelas mostrando todas as linhas da tabela da esquerda, mesmo se não houver correspondência na direita.
FROM products p
LEFT JOIN sale_items si ON p.product_id = si.product_id;


-- GROUP BY
-- EN: Groups identical rows and allows calculating sum, average, count, etc.
-- PT: Agrupa linhas iguais e permite calcular soma, média, contagem, etc.
GROUP BY c.name;

-- ORDER BY
-- EN: Sorts the results, ascending (ASC) or descending (DESC).
-- PT: Ordena os resultados, ascendente (ASC) ou descendente (DESC).
ORDER BY total_sales DESC;

-- LIMIT
-- EN: Limits how many rows appear in the result.
-- PT: Limita quantas linhas aparecem no resultado.
LIMIT 5;

-- Ref 6 – Intermediate Example / Exemplo Intermediário
-- List all customers who have placed more than 5 orders
-- Lista todos os clientes que fizeram mais de 5 pedidos
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING total_orders > 5;
-- COUNT(order_id) counts how many orders each customer made / Conta quantos pedidos cada cliente fez
-- GROUP BY customer_id groups the orders by customer / Agrupa os pedidos por cliente
-- HAVING total_orders > 5 filters after grouping, only customers with more than 5 orders / Filtra clientes com mais de 5 pedidos

SQL – INSERT INTO vs PROCEDURE

-- Comparison table showing pros and cons / Tabela comparando prós e contras
| Característica                  | INSERT INTO                           | PROCEDURE (CALL)                           |
|---------------------------------|--------------------------------------|-------------------------------------------|
| **Quantidade de código**        | Cada linha precisa ser escrita manualmente | Escreve a lógica **uma vez**, só chama com diferentes parâmetros |
| **Complexidade da lógica**      | Só insere; precisa de queries extras para atualizar estoque ou log | Insere, atualiza estoque, registra log e aplica regras automaticamente |
| **Manutenção**                  | Se mudar a regra, precisa editar cada insert | Só altera a procedure; todas as chamadas seguem a nova regra |
| **Erro humano**                 | Fácil esquecer passos ou errar valores | Menor risco de erro; tudo centralizado na procedure |
| **Uso em massa (200+ produtos)**| Muito repetitivo e propenso a erro   | Mantém consistência e reduz trabalho repetitivo |

-- Triggers

-- EN: A trigger is an SQL code that runs automatically when something happens in a table, like an INSERT, UPDATE, or DELETE.
-- PT: Uma trigger é um código SQL que roda automaticamente quando algo acontece em uma tabela, como um INSERT, UPDATE ou DELETE.
-- Example: Automatically update product stock when a sale item is inserted
CREATE TRIGGER AfterSaleItemInsert
AFTER INSERT ON sale_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END;

-- Triggers automate tasks without manual commands / Automatizam tarefas sem precisar executar comandos manualmente
-- Common examples / Exemplos comuns:
-- - Register insertion or update logs / Registrar logs de inserção ou atualização
-- - Automatically update stock when a sale is registered / Atualizar estoque automaticamente
-- - Validate data or prevent unwanted changes / Validar dados ou impedir alterações indesejadas
