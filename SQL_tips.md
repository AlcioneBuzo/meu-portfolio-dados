## My Quick SQL Tips / Minhas Dicas Rápidas de SQL
## JOIN / INNER JOIN
-- EN: Joins two tables showing only the matching rows in both.
-- PT: Junta duas tabelas mostrando só o que bate nas duas.

FROM sales s
JOIN products p ON s.product_id = p.product_id

## LEFT JOIN
-- EN: Joins two tables showing all rows from the left table, even if there’s no match on the right.
-- PT: Junta duas tabelas mostrando todas as linhas da tabela da esquerda, mesmo se não houver correspondência na direita.

FROM products p
LEFT JOIN sale_items si ON p.product_id = si.product_id

## GROUP BY
-- EN: Groups identical rows and allows calculating sum, average, count, etc.
-- PT: Agrupa linhas iguais e permite calcular soma, média, contagem, etc.

GROUP BY c.name

## ORDER BY
-- EN: Sorts the results, ascending (ASC) or descending (DESC).
-- PT: Ordena os resultados, ascendente (ASC) ou descendente (DESC).

ORDER BY total_sales DESC

## LIMIT
-- EN: Limits how many rows appear in the result.
-- PT: Limita quantas linhas aparecem no resultado.

LIMIT 5


## 6. List all customers who have placed more than 5 orders / Listar todos os clientes que fizeram mais de 5 pedidos
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING total_orders > 5;
-- COUNT(order_id) conta quantos pedidos cada cliente fez / counts how many orders each customer made
-- GROUP BY customer_id agrupa os pedidos por cliente / groups orders by customer
-- HAVING total_orders > 5 filtra depois de agrupar / filters after grouping, only customers with more than 5 orders

## INSERT INTO vs PROCEDURE
-- | Característica                  | INSERT INTO                           | PROCEDURE (CALL)                           |
-- |---------------------------------|--------------------------------------|-------------------------------------------|
-- | **Quantidade de código**        | Cada linha precisa ser escrita manualmente | Escreve a lógica **uma vez**, só chama com diferentes parâmetros |
-- | **Complexidade da lógica**      | Só insere; precisa de queries extras para atualizar estoque ou log | Insere, atualiza estoque, registra log e aplica regras automaticamente |
-- | **Manutenção**                  | Se mudar a regra, precisa editar cada insert | Só altera a procedure; todas as chamadas seguem a nova regra |
-- | **Erro humano**                 | Fácil esquecer passos ou errar valores | Menor risco de erro; tudo centralizado na procedure |
-- | **Uso em massa (200+ produtos)**| Muito repetitivo e propenso a erro   | Mantém consistência e reduz trabalho repetitivo |


Trigger
-- Uma trigger é um código SQL que roda automaticamente quando algo acontece em uma tabela
-- Serve para automatizar tarefas sem precisar executar comandos manualmente
-- Exemplos: registrar log de inserção/atualização, atualizar estoque automaticamente, validar dados


Resumo rápido:

INSERT INTO → ideal para poucas linhas ou operações simples.
PROCEDURE → centraliza lógica, garante consistência e facilita manutenção, mesmo para centenas de produtos.
Trigger = gatilho automático, executa sozinho quando os dados mudam.
