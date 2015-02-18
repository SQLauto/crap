CREATE PROCEDURE list_privileges (IN db_name CHAR(50))
BEGIN
    SELECT concat(Db,'.', '*') as 'what', User, Host, '...' as 'perms'
    FROM mysql.db
    WHERE Db=db_name
    UNION
    SELECT concat(Db,'.', Table_name), User, Host, table_priv
    FROM mysql.tables_priv
    WHERE Db=db_name and table_priv != ''
    UNION
    SELECT concat(Db,'.', Table_name, '(', Column_name,')'), User, Host, Column_priv
    FROM mysql.columns_priv
    WHERE Db=db_name
    UNION
    SELECT concat(Db,'.', Routine_name, '()'), User, Host, Proc_priv
    FROM mysql.procs_priv
    WHERE Db=db_name;
END//
