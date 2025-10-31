-- 테이블 전체 컬럼 조회
SELECT * 
FROM employees;

-- 특정 컬럼만 지정하여 조회
SELECT 
	name
	,birth
	,hire_at
FROM employees;

-- WHERE 절: 특정 컬럼의 갑과 일치한 데이터만 조회
SELECT *
FROM employees
WHERE
	emp_id = 5
;

-- 이름이 강영화이고, 성별이 M인 사원 조회
SELECT *
FROM employees
WHERE 
	NAME = '강영화'
	AND gender = 'M'
;

-- 날짜를 필터링 할 경우
SELECT *
FROM employees
WHERE 
	hire_at >= '2023-01-01'
;

-- 아직 재직중인 사원들만 조회하고 싶다. (NULL 조회)
SELECT *
FROM employees
WHERE 
-- 	fire_at IS NOT NULL
	fire_at IS NULL
;

-- WHERE 절에서 AND, OR 복합 사용시 주의
-- 입사일이 20250101 이후거나, 20000101 이전이고 
-- 이미 퇴사한 직원
-- () 괄호 치는 이유는 SQL은 한 줄씩 가동?하기 때문에 소괄호로 하나로 묶고 싶은 조건식은 묶어야한다. 
SELECT *
FROM employees
WHERE 
	(
		hire_at >= '2025-01-01'
		OR hire_at <= '2000-01-01'
	)
	AND fire_at IS NOT NULL
;

-- BETWEEN 연산자: 지정한 범위 내의 데이터를 조회
SELECT *
FROM employees
WHERE 
	emp_id >= 10000
	AND emp_id <= 10010
;

SELECT *
FROM employees
WHERE 
	emp_id BETWEEN 10000 AND 10010
;

-- IN 연산자: 지정한 값과 일치한 데이터를 조회
SELECT *
FROM employees
WHERE
	emp_id = 5
	OR emp_id = 7
	OR emp_id = 9
	OR emp_id = 12
;

SELECT *
FROM employees 
WHERE 
	emp_id IN(5, 7, 9, 12)
;

-- LIKE 연산자: 문자열 내용을 조회할 때 사용
-- % : 글자수와 상관없이 조회
-- 이름이 '태호'인 사원 조회
SELECT *
FROM employees
WHERE
	NAME LIKE '%호'
	;
	
-- _: 언더바의 개수만큼 글자의 개수
SELECT *
FROM employees
WHERE 
	NAME LIKE '남궁__'	
;

SELECT *
FROM employees
WHERE 
	NAME LIKE '%보_'
;

-- ORDER BY 절: 데이터 정렬 
-- ASC: 오름차순 
-- DESC: 내림차순
SELECT *
FROM employees
ORDER BY NAME ASC, birth ASC
;

-- 입사일이 2000년 이후인 사원
-- 이름, 생일 오름차순으로 정렬해서 조회
SELECT *
FROM employees
WHERE 
	hire_at >= '2000-01-01'
ORDER BY 
	NAME ASC
	,birth ASC
;

SELECT *
FROM employees
WHERE 
	gender = 'F'
	AND fire_at IS null
ORDER BY
	NAME ASC
	,birth ASC
;

-- DISTINCT 키워드: 검색결과에서 중복되는 레코드를 제거
SELECT distinct NAME, birth
FROM employees
ORDER BY 
	NAME ASC 
;

-- GROUP BY 절: 그룹으로 묶어서 조회 + 그리고 무조건 직계치가 나와야한다. 
-- HAVING 절: GROUP BY 절의 조건
-- 	집계함수
-- 	MAX(): 최대값
-- 	MIN(): 최소값
-- 	COUNT(): 개수
-- 	AVG(): 평균
-- 	SUM(): 합계
-- 사원별 최고 연봉 연봉
-- AS 별칭. 제거 가능. 
SELECT 
	emp_id
	,MAX(salary) AS max_salary
FROM salaries
GROUP BY 
	emp_id
;

-- 사원 별 최고 연봉이 5000만원 이상인 사원 조회(having 절 쓰러면 꼭 직계함수를 써야해~!~!~)
SELECT 
	emp_id
	,MAX(salary) AS max_salary
FROM salaries
GROUP BY 
	emp_id
	HAVING max_salary >= 50000000
;

-- 성별사원의 수를 조회해주세요. 
SELECT 
	gender
	,COUNT(gender) AS count_gender
FROM employees
GROUP BY 
	gender
;

-- 재직중인 성별 사원수를 조회해주세요. 
SELECT 
	gender
	,COUNT(gender) AS count_gender
FROM employees
WHERE 
	fire_at IS NULL
GROUP BY 
	gender
;

-- limit and offset: 출력하는 데이터의 개수를 제한
-- 사원번호로 오름차순 정렬해서 10개만 조회해주세요. 
SELECT *
FROM employees
ORDER BY emp_id ASC
LIMIT 10
;

-- 만약 이를 출력한다면 (page-1)*limit
SELECT *
FROM employees
WHERE fire_at IS NOT NULL
ORDER BY emp_id ASC
LIMIT 5 OFFSET 5
;

-- 현재 받고 있는 급여 중 사원의 연봉 상위 5명을 조회하세요. 
SELECT 
	sal_id
	,emp_id
	,salary
FROM salaries
WHERE end_at IS NULL
ORDER BY salary DESC
LIMIT 5
;

-- Select문의 기본 구조
SELECT [DISTINCT] [컬럼명]
FROM [테이블명]
WHERE [쿼리 조건]
GROUP BY [컬럼명] HAVING [집계함수 조건]
ORDER BY [컬럼명 ASC || 컬럼명 DESC]
LIMIT [n] OFFSET [n]
;
