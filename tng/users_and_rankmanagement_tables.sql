CREATE TABLE rankmanagement(
	rankid INT unsigned PRIMARY KEY auto_increment
	,rankname VARCHAR(20) NOT NULL
)
;

INSERT INTO users(
	username
	,birthday
	,created_at
)
VALUE (
	'green'
	,'2024-01-26'
	,NOW()
)
;

TRUNCATE TABLE users;

ALTER TABLE rankmanagement
ADD COLUMN userid INT UNSIGNED NOT null
;

ALTER TABLE rankmanagement
	ADD CONSTRAINT PK_RANKMANAGEMENT_USERID
		Foreign KEY (userid)
		REFERENCES users(userid)
;

INSERT INTO rankmanagement(
	rankname
	,userid
)
VALUE (
	'manager'
	,1
)
;

SELECT 
	us.username
	,us.birthday
	,rmg.rankname
FROM rankmanagement rmg
	JOIN users us
		ON  us.userid = rmg.userid
;
		