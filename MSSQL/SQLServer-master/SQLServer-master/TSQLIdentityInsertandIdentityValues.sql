USE OurDatabaseName
GO

-- Build experiment table
CREATE TABLE zCustomer4 (
   CustomerID INT IDENTITY NOT NULL PRIMARY KEY, 
   Name VARCHAR(40) NOT NULL
)


-- Insert values into experiment table
INSERT INTO zCustomer4 (Name) VALUES ('John Doe')
INSERT INTO zCustomer4 (Name) VALUES ('Jane Doe')
INSERT INTO zCustomer4 (Name) VALUES ('John Smith')
INSERT INTO zCustomer4 (Name) VALUES ('Susan Smith')
INSERT INTO zCustomer4 (Name) VALUES ('Sandra Joe')

-- View table
SELECT *
FROM zCustomer4

-- Should return an error because we already have that value
INSERT INTO zCustomer4 (CustomerID, Name) VALUES (1,'New Customer')

-- Delete the original value
DELETE FROM zCustomer4 WHERE CustomerID = 1

-- Try again (it bring up an error message)
INSERT INTO zCustomer4 (CustomerID, Name) VALUES (1,'New Customer')

-- View table (nothing happened)
SELECT *
FROM zCustomer4

-- Turn on IDENTITY_INSERT
SET IDENTITY_INSERT zCustomer4 OFF
INSERT INTO zCustomer4 (CustomerID, Name) VALUES (1,'New Customer')

-- Clean up
DROP TABLE zCustomer4
