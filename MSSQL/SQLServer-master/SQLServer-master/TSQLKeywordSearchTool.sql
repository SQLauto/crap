-- Enter the keyword
DECLARE @keyword
SET @keyword = ''

-- Replace the Table and Column name only
SELECT *
FROM OurTable
WHERE OurColumn LIKE '%' + @keyword + '%'

/* EXAMPLE */
-- Create test table
DECLARE @test TABLE (
	Line VARCHAR(140)
)

-- Insert some values into the test table
INSERT INTO @test VALUES ('This is the longest Tuesday in history')
INSERT INTO @test VALUES ('Gots me an A+ on my history exam')
INSERT INTO @test VALUES ('African history fascinates me; so much different')

-- Use our keyword search tool
DECLARE @keyword VARCHAR(140)
SET @keyword = 'history'

SELECT *
FROM @test
WHERE Line LIKE '%' + @keyword + '%'