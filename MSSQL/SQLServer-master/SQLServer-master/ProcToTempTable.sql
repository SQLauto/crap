/*

Select query from a stored procedure into a temporary table

*/

SELECT * INTO #zTempTablez 
FROM OPENROWSET('SQLNCLI'
     , 'Server=SERVER\INSTANCE;Catalog=DATABASENAME;Trusted_Connection=yes;'
     ,'EXECUTE dbo.stp_StoredProcedureName')
