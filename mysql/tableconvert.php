<?php
// connect your database here first
    $dbhost = 'localhost';
    $dbuser = 'root';
    $dbpass = '1cand01t';

    $conn = mysql_connect($dbhost, $dbuser, $dbpass) or die ('Error connecting to mysql');
    $dbname = 'sbdActive_IST';
    mysql_select_db($dbname);

// Actual code starts here
    $sql = "SHOW tables";
    $rs = mysql_query($sql);
    while($row = mysql_fetch_array($rs))
    {
        $tbl = $row[0];
        $sql = "ALTER TABLE $tbl ENGINE=INNODB";
        mysql_query($sql);
    }
?>