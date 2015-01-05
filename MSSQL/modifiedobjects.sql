USE US ;
GO
SELECT  so.name AS ObjectName,
        OBJECT_NAME(so.parent_object_id) AS ParentObjectName,
        SCHEMA_NAME(so.schema_id) AS SchemaName,
        so.type_desc AS ObjectType,
        so.create_date AS ObjectCreationDateTime,
        so.modify_date AS ObjectModificationDateTime,
        so.is_published AS IsPublished
FROM    sys.objects AS so
WHERE   so.is_ms_shipped = 0
ORDER BY CASE WHEN so.parent_object_id = 0 THEN so.object_id
              ELSE so.parent_object_id
         END,
        so.schema_id,
        so.type DESC,
        so.modify_date DESC,
        so.create_date DESC ;
GO
