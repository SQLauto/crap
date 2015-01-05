/* 

UPDATE Production Receipt

*/

BEGIN TRAN

DECLARE @check INT
SELECT @check = COUNT(*) FROM OurTable WHERE OurColumn = Criteria

UPDATE OurTable
SET OurColumn = NEWVALUE
WHERE OurColumn = Criteria
IF @@ROWCOUNT <> @check
BEGIN
	ROLLBACK TRAN
END
ELSE 
	COMMIT TRAN


/* EXAMPLE */

-- Test table with test values
CREATE TABLE #t(
	Number INT
)

INSERT INTO #t VALUES (1)
INSERT INTO #t VALUES (2)
INSERT INTO #t VALUES (5)
INSERT INTO #t VALUES (4)
SELECT * FROM #t

-- Begin the safe update
BEGIN TRAN

DECLARE @check INT
SELECT @check = COUNT(*) FROM #t WHERE Number = 5

UPDATE #t
SET Number = 3
WHERE Number = 5
IF @@ROWCOUNT <> @check
BEGIN
	ROLLBACK TRAN
END
ELSE 
	COMMIT TRAN

SELECT * FROM #t
