# Troubleshooting SQL Errors

## Issue 2: Alias in WHERE clause

**Problem:**
I tried to minimize the use of the computer system’s resources, so I initially chose a subquery statement instead of a JOIN statement. <br>
However, when calculating the average salary per department, I encountered errors or unexpected results with the subquery approach. <br>

### Original Query:
```sql
SELECT
	 dpte.dept_code,
	(
		SELECT 
			avg(sal.salary) 
		FROM salaries sal
		WHERE sal.end_at IS NULL
			AND sal.emp_id = dpte.emp_id
	) avg_salary_per_dpt
FROM department_emps dpte
WHERE 
	dpte.end_at IS null
	AND avg_salary_per_dpt >= '60000000'
ORDER BY 
	avg_salary_per_dpt asc
;
```

**⚠️ Why the Error Happens**
You can’t use avg_salary_per_dpt in the WHERE clause because SQL evaluates WHERE before the SELECT list. The alias doesn’t exist yet at that stage.

**solution:**
I initially wrote the same subquery in the WHERE clause instead of using its alias, but it didn’t seem efficient. So I ended up rewriting it as a JOIN instead of a subquery

### Corrected Query:
```sql
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
```