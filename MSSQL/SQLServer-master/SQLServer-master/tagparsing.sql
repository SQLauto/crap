/*

Tag parsing for HTML or XML between text in tags

*/

DECLARE @string VARCHAR(100)
SET @string = '<durkah> durkah durkah durkah durkah </durkah>'
DECLARE @minus INT
SELECT @minus = CHARINDEX('>',@string)

SELECT SUBSTRING(@string,@minus+1,CHARINDEX('</',@string)-@minus-1)
