/* 

MERGE example

*/

USE SSIS
GO

CREATE TABLE zData (
	ID INT IDENTITY,
	Account INT NULL,
	TransactionNumber INT NULL,
	Name VARCHAR(50) NULL,
	Amount DECIMAL(5,2) NULL,
	UpdateTime SMALLDATETIME
)

CREATE TABLE zFlow (
	ID INT IDENTITY,
	Account INT NULL,
	TransactionNumber INT NULL,
	Name VARCHAR(50) NULL,
	Amount DECIMAL(5,2) NULL,
	UpdateTime SMALLDATETIME
)

INSERT INTO zData VALUES (50000,32500,'Gasoline',22.5,DATEADD(DD,-1,getdate()))
INSERT INTO zData VALUES (50001,32501,'Natural Gas',27.4,DATEADD(DD,-1,getdate()))
INSERT INTO zData VALUES (50002,32502,'Gasoline',42.5,DATEADD(DD,-1,getdate()))
INSERT INTO zData VALUES (50003,32503,'Carbon Dioxide',22.7,DATEADD(DD,-1,getdate()))
INSERT INTO zData VALUES (50004,32504,'Gasoline',56.5,DATEADD(DD,-1,getdate()))
INSERT INTO zData VALUES (50005,32505,'Gas',4.2,getdate())


INSERT INTO zFlow VALUES (50005,32505,'Gas',18.3,getdate())
INSERT INTO zFlow VALUES (50000,32506,'Gasoline',0,DATEADD(HH,-5,getdate()))
INSERT INTO zFlow VALUES (50001,32507,'Natural Gas',0,DATEADD(HH,-5,getdate()))
INSERT INTO zFlow VALUES (50002,32508,'Gasoline',0,DATEADD(HH,-5,getdate()))
INSERT INTO zFlow VALUES (50003,32509,'Carbon Dioxide',0,DATEADD(HH,-5,getdate()))
INSERT INTO zFlow VALUES (50004,32510,'Gasoline',0,DATEADD(HH,-5,getdate()))


SELECT *
FROM zData

SELECT *
FROM zFlow

MERGE zData AS t
USING zFlow AS s
ON (t.Account = s.Account AND t.TransactionNumber = s.TransactionNumber)
WHEN MATCHED THEN
	UPDATE SET t.Amount = s.Amount, t.UpdateTime = s.UpdateTime
WHEN NOT MATCHED THEN
	INSERT (Account,TransactionNumber,Name,Amount,UpdateTime) VALUES (s.Account, s.TransactionNumber, s.Name, s.Amount, s.UpdateTime);

SELECT *
FROM zData

TRUNCATE TABLE zFlow -- Clear our update table

INSERT INTO zFlow VALUES (50000,32506,'Gasoline',22,getdate())
INSERT INTO zFlow VALUES (50001,32507,'Natural Gas',47.8,getdate())
INSERT INTO zFlow VALUES (50002,32508,'Gasoline',23.1,getdate())
INSERT INTO zFlow VALUES (50003,32509,'Carbon Dioxide',41.4,getdate())
INSERT INTO zFlow VALUES (50004,32510,'Gasoline',61.3,getdate())
INSERT INTO zFlow VALUES (50005,32511,'Gas',15.4,getdate())


MERGE zData AS t
USING zFlow AS s
ON (t.Account = s.Account AND t.TransactionNumber = s.TransactionNumber)
WHEN MATCHED THEN
	UPDATE SET t.Amount = s.Amount, t.UpdateTime = s.UpdateTime
WHEN NOT MATCHED THEN
	INSERT (Account,TransactionNumber,Name,Amount,UpdateTime) VALUES (s.Account, s.TransactionNumber, s.Name, s.Amount, s.UpdateTime);

SELECT *
FROM zData

-- Clean
DROP TABLE zData
DROP TABLE zFlow