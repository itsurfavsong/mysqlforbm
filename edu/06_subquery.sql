-- 서브쿼리 SubQuery

-- ---------------------
-- WHERE 절에서 사용
-- ----------------------
-- D001 부서장의 사번과 이름을 출력
-- =가 있기때문에 1대 1로 똑같아야한다. 그래서 1=다수의 데이터는 안된다. IN을 사용하자. 
SELECT 
	emp.emp_id
	, emp.`name`
FROM employees AS emp
WHERE 
	emp.emp_id = (
		SELECT 
			depm.emp_id
		FROM department_managers AS depm
		WHERE 	
			depm.end_at IS NULL
			AND depm.dept_code = 'D001'
	)
;

-- 다중 [행] 서브쿼리
-- 서브쿼리가 2건 이상 반환될 때
-- 반드시 다중행 비교연산자 (IN, ALL, ANY, SOM, EXISTX 등)을 함께해야한다. 
SELECT 
	emp.emp_id
	, emp.`name`
FROM employees AS emp
where
	emp.emp_id in (
		SELECT 
			depm.emp_id
		FROM department_managers AS depm
		WHERE 	
			depm.end_at IS NULL
	)
;

-- 다중 [열] 서브쿼리 (성능이슈 존재. 그래서 주로 join 쿼리를 사용한다)
-- 서브쿼리의 결과가 복수의 컬럼을 반환 할 경우, 
-- 메인 쿼리의 조건과 동시 비교
-- 현재 D002의 부서장이 해당 부서에 조인하게 된 날짜
SELECT
	department_emps.*
FROM department_emps
WHERE 
	(department_emps.emp_id, department_emps.dept_code) IN (
		SELECT 
			department_managers.emp_id
			,department_managers.dept_code
		FROM department_managers
		where
			department_managers.dept_code = 'D002'
			AND department_managers.end_at IS NULL
	)
;

-- 연관 서브쿼리
-- 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리
-- 부서장 직을 지냈던 경력이 있는 사원의 정보 출력 (한 번이라도 있었던 사람들)
SELECT 
	employees.*
FROM employees
WHERE 	
	employees.emp_id IN(
		SELECT department_managers.emp_id
		FROM department_managers
		WHERE 
			department_managers.emp_id = employees.emp_id
	)
;