USE [US]
GO
/****** Object:  StoredProcedure [dbo].[Terabitz_Image_Transfer]    Script Date: 7/16/2014 1:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Terabitz_Image_Transfer]
@LinkedServer nvarchar (1000),
@MLSDBName nvarchar (100),
@Datasource nvarchar (100),
@StartDate nvarchar (20),
@DateInterval nvarchar (20),
@Incremental nvarchar (1)
AS
BEGIN

IF OBJECT_ID('tempdb..#tb_property_list') IS NOT NULL DROP TABLE #tb_property_list

CREATE TABLE #tb_property_list (
	[ID] varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TERABITZ_ID] bigint NULL
);


CREATE NONCLUSTERED INDEX [TerabitzID]
ON #tb_property_list ([ID] ASC, [TERABITZ_ID] ASC)
WITH (
	PAD_INDEX = OFF,
	IGNORE_DUP_KEY = OFF,
	STATISTICS_NORECOMPUTE = OFF,
	SORT_IN_TEMPDB = OFF,
	ONLINE = OFF,
	ALLOW_ROW_LOCKS = ON,
	ALLOW_PAGE_LOCKS = ON
)


DECLARE
	@OPENQUERY nvarchar (4000),
	@TSQL nvarchar (MAX),
	@PHOTO_DELETE_SQL nvarchar(MAX),
	@PHOTO_INSERT_SQL nvarchar(MAX),
	@WHERE_SQL nvarchar(MAX)

IF @LinkedServer IS NULL
BEGIN
	SET @LinkedServer = 'TBPRODMAN'
END

IF @MLSDBName IS NULL
BEGIN
	SET @MLSDBName = 'mls_az_azrmls'
END

IF @Datasource IS NULL
BEGIN
	SET @Datasource = 'azrmls'
END

IF @StartDate IS NULL
BEGIN
	SET @StartDate = '2014-04-07'
END

IF @DateInterval IS NULL
BEGIN
	SET @DateInterval = 'DAY'
END

IF @Incremental IS NULL
BEGIN
	SET @Incremental = '1'
END

IF @Incremental = '1'
BEGIN
	SET @WHERE_SQL = '(
							common.in_modify_date BETWEEN DATEADD( [' + @DateInterval + '], -1, ''' + @StartDate + ''') AND ''' + @StartDate + '''
							OR ( 
									common.in_load_date BETWEEN DATEADD([' + @DateInterval + '], -1, ''' + @StartDate + ''') AND ''' + @StartDate + '''
								AND 
									common.in_modify_date IS NULL 
								) 
						)'
END
ELSE
	SET @WHERE_SQL = '(	common.in_list_date BETWEEN DATEADD( [' + @DateInterval + '], -1, ''' + @StartDate + ''') AND ''' + @StartDate + ''' )'


SET @OPENQUERY = 'INSERT INTO #tb_property_list SELECT * FROM OPENQUERY(' + @LinkedServer + ','''
SET @TSQL = 'SELECT ID,TERABITZ_ID FROM `' + @MLSDBName + '`.property_ptnf WHERE DATASOURCE=''''' + @Datasource + ''''''')' 

EXEC (@OPENQUERY +@TSQL);

SET @PHOTO_DELETE_SQL = '
delete FROM OPENQUERY(' + @LinkedServer + ', ''SELECT * FROM `' + @MLSDBName + '`.links_ptnf'') 
WHERE 
TERABITZ_ID IN (
	
		SELECT 
			TERABITZ_ID 
		FROM 
			#tb_property_list
		INNER JOIN
			dbo.data_common_onmarket common
				ON #tb_property_list.ID = common.listing_id AND common.org_id = ''' + @Datasource + '''
		WHERE ' + @WHERE_SQL + '
	UNION 
		SELECT 
			TERABITZ_ID 
		FROM 
			#tb_property_list
		INNER JOIN
			dbo.data_common_offmarket common
				ON #tb_property_list.ID = common.listing_id AND common.org_id = ''' + @Datasource + '''
		WHERE ' + @WHERE_SQL + '
)'

--SELECT @PHOTO_DELETE_SQL
EXEC(@PHOTO_DELETE_SQL);

SET @PHOTO_INSERT_SQL = '
insert INTO OPENQUERY(' + @LinkedServer + ', ''SELECT TERABITZ_ID, TYPE, CAPTION, URL, PHOTOORDER FROM `' + @MLSDBName + '`.links_ptnf'') 
	SELECT
		#tb_property_list.TERABITZ_ID,
		''Photo'' AS TYPE,
		photos.photo_caption AS CAPTION,
		''http://mlsimage.fnisrediv.com/ListingImages/'' + photos.org_id + CASE display_sequence WHEN 1 THEN ''/images/'' ELSE ''/addl_picts/'' END + [File_name] AS URL,
		photos.display_sequence AS PHOTOORDER
	FROM
	  dbo.listing_photos photos
	INNER JOIN
		#tb_property_list
			ON photos.listing_id = #tb_property_list.ID
	INNER JOIN
		dbo.data_common_onmarket common
			ON (photos.org_id = common.org_id) AND (photos.listing_id = common.listing_id)
	WHERE
	' + @WHERE_SQL + '
	AND 
		photos.org_id = ''' + @Datasource + '''
UNION 
	SELECT
		#tb_property_list.TERABITZ_ID,
		''Photo'' AS TYPE,
		photos.photo_caption AS CAPTION,
		''http://mlsimage.fnisrediv.com/ListingImages/'' + photos.org_id + CASE display_sequence WHEN 1 THEN ''/images/'' ELSE ''/addl_picts/'' END + [File_name] AS URL,
		photos.display_sequence AS PHOTOORDER
	FROM
	  dbo.listing_photos photos
	INNER JOIN
		#tb_property_list
			ON photos.listing_id = #tb_property_list.ID
	INNER JOIN
		dbo.data_common_offmarket common
			ON (photos.org_id = common.org_id) AND (photos.listing_id = common.listing_id)
	WHERE
	' + @WHERE_SQL + '
	AND 
		photos.org_id = ''' + @Datasource + '''
'

EXEC(@PHOTO_INSERT_SQL);

SET @PHOTO_INSERT_SQL = 'SELECT * FROM OPENQUERY(' + @LinkedServer + ', ''CALL `' + @MLSDBName + '`.Sync_Properties_Images()'')'

EXEC(@PHOTO_INSERT_SQL);

DROP TABLE #tb_property_list

END
