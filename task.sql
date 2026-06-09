DROP DATABASE ShopDB;

CREATE DATABASE ShopDB;
USE ShopDB;

DELIMITER //
CREATE PROCEDURE get_warehouse_product_inventory(IN p_warehouse_id INT)
BEGIN
	SELECT pr.Name AS ProductName,
		   pi.WarehouseAmount AS Amount
	FROM ProductInventory pi
	JOIN Products pr ON pr.ID = pi.ProductID
	WHERE pi.WarehouseID = p_warehouse_id;
END //
DELIMITER ;

