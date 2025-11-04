-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT *
FROM titles
;
-- 2. 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요. (현재 다니고 있는?)
SELECT 
	emp_id
FROM salaries
WHERE
	end_at IS null
	AND salary <= 60000000
;

-- WHERE
-- 	end_at IS null 이걸 먼저 해주는 이유가 속도때문이다. end_at is null의 정보가 적을 것이기 때문이지. 
-- 	AND salary <= 60000000
-- ;

-- 3. 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요. (현재 다니고 있는?)
SELECT 
	emp_id
FROM salaries
WHERE 
	end_at IS null
	AND salary BETWEEN 60000000 AND 70000000
;
-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT 
	*
FROM employees
WHERE 
	emp_id IN (10001, 10005)
;
-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT
	title_code
	,title
FROM titles
WHERE
	title LIKE '%사%'
;
-- 6. 사원 이름 오름차순으로 정렬해서 조회해 주세요.
-- order by는 데이터를 정렬해서 결과를 어떤 순서로 보여줄지 결정합니다.
-- where는 데이터를 제한하거나 조건을 만족하는 데이터를 선택하는 데 사용됩니다.
SELECT
	*
FROM employees
ORDER BY 
	`NAME` asc
	,birth DESC
;
-- 7. 사원별 전체 급여의 평균을 조회해 주세요.
-- 주로 연도별로 현재 직원들의 급여들의 평균을 구한다. 
SELECT
	emp_id
	,AVG(salary) AS avg_salary
FROM salaries
GROUP BY emp_id
;
-- 8. 사원별 전체 급여의 평균이 30,000,000 ~ 50,000,000인, 사원번호와 평균급여를 조회해 주세요.
SELECT 
	emp_id
	,AVG(salary) AS avg_sal
FROM salaries
GROUP BY emp_id
HAVING avg_sal BETWEEN 30000000 AND 50000000
;
-- 9. 사원별 전체 급여 평균이 70,000,000이상인, 사원의 사번, 이름, 성별을 조회해 주세요.
-- WHERE는 데이터를 제한하거나 조건을 만족하는 데이터를 선택하는 데 사용됩니다.
SELECT 
	emp.emp_id,
	emp.gender,
	emp.name
	,(
		SELECT AVG(sal.salary)
		FROM salaries AS sal
		WHERE emp.emp_id = sal.emp_id
	) AS avg_sal
FROM employees emp
GROUP BY 
	emp.emp_id
HAVING avg_sal >= 70000000 
;

SELECT
	emp.emp_id
	,emp.gender
	,emp.name
FROM employees emp
WHERE 
	emp.emp_id IN (
		select
			sal.emp_id
		FROM salaries sal
		GROUP BY sal.emp_id
			HAVING AVG(sal.salary) >= 70000000
	)
;
-- 10. 현재 직급이 'T005'인,사원의 사원번호와 이름을 조회해 주세요.
SELECT 
	emp.`name`,
	emp.emp_id
FROM employees emp
WHERE 
	emp.emp_id in (
		SELECT 
			tem.emp_id
		FROM title_emps AS tem
		WHERE tem.end_at IS NULL
			and tem.title_code = 'T005'
	)
;

