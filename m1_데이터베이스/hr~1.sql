SELECT * FROM employees;

--Q. ����� 120���� ����� ��� , �̸� , ���� , (job_id), ������(job_title)�� ���
SELECT E.employee_id ���, E.first_name �̸�, E.last_name ��, E.job_id ����, J.job_title ������
FROM employees E
INNER JOIN jobs J ON E.job_id = J.job_id
WHERE E.employee_id=120;

--FIRST_name||''|| LAST_NAME AS �̸�: FIRST_NAME �� LAST_NAME�� �������� �����Ͽ�
--�ϳ��� ���ڿ��� ��ġ�� �� ����� ��Ī�� '�̸�'���� ����

SELECTT
EMPLOYEE_ID ���,
FIRST_NAME ||''|| LAST_NAME AS �̸�,
J.JOB_ID ����,
J.JOB_TITLE ������
FROM EMPLOYEES E, JOBS J
WHERE E.EMPLOYEE_ID=120
AND e.job_id = j.job_id;

SELECT
    E.EMPLOYEE_ID AS ���,  -- ������ ����� ��ȸ�ϰ� '���'�̶�� ��Ī�� ���Դϴ�.
    E.FIRST_NAME || ' ' || E.LAST_NAME AS �̸�,  -- ������ �̸��� ���� �������� �����Ͽ� '�̸�'�̶�� ��Ī�� ���Դϴ�.
    J.JOB_ID AS ����,  -- ������ ���� ID�� ��ȸ�ϰ� '����'��� ��Ī�� ���Դϴ�.
    J.JOB_TITLE AS ������  -- ������ �������� ��ȸ�ϰ� '������'�̶�� ��Ī�� ���Դϴ�.
FROM
    EMPLOYEES E  -- ���� ���̺��� �����մϴ�.
JOIN
    JOBS J ON E.JOB_ID = J.JOB_ID  -- ������ ���� ID�� ���� ���̺��� ���� ID�� �����մϴ�.
WHERE
    E.EMPLOYEE_ID = 120
    
AND e.job_id = j.job_id;

--Q.2005�� ��ݱ⿡ �Ի��� ������� �̸�(full name)�� �Ի��ϸ� ���
SELECT first_name||''||last_name "�̸�",hire_date "�Ի���"
FROM employees
WHERE TO_CHAR(hire_date, 'YY/MM') BETWEEN '05/01' AND '05/06';


--_�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����ϰ� ���� �� escape �ɼ��� ���
select * from employees where job_id like '%\_A%';
select * from employees where job_id like '%\_A%'; escape '\';
select * from employees where job_id like '%\_A%'; escape '%';

--IN : OR ��� ���
select * from employees where manager_id=101 or manager_id=102 or manager_id=103;
select * from employees where manager_id in (101,102,103);

--Q. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
select * from employees where job_id in('SA_MAN', 'IT_PROG', 'ST_MAN');

--IS NULL / IS NOT NULL
--null �������� Ȯ���� ��� = �� �����ڸ� ������� �ʰ� is null �� ����Ѵ�
select * from employees where commission_pct is null;
select * from employees where commission_pct is not null;

--ORDER BY
--ORDER BY �÷��� (ASC | DESC)
select * from employees order by salary asc;
select * from employees order by salary desc;
select * from employees order by salary asc, last_name desc;

--DUAL ���̺�
--mod ������
select * from employees where mod(employee_id, 2) = 1;
select mod(10,3) from dual;

--round()
select round(355.95555) from dual;
select round(355.95555, 2) from dual;
select round(355.95555, -2) from dual;

--trunc() ���� �Լ� ������ �ڸ��� ���ϸ� ���� ��� ����
select trunc(45.5555, 1) from dual;

--ceil() ������ �ø�, �ڸ� ���� ����
select ceil(45.11)from dual;

--Q. HR EMPLOYEES ���̺��� �̸� , �޿� , 10% �λ�� �޿��� ����ϼ���
SELECT last_name �̸�, salary �޿�, salary*1.1 "�λ�� �޿�"
FROM employees;

--Q. EMPLOYEE_ID�� Ȧ���� ������ EMPLOYEE_ID�� LAST_NAME�� ����ϼ���
SELECT employee_id �����ȣ, last_name �̸�
FROM employees
WHERE employee_id IN (SELECT employee_id FROM employees WHERE mod(employee_id, 2) = 1);

--Q. EMPLOYEES ���̺��� commission_pct �� Null�� ������ ���������
SELECT COUNT(*) FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;

--Q.EMPLOYEES ���̺��� department_id�� ���� ������ �����Ͽ� POSITION�� '����'���� ����ϼ���(position ���� �߰�)
SELECT employee_id, first_name||' '||last_name sull_name, '����' position
FROM employees 
WHERE department_id is null;

--��¥ ����
select sysdate from dual;
select sysdate +1 from dual;
select sysdate -1 from dual;

select * from employees;
--�ٹ��� ��¥ ���
select last_name, sysdate, hire_date, trunc(sysdate-hire_date) �ٹ��Ⱓ from employees;

--add_months()          Ư�� ���� ���� ���� ��¥�� ���Ѵ�
select last_name, hire_date, add_months(hire_date,6) recised_date from employees;

--last_day()           �ش� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
select last_name, hire_date, last_day(hire_date) from employees;

select last_name, hire_date, last_day(add_months(hire_date,1)) from employees;

--next_day()          �ش� ��¥�� �������� ������ ��� ���Ͽ� �ش��ϴ� ���ڸ� ��ȯ
--�� - ��, 1-7�� ǥ������
select hire_date, next_day(hire_date, '��') from employees;
select hire_date, next_day(hire_date, 2) from employees;

--months_between()    ��¥�� ��¥ ������ �������� ���Ѵ�
select hire_date, round(months_between(sysdate, hire_date),1) from employees;

--�� ��ȯ �Լ� : to_date()       ���ڿ��� ��¥��
--'2023-01-01'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ
select to_date('2023-01-01', 'YYYY-MM-DD') from dual;

--to_date(��¥)     ��¥�� ���ڷ� ��ȯ
select to_char(sysdate, 'yy/mm/dd') from dual;
select to_char(sysdate, 'YY/MM/DD') from dual;

--����
--YYYY       �� �ڸ� ����
--YY      �� �ڸ� ����
--YEAR      ���� ���� ǥ��
--MM      ���� ���ڷ�
--MON      ���� ���ĺ�����
--DD      ���� ���ڷ�
--DAY      ���� ǥ��
--DY      ���� ��� ǥ��
--D      ���� ���� ǥ��
--AM �Ǵ� PM   ���� ����
--HH �Ǵ� HH12   12�ð�
--HH24      24�ð�
--MI      ��
--SS      ��


--Q. ���糯¥(SYSDATE)�� 'YYYY/MM/DD' ������ ���ڿ��� ��ȯ�ϼ���
select to_char(sysdate, 'YYYY/MM/DD') "��¥" from dual;
--Q. '01-01-2023'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȭ�ϼ���
select to_date('02-01-2023', 'mm/dd/yyyy') from dual;
--Q. ���� ��¥�� �ð�(SYSDATE)�� 'YYYY-MM-DD HH24:MI:SS' ������ ���ڿ��� ��ȯ�ϼ���
select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual;
--Q. '2023-01-01 15:30:00'�̶�� ���ڿ��� ��¥ �� �ð� Ÿ������ ��ȯ�ϼ���
select to_date('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS') from dual;


--to_char( ���� )   ���ڸ� ���ڷ� ��ȯ
--9      �� �ڸ��� ���� ǥ��      ( 1111, ��99999�� )      1111   
--0      �� �κ��� 0���� ǥ��      ( 1111, ��099999�� )      001111
--$      �޷� ��ȣ�� �տ� ǥ��      ( 1111, ��$99999�� )      $1111
--.      �Ҽ����� ǥ��         ( 1111, ��99999.99�� )      1111.00
--,      Ư�� ��ġ�� , ǥ��      ( 1111, ��99,999�� )      1,111
--MI      �����ʿ� - ��ȣ ǥ��      ( 1111, ��99999MI�� )      1111-
--PR      �������� <>�� ǥ��      ( -1111, ��99999PR�� )      <1111>
--EEEE      ������ ǥ��         ( 1111, ��99.99EEEE�� )      1.11E+03
--V      10�� n�� ���Ѱ����� ǥ��   ( 1111, ��999V99�� )      111100
--B      ������ 0���� ǥ��      ( 1111, ��B9999.99�� )      1111.00
--L      ������ȭ         ( 1111, ��L9999�� )

select salary, to_char(salary,'0999999') from employees;
select to_char(-salary, '999999PR') from employees;
--1111 -> 1.11E*03
select to_char(11111,'9.999EEEE') from dual;
select to_char(-1111111, '9999999MI') from dual;

--width_bucket()          ������, �ּҰ�, �ִ밪, bucket����
select width_bucket(92,0,100,10) from dual;
select width_bucket(100,0,100,10) from dual;

select salary from employees;
--Q. employees ���̺��� salary�� 5�� ������� ǥ���ϼ���
select max(salary)max,min(salary) min from employees;
select salary, width_bucket(salary, 2100, 24001, 5) AS grade
from employees;

--���� �Լ� character function
--upper()      �빮�ڷ� ����
select upper('Hello World') from dual;
--lower()     �ҹ��ڷ� ����
select lower('Hello World') from dual;

--Q. last_name�� Seo�� ������ last_name �� salary�� ���ϼ���.(Seo, SEO, seo ��ΰ���)
select last_name, salary from employees where lower(last_name) = 'seo';

--initcap()          ù���ڸ� �빮��
select job_id, initcap(job_id) from employees;

--length()         ���ڿ��� ����
select job_id, length(job_id) from employees;

--instr()       ���ڿ�, ã�� ����, ã�� ��ġ, ã�� ���� �� ���°
select instr('Hello World','o',3,2) from dual;

--substr()       ���ڿ�, ������ġ, ����
select substr('Hello World',3,3) from dual;
select substr('Hello World',9,3) from dual;
select substr('Hello World',-3,3) from dual;

--lpad()        ������ ���� �� ���ʿ� ���ڸ� ä���
select lpad('Hello World',20, '#') from dual;

--rpad()        ���� ���� �� �����ʿ� ���ڸ� ä���
select rpad('Hello World',20, '#') from dual;

--ltrim()
select ltrim('aaaHello Worldaaa', 'a') from dual;
select ltrim('   Hello World   ', 'a') from dual;
--rtrim()
select rtrim('aaaHello Worldaaa', 'a') from dual;
select rtrim('   Hello World   ', 'a') from dual;

select last_name from employees;
select last_name as �̸�, ltrim(last_name,'A') as ��ȯ
from employees;

--trim
select trim('   Hello World   ') from dual;
--�յ��� Ư�� ���� ����
select last_name, trim('A' from last_name) from employees;

--nvl()   null�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϴ� �Լ�
select last_name, manager_id,
nvl(to_char(manager_id),'CEO') from employees;

--decode()    if���̳� case���� ���� ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
--DECODE �Լ��� �ܼ��� ���ǿ� ����Ͽ� ���� ��ȯ�մϴ�. ������ DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--���⼭ expression�� �˻��� ���� ��Ÿ����, search�� result�� ���� ���ǰ� �ش� ������ ���� �� ��ȯ�� ��
--default�� ��� search ������ ������ �� ��ȯ�� �⺻ �� ���
select last_name, department_id,
decode (department_id,
    90, '�濵������',
    60, '���α׷���',
    100, '�λ��','��Ÿ') �μ�
from employees;

--Q. employees ���̺��� commission_pct�� null�� �ƴ� ���, 'A' null�� ��� 'N' �� ǥ���ϴ� ������ �ۼ�
select commission_pct as commission
    , decode(commission_pct, null, 'N', 'A') as ��ȯ
from employees
order by ��ȯ desc;

--case()
--decode() �Լ��� �����ϳ� decode() �Լ��� �ܼ��� ���� �񱳿� ���Ǵ� �ݸ�
--case() �Լ��� �پ��� �񱳿����ڷ� ������ ������ �� �ִ�.
--CASE ���� ���ǿ� ���� �ٸ� ���� ��ȯ�ϴ� �� ���Ǹ�, DECODE���� ������ ������ ǥ���� �� �ִ�. 
--������ CASE WHEN condition THEN result ... ELSE default END�̴�. 
select last_name, department_id,
case when department_id=90 then '�濵������'
when department_id=60 then '���α׷���'
when department_id=100 then '�λ��'
else '��Ÿ'
end as �Ҽ�
from employees;

--Q. employees ���̺��� salary�� 20000 dltkddlaus 'a', 10000�� 20000�̸� ���̸� 'b', �� ���ϸ� 'c'�� ǥ���ϴ� ������ �ۼ��Ͻÿ�(case)
select last_name,salary,
case
when salary>=20000 then 'a'
when salary>=10000 and salary<20000 then 'b'
else 'c'
end as ���
from employees;


--INSERT
--���̺� �����͸� �Է��ϴ� ����� �� ���� ������ ������ �� ���� �� �Ǹ� �Էµȴ�.
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUMN_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);

--concatention : �޸� ��ſ� ����ϸ� ���ڿ��� ����Ǿ� ����Ѵ�
select last_name, 'is a', job_id from employees;
select last_name || 'is a' || job_id from employees;

--UNION
--UNION(������) INTERSECT(������) MINUS(������) UNION ALL(��ġ�°ͱ��� ����)
--�� ���� �������� ����ؾ� �Ѵ� ������ Ÿ���� ��ġ ���Ѿ� �Ѵ�
select first_name �̸�, salary �޿�, hire_date from employees
where salary < 5000
union
select first_name �̸�, salary �޿�, hire_date from employees
where hire_date < '05/01/01';

select first_name �̸�, salary �޿�, hire_date from employees
where salary < 5000
intersect
select first_name �̸�, salary �޿�, hire_date from employees
where hire_date < '05/01/01';

select first_name �̸�, salary �޿�, hire_date from employees
where salary < 5000
union all
select first_name �̸�, salary �޿�, hire_date from employees
where hire_date < '05/01/01';

--CREATE VIEW ��ɾ�� ����Ŭ SQL���� ���̺��� Ư�� �κ��̳� ���ε� ����� ������ ��(view)�� ���� �� ���
--��� �����͸� ����ϰų� ������ ������ �ܼ�ȭ�ϸ�, ����ڿ��� �ʿ��� �����͸��� �����ִ� �� ����
--��� ���� ���̺� �����͸� �������� �ʰ� ��� ������ ��ü�� ����
--���� �ֿ� Ư¡
--���� �ܼ�ȭ: ������ ������ ��� ���������ν� ����ڴ� ������ �������� �ݺ��ؼ� �ۼ��� �ʿ� ���� �����ϰ� �並 ������ �� �ִ�.
--������ �߻�ȭ: ��� �⺻ ���̺��� ������ ����� ����ڿ��� �ʿ��� �����͸��� ������ �� �־�, ������ �߻�ȭ�� ����.
--���� ��ȭ: �並 ����ϸ� Ư�� �����Ϳ� ���� ������ ������ �� ������, ����ڰ� �� �� �ִ� �������� ������ ������ �� �ִ�.
--������ ���Ἲ ����: �並 ����Ͽ� �����͸� �����ϴ���, �� ��������� �⺻ ���̺��� ������ ���Ἲ ��Ģ�� �������� �ʵ��� ������ �� �ִ�.

create view employee_details as
select employee_id, last_name, department_id
from employees;

select * from employee_details;

--Q. employees ���̺��� salary�� 10000�� �̻��� �������� �����ϴ� �� special_employee�� �����ϴ� SQL ��ɹ��� �ۼ��Ͻÿ�
create view special_employee as
select *
from employees
where salary >= 10000;
select * from special_employee;

--Q. employees ���̺��� �� �μ��� ���� ���� �����ϴ� �並 �����ϼ���
CREATE VIEW department_employee_count AS
SELECT department_id COUNT(*) AS �μ���_������
FROM employees
GROUP BY department_id
ORDER BY �μ���_������

SELECT * FROM department__employee_count;
--Q. employees ���̺��� �ټӱⰣ�� 10�� �̻��� ������ �����ϴ� �並 �����ϼ���
CREATE VIEW goinmul AS
SELECT last_name, round(sysdate-hire_date) AS �ټӱⰣ
FROM employees
WHERE trunc(sysdate-hire_date) > 365 * 10;
ORDER BY �ټӱⰣ;
SELECT * FROM goinmul;

--TCL (Transaction Control Language)
--COMMIT: ���� Ʈ����� ������ ����� ��� ����(INSERT, UPDATE, DELETE ��)�� �����ͺ��̽��� ���������� ����.
--COMMIT ����� �����ϸ�, Ʈ������� �Ϸ�Ǹ�, �� ���Ŀ��� ���� ������ �ǵ��� �� ����.
--ROLLBACK: ���� Ʈ����� ������ ����� ������� ����ϰ�, �����ͺ��̽��� Ʈ������� �����ϱ� ���� ���·� �ǵ�����. 
--������ �߻��߰ų� �ٸ� ������ Ʈ������� ����ؾ� �� ��쿡 ���ȴ�.
--SAVEPOINT: Ʈ����� ������ �߰� üũ����Ʈ�� �����մϴ�. ������ �߻��� ���, ROLLBACK�� ����Ͽ� �ֱ��� SAVEPOINT���� �ǵ��� �� �ִ�.
--Ʈ������� ��Ʈ���ϴ� TCL(TRANSACTION CONTROL LANGUAGE)

--members ���̺� ����
drop table members;
create table members(
    member_id number primary key,
    name varchar2(100),
    email varchar2(100),
    join_date DATE,
    status varchar2(20)
);
INSERT INTO members (member_id, name, email, join_date, status) VALUES (1, 'John Doe', 'john@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (2, 'Jane Doe', 'jane@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (3, 'Mike Smith', 'mike@example.com', SYSDATE, 'Inactive');

select * from members;

INSERT INTO members (member_id, name, email, join_date, status) VALUES (4, 'Alice Johnson', 'alice@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (5, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (6, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');

savepoint sql;
insert into members (member_id, name, email, join_date, status) values (7, 'Bob Kim', 'bob@example.com', SYSDATE, 'Inactive');

rollback to sql;
commit;

--Task1_0523. 
--orders��� ���̺��� �����ϰ�, order_id, customer_id, order_date, amount, status��� �Ӽ��� �����ϼ���.
--�����͸� 5�� �Է��ϼ���.
--�Է��� ������ �� 2���� �����ϼ���.
--������ �����͸� ����ϱ� ���� �ѹ��� ����ϼ���.
--3���� ���ο� �����͸� �Է��ϰ�, �� �� ������ ������ �Է¸� ����� �� �������� Ŀ���ϼ���.

--�μ���� Ȯ��
--�μ��� �޿� ��Ȳ
--���̺����, �μ��� �޿��� �� �޿��� Ȯ�� �� �� ����.
--(�޿��� �� ��� �ּڰ� �ִ�, �� ������, �޿���ü����, ������ձ޿�, �μ���ձ޿�)
--table ����� �μ��� �޿��� �뷫������ ����
--����� ���̺� Ȯ��
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--�μ� ��� Ȯ��
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- �μ� ��� department_id : 10,20,30,40,50,60,70,80,90,100,110 �� �� ������(120~200��..)�� ���� null ���� ����.
--department_id �� null �� ����� ��� job_id �� �´� department_id �� �ο����ַ�����(������ ���Ἲ)
--1. department_id �� null ���� ��� ã��
select *
from employees
where department_id IS NULL;
--�Ѹ� �ۿ� ����. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id �� SA_REP �� department_id ã�� (������ �´� �μ� ã��)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP �� department_id �� 80

--3. ���� �� savepoint ����
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. ��������primary key �� employee_id �� ã�Ƽ� derpartment_id �� 80���� ����
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint�� ����
--commit;
--������

--Ž���� �� ������ ������
--�� �μ����� ������ ����̰� � �����ǵ��� �ְ� ������ ��� �Ǵ���
--ROLLUP�� ���������� ���� ����� ���� : ��� �� �μ� �� ������ ���� ���� ����
SELECT E.department_id, D.department_name, NVL(E.job_id, 'Total') job_id, COUNT(*) AS ������
FROM employees E
LEFT OUTER JOIN departments D ON E.department_id = D.department_id
GROUP BY ROLLUP (E.department_id, D.department_name, E.job_id)
ORDER BY E.department_id;

--JOB ID �� ������� �� �޴��� �� �������� ������ ���
SELECT job_id, ����, ROUND(AVG(salary)) ��ձ޿�
FROM (SELECT job_id, FLOOR(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) AS ����, salary FROM employees)
GROUP BY job_id, ����
ORDER BY job_id, ����;





--*****************************************************************************************
(�ǽ�)
--���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���
--�λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���Ը����� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ���

CREATE TABLE "COUNTRIES" 
   (   "COUNTRY_ID" CHAR(2), 
   "COUNTRY_NAME" VARCHAR2(40), 
   "REGION_ID" NUMBER, 
    CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "COUNTRIES"."COUNTRY_ID" IS 'Primary key of countries table.';
   COMMENT ON COLUMN "COUNTRIES"."COUNTRY_NAME" IS 'Country name';
   COMMENT ON COLUMN "COUNTRIES"."REGION_ID" IS 'Region ID for the country. Foreign key to region_id column in the departments table.';
   COMMENT ON TABLE "COUNTRIES"  IS 'country table. Contains 25 rows. References with locations table.';
--------------------------------------------------------
--  DDL for Table DEPARTMENTS
--------------------------------------------------------

  CREATE TABLE "DEPARTMENTS" 
   (   "DEPARTMENT_ID" NUMBER(4,0), 
   "DEPARTMENT_NAME" VARCHAR2(30), 
   "MANAGER_ID" NUMBER(6,0), 
   "LOCATION_ID" NUMBER(4,0)
   ) ;

   COMMENT ON COLUMN "DEPARTMENTS"."DEPARTMENT_ID" IS 'Primary key column of departments table.';
   COMMENT ON COLUMN "DEPARTMENTS"."DEPARTMENT_NAME" IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. ';
   COMMENT ON COLUMN "DEPARTMENTS"."MANAGER_ID" IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';
   COMMENT ON COLUMN "DEPARTMENTS"."LOCATION_ID" IS 'Location id where a department is located. Foreign key to location_id column of locations table.';
   COMMENT ON TABLE "DEPARTMENTS"  IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';
--------------------------------------------------------
--  DDL for Table EMPLOYEES
--------------------------------------------------------

  CREATE TABLE "EMPLOYEES" 
   (   "EMPLOYEE_ID" NUMBER(6,0), 
   "FIRST_NAME" VARCHAR2(20), 
   "LAST_NAME" VARCHAR2(25), 
   "EMAIL" VARCHAR2(25), 
   "PHONE_NUMBER" VARCHAR2(20), 
   "HIRE_DATE" DATE, 
   "JOB_ID" VARCHAR2(10), 
   "SALARY" NUMBER(8,2), 
   "COMMISSION_PCT" NUMBER(2,2), 
   "MANAGER_ID" NUMBER(6,0), 
   "DEPARTMENT_ID" NUMBER(4,0)
   ) ;

   COMMENT ON COLUMN "EMPLOYEES"."EMPLOYEE_ID" IS 'Primary key of employees table.';
   COMMENT ON COLUMN "EMPLOYEES"."FIRST_NAME" IS 'First name of the employee. A not null column.';
   COMMENT ON COLUMN "EMPLOYEES"."LAST_NAME" IS 'Last name of the employee. A not null column.';
   COMMENT ON COLUMN "EMPLOYEES"."EMAIL" IS 'Email id of the employee';
   COMMENT ON COLUMN "EMPLOYEES"."PHONE_NUMBER" IS 'Phone number of the employee; includes country code and area code';
   COMMENT ON COLUMN "EMPLOYEES"."HIRE_DATE" IS 'Date when the employee started on this job. A not null column.';
   COMMENT ON COLUMN "EMPLOYEES"."JOB_ID" IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.';
   COMMENT ON COLUMN "EMPLOYEES"."SALARY" IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)';
   COMMENT ON COLUMN "EMPLOYEES"."COMMISSION_PCT" IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage';
   COMMENT ON COLUMN "EMPLOYEES"."MANAGER_ID" IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';
   COMMENT ON COLUMN "EMPLOYEES"."DEPARTMENT_ID" IS 'Department id where employee works; foreign key to department_id
column of the departments table';
   COMMENT ON TABLE "EMPLOYEES"  IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.';
--------------------------------------------------------
--  DDL for Table JOBS
--------------------------------------------------------

  CREATE TABLE "JOBS" 
   (   "JOB_ID" VARCHAR2(10), 
   "JOB_TITLE" VARCHAR2(35), 
   "MIN_SALARY" NUMBER(6,0), 
   "MAX_SALARY" NUMBER(6,0)
   ) ;

   COMMENT ON COLUMN "JOBS"."JOB_ID" IS 'Primary key of jobs table.';
   COMMENT ON COLUMN "JOBS"."JOB_TITLE" IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';
   COMMENT ON COLUMN "JOBS"."MIN_SALARY" IS 'Minimum salary for a job title.';
   COMMENT ON COLUMN "JOBS"."MAX_SALARY" IS 'Maximum salary for a job title';
   COMMENT ON TABLE "JOBS"  IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';
--------------------------------------------------------
--  DDL for Table JOB_HISTORY
--------------------------------------------------------

  CREATE TABLE "JOB_HISTORY" 
   (   "EMPLOYEE_ID" NUMBER(6,0), 
   "START_DATE" DATE, 
   "END_DATE" DATE, 
   "JOB_ID" VARCHAR2(10), 
   "DEPARTMENT_ID" NUMBER(4,0)
   ) ;

   COMMENT ON COLUMN "JOB_HISTORY"."EMPLOYEE_ID" IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';
   COMMENT ON COLUMN "JOB_HISTORY"."START_DATE" IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';
   COMMENT ON COLUMN "JOB_HISTORY"."END_DATE" IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';
   COMMENT ON COLUMN "JOB_HISTORY"."JOB_ID" IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';
   COMMENT ON COLUMN "JOB_HISTORY"."DEPARTMENT_ID" IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';
   COMMENT ON TABLE "JOB_HISTORY"  IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';
--------------------------------------------------------
--  DDL for Table LOCATIONS
--------------------------------------------------------

  CREATE TABLE "LOCATIONS" 
   (   "LOCATION_ID" NUMBER(4,0), 
   "STREET_ADDRESS" VARCHAR2(40), 
   "POSTAL_CODE" VARCHAR2(12), 
   "CITY" VARCHAR2(30), 
   "STATE_PROVINCE" VARCHAR2(25), 
   "COUNTRY_ID" CHAR(2)
   ) ;
--�÷� �ּ� ����
   COMMENT ON COLUMN "LOCATIONS"."LOCATION_ID" IS 'Primary key of locations table';
   COMMENT ON COLUMN "LOCATIONS"."STREET_ADDRESS" IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';
   COMMENT ON COLUMN "LOCATIONS"."POSTAL_CODE" IS 'Postal code of the location of an office, warehouse, or production site
of a company. ';
   COMMENT ON COLUMN "LOCATIONS"."CITY" IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. ';
   COMMENT ON COLUMN "LOCATIONS"."STATE_PROVINCE" IS 'State or Province where an office, warehouse, or production site of a
company is located.';
   COMMENT ON COLUMN "LOCATIONS"."COUNTRY_ID" IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';
   COMMENT ON TABLE "LOCATIONS"  IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';
--------------------------------------------------------
--  DDL for Table REGIONS
--------------------------------------------------------

  CREATE TABLE "REGIONS" 
   (   "REGION_ID" NUMBER, 
   "REGION_NAME" VARCHAR2(25)
   ) ;
REM INSERTING into COUNTRIES
SET DEFINE OFF;
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('AR','Argentina',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('AU','Australia',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('BE','Belgium',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('BR','Brazil',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CA','Canada',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CH','Switzerland',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CN','China',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DE','Germany',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DK','Denmark',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('EG','Egypt',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('FR','France',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IL','Israel',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IN','India',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IT','Italy',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('JP','Japan',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('KW','Kuwait',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ML','Malaysia',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('MX','Mexico',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('NG','Nigeria',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('NL','Netherlands',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('SG','Singapore',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('UK','United Kingdom',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('US','United States of America',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ZM','Zambia',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ZW','Zimbabwe',4);
REM INSERTING into DEPARTMENTS
SET DEFINE OFF;
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (10,'Administration',200,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (20,'Marketing',201,1800);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (30,'Purchasing',114,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (40,'Human Resources',203,2400);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (50,'Shipping',121,1500);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (60,'IT',103,1400);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (70,'Public Relations',204,2700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (80,'Sales',145,2500);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (90,'Executive',100,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (100,'Finance',108,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (110,'Accounting',205,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (120,'Treasury',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (130,'Corporate Tax',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (140,'Control And Credit',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (150,'Shareholder Services',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (160,'Benefits',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (170,'Manufacturing',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (180,'Construction',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (190,'Contracting',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (200,'Operations',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (210,'IT Support',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (220,'NOC',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (230,'IT Helpdesk',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (240,'Government Sales',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (250,'Retail Sales',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (260,'Recruiting',null,1700);
Insert into DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID) values (270,'Payroll',null,1700);
REM INSERTING into EMPLOYEES
SET DEFINE OFF;
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (100,'Steven','King','SKING','515.123.4567',to_date('03/06/17','RR/MM/DD'),'AD_PRES',24000,null,null,90);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (101,'Neena','Kochhar','NKOCHHAR','515.123.4568',to_date('05/09/21','RR/MM/DD'),'AD_VP',17000,null,100,90);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (102,'Lex','De Haan','LDEHAAN','515.123.4569',to_date('01/01/13','RR/MM/DD'),'AD_VP',17000,null,100,90);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (103,'Alexander','Hunold','AHUNOLD','590.423.4567',to_date('06/01/03','RR/MM/DD'),'IT_PROG',9000,null,102,60);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (104,'Bruce','Ernst','BERNST','590.423.4568',to_date('07/05/21','RR/MM/DD'),'IT_PROG',6000,null,103,60);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (105,'David','Austin','DAUSTIN','590.423.4569',to_date('05/06/25','RR/MM/DD'),'IT_PROG',4800,null,103,60);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (106,'Valli','Pataballa','VPATABAL','590.423.4560',to_date('06/02/05','RR/MM/DD'),'IT_PROG',4800,null,103,60);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (107,'Diana','Lorentz','DLORENTZ','590.423.5567',to_date('07/02/07','RR/MM/DD'),'IT_PROG',4200,null,103,60);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (108,'Nancy','Greenberg','NGREENBE','515.124.4569',to_date('02/08/17','RR/MM/DD'),'FI_MGR',12008,null,101,100);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (109,'Daniel','Faviet','DFAVIET','515.124.4169',to_date('02/08/16','RR/MM/DD'),'FI_ACCOUNT',9000,null,108,100);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (110,'John','Chen','JCHEN','515.124.4269',to_date('05/09/28','RR/MM/DD'),'FI_ACCOUNT',8200,null,108,100);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (111,'Ismael','Sciarra','ISCIARRA','515.124.4369',to_date('05/09/30','RR/MM/DD'),'FI_ACCOUNT',7700,null,108,100);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (112,'Jose Manuel','Urman','JMURMAN','515.124.4469',to_date('06/03/07','RR/MM/DD'),'FI_ACCOUNT',7800,null,108,100);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (113,'Luis','Popp','LPOPP','515.124.4567',to_date('07/12/07','RR/MM/DD'),'FI_ACCOUNT',6900,null,108,100);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (114,'Den','Raphaely','DRAPHEAL','515.127.4561',to_date('02/12/07','RR/MM/DD'),'PU_MAN',11000,null,100,30);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (115,'Alexander','Khoo','AKHOO','515.127.4562',to_date('03/05/18','RR/MM/DD'),'PU_CLERK',3100,null,114,30);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (116,'Shelli','Baida','SBAIDA','515.127.4563',to_date('05/12/24','RR/MM/DD'),'PU_CLERK',2900,null,114,30);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (117,'Sigal','Tobias','STOBIAS','515.127.4564',to_date('05/07/24','RR/MM/DD'),'PU_CLERK',2800,null,114,30);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (118,'Guy','Himuro','GHIMURO','515.127.4565',to_date('06/11/15','RR/MM/DD'),'PU_CLERK',2600,null,114,30);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (119,'Karen','Colmenares','KCOLMENA','515.127.4566',to_date('07/08/10','RR/MM/DD'),'PU_CLERK',2500,null,114,30);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (120,'Matthew','Weiss','MWEISS','650.123.1234',to_date('04/07/18','RR/MM/DD'),'ST_MAN',8000,null,100,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (121,'Adam','Fripp','AFRIPP','650.123.2234',to_date('05/04/10','RR/MM/DD'),'ST_MAN',8200,null,100,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (122,'Payam','Kaufling','PKAUFLIN','650.123.3234',to_date('03/05/01','RR/MM/DD'),'ST_MAN',7900,null,100,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (123,'Shanta','Vollman','SVOLLMAN','650.123.4234',to_date('05/10/10','RR/MM/DD'),'ST_MAN',6500,null,100,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (124,'Kevin','Mourgos','KMOURGOS','650.123.5234',to_date('07/11/16','RR/MM/DD'),'ST_MAN',5800,null,100,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (125,'Julia','Nayer','JNAYER','650.124.1214',to_date('05/07/16','RR/MM/DD'),'ST_CLERK',3200,null,120,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (126,'Irene','Mikkilineni','IMIKKILI','650.124.1224',to_date('06/09/28','RR/MM/DD'),'ST_CLERK',2700,null,120,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (127,'James','Landry','JLANDRY','650.124.1334',to_date('07/01/14','RR/MM/DD'),'ST_CLERK',2400,null,120,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (128,'Steven','Markle','SMARKLE','650.124.1434',to_date('08/03/08','RR/MM/DD'),'ST_CLERK',2200,null,120,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (129,'Laura','Bissot','LBISSOT','650.124.5234',to_date('05/08/20','RR/MM/DD'),'ST_CLERK',3300,null,121,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (130,'Mozhe','Atkinson','MATKINSO','650.124.6234',to_date('05/10/30','RR/MM/DD'),'ST_CLERK',2800,null,121,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (131,'James','Marlow','JAMRLOW','650.124.7234',to_date('05/02/16','RR/MM/DD'),'ST_CLERK',2500,null,121,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (132,'TJ','Olson','TJOLSON','650.124.8234',to_date('07/04/10','RR/MM/DD'),'ST_CLERK',2100,null,121,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (133,'Jason','Mallin','JMALLIN','650.127.1934',to_date('04/06/14','RR/MM/DD'),'ST_CLERK',3300,null,122,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (134,'Michael','Rogers','MROGERS','650.127.1834',to_date('06/08/26','RR/MM/DD'),'ST_CLERK',2900,null,122,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (135,'Ki','Gee','KGEE','650.127.1734',to_date('07/12/12','RR/MM/DD'),'ST_CLERK',2400,null,122,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (136,'Hazel','Philtanker','HPHILTAN','650.127.1634',to_date('08/02/06','RR/MM/DD'),'ST_CLERK',2200,null,122,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (137,'Renske','Ladwig','RLADWIG','650.121.1234',to_date('03/07/14','RR/MM/DD'),'ST_CLERK',3600,null,123,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (138,'Stephen','Stiles','SSTILES','650.121.2034',to_date('05/10/26','RR/MM/DD'),'ST_CLERK',3200,null,123,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (139,'John','Seo','JSEO','650.121.2019',to_date('06/02/12','RR/MM/DD'),'ST_CLERK',2700,null,123,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (140,'Joshua','Patel','JPATEL','650.121.1834',to_date('06/04/06','RR/MM/DD'),'ST_CLERK',2500,null,123,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (141,'Trenna','Rajs','TRAJS','650.121.8009',to_date('03/10/17','RR/MM/DD'),'ST_CLERK',3500,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (142,'Curtis','Davies','CDAVIES','650.121.2994',to_date('05/01/29','RR/MM/DD'),'ST_CLERK',3100,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (143,'Randall','Matos','RMATOS','650.121.2874',to_date('06/03/15','RR/MM/DD'),'ST_CLERK',2600,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (144,'Peter','Vargas','PVARGAS','650.121.2004',to_date('06/07/09','RR/MM/DD'),'ST_CLERK',2500,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (145,'John','Russell','JRUSSEL','011.44.1344.429268',to_date('04/10/01','RR/MM/DD'),'SA_MAN',14000,0.4,100,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (146,'Karen','Partners','KPARTNER','011.44.1344.467268',to_date('05/01/05','RR/MM/DD'),'SA_MAN',13500,0.3,100,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (147,'Alberto','Errazuriz','AERRAZUR','011.44.1344.429278',to_date('05/03/10','RR/MM/DD'),'SA_MAN',12000,0.3,100,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (148,'Gerald','Cambrault','GCAMBRAU','011.44.1344.619268',to_date('07/10/15','RR/MM/DD'),'SA_MAN',11000,0.3,100,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018',to_date('08/01/29','RR/MM/DD'),'SA_MAN',10500,0.2,100,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (150,'Peter','Tucker','PTUCKER','011.44.1344.129268',to_date('05/01/30','RR/MM/DD'),'SA_REP',10000,0.3,145,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (151,'David','Bernstein','DBERNSTE','011.44.1344.345268',to_date('05/03/24','RR/MM/DD'),'SA_REP',9500,0.25,145,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (152,'Peter','Hall','PHALL','011.44.1344.478968',to_date('05/08/20','RR/MM/DD'),'SA_REP',9000,0.25,145,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (153,'Christopher','Olsen','COLSEN','011.44.1344.498718',to_date('06/03/30','RR/MM/DD'),'SA_REP',8000,0.2,145,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (154,'Nanette','Cambrault','NCAMBRAU','011.44.1344.987668',to_date('06/12/09','RR/MM/DD'),'SA_REP',7500,0.2,145,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (155,'Oliver','Tuvault','OTUVAULT','011.44.1344.486508',to_date('07/11/23','RR/MM/DD'),'SA_REP',7000,0.15,145,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (156,'Janette','King','JKING','011.44.1345.429268',to_date('04/01/30','RR/MM/DD'),'SA_REP',10000,0.35,146,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (157,'Patrick','Sully','PSULLY','011.44.1345.929268',to_date('04/03/04','RR/MM/DD'),'SA_REP',9500,0.35,146,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (158,'Allan','McEwen','AMCEWEN','011.44.1345.829268',to_date('04/08/01','RR/MM/DD'),'SA_REP',9000,0.35,146,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (159,'Lindsey','Smith','LSMITH','011.44.1345.729268',to_date('05/03/10','RR/MM/DD'),'SA_REP',8000,0.3,146,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (160,'Louise','Doran','LDORAN','011.44.1345.629268',to_date('05/12/15','RR/MM/DD'),'SA_REP',7500,0.3,146,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (161,'Sarath','Sewall','SSEWALL','011.44.1345.529268',to_date('06/11/03','RR/MM/DD'),'SA_REP',7000,0.25,146,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (162,'Clara','Vishney','CVISHNEY','011.44.1346.129268',to_date('05/11/11','RR/MM/DD'),'SA_REP',10500,0.25,147,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (163,'Danielle','Greene','DGREENE','011.44.1346.229268',to_date('07/03/19','RR/MM/DD'),'SA_REP',9500,0.15,147,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (164,'Mattea','Marvins','MMARVINS','011.44.1346.329268',to_date('08/01/24','RR/MM/DD'),'SA_REP',7200,0.1,147,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (165,'David','Lee','DLEE','011.44.1346.529268',to_date('08/02/23','RR/MM/DD'),'SA_REP',6800,0.1,147,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (166,'Sundar','Ande','SANDE','011.44.1346.629268',to_date('08/03/24','RR/MM/DD'),'SA_REP',6400,0.1,147,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (167,'Amit','Banda','ABANDA','011.44.1346.729268',to_date('08/04/21','RR/MM/DD'),'SA_REP',6200,0.1,147,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (168,'Lisa','Ozer','LOZER','011.44.1343.929268',to_date('05/03/11','RR/MM/DD'),'SA_REP',11500,0.25,148,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (169,'Harrison','Bloom','HBLOOM','011.44.1343.829268',to_date('06/03/23','RR/MM/DD'),'SA_REP',10000,0.2,148,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (170,'Tayler','Fox','TFOX','011.44.1343.729268',to_date('06/01/24','RR/MM/DD'),'SA_REP',9600,0.2,148,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (171,'William','Smith','WSMITH','011.44.1343.629268',to_date('07/02/23','RR/MM/DD'),'SA_REP',7400,0.15,148,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (172,'Elizabeth','Bates','EBATES','011.44.1343.529268',to_date('07/03/24','RR/MM/DD'),'SA_REP',7300,0.15,148,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (173,'Sundita','Kumar','SKUMAR','011.44.1343.329268',to_date('08/04/21','RR/MM/DD'),'SA_REP',6100,0.1,148,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (174,'Ellen','Abel','EABEL','011.44.1644.429267',to_date('04/05/11','RR/MM/DD'),'SA_REP',11000,0.3,149,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (175,'Alyssa','Hutton','AHUTTON','011.44.1644.429266',to_date('05/03/19','RR/MM/DD'),'SA_REP',8800,0.25,149,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265',to_date('06/03/24','RR/MM/DD'),'SA_REP',8600,0.2,149,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (177,'Jack','Livingston','JLIVINGS','011.44.1644.429264',to_date('06/04/23','RR/MM/DD'),'SA_REP',8400,0.2,149,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (178,'Kimberely','Grant','KGRANT','011.44.1644.429263',to_date('07/05/24','RR/MM/DD'),'SA_REP',7000,0.15,149,null);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (179,'Charles','Johnson','CJOHNSON','011.44.1644.429262',to_date('08/01/04','RR/MM/DD'),'SA_REP',6200,0.1,149,80);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (180,'Winston','Taylor','WTAYLOR','650.507.9876',to_date('06/01/24','RR/MM/DD'),'SH_CLERK',3200,null,120,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (181,'Jean','Fleaur','JFLEAUR','650.507.9877',to_date('06/02/23','RR/MM/DD'),'SH_CLERK',3100,null,120,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (182,'Martha','Sullivan','MSULLIVA','650.507.9878',to_date('07/06/21','RR/MM/DD'),'SH_CLERK',2500,null,120,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (183,'Girard','Geoni','GGEONI','650.507.9879',to_date('08/02/03','RR/MM/DD'),'SH_CLERK',2800,null,120,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (184,'Nandita','Sarchand','NSARCHAN','650.509.1876',to_date('04/01/27','RR/MM/DD'),'SH_CLERK',4200,null,121,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (185,'Alexis','Bull','ABULL','650.509.2876',to_date('05/02/20','RR/MM/DD'),'SH_CLERK',4100,null,121,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (186,'Julia','Dellinger','JDELLING','650.509.3876',to_date('06/06/24','RR/MM/DD'),'SH_CLERK',3400,null,121,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (187,'Anthony','Cabrio','ACABRIO','650.509.4876',to_date('07/02/07','RR/MM/DD'),'SH_CLERK',3000,null,121,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (188,'Kelly','Chung','KCHUNG','650.505.1876',to_date('05/06/14','RR/MM/DD'),'SH_CLERK',3800,null,122,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (189,'Jennifer','Dilly','JDILLY','650.505.2876',to_date('05/08/13','RR/MM/DD'),'SH_CLERK',3600,null,122,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (190,'Timothy','Gates','TGATES','650.505.3876',to_date('06/07/11','RR/MM/DD'),'SH_CLERK',2900,null,122,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (191,'Randall','Perkins','RPERKINS','650.505.4876',to_date('07/12/19','RR/MM/DD'),'SH_CLERK',2500,null,122,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (192,'Sarah','Bell','SBELL','650.501.1876',to_date('04/02/04','RR/MM/DD'),'SH_CLERK',4000,null,123,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (193,'Britney','Everett','BEVERETT','650.501.2876',to_date('05/03/03','RR/MM/DD'),'SH_CLERK',3900,null,123,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (194,'Samuel','McCain','SMCCAIN','650.501.3876',to_date('06/07/01','RR/MM/DD'),'SH_CLERK',3200,null,123,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (195,'Vance','Jones','VJONES','650.501.4876',to_date('07/03/17','RR/MM/DD'),'SH_CLERK',2800,null,123,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (196,'Alana','Walsh','AWALSH','650.507.9811',to_date('06/04/24','RR/MM/DD'),'SH_CLERK',3100,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (197,'Kevin','Feeney','KFEENEY','650.507.9822',to_date('06/05/23','RR/MM/DD'),'SH_CLERK',3000,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (198,'Donald','OConnell','DOCONNEL','650.507.9833',to_date('07/06/21','RR/MM/DD'),'SH_CLERK',2600,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (199,'Douglas','Grant','DGRANT','650.507.9844',to_date('08/01/13','RR/MM/DD'),'SH_CLERK',2600,null,124,50);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (200,'Jennifer','Whalen','JWHALEN','515.123.4444',to_date('03/09/17','RR/MM/DD'),'AD_ASST',4400,null,101,10);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (201,'Michael','Hartstein','MHARTSTE','515.123.5555',to_date('04/02/17','RR/MM/DD'),'MK_MAN',13000,null,100,20);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (202,'Pat','Fay','PFAY','603.123.6666',to_date('05/08/17','RR/MM/DD'),'MK_REP',6000,null,201,20);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (203,'Susan','Mavris','SMAVRIS','515.123.7777',to_date('02/06/07','RR/MM/DD'),'HR_REP',6500,null,101,40);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (204,'Hermann','Baer','HBAER','515.123.8888',to_date('02/06/07','RR/MM/DD'),'PR_REP',10000,null,101,70);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (205,'Shelley','Higgins','SHIGGINS','515.123.8080',to_date('02/06/07','RR/MM/DD'),'AC_MGR',12008,null,101,110);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) values (206,'William','Gietz','WGIETZ','515.123.8181',to_date('02/06/07','RR/MM/DD'),'AC_ACCOUNT',8300,null,205,110);
REM INSERTING into JOBS
SET DEFINE OFF;
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_PRES','President',20080,40000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_VP','Administration Vice President',15000,30000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_ASST','Administration Assistant',3000,6000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('FI_MGR','Finance Manager',8200,16000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('FI_ACCOUNT','Accountant',4200,9000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AC_MGR','Accounting Manager',8200,16000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AC_ACCOUNT','Public Accountant',4200,9000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SA_MAN','Sales Manager',10000,20080);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SA_REP','Sales Representative',6000,12008);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('PU_MAN','Purchasing Manager',8000,15000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('PU_CLERK','Purchasing Clerk',2500,5500);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('ST_MAN','Stock Manager',5500,8500);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('ST_CLERK','Stock Clerk',2008,5000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SH_CLERK','Shipping Clerk',2500,5500);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('IT_PROG','Programmer',4000,10000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_MAN','Marketing Manager',9000,15000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_REP','Marketing Representative',4000,9000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('HR_REP','Human Resources Representative',4000,9000);
Insert into JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('PR_REP','Public Relations Representative',4500,10500);
REM INSERTING into JOB_HISTORY
SET DEFINE OFF;
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (102,to_date('01/01/13','RR/MM/DD'),to_date('06/07/24','RR/MM/DD'),'IT_PROG',60);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (101,to_date('97/09/21','RR/MM/DD'),to_date('01/10/27','RR/MM/DD'),'AC_ACCOUNT',110);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (101,to_date('01/10/28','RR/MM/DD'),to_date('05/03/15','RR/MM/DD'),'AC_MGR',110);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (201,to_date('04/02/17','RR/MM/DD'),to_date('07/12/19','RR/MM/DD'),'MK_REP',20);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (114,to_date('06/03/24','RR/MM/DD'),to_date('07/12/31','RR/MM/DD'),'ST_CLERK',50);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (122,to_date('07/01/01','RR/MM/DD'),to_date('07/12/31','RR/MM/DD'),'ST_CLERK',50);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (200,to_date('95/09/17','RR/MM/DD'),to_date('01/06/17','RR/MM/DD'),'AD_ASST',90);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (176,to_date('06/03/24','RR/MM/DD'),to_date('06/12/31','RR/MM/DD'),'SA_REP',80);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (176,to_date('07/01/01','RR/MM/DD'),to_date('07/12/31','RR/MM/DD'),'SA_MAN',80);
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID) values (200,to_date('02/07/01','RR/MM/DD'),to_date('06/12/31','RR/MM/DD'),'AC_ACCOUNT',90);
REM INSERTING into LOCATIONS
SET DEFINE OFF;
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1000,'1297 Via Cola di Rie','00989','Roma',null,'IT');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1100,'93091 Calle della Testa','10934','Venice',null,'IT');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1300,'9450 Kamiya-cho','6823','Hiroshima',null,'JP');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1500,'2011 Interiors Blvd','99236','South San Francisco','California','US');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1700,'2004 Charade Rd','98199','Seattle','Washington','US');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2000,'40-5-12 Laogianggen','190518','Beijing',null,'CN');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2300,'198 Clementi North','540198','Singapore',null,'SG');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2400,'8204 Arthur St',null,'London',null,'UK');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2600,'9702 Chester Road','09629850293','Stretford','Manchester','UK');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2800,'Rua Frei Caneca 1360 ','01307-002','Sao Paulo','Sao Paulo','BR');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (3000,'Murtenstrasse 921','3095','Bern','BE','CH');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL');
Insert into LOCATIONS (LOCATION_ID,STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID) values (3200,'Mariano Escobedo 9991','11932','Mexico City','Distrito Federal,','MX');
REM INSERTING into REGIONS
SET DEFINE OFF;
Insert into REGIONS (REGION_ID,REGION_NAME) values (1,'Europe');
Insert into REGIONS (REGION_ID,REGION_NAME) values (2,'Americas');
Insert into REGIONS (REGION_ID,REGION_NAME) values (3,'Asia');
Insert into REGIONS (REGION_ID,REGION_NAME) values (4,'Middle East and Africa');
--------------------------------------------------------
--  DDL for Index COUNTRY_C_ID_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "COUNTRY_C_ID_PK" ON "COUNTRIES" ("COUNTRY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index DEPT_ID_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "DEPT_ID_PK" ON "DEPARTMENTS" ("DEPARTMENT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index DEPT_LOCATION_IX
--------------------------------------------------------

  CREATE INDEX "DEPT_LOCATION_IX" ON "DEPARTMENTS" ("LOCATION_ID") 
  ;
--------------------------------------------------------
--  DDL for Index EMP_DEPARTMENT_IX
--------------------------------------------------------

  CREATE INDEX "EMP_DEPARTMENT_IX" ON "EMPLOYEES" ("DEPARTMENT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index EMP_EMAIL_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "EMP_EMAIL_UK" ON "EMPLOYEES" ("EMAIL") 
  ;
--------------------------------------------------------
--  DDL for Index EMP_EMP_ID_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "EMP_EMP_ID_PK" ON "EMPLOYEES" ("EMPLOYEE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index EMP_JOB_IX
--------------------------------------------------------

  CREATE INDEX "EMP_JOB_IX" ON "EMPLOYEES" ("JOB_ID") 
  ;
--------------------------------------------------------
--  DDL for Index EMP_MANAGER_IX
--------------------------------------------------------

  CREATE INDEX "EMP_MANAGER_IX" ON "EMPLOYEES" ("MANAGER_ID") 
  ;
--------------------------------------------------------
--  DDL for Index EMP_NAME_IX
--------------------------------------------------------

  CREATE INDEX "EMP_NAME_IX" ON "EMPLOYEES" ("LAST_NAME", "FIRST_NAME") 
  ;
--------------------------------------------------------
--  DDL for Index JHIST_DEPARTMENT_IX
--------------------------------------------------------

  CREATE INDEX "JHIST_DEPARTMENT_IX" ON "JOB_HISTORY" ("DEPARTMENT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index JHIST_EMPLOYEE_IX
--------------------------------------------------------

  CREATE INDEX "JHIST_EMPLOYEE_IX" ON "JOB_HISTORY" ("EMPLOYEE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index JHIST_EMP_ID_ST_DATE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "JHIST_EMP_ID_ST_DATE_PK" ON "JOB_HISTORY" ("EMPLOYEE_ID", "START_DATE") 
  ;
--------------------------------------------------------
--  DDL for Index JHIST_JOB_IX
--------------------------------------------------------

  CREATE INDEX "JHIST_JOB_IX" ON "JOB_HISTORY" ("JOB_ID") 
  ;
--------------------------------------------------------
--  DDL for Index JOB_ID_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "JOB_ID_PK" ON "JOBS" ("JOB_ID") 
  ;
--------------------------------------------------------
--  DDL for Index LOC_CITY_IX
--------------------------------------------------------

  CREATE INDEX "LOC_CITY_IX" ON "LOCATIONS" ("CITY") 
  ;
--------------------------------------------------------
--  DDL for Index LOC_COUNTRY_IX
--------------------------------------------------------

  CREATE INDEX "LOC_COUNTRY_IX" ON "LOCATIONS" ("COUNTRY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index LOC_ID_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LOC_ID_PK" ON "LOCATIONS" ("LOCATION_ID") 
  ;
--------------------------------------------------------
--  DDL for Index LOC_STATE_PROVINCE_IX
--------------------------------------------------------

  CREATE INDEX "LOC_STATE_PROVINCE_IX" ON "LOCATIONS" ("STATE_PROVINCE") 
  ;
--------------------------------------------------------
--  DDL for Index REG_ID_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "REG_ID_PK" ON "REGIONS" ("REGION_ID") 
  ;
--------------------------------------------------------
--  Constraints for Table COUNTRIES
--------------------------------------------------------

  ALTER TABLE "COUNTRIES" ADD CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "COUNTRIES" MODIFY ("COUNTRY_ID" CONSTRAINT "COUNTRY_ID_NN" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DEPARTMENTS
--------------------------------------------------------

  ALTER TABLE "DEPARTMENTS" MODIFY ("DEPARTMENT_NAME" CONSTRAINT "DEPT_NAME_NN" NOT NULL ENABLE);
  ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table EMPLOYEES
--------------------------------------------------------

  ALTER TABLE "EMPLOYEES" MODIFY ("LAST_NAME" CONSTRAINT "EMP_LAST_NAME_NN" NOT NULL ENABLE);
  ALTER TABLE "EMPLOYEES" MODIFY ("EMAIL" CONSTRAINT "EMP_EMAIL_NN" NOT NULL ENABLE);
  ALTER TABLE "EMPLOYEES" MODIFY ("HIRE_DATE" CONSTRAINT "EMP_HIRE_DATE_NN" NOT NULL ENABLE);
  ALTER TABLE "EMPLOYEES" MODIFY ("JOB_ID" CONSTRAINT "EMP_JOB_NN" NOT NULL ENABLE);
  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0) ENABLE;
  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL")
  USING INDEX  ENABLE;
  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table JOBS
--------------------------------------------------------

  ALTER TABLE "JOBS" MODIFY ("JOB_TITLE" CONSTRAINT "JOB_TITLE_NN" NOT NULL ENABLE);
  ALTER TABLE "JOBS" ADD CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table JOB_HISTORY
--------------------------------------------------------

  ALTER TABLE "JOB_HISTORY" MODIFY ("EMPLOYEE_ID" CONSTRAINT "JHIST_EMPLOYEE_NN" NOT NULL ENABLE);
  ALTER TABLE "JOB_HISTORY" MODIFY ("START_DATE" CONSTRAINT "JHIST_START_DATE_NN" NOT NULL ENABLE);
  ALTER TABLE "JOB_HISTORY" MODIFY ("END_DATE" CONSTRAINT "JHIST_END_DATE_NN" NOT NULL ENABLE);
  ALTER TABLE "JOB_HISTORY" MODIFY ("JOB_ID" CONSTRAINT "JHIST_JOB_NN" NOT NULL ENABLE);
  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date) ENABLE;
  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table LOCATIONS
--------------------------------------------------------

  ALTER TABLE "LOCATIONS" MODIFY ("CITY" CONSTRAINT "LOC_CITY_NN" NOT NULL ENABLE);
  ALTER TABLE "LOCATIONS" ADD CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Constraints for Table REGIONS
--------------------------------------------------------

  ALTER TABLE "REGIONS" MODIFY ("REGION_ID" CONSTRAINT "REGION_ID_NN" NOT NULL ENABLE);
  ALTER TABLE "REGIONS" ADD CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID")
  USING INDEX  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COUNTRIES
--------------------------------------------------------

  ALTER TABLE "COUNTRIES" ADD CONSTRAINT "COUNTR_REG_FK" FOREIGN KEY ("REGION_ID")
     REFERENCES "REGIONS" ("REGION_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DEPARTMENTS
--------------------------------------------------------

  ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID")
     REFERENCES "LOCATIONS" ("LOCATION_ID") ENABLE;
  ALTER TABLE "DEPARTMENTS" ADD CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID")
     REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table EMPLOYEES
--------------------------------------------------------

  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
     REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID") ENABLE;
  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID")
     REFERENCES "JOBS" ("JOB_ID") ENABLE;
  ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID")
     REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table JOB_HISTORY
--------------------------------------------------------

  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY ("JOB_ID")
     REFERENCES "JOBS" ("JOB_ID") ENABLE;
  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY ("EMPLOYEE_ID")
     REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") ENABLE;
  ALTER TABLE "JOB_HISTORY" ADD CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID")
     REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table LOCATIONS
--------------------------------------------------------

  ALTER TABLE "LOCATIONS" ADD CONSTRAINT "LOC_C_ID_FK" FOREIGN KEY ("COUNTRY_ID")
     REFERENCES "COUNTRIES" ("COUNTRY_ID") ENABLE;
      
COMMIT;      

select * from employees;

--1. �μ��� ��Ż�� ���
--�μ����� ��Ż�� ���� ���� ����ϰ� ��ü ���� �� ��� ��Ż���� ����մϴ�.
WITH EmployeeCounts AS (
    SELECT 
        DEPARTMENT_ID,
        COUNT(*) AS TOTAL_EMPLOYEES
    FROM 
        EMPLOYEES
    GROUP BY 
        DEPARTMENT_ID
),
JobHistoryCounts AS (
    SELECT 
        DEPARTMENT_ID,
        COUNT(DISTINCT EMPLOYEE_ID) AS TOTAL_DEPARTURES
    FROM 
        JOB_HISTORY
    GROUP BY 
        DEPARTMENT_ID
)
SELECT 
    D.DEPARTMENT_NAME,
    EC.TOTAL_EMPLOYEES,
    JHC.TOTAL_DEPARTURES,
    (JHC.TOTAL_DEPARTURES / EC.TOTAL_EMPLOYEES) * 100 AS DEPARTURE_RATE
FROM 
    EmployeeCounts EC
JOIN 
    JobHistoryCounts JHC ON EC.DEPARTMENT_ID = JHC.DEPARTMENT_ID
JOIN 
    DEPARTMENTS D ON EC.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY 
    DEPARTURE_RATE DESC;
    
    
--2. ������ ��Ż�� ���
--�������� ��Ż�� ���� ���� ����ϰ� ��ü ���� �� ��� ��Ż���� ����մϴ�.
WITH EmployeeCounts AS (
    SELECT 
        JOB_ID,
        COUNT(*) AS TOTAL_EMPLOYEES
    FROM 
        EMPLOYEES
    GROUP BY 
        JOB_ID
),
JobHistoryCounts AS (
    SELECT 
        JOB_ID,
        COUNT(DISTINCT EMPLOYEE_ID) AS TOTAL_DEPARTURES
    FROM 
        JOB_HISTORY
    GROUP BY 
        JOB_ID
)
SELECT 
    J.JOB_TITLE,
    EC.TOTAL_EMPLOYEES,
    JHC.TOTAL_DEPARTURES,
    (JHC.TOTAL_DEPARTURES / EC.TOTAL_EMPLOYEES) * 100 AS DEPARTURE_RATE
FROM 
    EmployeeCounts EC
JOIN 
    JobHistoryCounts JHC ON EC.JOB_ID = JHC.JOB_ID
JOIN 
    JOBS J ON EC.JOB_ID = J.JOB_ID
ORDER BY 
    DEPARTURE_RATE DESC;
    
--3. ���� ��Ż ���� �м�
--������ ��Ż ������ �ľ��ϱ� ���� �� ������ ��Ż�� �μ��� ������ �����մϴ�. �̸� ���� Ư�� �μ��� �������� ��Ż���� ������ Ȯ���� �� �ֽ��ϴ�.
SELECT 
    JH.EMPLOYEE_ID,
    E.FIRST_NAME,
    E.LAST_NAME,
    D.DEPARTMENT_NAME,
    J.JOB_TITLE,
    JH.START_DATE,
    JH.END_DATE,
    (JH.END_DATE - JH.START_DATE) AS DURATION
FROM 
    JOB_HISTORY JH
JOIN 
    EMPLOYEES E ON JH.EMPLOYEE_ID = E.EMPLOYEE_ID
JOIN 
    DEPARTMENTS D ON JH.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN 
    JOBS J ON JH.JOB_ID = J.JOB_ID
ORDER BY 
    DURATION DESC;
    
--4. ��Ż���� ���� �μ� �� ���� �ľ�
--��Ż���� ���� �μ��� ������ �ľ��ϱ� ���� �μ��� ������ ��Ż �Ǽ��� ����մϴ�.
SELECT 
    D.DEPARTMENT_NAME,
    J.JOB_TITLE,
    COUNT(*) AS DEPARTURE_COUNT
FROM 
    JOB_HISTORY JH
JOIN 
    DEPARTMENTS D ON JH.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN 
    JOBS J ON JH.JOB_ID = J.JOB_ID
GROUP BY 
    D.DEPARTMENT_NAME, J.JOB_TITLE
ORDER BY 
    DEPARTURE_COUNT DESC;
    
***************************��Ż�� ���� kpi*******************************************
--1. ��Ż��(Turnover Rate)
--��ǥ: ��Ż���� 10% ���Ϸ� ����
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS TOTAL_EMPLOYEES,
    (SELECT COUNT(*) FROM JOB_HISTORY WHERE END_DATE BETWEEN ADD_MONTHS(SYSDATE, -12) AND SYSDATE AND DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTURES_LAST_YEAR,
    (SELECT COUNT(*) FROM JOB_HISTORY WHERE END_DATE BETWEEN ADD_MONTHS(SYSDATE, -12) AND SYSDATE AND DEPARTMENT_ID = E.DEPARTMENT_ID) / COUNT(*) * 100 AS TURNOVER_RATE
FROM 
    EMPLOYEES E
GROUP BY 
    DEPARTMENT_ID;
    
--2. �μ��� ��Ż��(Departmental Turnover Rate)
--��ǥ: �μ��� ��Ż���� 15% ���Ϸ� ����
SELECT 
    D.DEPARTMENT_NAME,
    COUNT(*) AS TOTAL_EMPLOYEES,
    (SELECT COUNT(*)
     FROM JOB_HISTORY JH
     WHERE JH.END_DATE BETWEEN ADD_MONTHS(SYSDATE, -12) AND SYSDATE
       AND JH.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTURES_LAST_YEAR,
    (SELECT COUNT(*)
     FROM JOB_HISTORY JH
     WHERE JH.END_DATE BETWEEN ADD_MONTHS(SYSDATE, -12) AND SYSDATE
       AND JH.DEPARTMENT_ID = D.DEPARTMENT_ID) / COUNT(*) * 100 AS DEPARTMENTAL_TURNOVER_RATE
FROM 
    EMPLOYEES E
JOIN 
    DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY 
    D.DEPARTMENT_NAME, D.DEPARTMENT_ID
ORDER BY 
    D.DEPARTMENT_NAME;

--3. ������ ��Ż��(Job Role Turnover Rate)
--��ǥ: ������ ��Ż���� 12% ���Ϸ� ����
SELECT 
    J.JOB_TITLE,
    COUNT(*) AS TOTAL_EMPLOYEES,
    (SELECT COUNT(*)
     FROM JOB_HISTORY JH
     WHERE JH.END_DATE BETWEEN ADD_MONTHS(SYSDATE, -12) AND SYSDATE
       AND JH.JOB_ID = J.JOB_ID) AS DEPARTURES_LAST_YEAR,
    (SELECT COUNT(*)
     FROM JOB_HISTORY JH
     WHERE JH.END_DATE BETWEEN ADD_MONTHS(SYSDATE, -12) AND SYSDATE
       AND JH.JOB_ID = J.JOB_ID) / COUNT(*) * 100 AS JOB_ROLE_TURNOVER_RATE
FROM 
    EMPLOYEES E
JOIN 
    JOBS J ON E.JOB_ID = J.JOB_ID
GROUP BY 
    J.JOB_TITLE, J.JOB_ID
ORDER BY 
    J.JOB_TITLE;
    
--4. ��� �ټ� �Ⱓ(Average Tenure)
--��ǥ: ��� �ټ� �Ⱓ�� 5�� �̻� ����
SELECT 
    AVG(END_DATE - START_DATE) AS AVERAGE_TENURE
FROM 
    JOB_HISTORY
WHERE 
    END_DATE IS NOT NULL;
    
--5. �����(Rehire Rate)
--��ǥ: ������� 5% �̻����� ����
-- ����� ���� �����Ͱ� �ִ� ���
SELECT 
    (SELECT COUNT(*) FROM JOB_HISTORY WHERE END_DATE IS NOT NULL) AS REHIRED_EMPLOYEES,
    (SELECT COUNT(*) FROM JOB_HISTORY WHERE END_DATE IS NOT NULL) / (SELECT COUNT(*) FROM EMPLOYEES) * 100 AS REHIRE_RATE
FROM 
    DUAL;






