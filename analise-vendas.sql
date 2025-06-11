-- Análise de vendas por região 
SELECT 
    regiao,
    SUM(vendas) AS total_vendas
FROM vendas
GROUP BY regiao;
