DELIMITER //
CREATE PROCEDURE mysql.GetUserPrivileges(IN userName VARCHAR(255))
BEGIN
SELECT user, host, db, create_priv, select_priv, insert_priv, grant_priv, delete_priv, alter_priv, drop_priv
FROM mysql.db
WHERE user = userName;
END //
DELIMITER ;