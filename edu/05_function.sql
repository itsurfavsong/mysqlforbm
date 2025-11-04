-- 내장 함수: 데이터를 처리하고 분석하는데 사용하는 프로그램

-- 데이터 타입 변환 함수
-- CAST 이전 버전, CONVERT 새로운 버전
SELECT 
	1234
	,CAST(1234 AS CHAR(4))
	,CONVERT(1234, CHAR(4))
;

-- 제어 흐름 함수
-- IF(수식, 참일 때, 거짓일 때)
-- 수식의 결과에 따라 분기 처리를 하는 함수
-- gender가 M 인가? 이 물음에 true 이면 남자, false면 여자
SELECT 
	emp_id
	,`name`
	,IF(gender = 'M', '남자', '여자') AS ko_gender
FROM employees
;

-- CASE 문: CASE + WHEN + END
--     CASE 체크하려는 수식1
--   	WHEN 분기수식1 THEN 결과1
--   	WHEN 분기수식2 THEN 결과2
--   	WHEN 분기수식3 THEN 결과3
--         ELSE 결과4
--    END

SELECT
	emp_id
	,`name`
	,CASE gender
		when 'M' then '남자'
		when 'F' then '여자'
		ELSE '성별없음'
	END AS ko_gender
FROM employees
;

-- IFNULL(수식1, 수식2)
-- 수식1이 NULL이면 수식2를 반환
-- 수식1이 NULL이 아니면 수식 1을 반환
SELECT 
	emp_id
	,IFNULL(end_at, '9999-12-31') AS ifnull_end_at
FROM title_emps
;

-- NULLIF(수식1, 수식2)
-- 수식1과 수식2가 일치하는 지 체크를 하고, 
-- 참이면 NULL 반환, 거짓이면 수식1을 반환
-- 원래 gender의 값이 나온다. 
SELECT 
	emp_id
	,`name`
	,NULLIF(gender, 'F') AS nullif_gender
FROM employees
;

	
-- ---------------------------------------
-- 문자열 함수
-- ---------------------------------------
-- CONCAT(문자열1, 문자열2, ...)
-- 문자열을 연결하는 함수
SELECT CONCAT('안녕하세요.', ' ', 'DB입니다.');
SELECT CONCAT(gender, `name`) 
FROM employees;

-- CONCAT_WS(구분자, 문자열1, 문자열2 ...)
-- 문자열 사이에 구분자를 넣어 연결하는 함수
SELECT CONCAT_WS(', ', '딸기', '키위', '수박');

-- FORMAT(숫자, 소수점 자리수)
-- 숫자를 소수점 자릿수에 맞는 문자열을 반환하는 함수
-- 자리수 콤마가 자동으로 들어가게 된다. 유의할 점. 
-- 문자열로 반환
SELECT FORMAT(314595675, 8);

-- LEFT(문자열, 숫자)
-- 문자열을 왼쪽부터 숫자길이 만큼 잘라 반환
SELECT LEFT('abcdef', 2);

-- RIGHT(문자열, 숫자)
-- 문자열을 오른쪽부터 숫자길이 만큼 잘라 반환
SELECT RIGHT('abcdef', 2);

-- UPPER(문자열), LOWER(문자열)
-- 영어 대/소문자로 변환
SELECT UPPER('AbCde'), LOWER('AbCde');

-- LPAD(문자열, 길이, 채울 문자열)
-- RPAD(문자열, 길이, 채울 문자열)
-- 문자열을 포함해 길이만큼 채울 문자열을 좌/우에 삽입해 반환
SELECT LPAD('1', 4, '0'), RPAD('1', 4, '0');

-- TRIM(문자열), RTRIM(문자열), LTRIM(문자열)
-- (좌우/우/좌) 공백을 제거
-- 2차 프로젝트에서 많이 쓸 예정. 
SELECT 
	TRIM('     트림  ')
	,RTRIM('     트림  ')
	,LTRIM('     트림  ')
;

-- TRIM(방향 문자열1 FROM 문자열2)
-- 방향을 지정해서 문자열 2에서 문자열 1을 제거하여 반환
-- 방향은 LEADING(좌), BOTH(좌우), TRAILING(우) 지정 가능
-- 'Bearer dfkajldsfjafjksdjalfkjds' 이런 문자열에서 필요없는 BEARER 를 삭제하다. 
SELECT 
	TRIM(LEADING 'Bearer ' FROM 'Bearer dfkajldsfjafjksdjalfkjds');
	
-- SUBSTRING(문자열, 시작위치, 길이)
-- 문자열을 시작위치에서 길이만큼 잘라서 반환
SELECT SUBSTRING('abcdef', 3, 2);

-- SUBSTRING_INDEX(문자열, 구분자, 횟수)
-- 왼쪽부터 구분자가 횟수번째가 나오면 그 이후 문자열을 버린다. 
-- 홧수를 음수로 설정시, 오른쪽부터 적용
-- 횟수는 -일때도 있다. 
SELECT SUBSTRING_INDEX('your_fav_song', '_', 2);

-- ----------------------------------
-- 수학함수
-- ----------------------------------
-- CEILING(값): 올림
-- FLOOR(값): 버림
-- ROUND(값): 반올림
SELECT CEILING(1.2), FLOOR(1.9), ROUND(1.5);

-- TRUNCATE(값, 정수)
-- 소수점 기준으로 정수위치까지 구하고 나머지는 버림
-- 숫자로 반환
SELECT TRUNCATE(3.14847895, 2);

-- -----------------------------------
-- 날짜 및 시간 함수
-- -----------------------------------
-- NOW(): 현재 날짜 및 시간을 반환(YYYY-MM-DD HH:mm:ss)
SELECT NOW();

-- DATE(데이트 타입의 값): 데이트타입의 값을 (YYYY-MM-DD) 형식으로 변환
SELECT DATE(NOW());

-- ADDDATE(날짜1, INTERVAL 숫자 시간단위):
-- 날짜1에서 시간 단위에 따라 숫자만큼 더해서 반환
-- 여기서 과거 시간을 설정하고 싶으면 음수 넣어주면 됨
SELECT ADDDATE(NOW(), INTERVAL 1 YEAR); 
SELECT ADDDATE(NOW(), INTERVAL -2 YEAR);

-- ---------------------------------------
-- 집계 함수
-- ---------------------------------------
-- SUM(컬럼), MAX(컬럼), MIN(컬럼), COUNT(컬럼), AVG(컬럼)
SELECT 
	SUM(salary)
	,MAX(salary)
	,MIN(salary)
	,COUNT(salary)
	,AVG(salary)
FROM salaries;

-- 주의 사항
-- COUNT(*) : 검색 결과의 총 레코드 수를 출력(NULL 포함)
-- COUNT(컬럼명) : 검색 결과의 총 레코드 수를 출력 (NULL 비포함)
SELECT COUNT(*)
	,COUNT(end_at)
FROM salaries;

-- ------------------------------------------
-- 순위 함수
-- ------------------------------------------
-- RANK() OVER(ORDER BY 컬럼 ASC/DESC)
-- 지정한 컬럼을 기준으로 순위를 매겨 반환
-- 동일한 (중복) 값이 있는 경우 동일한 순위를 부여
SELECT 
	emp_id
	,salary
	,RANK() OVER(ORDER BY salary ASC) AS sal_rank
FROM salaries
LIMIT 5
;

-- ROW_NUMBER() OVER(ORDER BY 컬럼 ASC/DESC)
-- 레코드에 순위를 매겨 반환
-- 동일한 값이 있는 경우에도 각 행에 고유한 랭크를 부여
SELECT 
	emp_id
	,salary
	,ROW_NUMBER() OVER(ORDER BY salary ASC) AS sal_rank
FROM salaries;

-- 
-- 