-- TRANSACTION

-- 트랜잭션 시작
START TRANSACTION;

-- INSERT
INSERT INTO employees (
	`name`
	,birth
	,gender
	,hire_at
)
VALUE (
	'미어캣'
	,'2000-01-01'
	,'M'
	,DATE(NOW())
)
;

-- update employees set birth = now() where emp_id = 100008;

-- SELECT
SELECT *
FROM 
	employees
WHERE
	`name` = '미어캣';
	
-- ROLLBACK
ROLLBACK;

-- COMMIT
COMMIT;