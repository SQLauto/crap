/* 

Trigger for recording inserts into a table in an audting table

*/

CREATE TRIGGER OurAuditTrigger
	ON OurTableName
	FOR INSERT
AS
	INSERT INTO OurAuditTable VALUES ('Insert',getdate())
