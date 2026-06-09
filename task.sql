DROP DATABASE IF EXISTS ShopDB;
CREATE DATABASE ShopDB;
USE ShopDB;

CREATE TABLE IF NOT EXISTS Products (
	ID INT PRIMARY KEY,
	Name VARCHAR(50)
);
INSERT INTO Products (ID, Name)
VALUES (1, 'AwersomeProduct')
ON DUPLICATE KEY UPDATE Name=VALUES(Name);

CREATE TABLE IF NOT EXISTS ProductInventory (
	ID INT PRIMARY KEY,
	ProductID INT,
	WarehouseAmount INT,
	WarehouseID INT
);

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

