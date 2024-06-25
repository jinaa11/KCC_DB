-- 서브 쿼리
SELECT AVG(salary) FROM employees;

SELECT last_name, salary
FROM employees
WHERE salary > 6461.831775700934579439252336448598130841;

SELECT last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 퀴즈 hr> ‘Chen’ 사원보다 salary를 많이 받는 사원 목록을 출력하라.
SELECT last_name , salary
FROM employees
WHERE salary > 
    (SELECT salary FROM employees
    WHERE last_name = 'Chen');

-- 다중 컬럼, 다중 로우
SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees
GROUP BY job_id);

SELECT MAX(salary) FROM employees
GROUP BY job_id;

-- 다중 로우 처리
SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE salary IN (SELECT MAX(salary) FROM employees
GROUP BY job_id);

-- 다중 컬럼 처리
SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE (salary, job_id) IN (SELECT MAX(salary), job_id FROM employees
GROUP BY job_id);

-- FROM절 서브쿼리(n-tier)
SELECT employee_id ,last_name, hire_date
FROM employees
ORDER BY hire_date;

SELECT ROWNUM, alias.*
FROM (SELECT employee_id ,last_name, hire_date
			FROM employees
			ORDER BY hire_date) alias 
WHERE ROWNUM <= 5;

SELECT * FROM employees;
SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary DESC;

SELECT ROWNUM, alias.*
FROM (SELECT employee_id, last_name, salary
        FROM employees
        ORDER BY salary DESC) alias
WHERE ROWNUM <= 3;        

-- 종합 mission
-- 서브쿼리문제.txt
-- 1)
SELECT department_id FROM employees
WHERE last_name = 'Patel';

SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE department_id = (SELECT department_id 
                        FROM employees
                        WHERE last_name = 'Patel');
-- 2)
SELECT job_id
FROM employees
WHERE last_name = 'Austin';

SELECT e.last_name, d.department_name, e.salary, e.job_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.job_id = (SELECT job_id
                FROM employees
                WHERE last_name = 'Austin');
-- 3)
SELECT salary
FROM employees
WHERE last_name = 'Seo';

SELECT employee_id, last_name, salary
FROM employees
WHERE salary = (SELECT salary
        FROM employees
        WHERE last_name = 'Seo');
-- 4)
SELECT MAX(salary)
FROM employees 
WHERE department_id = 30;

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > ALL(SELECT salary
                    FROM employees 
                    WHERE department_id = 30);
-- 5)
SELECT salary
FROM employees 
WHERE department_id = 30;

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > ANY(SELECT salary
                    FROM employees 
                    WHERE department_id = 30);
-- 6)
SELECT AVG(salary)
FROM employees;

SELECT employee_id, last_name,
department_name,
hire_date, 
city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND salary > (SELECT AVG(salary)
                FROM employees);
-- 7)
SELECT job_id FROM employees
WHERE department_id = 30;

SELECT employee_id, last_name,
department_name,
hire_date,
city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND job_id NOT IN (SELECT job_id FROM employees
                WHERE department_id = 30)
AND e.department_id = 100;
