/* 

This is a safer delete: a variable automates the checking to ensure the correct number of rows are deleted

*/

BEGIN TRAN

DECLARE @check INT
SELECT @check = COUNT(*) FROM OurTable WHERE OurColumn = Criteria

DELETE FROM OurTable
WHERE OurColumn = Criteria
IF @@ROWCOUNT <> @check
BEGIN
	ROLLBACK TRAN
END
ELSE 
	COMMIT TRAN