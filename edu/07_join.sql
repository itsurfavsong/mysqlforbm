-- Join 문
-- 두 개 이상의 테이블을 묶어서 하나의 결과 집합으로 출력

-- Inner Join
-- 두 테이블이 공통적으로 만족하는 레코드를 출력
-- JOIN 다음에 ON으로 조건을 설정한다. (where의 역할)

-- 전 사원의 사번, 이름, 소속 부서명을 출력해주세요. 
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp	
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
-- WEHRE sal.end_at IS NULL 해도 괜찮다. 
ORDER BY emp.emp_id ASC
;

-- 재직중인 사원의 사번, 이름, 생일, 부서명
-- 왼쪽 테이블을 기준
SELECT 
	depe.emp_id
	,emp.`name`
	,emp.birth
	,dept.dept_code
	,dept.dept_name
FROM
	department_emps depe
	JOIN departments dept
		ON depe.dept_code = dept.dept_code
	JOIN employees emp
		ON depe.emp_id = emp.emp_id
			AND emp.fire_at IS null
WHERE 
	depe.end_at IS NULL
;

-- LEFT JOIN
-- 가져올 정보가 없다면 null 입니다. 
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	left JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS null
;

-- 두 개 이상의 쿼리의 결과를 합쳐서 출력
-- UNION (중복 레코드 제거)
-- UNION ALL (중복 레코드 제거 안함)
SELECT * FROM employees WHERE emp_id IN (1, 3)
UNION
SELECT * FROM employees WHERE emp_id IN (1, 3)
;

-- self join
-- 같은 테이블 끼리 join 
-- 원래 하나의 테이블에 있는 정보로, 서로 “관계가 있는 두 행”을 함께 보고 싶을 때
SELECT 
	emp.emp_id AS junior_id
	,emp.`name` AS junior_name
	,supemp.emp_id AS supervisor_id
	,supemp.`name` AS supervisor_name
FROM employees emp
	JOIN employees supemp
		on emp.sup_id = supemp.emp_id
WHERE 	
	emp.emp_id = 98415
;

-- 정규화로 쪼갠다 -> join이 많이 안되게 노력한다. 테이블 join은 3개가 max이다. 