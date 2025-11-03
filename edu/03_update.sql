-- UPDATE 문
-- 기존에 있는 데이터를 수정(update)하기 위해서
-- UPDATE employees
-- SET 
-- 	fire_at = NOW()
-- 	,deleted_at = NOW()
-- WHERE 
-- 	emp_id = 100006
-- ;
-- 실수를 덜하기 위해서는 where 절을 먼저 쓰세요. 
-- where를 적지 않으면 실수가 생기는데 돌릴 수 없다. 

START TRANSACTION;

UPDATE employees
SET 
WHERE 
	emp_id = 100006
;

UPDATE salaries
SET 
	salary = 35000000
WHERE 
	sal_id = 1022179
;

SELECT *
FROM salaries
WHERE
	emp_id = 100000
	AND end_at IS null
;