set serveroutput on;

CREATE OR REPLACE PROCEDURE listByDeptno(p_deptno IN employees.department_id%TYPE)
IS 
   CURSOR employee_cursors IS
      SELECT * FROM employees
         WHERE department_id = p_deptno;
   
   employee_record employee_cursors%ROWTYPE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('==============사원 리스트==============');
   FOR employee_record IN employee_cursors LOOP
      DBMS_OUTPUT.PUT_LINE(p_deptno || ' ' || employee_record.employee_id
                                    || ' ' || employee_record.last_name);
   END LOOP;
END;

-- 프로시저 실행
EXECUTE listByDeptno(30);

-- 퀴즈
CREATE TABLE jobs2
AS SELECT * FROM jobs;

CREATE OR REPLACE PROCEDURE my_new_job_proc(
                            p_job_id IN jobs2.job_id%TYPE,
                            p_job_title IN jobs2.job_title%TYPE,
                            p_min_salary IN jobs2.min_salary%TYPE,
                            p_max_salary IN jobs2.max_salary%TYPE)
IS
BEGIN
    INSERT INTO jobs2(job_id, job_title, min_salary, max_salary)
    VALUES (p_job_id, p_job_title, p_min_salary, p_max_salary);
    COMMIT;
END;    

EXECUTE my_new_job_proc('a', 'IT', 100, 1000);

-- 과제
ALTER TABLE jobs2
ADD CONSTRAINT jobs2_job_id_pk PRIMARY KEY(job_id);

CREATE OR REPLACE PROCEDURE check_job_id_proc(
                                p_job_id IN jobs2.job_id%TYPE,
                                p_job_title IN jobs2.job_title%TYPE,
                                p_min_salary IN jobs2.min_salary%TYPE,
                                p_max_salary IN jobs2.max_salary%TYPE)
IS
    v_cnt NUMBER := 0;
    v_job_id jobs2.job_id%TYPE;
BEGIN
    -- 동일한 job_id 체크
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs2
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN
        -- INSERT
        INSERT INTO jobs2(job_id, job_title, min_salary, max_salary)
        VALUES (p_job_id, p_job_title, p_min_salary, p_max_salary);
    ELSE
        -- UPDATE
        UPDATE jobs2 SET 
            job_title = p_job_title, 
            min_salary = p_min_salary, 
            max_salary = p_max_salary
        WHERE job_id = p_job_id;    
    END IF;  
    COMMIT;
END;

EXECUTE check_job_id_proc('a', 'IT', 300, 3000);
EXECUTE check_job_id_proc('b', 'Marketing', 200, 2000);

-- 매개변수 디폴트 값 설정
CREATE OR REPLACE PROCEDURE check_job_id_proc2(
                                p_job_id IN jobs2.job_id%TYPE,
                                p_job_title IN jobs2.job_title%TYPE,
                                p_min_salary IN jobs2.min_salary%TYPE := 100,
                                p_max_salary IN jobs2.max_salary%TYPE := 1000)
IS
    v_cnt NUMBER := 0;
    v_job_id jobs2.job_id%TYPE;
BEGIN
    -- 동일한 job_id 체크
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs2
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN
        -- INSERT
        INSERT INTO jobs2(job_id, job_title, min_salary, max_salary)
        VALUES (p_job_id, p_job_title, p_min_salary, p_max_salary);
    ELSE
        -- UPDATE
        UPDATE jobs2 SET 
            job_title = p_job_title, 
            min_salary = p_min_salary, 
            max_salary = p_max_salary
        WHERE job_id = p_job_id;    
    END IF;  
    COMMIT;
END;

EXECUTE check_job_id_proc2('c', 'C');

-- OUT, IN 매개변수 설정
CREATE OR REPLACE PROCEDURE check_job_id_proc3(
                                p_job_id IN jobs2.job_id%TYPE,
                                p_job_title IN jobs2.job_title%TYPE,
                                p_min_salary IN jobs2.min_salary%TYPE := 100,
                                p_max_salary IN jobs2.max_salary%TYPE := 1000,
                                p_result OUT NUMBER)
IS
    v_cnt NUMBER := 0;
    v_job_id jobs2.job_id%TYPE;
BEGIN
    -- 동일한 job_id 체크
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs2
    WHERE job_id = p_job_id;
    
    IF v_cnt = 0 THEN
        -- INSERT
        p_result := 1;
        INSERT INTO jobs2(job_id, job_title, min_salary, max_salary)
        VALUES (p_job_id, p_job_title, p_min_salary, p_max_salary);
    ELSE
        -- UPDATE
        p_result := 2;
        UPDATE jobs2 SET 
            job_title = p_job_title, 
            min_salary = p_min_salary, 
            max_salary = p_max_salary
        WHERE job_id = p_job_id;    
    END IF;  
    COMMIT;
END;

-- 실행
DECLARE
	p_result NUMBER;
BEGIN
	check_job_id_proc3('d', 'd1', 200, 2000, p_result);
	
	IF p_result = 1 THEN
		DBMS_OUTPUT.PUT_LINE('추가 되었습니다.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('수정 되었습니다.');
	END IF;
END;

-- 함수
CREATE OR REPLACE FUNCTION getSalary(p_no employees.employee_id%TYPE)
	RETURN NUMBER
IS
	v_salary NUMBER;
BEGIN
	SELECT salary INTO v_salary
	FROM employees
	WHERE employee_id = p_no;
	
	RETURN v_salary;
END;

SELECT getSalary(100) FROM dual;

-- 퀴즈 사원번호를 입력 받아 이름을 반환하는 함수를 구현하자. 없으면 ⇒ 해당 사원 없음
CREATE OR REPLACE FUNCTION get_emp_name(p_no employees.employee_id%TYPE)
    RETURN VARCHAR2
IS
    v_name VARCHAR2(50) := null;
BEGIN
    -- 사원명 검색
    SELECT last_name INTO v_name
    FROM employees
    WHERE employee_id = p_no;
    
    RETURN v_name;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            return '존재하지 않는 사원입니다.';
END;

SELECT get_emp_name(100) FROM dual;
SELECT get_emp_name(1000) FROM dual;

-- 패키지(Package)
-- 패키지 선언
CREATE OR REPLACE PACKAGE my_package
IS
	PROCEDURE getEmployee(in_id IN employees.employee_id%TYPE,
												out_id OUT employees.employee_id%TYPE,
												out_name OUT employees.first_name%TYPE,
												out_salary OUT employees.salary%TYPE);

FUNCTION getSalary(p_no employees.employee_id%TYPE)
	RETURN NUMBER;			
END;				

-- 패키지 본문
CREATE OR REPLACE PACKAGE BODY my_package
IS
	PROCEDURE getEmployee(in_id IN employees.employee_id%TYPE,
												out_id OUT employees.employee_id%TYPE,
												out_name OUT employees.first_name%TYPE,
												out_salary OUT employees.salary%TYPE)
IS
BEGIN
	SELECT employee_id, first_name, salary
	INTO out_id, out_name, out_salary
	FROM employees
	WHERE employee_id = in_id;
END; -- 프로시저 종료

FUNCTION getSalary(p_no employees.employee_id%TYPE)
	RETURN NUMBER	
	
	IS
		v_salary NUMBER;
	BEGIN
		SELECT salary INTO v_salary
		FROM employees
		WHERE employee_id = p_no;
		
		RETURN v_salary;
	END; -- 함수 종료
	
END; -- 패키지 종료
-- 함수 실행
SELECT my_package.getSalary(100) FROM dual;
-- 프로시저 실행
DECLARE
	p_id NUMBER;
	P_name VARCHAR2(50);
	p_salary NUMBER;
	
BEGIN
	my_package.getEmployee(100, p_id, p_name, p_salary);
	dbms_output.put_line(p_id || ' ' || p_name || ' ' || p_salary);
END;

-- 트리거
CREATE TABLE emp14(
	empno NUMBER PRIMARY KEY,
	ename VARCHAR2(20),
	job VARCHAR2(20)
)
					
CREATE OR REPLACE TRIGGER trg_01
	AFTER INSERT
	ON emp14
	BEGIN
		dbms_output.put_line('신입사원이 추가 되었습니다.');
	END; 
    
INSERT INTO emp14 VALUES(1, '홍길동', '개발');    

CREATE TABLE sal01(
	salno NUMBER PRIMARY KEY,
	sal NUMBER,
	empno NUMBER REFERENCES emp14(empno)
)

CREATE SEQUENCE sal01_salno_seq;

CREATE OR REPLACE TRIGGER trg02
	AFTER INSERT
	ON emp14
	FOR EACH ROW
		BEGIN
			INSERT INTO sal01 VALUES (sal01_salno_seq.NEXTVAL, 4000, :NEW.empno);
        END; 
        
INSERT INTO emp14 VALUES (2, '박길동', '영업');

CREATE OR REPLACE TRIGGER trg03
    AFTER DELETE
    ON emp14
    FOR EACH ROW
        BEGIN
            DELETE FROM sal01 WHERE empno = :OLD.empno;
        END;    
        
DELETE FROM emp14 WHERE empno = 2;

-- mission package
ALTER TABLE employees2 ADD(retire_date date);

--패키지 선언부
CREATE OR REPLACE PACKAGE hr_pkg IS
    --신규 사원 입력
    --신규사원 사번 => 마지막(최대)사번 + 1
    --신규사원 등록
    PROCEDURE new_emp_proc(ps_emp_name IN VARCHAR2,
	pe_email IN VARCHAR2,
	pj_job_id IN VARCHAR2,
	pd_hire_date IN VARCHAR2);
    -- TO_DATE(pdhire_date, 'YYYY-MM-DD');
    
  -- 퇴사 사원 처리
   --퇴사한 사원은 사원테이블에서 삭제하지 않고 퇴사일자(retire_date)를 NULL에서 갱신
   PROCEDURE retire_emp_proc(pn_employee_id IN NUMBER);
END hr_pkg;
-- 패키지 본문
CREATE OR REPLACE PACKAGE BODY hr_pkg IS  
    --신규 사원 입력
    PROCEDURE new_emp_proc(ps_emp_name IN VARCHAR2,
	pe_email IN VARCHAR2,
	pj_job_id IN VARCHAR2,
	pd_hire_date IN VARCHAR2)
    -- TO_DATE(pdhire_date, 'YYYY-MM-DD');
    
    IS
    v_max NUMBER := 0;
    BEGIN
         --신규사원 사번 => 마지막(최대)사번 + 1
        SELECT MAX(employee_id) 
        INTO v_max
        FROM employees2;
        --신규사원 등록
        INSERT INTO employees2(employee_id, last_name, email, hire_date, job_id) 
        VALUES(v_max + 1, ps_emp_name, pe_email, pd_hire_date, pj_job_id);
        
        COMMIT;
        
    END;
    
  -- 퇴사 사원 처리
   --퇴사한 사원은 사원테이블에서 삭제하지 않고 퇴사일자(retire_date)를 NULL에서 갱신
   PROCEDURE retire_emp_proc(pn_employee_id IN NUMBER)
   IS
   BEGIN
    UPDATE employees2 SET retire_date = SYSDATE
    WHERE employee_id = pn_employee_id;
   END;
END;   

-- 입사 프로시저 실행
DECLARE 
    BEGIN
        hr_pkg.new_emp_proc('홍길동', 'hong@naver.com', 'IT', SYSDATE);
    END;
-- 퇴사 프로시저 실행    
DECLARE  
BEGIN
    hr_pkg.retire_emp_proc(208);
END;
