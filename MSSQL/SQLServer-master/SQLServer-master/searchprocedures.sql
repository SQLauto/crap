/* 

Search for text in procedure

*/


DECLARE @sql NVARCHAR(MAX), @find VARCHAR(100)
SET @find = 'tbUserSettings'


SET @sql = ';WITH CheckAll AS(
	SELECT id ObjectID
		, o.name ObjectName
		, text ObjectText
	FROM sys.syscomments c
		INNER JOIN sys.objects o ON c.id = o.object_id 
	WHERE text LIKE ''%' + @find + '%''
)
SELECT DISTINCT ObjectID
	, ObjectName
FROM CheckAll'


EXECUTE sp_executesql @sql
