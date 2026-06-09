-- Ensure we are using the test database
USE ShopDB;

-- Ensure ProductInventory table exists (idempotent).
-- Avoid FK constraints here so this script can run independently of creation order.
CREATE TABLE IF NOT EXISTS ProductInventory (
	ID INT PRIMARY KEY,
	ProductID INT,
	WarehouseAmount INT,
	WarehouseID INT
);

-- Insert sample rows required by tests (idempotent - will update if PK exists)
INSERT INTO ProductInventory (ID, ProductID, WarehouseAmount, WarehouseID)
VALUES (1, 1, 2, 1)
ON DUPLICATE KEY UPDATE ProductID=VALUES(ProductID), WarehouseAmount=VALUES(WarehouseAmount), WarehouseID=VALUES(WarehouseID);
INSERT INTO ProductInventory (ID, ProductID, WarehouseAmount, WarehouseID)
VALUES (2, 1, 4242, 2)
ON DUPLICATE KEY UPDATE ProductID=VALUES(ProductID), WarehouseAmount=VALUES(WarehouseAmount), WarehouseID=VALUES(WarehouseID);

DELIMITER //
DROP PROCEDURE IF EXISTS get_warehouse_product_inventory;//
CREATE PROCEDURE get_warehouse_product_inventory(IN p_warehouse_id INT)
BEGIN
	SELECT pr.Name AS ProductName,
		   pi.WarehouseAmount AS Amount
	FROM ProductInventory pi
	JOIN Products pr ON pr.ID = pi.ProductID
	WHERE pi.WarehouseID = p_warehouse_id;
END //
DELIMITER ;

