---- VIEW 예제 -> 과도한 조인을 뷰를 통해 쿼리 질의
--SELECT e.first_name, e.last_name, e.email, d.department_id,
--d.department_name, j.job_id, j.job_title
--FROM employees e
--INNER JOIN departments d
--ON e.department_id = d.department_id
--INNER JOIN jobs j
--ON e.job_id = j.job_id;
--
--CREATE VIEW employee_view
--AS (SELECT e.first_name, e.last_name, e.email, d.department_id,
--    d.department_name, j.job_id, j.job_title
--    FROM employees e
--    INNER JOIN departments d
--    ON e.department_id = d.department_id
--    INNER JOIN jobs j
--    ON e.job_id = j.job_id);
--    
--SELECT first_name, last_name, department_name, job_title
--FROM employee_view
--WHERE department_id = 30;
--
---- employees 테이블에서 salary를 제외한 VIEW 생성 ⇒ 쿼리 질의(VIEW
--SELECT * FROM employees;
--SELECT employee_id, first_name, last_name, email, phone_number, hire_date
--job_id, commission_pct, manager_id, department_id
--FROM employees;
--
--CREATE VIEW employee_no_salary_view
--AS (SELECT employee_id, first_name, last_name, email, phone_number, hire_date
--    job_id, commission_pct, manager_id, department_id
--    FROM employees);
--    
--SELECT * FROM employee_no_salary_view
--WHERE last_name = 'Popp';   
--
---- PL/SQL
--set serveroutput on;
--
--DECLARE
---- 변수 선언
--	v_no NUMBER := 10;
--	v_hireDate VARCHAR2(30) := TO_CHAR(SYSDATE, 'YYYY/MM/DD');
---- 상수 선언
--	c_message CONSTANT VARCHAR2(50) := 'Hello PL/SQL!~!';
--BEGIN
--	DBMS_OUTPUT.PUT_LINE('PL/SQL 수업');
--	DBMS_OUTPUT.PUT_LINE(c_message);
--	DBMS_OUTPUT.PUT_LINE(v_hireDate);
--END;

-- employees 테이블의 로우를 검색하여 변수에 할당해 보자.
--DECLARE
--	v_name VARCHAR2(20);
--	v_salary NUMBER;
--	v_hireDate VARCHAR2(30);
--
--BEGIN
--	SELECT first_name, salary, TO_CHAR(SYSDATE, 'YYYY-MM-DD')
--	INTO v_name, v_salary, v_hireDate
--	FROM employees
--	WHERE first_name = 'Ellen';
--	
--	DBMS_OUTPUT.PUT_LINE('검색된 사원의 정보');
--	DBMS_OUTPUT.PUT_LINE(v_name || ' ' || v_salary || ' ' || v_hireDate);
--END;

-- 사원번호 100번에 해당하는 사원의 이름과 부서명을 출력하시오.
--SELECT last_name, department_name
--FROM employees e
--JOIN departments d
--ON e.department_id = d.department_id
--WHERE e.employee_id = 100;
--
--DECLARE
--    v_emp_name VARCHAR2(20);
--    V_department_name VARCHAR2(30);
--BEGIN
--    SELECT first_name, department_name
--    INTO v_emp_name, v_department_name
--    FROM employees e
--    JOIN departments d
--    ON e.department_id = d.department_id
--    WHERE e.employee_id = 100;
--    
--    DBMS_OUTPUT.PUT_LINE(v_emp_name || ' ' || v_department_name);
--END;

--DECLARE
--	-- 기본형 데이터형
--	v_search VARCHAR2(30) := 'Lisa';
--	-- 레퍼런스형
--	v_name employees.last_name%TYPE;
--	v_salary employees.salary%TYPE;
--
--BEGIN
--	SELECT last_name, salary
--	INTO v_name, v_salary
--	FROM employees
--	WHERE first_name = v_search;
--	
--	DBMS_OUTPUT.PUT_LINE(v_name || ' ' || v_salary);
--END;

-- 과제
-- 1)
--DECLARE
--    v_emp_name employees.last_name%TYPE;
--    v_email employees.email%TYPE;
--BEGIN
--    SELECT last_name, email
--    INTO v_emp_name, v_email
--    FROM employees
--    WHERE employee_id = 201;
--    
--    DBMS_OUTPUT.PUT_LINE(v_emp_name || ' ' || v_email);
--END;    
-- 2)
--CREATE TABLE employees2
--AS SELECT * FROM employees;
--
--SELECT MAX(employee_id) FROM employees2;
--
--DECLARE 
--    v_employee_id employees2.employee_id%TYPE;
--BEGIN
--    SELECT MAX(employee_id)
--    INTO v_employee_id
--    FROM employees2;
--    
--    INSERT INTO employees2(employee_id, last_name, email, hire_date, job_id) VALUES(v_employee_id+1,'Hong gil dong', 'aa@aa.com', SYSDATE, 'AD_VP');
--    COMMIT;
--END;

-- ROWTYPE
--DECLARE
--	-- 1개의 로우 전체를 담음
--	employee_record employees%ROWTYPE;
--BEGIN
--	SELECT * INTO employee_record
--	FROM employees
--	WHERE first_name = 'Lisa';
--	
--	DBMS_OUTPUT.PUT_LINE(employee_record.employee_id || ' ' ||
--	employee_record.first_name || ' ' || employee_record.salary);
--END;

-- 조건문 퀴즈
--DECLARE
--    v_random_deptno NUMBER := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
--    v_avg_salary employees.salary%TYPE;
--BEGIN
--    DBMS_OUTPUT.PUT_LINE('부서 번호: ' || v_random_deptno);
--    SELECT AVG(salary)
--    INTO v_avg_salary
--    FROM employees
--    WHERE 
--        department_id = v_random_deptno;
--    /*
--    IF v_avg_salary >= 6000 THEN
--        DBMS_OUTPUT.PUT_LINE('높음');
--    ELSIF v_avg_salary >= 3000 THEN
--        DBMS_OUTPUT.PUT_LINE('보통');
--    ELSE
--        DBMS_OUTPUT.PUT_LINE('낮음');
--    END IF;
--    */
--    
--    CASE WHEN v_avg_salary BETWEEN 1 AND 3000 THEN
--        DBMS_OUTPUT.PUT_LINE('낮음');
--    WHEN v_avg_salary BETWEEN 3000 AND 6000 THEN
--        DBMS_OUTPUT.PUT_LINE('보통');
--    ELSE
--        DBMS_OUTPUT.PUT_LINE('높음');
--    END CASE;    
--END;

-- 반복문 LOOP
--DECLARE
--	i NUMBER := 0;
--	total NUMBER := 0;
--BEGIN
--	LOOP
--		i := i + 1;
--		total := total + i;
--		-- 조건
--		EXIT WHEN i >= 10;
--	END LOOP;	
--		DBMS_OUTPUT.PUT_LINE(total);    
--END;

-- 반복문 WHILE
--DECLARE
--	i NUMBER := 0;
--	total NUMBER := 0;
--BEGIN
--	WHILE i <= 10 LOOP
--		total := total + i;
--		i := i + 1;
--	END LOOP;
--	DBMS_OUTPUT.PUT_LINE(total);    
--END;

-- 반복문 FOR
--DECLARE
--	i NUMBER := 0;
--	total NUMBER := 0;
--BEGIN
--	FOR i IN 1..10 LOOP
--		total := total + i;
--	END LOOP;
--	DBMS_OUTPUT.PUT_LINE(total);    
--END;

-- 반복문 이용해서 구구단 출력
-- LOOP ⇒ 구구단 3단 ⇒ 3 * 1 = 3
--DECLARE
--    i NUMBER := 0;
--    result NUMBER := 0;
--BEGIN
--    LOOP
--        i := i + 1;
--        result := 3 * i;
--        EXIT WHEN i >= 10;
--        DBMS_OUTPUT.PUT_LINE('3 * ' || i || ' = ' || result);
--    END LOOP;
--END; 

-- FOR ⇒ 구구단 전체
--DECLARE
--    i NUMBER := 0;
--    j NUMBER := 0;
--    result NUMBER := 0;
--BEGIN
--    FOR i IN 2..9 LOOP
--        FOR j IN 1..9 LOOP
--            DBMS_OUTPUT.PUT_LINE(i || ' * ' || j || ' = ' || i * j);
--        END LOOP;
--        DBMS_OUTPUT.PUT_LINE('');
--    END LOOP;
--END;    

-- 예외 처리: 오라클에서 제공
--DECLARE
--	employee_record employees%ROWTYPE;
--	
--BEGIN
--	SELECT employee_id, last_name, department_id
--	INTO employee_record.employee_id,
--			employee_record.last_name,
--			employee_record.department_id
--	FROM employees
--	WHERE department_id = 50;
--    
--    EXCEPTION
--		-- UNIQUE 제약조건을 갖는 컬럼에 중복된 데이터 insert
--		WHEN DUP_VAL_ON_INDEX THEN
--			DBMS_OUTPUT.PUT_LINE('이미 존재하는 사원입니다.');
--		-- SELECT문 결과, 2개 이상의 로우를 반환
--		WHEN TOO_MANY_ROWS THEN
--			DBMS_OUTPUT.PUT_LINE('검색된 로우가 많습니다.');
--		-- 데이터가 없을 때
--		WHEN NO_DATA_FOUND THEN
--			DBMS_OUTPUT.PUT_LINE('검색된 사원이 없습니다.');
--		-- 그 밖에 예외 사유
--		WHEN OTHERS THEN
--			DBMS_OUTPUT.PUT_LINE('기타 예외');
--END;

-- 예외 처리: 사용자가 강제로 예외 발생
--DECLARE
--	-- 사용자 예외 정의
--	e_user_exception EXCEPTION;
--	cnt NUMBER := 0;
--BEGIN
--	SELECT COUNT(*) INTO cnt
--	FROM employees
--	WHERE department_id = 40;
--	
--	IF cnt < 5 THEN
--		-- 인위적으로 예외 발생
--		RAISE e_user_exception;
--	END IF;
--	
--	EXCEPTION
--		WHEN e_user_exception THEN
--			DBMS_OUTPUT.PUT_LINE('5명 이하 부서 금지');
--END;

-- 퀴즈> 신입사원을 입력 시 잘못된 부서번호에 대해서 사용자 예외처리 하세요.
--DECLARE
--    v_employee_id employees2.employee_id%TYPE;
--    v_department_id NUMBER := 30;
--    e_user_exception EXCEPTION;
--    v_dept_count NUMBER;
--BEGIN
--    -- 가장 큰 employee_id 값을 가져옴
--    SELECT MAX(employee_id)
--    INTO v_employee_id
--    FROM employees2;
--    
--    -- 부서 번호가 존재하는지 확인
--    SELECT COUNT(*)
--    INTO v_dept_count
--    FROM departments
--    WHERE department_id = v_department_id;
--    
--    IF v_dept_count = 0 THEN
--        -- 부서 번호가 존재하지 않으면 예외 발생
--        RAISE e_user_exception;
--    ELSE 
--        -- 부서 번호가 존재하면 직원 정보 삽입
--        INSERT INTO employees2(employee_id, last_name, email, hire_date,
--        job_id, department_id)
--        VALUES(v_employee_id + 1, 'JINA', 'jinaa@naver.com', SYSDATE, 'AD_VP', v_department_id);
--    END IF; 
--    
--    EXCEPTION
--        WHEN e_user_exception THEN
--            DBMS_OUTPUT.PUT_LINE('존재하지 않는 부서 번호 입니다.');
--END;    

--DECLARE
--	p_department_id NUMBER := 50000;
--	v_cnt NUMBER := 0;
--	v_employee_id employees2.employee_id%TYPE;
--	ex_invalid_deptid EXCEPTION;
--BEGIN
--	SELECT COUNT(*) INTO v_cnt
--	FROM employees2
--	WHERE department_id = p_department_id;
--	
--	-- 예외 발생하면 EXCEPTION 구문으로 감
--	IF v_cnt = 0 THEN
--		RAISE ex_invalid_deptid;
--	END IF;
--			
--	-- 예외가 발생하지 않으면 정상적으로 데이터 삽입
--	SELECT MAX(employee_id) + 1
--	INTO v_employee_id
--	FROM employees2;
--	
--	INSERT INTO employees2(employee_id, last_name, email, hire_date, job_id, department_id)
--	VALUES(v_employee_id, 'aa', 'aa@aa.com', SYSDATE, 'AD_VP', p_department_id);
--	
--	EXCEPTION
--		WHEN ex_invalid_deptid THEN
--			DBMS_OUTPUT.PUT_LINE('해당 부서가 없습니다.');
--		WHEN OTHERS THEN
--			DBMS_OUTPUT.PUT_LINE('기타 예외');
--END;

-- 커서(CURSOR) => LOOP
--DECLARE
--	-- 커서 선언
--	CURSOR department_cursors IS
--	SELECT department_id, department_name, location_id
--	FROM departments;
--	
--	department_record department_cursors%ROWTYPE;
--	
--	BEGIN
--		-- 커서 열기
--		OPEN department_cursors;
--		LOOP
--			FETCH department_cursors
--			INTO department_record.department_id,
--						department_record.department_name,
--						department_record.location_id;
--			EXIT WHEN department_cursors%NOTFOUND;
--			
--			DBMS_OUTPUT.PUT_LINE(department_record.department_id || ' ' ||
--													department_record.department_name || ' ' ||
--													department_record.location_id);
--		END LOOP;
--		CLOSE department_cursors;
--END;
-- 커서(CURSOR)=> FOR...IN
--DECLARE
--	-- 커서 선언
--	CURSOR department_cursors IS
--	SELECT department_id, department_name, location_id
--	FROM departments;
--	
--	department_record department_cursors%ROWTYPE;
--BEGIN
--	FOR department_record IN department_cursors LOOP
--		DBMS_OUTPUT.PUT_LINE(department_record.department_id || ' ' ||
--													department_record.department_name || ' ' ||
--													department_record.location_id);
--	END LOOP;
--END;

-- 커서 퀴즈
-- 커서를 이용하여 사원의 정보를 출력하라.
-- - (사원 번호, 사원 이름(first_name), 급여, 급여 누계)
DECLARE
    CURSOR employee_cursors IS
    SELECT employee_id, first_name, salary
    FROM employees;
    
    employee_record employee_cursors%ROWTYPE;
    v_sum_salary NUMBER := 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(
        RPAD('사원번호', 12) || ' ' ||
        RPAD('사원이름', 15) || ' ' ||
        LPAD('급여', 12) || ' ' ||
        LPAD('급여 누계', 17)
    );
    
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        FOR employee_record IN employee_cursors LOOP
            v_sum_salary := v_sum_salary + employee_record.salary;
            
            DBMS_OUTPUT.PUT_LINE(
                RPAD(employee_record.employee_id, 10) || ' ' ||
                RPAD(employee_record.first_name, 15) || ' ' ||
                LPAD(TO_CHAR(employee_record.salary, 'FM999,999'), 10) || '원 ' ||
                LPAD(TO_CHAR(v_sum_salary,'FM999,999'), 12) || '원'
            );              
        END LOOP;
END;        
        
