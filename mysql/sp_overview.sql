DELIMITER $$ 
CREATE PROCEDURE mysql.sp_overview()
BEGIN
 
    SELECT s.SCHEMA_NAME AS `Database`, s.DEFAULT_CHARACTER_SET_NAME AS `Charset`,
        COUNT(t.TABLE_NAME) AS `Tables`,
 
        (SELECT COUNT(*) FROM information_schema.ROUTINES AS r
            WHERE r.routine_schema = s.SCHEMA_NAME) AS `Routines`,
 
         round(SUM(t.DATA_LENGTH + t.INDEX_LENGTH) / 1048576 ,1) AS `Size Mb`
 
        FROM information_schema.SCHEMATA AS s
            LEFT JOIN information_schema.TABLES t ON s.schema_name = t.table_schema
        WHERE s.SCHEMA_NAME NOT IN ('information_schema', 'performance_schema')
 
    GROUP BY s.SCHEMA_NAME;
END$$
DELIMITER ;