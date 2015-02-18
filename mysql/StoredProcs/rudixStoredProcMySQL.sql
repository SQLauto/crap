DELIMITER //

CREATE PROCEDURE `proc_IN` 
(IN DNIS VARCHAR(20),
IN MSISDN VARCHAR(20),
IN AVPAIR1 VARCHAR(20),
IN AVPAIR2 VARCHAR(20),
OUT DNS1 VARCHAR(20),
OUT DNS2 VARCHAR(20),
OUT AUTHSTAT VARCHAR(100))

dns1_tmp = GRP.DNS1;
dns2_tmp =  GRP.DNS2;
avpair1_tmp varchar(100);
avpair2_tmp varchar(100);
grpid_tmp number;
GROUPID number;
newmsisdn varchar(12) := MSISDN;
newdnis  varchar(12) := DNIS;

CURSOR C_USER IS
	SELECT AvPair1, AvPair2, DNS1, DNS2, GRP.GROUPID
		FROM grp, allmember
        WHERE grp.dnis=newdnis
        AND allmember.msisdn=newmsisdn AND allmember.groupid=grp.groupid
UNION
	SELECT AvPair1, AvPair2, DNS1, DNS2, GRP.GROUPID
		FROM grp
        WHERE grp.dnis=newdnis and grp.universal = 1;
        
BEGIN
OPEN C_USER;
FETCH C_USER INTO AVPAIR1, AVPAIR2, DNS1, DNS2, GROUPID;
LOOP
	FETCH C_USER INTO avpair1_tmp, avpair2_tmp, dns1_tmp, dns2_tmp, grpid_tmp;
    EXIT WHEN C_USER%NOTFOUND;
    INSERT INTO duplog VALUES(DNIS, MSISDN, avpair1_tmp, avpair2_tmp, dns1_tmp,dns2_tmp, grpid_tmp, SYSDATE);
END LOOP;

IF C_USER%ROWCOUNT > 1 THEN
	  INSERT INTO duplog VALUES(DNIS, MSISDN, AVPAIR1, AVPAIR2, DNS1,DNS2, GROUPID, SYSDATE);
	AUTHSTAT := 'ok';
ELSIF C_USER%ROWCOUNT = 1 THEN
	AUTHSTAT := 'ok';
ELSE
	AUTHSTAT := NULL;
END IF;

CLOSE C_USER;
COMMIT;
END //

DELIMITER ;