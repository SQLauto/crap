/* Simple Energy Invoice Example */

/*

-- Billing By Unit Table
SELECT 1 AS UnitID, 21.5 AS CostPerUnit
INTO UnitCost
INSERT INTO UnitCost VALUES(2, 17.9),(3,13.0),(4,12.7),(5,8.6)

SELECT *
FROM UnitCost

-- Billing Cycle Table
SELECT 9 AS CycleID, 'September' AS Month
INTO MonthID
INSERT INTO MonthID VALUES(2,'February'),(3,'March'),(4,'April'),(5,'May'),(6,'June'),(7,'July'),(8,'August'),(1,'January'),(10,'October'),(11,'November'),(12,'December')

SELECT *
FROM MonthID

-- Customer Information Table
SELECT 1 AS CustomerID
, 2 AS UnitID
, 'John Smith' AS CustomerName
, '3201 NonExist Street' AS Address
, 'ExistNot' AS City
, 'WA' AS State
, '55512' AS ZipCode
INTO Customer

INSERT INTO Customer VALUES (2,1,'Joe Moe','123 Right St','Right','WA','55512')
INSERT INTO Customer VALUES (3,4,'Sarah Smith','114 Two St',Left','NY','55147')

SELECT *
FROM Customer

-- Customer Usage
SELECT 1 AS CustomerID, 1 AS Month, 3.5 AS UsedUnits
INTO Usage

INSERT INTO Usage VALUES(1,2,3.2),(1,3,4),(2,1,4),(2,2,6.7),(2,3,5.2)

SELECT *
FROM Usage

DROP TABLE UnitCost
DROP TABLE MonthID
DROP TABLE Customer
DROP TABLE Usage


*/

DECLARE @PastMonth VARCHAR(9)
DECLARE @CurrentMonth VARCHAR(9)
SELECT @PastMonth = Month FROM MonthID WHERE MONTH(DATEADD(MM,-1,getdate())) = CycleID
SELECT @CurrentMonth = Month FROM MonthID WHERE MONTH(getdate()) = CycleID

SELECT @PastMonth + ' 15 - ' + @CurrentMonth + ' 15, ' + CAST(YEAR(getdate()) AS VARCHAR(4)) AS BillingCycle
, C.CustomerName
, C.Address
, C.City
, C.State
, C.ZipCode
, MonthlUsage = U.UsedUnits
, MonthlyCharge = UC.CostPerUnit * U.UsedUnits
FROM Customer C
	INNER JOIN UnitCost UC ON C.UnitID = UC.UnitID
	INNER JOIN Usage U ON C.CustomerID = U.CustomerID AND MONTH(DATEADD(MM,-1,getdate())) = U.Month