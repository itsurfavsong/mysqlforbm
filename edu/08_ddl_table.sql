-- DB 생성
CREATE DATABASE mydb;

-- DB 선택
USE mydb;

-- DB 삭제
DROP DATABASE mydb;

-- 스키마: CREATE, ALTER, DROP

-- ---------------
-- 테이블 생성
-- ---------------
-- bigint unsigned -> 데이터 타입
-- primary key auto_increment -> 조건
CREATE TABLE users(
	id BIGINT unsigned PRIMARY KEY auto_increment
	,`name` VARCHAR(50) NOT NULL COMMENT '이름'
	,gender CHAR(1) NOT NULL COMMENT 'F는 여자, M은 남자(대문자로 적을 것), N은 선택안함'
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
-- 	윗줄에 now()를 넣으면 테이블을 만들려고 테이블을 선택할때의 시간으로 적힘.
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME 
-- 	deleted_at 은 사실 null로 default 값을 줘야된다...
)
-- 데이터 베이스를 세심하게 쓰고 싶다. (조건)
-- ENGINE=INNODB
-- innodb는 select의 속도가 빠른 아이. (디폴트값)
-- CHARSET=UTF8MB4 
-- COLLATE=utf8mb4_bin
;

-- 게시글 테이블
-- pk 1개, user number, title, content, created_at, updated_at, deleted_at
CREATE TABLE articles(
	id BIGINT unsigned PRIMARY KEY auto_increment
	,user_id BIGINT UNSIGNED NOT NULL
	,title VARCHAR(200) NOT NULL COMMENT '제목'
	,content VARCHAR(2000) NOT NULL COMMENT '내용'
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME 
)
;

-- 선생님이 작성한 것
CREATE TABLE posts(
	id BIGINT unsigned PRIMARY KEY auto_increment
	,user_id BIGINT UNSIGNED NOT NULL
	,title VARCHAR(50) NOT NULL COMMENT '제목'
	,content VARCHAR(2000) NOT NULL COMMENT '내용'
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME 
)
;

-- -------------
-- 테이블 수정
-- -------------
-- 1. FK 추가 방법
-- alter table 테이블명
-- add constraint constraint 명
-- foreign key (constraint 부여 컬럼명)
-- REFERENCES 참조 테이블명 (참조 테이블 컬럼명)
-- [ON DELETE 동작 / ON UPDATE 동작];

-- fk pk unique 다 schema와 관련됨
-- fk는 선택사항이다. 
-- 제약조건명-테이블명-컬럼명
-- constraint 는 FK때 사용하고 다른 때는 잘 사용안한다. 
ALTER TABLE posts
	ADD CONSTRAINT fk_posts_user_id
		Foreign KEY (user_id)
		REFERENCES users(id)
-- 프로그래밍단에서 cascaded 관련해서 코드를 쓴다. 그래서 db에서는 잘 사용안하심. 
-- users_id가 삭제되면 posts에 쓴 글도 다 없어진다
;

-- 2. FK 삭제
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id
;

-- ----------
-- 컬럼 추가
-- ----------
ALTER TABLE posts
add COLUMN image VARCHAR(100)
;

-- ----------
-- 컬럼 제거
-- ----------
ALTER TABLE posts
DROP column image
;

-- ---------
-- 컬럼 수정 (주로 데이터 크기를 너무 작게 제한한 것을 풀어주는 경우가 많다)
-- --------- 
ALTER TABLE users
MODIFY COLUMN gender VARCHAR(10) NOT NULL COMMENT '남자, 여자, 미선택'
;
-- 컬럼의 순서 상관쓰지마라. 순서 맞추고 싶다고 해서 중간에 넣으면 과부화 생김. 
-- DB에 fk가 걸리는 테이블이 있다면 프로그래밍단에서 삭제하고 싶어도 안된다. 오류로 반환함. 

-- ----------------------
-- AUTO_INCREMENT 값 변경
-- ----------------------
-- 고갈될 일이 없다. 
-- 그리고 duplicate 일이 생긴다. 그니까 되도록이면 건들이지마셈.
ALTER TABLE users AUTO_INCREMENT = 10;

-- ----------------------
-- 테이블 삭제
-- ----------------------
DROP TABLE posts;
DROP TABLE users;

-- -------------------------
-- 테이블의 모든 데이터 삭제
-- -------------------------
-- TRUNCATE TABLE ; 

