USE [master]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[DatabaseIntegrityCheck]
		@Databases = N'ALL_DATABASES'

SELECT	'Return Value' = @return_value

GO
