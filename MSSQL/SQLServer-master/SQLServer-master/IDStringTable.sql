DECLARE @string TABLE(
     StringID INT IDENTITY(1,1),
     StringName VARCHAR(100)
)

DECLARE @begin INT = 1
DECLARE @max INT
DECLARE @string VARCHAR(100)
SELECT @max = MAX(StringID) FROM @string
SET @max = @max + 1

WHILE @begin < @max
BEGIN
     SELECT @string = StringName FROM @string WHERE StringID = @begin

     -- Do Loop Logic

     SET @begin = @begin + 1
END
