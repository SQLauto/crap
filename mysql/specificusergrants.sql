SELECT user, host, password, select_priv, insert_priv, delete_priv, shutdown_priv, grant_priv 
FROM mysql.user where user='cable_label';