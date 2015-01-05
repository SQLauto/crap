-- Check if a database exists
SELECT DB_ID('OurDatabaseName')

-- Check if an object exists in a specific database will return a number (a NULL means it doesn't exist)
SELECT OBJECT_ID('OurDatabaseName..OurObjectName')
