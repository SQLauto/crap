select user, host, db, create_priv, select_priv, insert_priv, grant_priv, delete_priv, alter_priv, drop_priv
FROM mysql.db
INTO outfile '/tmp/userperms.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';