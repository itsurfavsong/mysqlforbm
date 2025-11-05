-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,tl_emp.title_code
FROM 
	employees emp
	JOIN title_emps tl_emp
		ON emp.emp_id = tl_emp.emp_id
			AND tl_emp.end_at IS NULL
ORDER BY
	emp_id asc
;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.gender
	,sal.salary
FROM 
	employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL
ORDER BY 
	emp_id asc
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
-- 연봉 이력과 함께 start or end 날짜 가져오는 건 센스다 이말이야. 
SELECT 
	emp.`name`
	,sal.salary
	,sal.start_at
	,sal.end_at
FROM 
	employees emp
	JOIN salaries sal
		ON emp.emp_id = 10010
			AND emp.emp_id = sal.emp_id
ORDER BY 
	sal.start_at asc
;	

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,dep.dept_name
FROM 
	employees emp
	JOIN department_emps dep_e
		ON emp.emp_id = dep_e.emp_id
		AND dep_e.end_at IS null
	JOIN departments dep
		ON dep_e.dept_code = dep.dept_code
WHERE emp.fire_at IS NULL
ORDER BY
	emp_id asc
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
-- 5-1. (ORDER BY 에서 퍼포먼스 이슈가 생김)
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM 
	employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS null
WHERE emp.fire_at IS null
ORDER BY 
	sal.salary DESC
LIMIT 10
;

-- 너무 느리다. 1.2초 걸림
-- 5-2. 더 빨라지는 rank를 넣어볼까? 근데 사바사인듯. 
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
	,RANK() OVER(ORDER BY sal.salary DESC) `rank`
FROM 
	employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS null
WHERE emp.fire_at IS null
LIMIT 10
;

-- 5-3. subquery (0.14초 걸림, order by 를 할 데이터를 확 줄여버린다)
SELECT
	emp.emp_id
	,emp.`name`
	,tmp_sal.salary
FROM 
	employees emp
	JOIN (
		SELECT 
			sal.emp_id
			,sal.salary
		FROM salaries sal
		WHERE sal.end_at IS null
		ORDER BY 
			sal.salary DESC
		LIMIT 10
	) tmp_sal
		ON emp.emp_id = tmp_sal.emp_id
WHERE emp.fire_at IS null
ORDER BY tmp_sal.salary desc
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT 
	dept.dept_name
	,emp.`name`
	,emp.hire_at
FROM 
	employees emp
	JOIN department_managers dept_m
		ON dept_m.emp_id = emp.emp_id
			AND dept_m.end_at IS null
	JOIN departments dept
		ON dept.dept_code = dept_m.dept_code
			AND dept.end_at IS NULL
WHERE emp.fire_at IS null
ORDER BY
	dept.dept_code asc
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT
	AVG(sal.salary) svg_sal 
FROM titles tl
	JOIN title_emps tl_e
		ON tl_e.title_code = tl.title_code
		AND tl.title = '부장'
		AND tl_e.end_at IS NULL
	JOIN salaries sal
		ON tl_e.emp_id = sal.emp_id
		AND sal.end_at IS null
;

-- 7-1. 현재 각 부장별 이름, 연봉평균
SELECT 
	emp.`name`
	,emp.hire_at
	,round(AVG(sal.salary)) avg_sal
FROM 
	titles tl
	JOIN title_emps tl_e
		ON tl_e.title_code = tl.title_code
		AND tl.title = '부장'
		AND tl_e.end_at IS null
	JOIN employees emp
		ON emp.emp_id = tl_e.emp_id
		AND emp.fire_at IS null
	JOIN salaries sal
		ON sal.emp_id = emp.emp_id
GROUP BY 
	emp.`name`
	,sal.emp_id
;

-- 또다른 방법
SELECT
	emp.`name`
	,sub_salaries.avg_sal
FROM employees emp
	JOIN (
		SELECT
			sal.emp_id
			,AVG(sal.salary) avg_sal 
		FROM title_emps tl_e
			JOIN titles tl
				ON tl_e.title_code = tl.title_code
				AND tl.title = '부장'
				AND tl_e.end_at IS null
			JOIN salaries sal
				ON sal.emp_id = tl_e.emp_id
		GROUP BY sal.emp_id
	) sub_salaries
		ON emp.emp_id = sub_salaries.emp_id
		AND emp.fire_at IS null
; 

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요. (중복허락)
-- 다른 부서로 옮겨서 타 부서 부서장직을 했을 수도 있잖아. 
SELECT
	emp.emp_id
	,emp.`name`
	,emp.hire_at
	,dept_m.dept_code
FROM 
	employees emp
	JOIN department_managers dept_m
		ON dept_m.emp_id = emp.emp_id
ORDER BY 
	emp_id ASC 
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을
--		평균연봉 내림차순으로 출력해 주세요.
SELECT 
	tl.title
	,ROUND(AVG(sal.salary))	avg_sal
FROM 
	titles tl
		JOIN title_emps tl_e
			ON tl_e.title_code = tl.title_code
			AND tl_e.end_at IS null
		JOIN salaries sal
			ON sal.emp_id = tl_e.emp_id
			AND sal.end_at IS NULL 
GROUP BY 
	tl.title
HAVING 
	avg_sal >= 60000000
ORDER BY 
	avg_sal DESC
;

-- 선생님과 같이 짠 query
SELECT 
	tl.title
	,CEILING(AVG(sal.salary)) avg_sal
FROM salaries sal
	JOIN title_emps tl_e
		ON sal.emp_id = tl_e.emp_id
		AND sal.end_at IS null
		AND tl_e.end_at IS null
	JOIN titles tl
		ON tl.title_code = tl_e.title_code
GROUP BY tl.title
	HAVING avg_sal >= 60000000
ORDER BY
	avg_sal desc
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT 
	tl.title
	,emp.gender
	,COUNT(emp.gender) AS employees_by_genders
FROM employees emp
	JOIN title_emps tl_e
		ON tl_e.emp_id = emp.emp_id
		AND tl_e.end_at IS null
	JOIN titles tl
		ON tl.title_code = tl_e.title_code
WHERE 
	emp.fire_at IS NULL
GROUP BY 
	tl.title
	,emp.gender
	,tl.title_code
ORDER BY 
	tl.title_code DESC
;
