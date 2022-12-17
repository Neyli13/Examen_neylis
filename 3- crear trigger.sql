USE AdventureWorks2019
GO

CREATE TABLE AlertTable(
ProductID int, 
ProductName varchar(255),
AlertDate DateTime DEFAULT GETDATE(),
AlertType varchar(50),
AlertDescription varchar(255)
);

CREATE TRIGGER StockAlert
ON StockTable
AFTER UPDATE
AS
BEGIN
INSERT INTO AlertTable
SELECT ProductID, ProductName, 'Low Stock', 
'There is only 1 ' + ProductName + ' left' 
FROM inserted
WHERE StockOnHand = 1
END
GO