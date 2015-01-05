CREATE PROCEDURE [dbo].[USP_AlterIndex_Defragment]
   AS
	BEGIN
		DECLARE @TableName VARCHAR(200)
		DECLARE cur_index CURSOR FOR
		SELECT  DISTINCT ss.NAME +'.'+
		OBJECT_NAME(dt.object_id) Tablename
		FROM    ( SELECT    object_id ,
		index_id ,
		avg_fragmentation_in_percent ,
		fragment_count,
		avg_fragment_size_in_pages,
		page_count,
		avg_page_space_used_in_percent
		FROM      sys.dm_db_index_physical_stats(DB_ID('HMY_TEST'),
		NULL, NULL, NULL,
		'DETAILED')
		WHERE     index_id <> 0
		) AS dt
		INNER JOIN sys.indexes si ON si.object_id = dt.object_id
		AND si.index_id = dt.index_id
		AND dt.avg_fragmentation_in_percent > 10
		--AND dt.avg_page_space_used_in_percent < 75
		INNER JOIN sys.objects so ON so.object_id = dt.OBJECT_ID
		INNER JOIN sys.schemas ss ON ss.schema_id = so.schema_id
		ORDER BY Tablename DESC
		OPEN cur_index
		FETCH NEXT
	FROM cur_index
	INTO @TableName
		WHILE @@FETCH_STATUS = 0
			BEGIN
				EXEC('ALTER INDEX ALL ON ' + @TableName + ' REBUILD WITH (FILLFACTOR=90,ONLINE=OFF)')
		FETCH NEXT
	FROM cur_index
	INTO @TableName
		END
	CLOSE cur_index ;
	DEALLOCATE cur_index ;
	END