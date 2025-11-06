# Troubleshooting SQL Errors

## Issue 1: Group By Clause Missing Columns for Aggregated Salary Calculation

**Problem:**
I encountered an error when calculating the average salary of employees holding the title "부장" (Manager). <br>
The `GROUP BY` clause only included `emp.name`, but I was also using an aggregate function (`AVG(sal.salary)`) <br>
which required additional grouping to avoid errors or unexpected results.

### Original Query:
```sql
SELECT 
    emp.`name`,
    emp.hire_at,
    ROUND(AVG(sal.salary)) AS avg_sal
FROM 
    titles tl
    JOIN title_emps tl_e
        ON tl_e.title_code = tl.title_code
        AND tl.title = '부장'
        AND tl_e.end_at IS NULL
    JOIN employees emp
        ON emp.emp_id = tl_e.emp_id
        AND emp.fire_at IS NULL
    JOIN salaries sal
        ON sal.emp_id = emp.emp_id
GROUP BY 
    emp.`name`;  -- Issue: Missing columns in GROUP BY for proper aggregation
```

**⚠️ Why the Error Happens**
you’re telling SQL: <br>
“Group by emp.name, but also show me emp.hire_at.” <br>
The problem: <br>
If a name appears multiple times with different hire dates, <br>
SQL doesn’t know which hire_at value to show for that group. <br>
That’s why SQL requires that: <br>
Every column in the SELECT list must either <br>
be inside an aggregate function (AVG, MAX, MIN, etc.), or <br>
be explicitly listed in the GROUP BY clause.

**solution:**
We added emp.hire_at to the GROUP BY clause to resolve the issue.

### Corrected Query:
```sql
SELECT 
    emp.`name`,
    emp.hire_at,
    ROUND(AVG(sal.salary)) AS avg_sal
FROM 
    titles tl
    JOIN title_emps tl_e
        ON tl_e.title_code = tl.title_code
        AND tl.title = '부장'
        AND tl_e.end_at IS NULL
    JOIN employees emp
        ON emp.emp_id = tl_e.emp_id
        AND emp.fire_at IS NULL
    JOIN salaries sal
        ON sal.emp_id = emp.emp_id
GROUP BY 
    emp.`name`,
    emp.hire_at;  -- Group by both name and hire date
```