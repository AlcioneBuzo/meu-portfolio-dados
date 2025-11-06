-- EXERCÍCIOS AVANÇADOS / ADVANCED EXERCISES

-- 16. Create a Stored Procedure to insert a product into the products table, register a log of the insertion / Criar uma Procedure para inserir um produto na tabela products e registrar no log
USE sales_company;

DELIMITER //

CREATE PROCEDURE AddProductAdvanced(
    IN p_name VARCHAR(100),        -- product name / nome do produto
    IN p_price DECIMAL(10,2),     -- product price / preço do produto
    IN p_stock INT,                -- product stock / estoque do produto
    IN p_category_id INT,  -- optional category / categoria opcional
    IN p_description TEXT  -- optional description / descrição opcional
)
BEGIN
    DECLARE new_id INT; -- variable to store new product ID / variável para armazenar o ID do novo produto

    -- Insert product into products table / Inserir o produto na tabela products
    INSERT INTO products(name, price, stock, category_id, description)
    VALUES (p_name, p_price, p_stock, p_category_id, p_description);

    -- Get the ID of the product just inserted / Pegar o ID do produto que acabou de ser inserido
    SET new_id = LAST_INSERT_ID();

    -- Register insertion in product_log / Registrar a inserção no product_log
    INSERT INTO product_log(product_id, operation, log_date)
    VALUES (new_id, 'Product inserted', NOW());
END //

DELIMITER ;

-- 17. Create a Trigger to automatically update product stock when a new item is added to sale_items / Criar uma Trigger que atualiza automaticamente o estoque do produto
DELIMITER //

CREATE TRIGGER AfterSaleItemInsert
AFTER INSERT ON sale_items  -- fires after each insert on sale_items / dispara após cada insert na tabela sale_items
FOR EACH ROW                -- executes for each inserted row / executa para cada linha inserida
BEGIN
    -- Update product stock by subtracting sold quantity / Atualiza o estoque do produto subtraindo a quantidade vendida
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

DELIMITER ;

-- 18. Create a View showing the total amount spent by each customer / Criar uma View mostrando o total gasto por cada cliente
CREATE OR REPLACE VIEW CustomerTotalSpent AS
SELECT 
    c.customer_id,  -- customer ID / ID do cliente
    c.name,         -- customer name / nome do cliente
    SUM(si.unit_price * si.quantity - si.discount) AS total_spent  -- total spent / total gasto
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN sale_items si ON s.sale_id = si.sale_id
GROUP BY c.customer_id, c.name;

-- 19. Create a Function to calculate the total price of a sale item after discount / Criar uma função para calcular o preço total de um item com desconto
DELIMITER //

CREATE FUNCTION CalcItemTotal(unit_price DECIMAL(10,2), quantity INT, discount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC  -- always returns the same result for same input / sempre retorna o mesmo resultado para os mesmos parâmetros
BEGIN
    RETURN (unit_price * quantity) - discount;  -- total calculation / cálculo do total
END //

DELIMITER ;

-- 20. Create a Trigger to log price changes in products / Criar uma trigger para registrar alterações de preço
DELIMITER //

CREATE TRIGGER LogPriceUpdate
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    -- Check if price changed / Verifica se o preço mudou
    IF OLD.price <> NEW.price THEN
        INSERT INTO product_log(product_id, operation, log_date)
        VALUES (
            NEW.product_id,
            CONCAT('Price changed from ', OLD.price, ' to ', NEW.price),
            NOW()
        );
    END IF;
END //

DELIMITER ;
