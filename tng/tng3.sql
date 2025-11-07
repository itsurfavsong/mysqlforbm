-- 1. 모든 직원의 이름과 입사일을 조회하세요.
SELECT 
	`name` current_all_emps_names
	,hire_at
FROM employees
WHERE fire_at IS NULL
ORDER BY
	`name` asc
;

-- 2. 'd005' 부서에 속한 모든 직원의 직원 ID를 조회하세요.
SELECT
	emp.emp_id emp_id_of_D005
FROM employees emp
	JOIN department_emps depte
		ON depte.emp_id = emp.emp_id
		AND depte.dept_code = 'D005'
		AND depte.end_at IS null
		AND emp.fire_at IS NULL
ORDER BY 
	emp.emp_id asc
;

-- 3. 1995년 1월 1일 이후에 입사한 모든 직원의 정보를 입사일 순서대로 정렬하여 조회하세요.
SELECT 
	emp.*
	FROM employees emp
WHERE hire_at >= '1995-01-1' 
	AND fire_at IS null
ORDER BY 
	emp.hire_at ASC
;

-- 4. 각 부서별로 몇 명의 직원이 있는지 계산하고, 직원 수가 많은 부서부터 순서대로 보여주세요.
SELECT 
	dept_code
	,COUNT(dept_emp_id) current_nbs_of_emps_per_dept
FROM 
	department_emps
WHERE end_at IS NULL
GROUP BY 
	dept_code
ORDER BY
	current_nbs_of_emps_per_dept desc 
;

-- 5. 각 직원의 현재 연봉 정보를 조회하세요.
SELECT 
	emp_id
	,salary current_salary
FROM salaries
WHERE end_at IS NULL
ORDER BY 
	emp_id asc
;

-- 6. 각 직원의 이름과 해당 직원의 현재 부서 이름을 함께 조회하세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,dpt.dept_name currnet_dept_name
FROM employees emp
	JOIN department_emps dpte
		ON dpte.emp_id = emp.emp_id
		AND emp.fire_at IS NULL
		AND dpte.end_at IS NULL 
	JOIN departments dpt
		ON dpt.dept_code = dpte.dept_code
ORDER BY
	emp.emp_id asc
;

-- 7. '마케팅부' 부서의 현재 매니저의 이름을 조회하세요.
-- 마케팅부 부서의 코드 번호 - 'D008'
SELECT 
	dpt.dept_name
	,emp.`name` current_manager_name
FROM employees emp
	JOIN department_managers dptm
		ON dptm.emp_id = emp.emp_id
		AND dptm.end_at IS NULL
		AND emp.fire_at IS NULL
	JOIN departments dpt
		ON dpt.dept_code = dptm.dept_code
		AND dpt.dept_name = '마케팅부'
;

-- 8. 현재 재직 중인 각 직원의 이름, 성별, 직책(title)을 조회하세요.
SELECT
	emp.`name`
	,emp.gender
	,tl.title current_title
FROM employees emp
	JOIN title_emps tle
		ON tle.emp_id = emp.emp_id
		AND emp.fire_at IS null
		AND tle.end_at IS NULL 
	JOIN titles tl
		ON tl.title_code = tle.title_code
ORDER BY 
	emp.emp_id ASC
;

-- 9. 현재 가장 높은 연봉을 받는 상위 5명의 직원 ID와 연봉을 조회하세요.
SELECT 
	emp_id
	,salary current_salary
FROM salaries
WHERE end_at IS null
ORDER BY 
	salary DESC
LIMIT 5
;

-- 10. 각 부서의 현재 평균 연봉을 계산하고, 평균 연봉이 60000 이상인 부서만 조회하세요.
-- subquery랑 join랑 성능차이X
SELECT
	 dpte.dept_code
	,ceiling(AVG(sal.salary)) avg_salary_per_dpt
FROM department_emps dpte
	JOIN salaries sal
		ON sal.emp_id = dpte.emp_id
		AND sal.end_at IS null
		AND dpte.end_at IS null
GROUP BY 
	dpte.dept_code
	HAVING avg_salary_per_dpt >= 60000000
ORDER BY 
	avg_salary_per_dpt asc
;
