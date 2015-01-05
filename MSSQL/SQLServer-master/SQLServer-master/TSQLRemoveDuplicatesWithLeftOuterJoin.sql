/* 

	LEFT OUTER JOIN to remove duplicates 
	
*/

-- Build experiment table
DECLARE @dup TABLE(
	ColumnOne VARCHAR(1),
	ColumnTwo INT
)

-- Insert experiment values
INSERT INTO @dup VALUES('A',1)
INSERT INTO @dup VALUES('A',2)
INSERT INTO @dup VALUES('B',3)
INSERT INTO @dup VALUES('C',4)
INSERT INTO @dup VALUES('D',5)
INSERT INTO @dup VALUES('E',6)
INSERT INTO @dup VALUES('E',7)
INSERT INTO @dup VALUES('E',8)
INSERT INTO @dup VALUES('E',9)


SELECT *
FROM @dup


-- Remove the duplicates
DELETE @dup
FROM @dup A
	LEFT OUTER JOIN (SELECT ColumnOne, ColumnTwo = MIN(ColumnTwo) FROM @dup GROUP BY ColumnOne) B ON A.ColumnTwo = B.ColumnTwo
WHERE B.ColumnTwo IS NULL

-- See the results
SELECT *
FROM @dup
