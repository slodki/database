-- rename table names used in GRM definitions not renamed in buggy v11 to v12 script

UPDATE REPORT SET SQLCONTENT = REPLACE(SQLCONTENT, '_v1', '' ) WHERE SQLCONTENT LIKE '%_v1%';
UPDATE REPORT SET LUACONTENT = REPLACE(LUACONTENT, '_v1', '' ) WHERE LUACONTENT LIKE '%_v1%';
UPDATE REPORT SET TEMPLATECONTENT = REPLACE(TEMPLATECONTENT, '_v1', '' ) WHERE TEMPLATECONTENT LIKE '%_v1%';

-- transfers must always store sepaate statuses for each account

UPDATE CHECKINGACCOUNT SET STATUS = STATUS || STATUS WHERE TRANSCODE = 'Transfer' AND STATUS LIKE '_';
UPDATE BILLSDEPOSITS   SET STATUS = STATUS || STATUS WHERE TRANSCODE = 'Transfer' AND STATUS LIKE '_';

-- remove DATAVERSION replaced with user_version pragma

DELETE FROM INFOTABLE WHERE INFONAME = 'DATAVERSION';

-- rename to something meaningful

UPDATE INFOTABLE SET INFONAME = 'CREATOR' WHERE INFONAME = 'MMEXVERSION';

-- finish

PRAGMA user_version = 14;