-- mission 
-- 1)
SELECT dno, eno, ename, job
FROM emp
WHERE dno != (SELECT dno FROM emp
                WHERE ename = '������')
AND job = (SELECT job FROM emp
            WHERE ename = '������');
-- 2)
SELECT st.sno, st.sname, g.grade
FROM student st, score sc, course c, scgrade g
WHERE st.sno = sc.sno
AND c.cno = sc.cno
AND cname = '�Ϲ�ȭ��'
AND result BETWEEN loscore AND hiscore
AND grade > (SELECT grade 
            FROM student st, score sc, course c, scgrade g
            WHERE st.sno = sc.sno 
            AND sc.cno = c.cno
            AND st.sname = '����'
            AND c.cname = '�Ϲ�ȭ��'
            AND result BETWEEN loscore AND hiscore);

-- HAVING�� ��������           
SELECT MAX(AVG(sal)) FROM emp
GROUP BY dno;

SELECT dno FROM emp
GROUP BY dno
HAVING AVG(sal) = (SELECT MAX(AVG(sal)) FROM emp
					GROUP BY dno);
                    
-- ����> �л� �ο� ���� ���� ���� �а��� �������.
SELECT major FROM student
GROUP BY major
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM student
                        GROUP BY major);

-- mission
-- 1)
SELECT st.sno, sname
FROM student st, score sc
WHERE st.sno = sc.sno
GROUP BY st.sno, st.sname
HAVING AVG(result) = (SELECT MIN(AVG(result)) FROM score
                        GROUP BY sno);
-- 2)
SELECT major, syear, sname, avr
FROM student
WHERE avr <= (SELECT AVG(avr) FROM student
                WHERE major = 'ȭ��'
                AND syear = 1)
AND major = 'ȭ��'
AND syear = 1;

-- ANY, ALL
SELECT MIN(sal) FROM emp
WHERE dno = 10;

SELECT eno, ename, sal, dno
FROM emp
WHERE sal < (SELECT MIN(sal) FROM emp
WHERE dno = 10);

-- ALL: ���� ���� ������ �۴�.
SELECT eno, ename, sal, dno
FROM emp
WHERE sal < ALL(SELECT sal FROM emp
WHERE dno = 10);

-- mission
-- 1)
SELECT * FROM emp;
SELECT ename FROM emp
WHERE sal > ALL(SELECT sal FROM emp
                WHERE dno = 30);
-- 2)
SELECT * FROM emp
WHERE sal < ANY(SELECT sal FROM emp
                WHERE dno = 30);
-- 3)
SELECT ename, mgr
FROM emp
WHERE (mgr, job) IN (SELECT mgr, JOB FROM emp
                WHERE ename = '���ϴ�');
-- 4)
SELECT sname, avr FROM student
WHERE avr IN (SELECT avr FROM student
                WHERE major = 'ȭ��');
-- 5)
SELECT syear, sname, avr
FROM student
WHERE (avr, syear) IN (SELECT avr, syear FROM student
                         WHERE major = 'ȭ��')
AND major != 'ȭ��';
-- 6)
SELECT c.cno, c.cname, p.pname, AVG(result)
FROM professor p, course c, score s
WHERE p.pno = c.pno
AND c.cno = s.cno
GROUP BY c.cname, c.cno, p.pname
HAVING AVG(s.result) > (SELECT AVG(s.result)
                    FROM score s, course c
                    WHERE s.cno = c.cno
                    AND c.cname = '��ȭ��');
                    
CREATE TABLE board(
	seq NUMBER,
	title VARCHAR2(50),
	writer VARCHAR2(50),
	contents VARCHAR2(200),
	regdate DATE,
	hitcount NUMBER
)      

INSERT INTO board VALUES(1, 'a1', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(2, 'a2', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(3, 'a3', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(4, 'a4', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(5, 'a5', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(6, 'a6', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(7, 'a7', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(8, 'a8', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(9, 'a9', 'a', 'a', sysdate, 0);
INSERT INTO board VALUES(10, 'a10', 'a', 'a', sysdate, 0);

-- board ���̺� ���� 5���� 5,4,3,2,1 ������ �������
SELECT * FROM board
ORDER BY seq DESC;

SELECT ROWNUM, temp.*
FROM (SELECT * FROM board
ORDER BY seq DESC) temp
WHERE ROWNUM BETWEEN 6 AND 10;

SELECT * FROM (
	SELECT ROWNUM AS ROW_NUM, temp.*
	FROM (SELECT * FROM board
            ORDER BY seq DESC) temp
)
WHERE ROW_NUM BETWEEN 6 AND 10;