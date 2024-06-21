CREATE TABLE emp01(
	empno NUMBER,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER
)

INSERT INTO emp01 VALUES(null, null, 'IT', 30);

CREATE TABLE emp02(
	empno NUMBER NOT NULL,
	ename VARCHAR2(20) NOT NULL,
	job VARCHAR2(20),
	deptno NUMBER
)

INSERT INTO emp02 VALUES(null, null, 'IT', 30);
INSERT INTO emp02 VALUES(100, 'kim', 'IT', 30);
INSERT INTO emp02 VALUES(100, 'park', 'IT', 30);

SELECT * FROM emp01;

CREATE TABLE emp03(
	empno NUMBER UNIQUE,
	ename VARCHAR2(20) NOT NULL,
	job VARCHAR2(20),
	deptno NUMBER
)

INSERT INTO emp03 VALUES(100, 'kim', 'IT', 30);
INSERT INTO emp03 VALUES(100, 'park', 'IT', 30);

CREATE TABLE emp04(
	empno NUMBER PRIMARY KEY,
	ename VARCHAR2(20) NOT NULL,
	job VARCHAR2(20),
	deptno NUMBER
)

INSERT INTO emp04 VALUES(null, 'kim', 'IT', 30);
INSERT INTO emp04 VALUES(100, 'kim', 'IT', 30);
INSERT INTO emp04 VALUES(100, 'park', 'IT', 30);
INSERT INTO emp04 VALUES(200, 'kim', 'IT', 3000);

CREATE TABLE emp05(
	empno NUMBER PRIMARY KEY,
	ename VARCHAR2(20) NOT NULL,
	job VARCHAR2(20),
	deptno NUMBER REFERENCES departments(department_id)
)
INSERT INTO emp05 VALUES(200, 'kim', 'IT', 3000);

CREATE TABLE emp06(
	empno NUMBER,
	ename VARCHAR2(20) NOT NULL,
	job VARCHAR2(20),
	deptno NUMBER,
	
	CONSTRAINT emp06_empno_pk PRIMARY KEY(empno),
	CONSTRAINT emp06_deptno_fk FOREIGN KEY(deptno) REFERENCES departments(department_id)
)

CREATE TABLE emp07(
	empno NUMBER,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER
)

ALTER TABLE emp07
ADD CONSTRAINT emp07_empno_pk PRIMARY KEY(empno);

ALTER TABLE emp07
ADD CONSTRAINT emp07_deptno_fk FOREIGN KEY(deptno)
REFERENCES departments(department_id);

ALTER TABLE emp07
MODIFY ename CONSTRAINT emp07_ename_nn NOT NULL;

CREATE TABLE emp08(
	empno NUMBER,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER
)

ALTER TABLE emp08
ADD CONSTRAINT emp08_empno_pk PRIMARY KEY(empno)
ADD CONSTRAINT emp08_deptno_fk FOREIGN KEY(deptno)
REFERENCES departments(department_id)
MODIFY ename CONSTRAINT emp08_ename_nn NOT NULL;

CREATE TABLE emp09(
	empno NUMBER,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER,
	gender CHAR(1) CHECK(gender IN('M','F'))
)

INSERT INTO emp09 VALUES(100, 'kim', 'IT', 10, 'L');

CREATE TABLE emp10(
	empno NUMBER,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER,
	loc VARCHAR2(20) DEFAULT 'Seoul'
)

INSERT INTO emp10(empno, ename, job, deptno) VALUES(100, 'kim', 'IT', 30);

CREATE TABLE emp11(
    empno NUMBER,
    ename VARCHAR2(20),
    
    CONSTRAINT empno_ename_pk PRIMARY KEY(empno, ename)
)

INSERT INTO emp11 VALUES (100, 'KIM');
INSERT INTO emp11 VALUES (200, 'KIM');
INSERT INTO emp11 VALUES (200, 'KIM');

CREATE TABLE emp12(
	empno NUMBER,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER
);

ALTER  TABLE dept01
ADD CONSTRAINT dept01_department_id_pk PRIMARY KEY(department_id);

ALTER TABLE emp12
ADD CONSTRAINT emp12_deptno_fk FOREIGN KEY(deptno)
REFERENCES dept01(department_id);

INSERT INTO emp12 VALUES(100, 'kim', 'IT', 30);

DELETE FROM emp12 WHERE deptno = 30;

DELETE FROM dept01 WHERE department_id = 30;

CREATE TABLE emp13(
	empno NUMBER,
	ename VARCHAR2(20),
	job VARCHAR2(20),
	deptno NUMBER REFERENCES dept01(department_id)
	ON DELETE CASCADE
);

INSERT INTO emp13 VALUES(100, 'KIM', 'IT', 20);
INSERT INTO emp13 VALUES(200, 'KIM', 'IT', 20);
DELETE FROM dept01 WHERE department_id = 20;

SELECT employee_id, department_id
FROM employees
WHERE last_name = 'King';

SELECT department_id, department_name
FROM departments
WHERE department_id IN (80,90);

SELECT e.employee_id, e.department_id, d.department_name 
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND last_name = 'King';

SELECT e.employee_id, e.department_id, d.department_name 
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE last_name = 'King';

-- QUIZ1 1) WHERE
SELECT e.first_name, e.last_name, e.email, d.department_id,
d.department_name, j.job_id, j.job_title
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND j.job_id = e.job_id;
-- ANSI JOIN
SELECT e.first_name, e.last_name, e.email, d.department_id,
d.department_name, j.job_id, j.job_title
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN jobs j
ON e.job_id = j.job_id;

-- QUIZ2 1) WHERE
SELECT e.first_name, d.department_id, j.job_id, j.job_title, l.city
FROM employees e, departments d, jobs j, locations l
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id
AND d.location_id = l.location_id
AND l.city = 'Seattle';
-- 2) ANSI JOIN
SELECT e.first_name, d.department_id, j.job_id, j.job_title, l.city
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN jobs j
ON e.job_id = j.job_id
INNER JOIN locations l
ON d.location_id = l.location_id
WHERE l.city = 'Seattle';

SELECT A.last_name || '의 매니저는 ' || B.last_name || '이다.'
FROM employees A, employees B
WHERE A.manager_id = B.employee_id
AND A.last_name = 'Kochhar';