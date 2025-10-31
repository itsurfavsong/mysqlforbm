-- INSERT 문
-- 신규 데이터를 저장하기 위해 사용하는 문.
INSERT INTO employees(
	`name`
	,birth
	,gender
	,hire_at
	,fire_at
	,sup_id
	,created_at
	,updated_at
	,deleted_at	
)
VALUES(
	'송보미'
	,'1993-02-04'
	,'F'
	,'2025-10-21'
	,NULL
	,NULL
	,NOW()
	,NOW()
	,NULL
);

-- 생성일이 가장 최근인 것
-- 그냥 내이름으로 찾기
SELECT *
FROM employees
WHERE 
	birth = '1993-02-04'
	AND `name` = '송보미'
	AND hire_at = '2025-10-21'
;

-- 자신의 연봉 데이터를 넣어주세요. 
INSERT INTO salaries(
	emp_id
   ,salary
   ,start_at
   ,end_at
   ,created_at
   ,updated_at
   ,deleted_at
)
VALUES (
	'100005'
   ,'1000000000'
   ,'2025-10-21'
   ,NULL
   ,NOW()
   ,NOW()
   ,NULL
)
;

-- SELECT INSERT
INSERT INTO salaries (
	emp_id
	,salary
	,start_at
)

SELECT 
	emp_id
	,30000000
	,created_at
FROM employees
WHERE 
	emp_id = '100005'
	AND `name` = '송보미'
;

-- WHERE DATE(created_at) = '2025-01-01'
-- BETWEEN '2025-01-01 00:00:00' AND '2025-01-01 23:59:59'

