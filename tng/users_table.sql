CREATE TABLE users(
	userid INT unsigned PRIMARY KEY auto_increment
	,username VARCHAR(30) NOT NULL COMMENT '이름'
	,authflg CHAR(1) DEFAULT 0
	,birthday DATE NOT NULL
	,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
;

INSERT INTO users(
	username
	,birthday
	,created_at
)
VALUE (
	'그린'
	,'2025-01-26'
	,DATE(NOW())
)
;

START TRANSACTION;
UPDATE users
SET 
	username = '테스터'
	,authFlg = 1
	,birthday = '2007-03-01'
WHERE 
	userid = 1
;

DELETE FROM users
WHERE 
	userid = 1
;

ALTER TABLE users
add COLUMN addr VARCHAR(100) NOT NULL DEFAULT '-'
;

ALTER TABLE users
DROP column addr
;
