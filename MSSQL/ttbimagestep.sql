DECLARE @Today nvarchar(10)
SET @Today=FORMAT(GETDATE(), 'yyyy-MM-dd')
EXEC dbo.Terabitz_Image_Transfer @LinkedServer='TBPRODSERVER',@MLSDBName='mls_ca_carets',@Datasource='caclaw',@StartDate=@Today,@DateInterval='DAY',@Incremental='1'