-- 1)
SELECT job FROM emp
WHERE ename = 'ALLEN';

SELECT job, empno, ename, d.deptno, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND job = (SELECT job FROM emp
            WHERE ename = 'ALLEN');
-- 2)
SELECT AVG(sal) FROM emp;

SELECT e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
FROM emp e, dept d, salgrade s
WHERE e.deptno = d.deptno
AND e.sal BETWEEN s.losal AND s.hisal
AND e.sal > (SELECT AVG(sal) FROM emp)
ORDER BY e.sal DESC, e.empno;
-- 3)
SELECT job
FROM emp e, dept d
WHERE e.deptno = 30;

SELECT e.empno, e.ename, e.job,
d.deptno, d.dname, d.loc
FROM emp e
JOIN dept d
ON e.deptno = d.deptno
WHERE job NOT IN (SELECT job
                FROM emp e, dept d
                WHERE e.deptno = 30)
AND e.deptno = 10;
-- 4)
SELECT sal FROM emp
WHERE job = 'SALESMAN';

-- 다중행 사용
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e
JOIN salgrade s
ON e.sal BETWEEN losal AND hisal
WHERE sal > (SELECT MAX(sal) FROM emp
                WHERE job = 'SALESMAN')
ORDER bY e.empno;

-- 다중행 사용 X
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e
JOIN salgrade s
ON e.sal BETWEEN losal AND hisal
WHERE sal > ALL(SELECT sal FROM emp
                WHERE job = 'SALESMAN')
ORDER bY e.empno;