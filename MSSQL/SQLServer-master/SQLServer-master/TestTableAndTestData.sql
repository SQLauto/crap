/* 

Experiment table with easy data populate for playing with code

*/

CREATE TABLE zztestzz (
	FirstName VARCHAR(10) NULL,
	LastName VARCHAR(10) NULL,
	Phone VARCHAR(10) NULL,
	EmailAddress VARCHAR(200) NULL
)

DECLARE @cnt INT
SET @cnt = 0

-- Determine how many rows of each you want here
WHILE @cnt < 10
BEGIN
	INSERT INTO zztestzz
	-- Copy and past the values below to do insert after insert in this zztestzz table
	VALUES ('Jane','Doe','8005552121','emailettedoesnotexist@ournonexistentdomain.com')
	SET @cnt = @cnt + 1
END

/* VALUES List:

VALUES ('John','Doe','8005551212','emaildoesnotexist@ournonexistentdomain.com')
VALUES ('Jane','Doe','8005552121','emailettedoesnotexist@ournonexistentdomain.com')
VALUES ('John','Smith','8001112222','john.smith@ournonexistentdomain.com')
VALUES ('Jane','Smith','8002223333','jane.smith@ournonexistentdomain.com')
VALUES ('Kacy','Johnson','8001234567','kacy.johnson@ournonexistentdomain.com')
VALUES ('David','Johnson','8004445555','wildmanofalcatrass@ournonexistentdomain.com')
VALUES ('Joe','Joe','8000000000','ofcoursecommajoe@ournonexistentdomain.com')
VALUES ('Batman','NoLastName','Unlisted','batman@ournonexistentdomain.com')
VALUES ('RealBatman','4Realsies',NULL,'iamtherealbatman@ournonexistentdomain.com')
VALUES ('Scott','Adams','8001001000','dilbertdude@ournonexistentdomain.com')
VALUES ('Mark','Bill','8002002000','firstnameandfirstname@ournonexistentdomain.com')

Or add custom ones:

VALUES ('','','','@ournonexistentdomain.com')

*/

-- Check it
SELECT *
FROM zztestzz

-- Clean up
DROP TABLE zztestzz