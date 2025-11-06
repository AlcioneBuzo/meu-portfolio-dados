-- 16. Create a Stored Procedure to insert a product into the products table, register a log of the insertion, and execute it to insert multiple products at once.
USE sales_company;

DELIMITER //

CREATE PROCEDURE AddProductAdvanced(
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_stock INT
)
BEGIN
    DECLARE new_id INT;

    -- insert product into products table
    INSERT INTO products(name, price, stock)
    VALUES (p_name, p_price, p_stock);

    -- Get the ID of the product just inserted
    SET new_id = LAST_INSERT_ID();

    -- Log insertion
    INSERT INTO product_log(product_id, operation, log_date)
    VALUES (new_id, 'Product Added', NOW());
END //

DELIMITER ;

-- Insert multiple products 
CALL AddProductAdvanced('Notebook', 1200.00, 10);
CALL AddProductAdvanced('Mouse', 50.00, 25);
CALL AddProductAdvanced('Keyboard', 150.00, 20);
CALL AddProductAdvanced('Monitor', 800.00, 15);
CALL AddProductAdvanced('Printer', 600.00, 5);
CALL AddProductAdvanced('Headset', 120.00, 30);
CALL AddProductAdvanced('Webcam', 200.00, 12);
CALL AddProductAdvanced('Tablet', 900.00, 8);
CALL AddProductAdvanced('Smartphone', 1500.00, 20);
CALL AddProductAdvanced('External HD', 350.00, 18);
CALL AddProductAdvanced('USB Cable', 20.00, 50);
CALL AddProductAdvanced('Router', 300.00, 10);
CALL AddProductAdvanced('Speaker', 250.00, 15);
CALL AddProductAdvanced('Microphone', 180.00, 10);
CALL AddProductAdvanced('Charger', 60.00, 25);

SELECT 
    p.product_id,
    p.name AS product_name,
    p.price,
    p.stock,
    l.operation AS log_operation,
    l.log_date
FROM products p
LEFT JOIN product_log l
ON p.product_id = l.product_id
ORDER BY p.product_id;
