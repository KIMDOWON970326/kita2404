SELECT * FROM book;
SELECT bookid,price FROM book;

SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM imported_book;

--�ߺ����� ���
SELECT DISTINCT publisher FROM book;

--Q.������ 10,000�� �̻��� ������ �˻�
SELECT * FROM book
WHERE price > 10000;

--Q. ������ 10,000�� �̻� 20,000 ������ ������ �˻� �Ͻÿ�(2���� ���)
SELECT * FROM book
WHERE price >= 10000 AND price <= 20000;

SELECT * FROM book
WHERE price BETWEEN 10000 AND 20000;

--Task1_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��' �� ������ �˻��Ͻÿ� (3���� ���)
SELECT * FROM book
WHERE (publisher='�½�����') or (publisher='���ѹ̵��');

SELECT * FROM book
WHERE publisher IN ('�½�����','���ѹ̵��');

SELECT * FROM book
WHERE publisher = '�½�����'
UNION
SELECT * FROM book
WHERE publisher = '���ѹ̵��';

--Task2_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��' �� �ƴ� ������ �˻�
SELECT * FROM book
WHERE publisher NOT IN ('�½�����','���ѹ̵��');

--LIKE�� ��Ȯ�� '�౸�� ����'�� ��ġ�ϴ� �ุ ����
SELECT bookname, publisher FROM book
WHERE bookname LIKE '�౸�� ����';

--'�౸' �� ���Ե� ���ǻ�
SELECT bookname, publisher FROM book
WHERE bookname LIKE '%�౸%';

--�����̸��� ���� �ι�° ��ġ�� '��' ��� ���ڿ��� ���� ����
SELECT bookname, publisher FROM book
WHERE bookname LIKE '_��%';

--Task3_0517. �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT bookname,price FROM book
WHERE bookname LIKE '%�౸%' AND price >= 20000;

--ORDER BY : �ø����� ����
SELECT * FROM book
ORDER BY price;

--��������
SELECT * FROM book
ORDER BY price DESC;

--Q. ������ ���ݼ����� �˻��ϰ� , ������ ������ �̸������� �˻��Ͻÿ�
SELECT * FROM book
ORDER BY price, bookname;

--2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�
SELECT custid FROM customer
WHERE customer = "�迬��";
SELECT SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE custid = 2;

--GROUP BY : �����͸� Ư�� ���ؿ� ���� �׷�ȭ�ϴµ� ���. �̸� ���� ���� �Լ�(SUM,AVG,MAX,MIN,COUNT)�� �̿�, ��� 
SELECT SUM(saleprice) AS total,
AVG(saleprice) AS average,
MIN(saleprice) AS mininum,
MAX(saleprice) AS maximum
FROM orders;

--�� �Ǹž��� custid �������� �׷�ȭ
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
GROUP BY custid;


--bookid�� 5���� ū ����
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE bookid > 5
GROUP BY custid;

--���������� 2���� ū ����
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE bookid > 5
GROUP BY custid
HAVING COUNT(*) > 2;


--Task4_0517. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT customer.name, orders.custid, sum(orders.saleprice) AS "�� �Ǹž�"
from orders, customer
where orders.custid = 2 and orders.custid=customer.custid
GROUP BY customer.name, orders.custid;

--Task4_0517. 2�� �迬�� ���� �ֹ��� ������ ������ �� �Ǹž��� ���Ͻÿ�.
SELECT customer.name, orders.custid, count(orders.saleprice) AS"��������",sum(orders.saleprice) "�� �Ǹž�"
from orders, customer
where orders.custid = 2 and orders.custid=customer.custid
GROUP BY customer.name, orders.custid;

--Task5_0517. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. 
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
SELECT custid, COUNT(*) AS ��������
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2
ORDER BY custid;

--Task6_0517. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--Task7_0517. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT custid, SUM(saleprice) "�� �Ǹž�"
FROM orders
GROUP BY custid
ORDER BY custid;

SELECT name, SUM(saleprice) "�� �Ǹž�"
FROM customer C, orders O
WHERE C.custid = O.custid
GROUP BY C.name
ORDER BY C.name;

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid = O.custid AND O.bookid = B.bookid;

SELECT customer.name, book.bookname
FROM orders
INNER JOIN customer ON orders.custid = customer.custid
INNER JOIN book ON orders.bookid = book.bookid;

--Q. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT C.name, B.bookname
FROM book B, customer C, orders O
WHERE C.custid = O.custid AND O.bookid = B.bookid AND B.price = 20000;

--JOIN�� �ΰ� �̻��� ���̺��� �����Ͽ� ���õ� �����͸� ������ �� ���
--���� ���� (INNER JOIN)
SELECT customer.name, orders.saleprice
FROM customer
INNER JOIN orders ON customer.custid=orders.custid;

--���� �ܺ� ���� (Left Outer Join) : . �� ���� ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name, orders.saleprice
FROM customer
LEFT OUTER JOIN orders ON customer.custid=orders.custid;

--������ �ܺ� ���� (Right Outer Join) : ù ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name, orders.saleprice
FROM customer
RIGHT OUTER JOIN
orders ON customer.custid=orders.custid;

--FULL OUTER JOIN : ��ġ�ϴ� �����Ͱ� ���� ��� �ش� ���̺����� NULL ���� ���
SELECT customer.name, orders.saleprice
FROM customer
FULL OUTER JOIN orders ON customer.custid=orders.custid;
--CROSS JOIN : �� ���̺� ���� ��� ������ ������ ����
SELECT customer.name, orders.saleprice
FROM customer
CROSS JOIN orders;

--Q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.(2���� ���,WHERER,JOIN)
SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

SELECT customer.name, orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

SELECT C.name, O.saleprice
FROM customer C
LEFT JOIN orders O ON C.custid = O.custid;

--�μ� ����
SELECT * FROM customer;
SELECT * FROM orders;
--������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--Q. �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT C.name
FROM customer C
INNER JOIN orders O ON C.custid = O.custid
INNER JOIN book B ON O.bookid = B.bookid
WHERE B.publisher = '���ѹ̵��';

SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders
WHERE bookid IN (SELECT bookid FROM book
WHERE publisher = '���ѹ̵��'));
--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price)
FROM book b2
WHERE b2.publisher = b1.publisher);
--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT name
FROM customer
WHERE custid NOT IN (SELECT custid FROM orders);
--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT name "���̸�", address "���ּ�"
FROM customer
WHERE custid IN (SELECT custid FROM orders);


--������ Ÿ��
--������ (Numeric Types)
--NUMBER: ���� �������� ���� ������ Ÿ��. ����, �Ǽ�, ���� �Ҽ���, �ε� �Ҽ��� ���� ����
--NUMBER�� NUMBER(30,0)�� ���� �ǹ̷� �ؼ�, precision 30�� �ڸ���,Scale 0�� �Ҽ��� ���� �ڸ���
--NUMBER(30), NUMBER(0,2)
--������ (Character Types)
--VARCHAR2(size): ���� ���� ���ڿ��� ����. size�� �ִ� ���� ���̸� ����Ʈ�� ����
--NVARCHAR2(size)�� ����� ������ ���� ����Ʈ ���� ��� �׻� ���� ������ ũ�Ⱑ ����
--CHAR(size): ���� ���� ���ڿ��� ����. ������ ���̺��� ª�� ���ڿ��� �ԷµǸ� �������� �������� ä����
--��¥ �� �ð��� (Date and Time Types)
--DATE: ��¥�� �ð��� ����. ������ Ÿ���� ��, ��, ��, ��, ��, �ʸ� ����
--DATE Ÿ���� ��¥�� �ð��� YYYY-MM-DD HH24:MI:SS �������� �����մϴ�.
--���� ���, 2024�� 5�� 20�� ���� 3�� 45�� 30�ʴ� 2024-05-20 15:45:30���� ����
--TIMESTAMP: ��¥�� �ð��� �� ���� ������ �������� ����
--���� �������� (Binary Data Types)
--BLOB: �뷮�� ���� �����͸� ����. �̹���, ����� ���� ���� �����ϴ� �� ����
--��Ը� ��ü�� (Large Object Types)
--CLOB: �뷮�� ���� �����͸� ����
--NCLOB: �뷮�� ������ ���� ���� �����͸� ����

--���� ���ڵ��� �ǹ�
--��ǻ�ʹ� ���ڷ� �̷���� �����͸� ó��. ���ڵ��� ���� ����(��: 'A', '��', '?')�� 
--����(�ڵ� ����Ʈ)�� ��ȯ�Ͽ� ��ǻ�Ͱ� �����ϰ� ������ �� �ְ� �Ѵ�.
--���� ���, ASCII ���ڵ������� �빮�� 'A'�� 65��, �ҹ��� 'a'�� 97�� ���ڵ�. 
--�����ڵ� ���ڵ������� 'A'�� U+0041, �ѱ� '��'�� U+AC00, �̸�Ƽ�� '?'�� U+1F60A�� ���ڵ�
--�ƽ�Ű�� 7��Ʈ�� ����Ͽ� �� 128���� ���ڸ� ǥ���ϴ� �ݸ� �����ڵ�� �ִ� 1,114,112���� ���ڸ� ǥ��

--ASCII ���ڵ�:
--���� 'A' -> 65 (10����) -> 01000001 (2����)
--���� 'B' -> 66 (10����) -> 01000010 (2����)

--�����ڵ�(UTF-8) ���ڵ�: 
--���� 'A' -> U+0041 -> 41 (16����) -> 01000001 (2����, ASCII�� ����)
--���� '��' -> U+AC00 -> EC 95 80 (16����) -> 11101100 10010101 10000000 (2����)

--CLOB: CLOB�� �Ϲ������� �����ͺ��̽��� �⺻ ���� ����(��: ASCII, LATIN1 ��)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. 
--�� ������ �ַ� ����� ���� ���� ����Ʈ ���ڷ� �̷���� �ؽ�Ʈ�� �����ϴ� �� ���.
--NCLOB: NCLOB�� �����ڵ�(UTF-16)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. ���� �ٱ��� ������ �ʿ��� ��, \
--�� �پ��� ���� ������ �ؽ�Ʈ �����͸� ������ �� ����. �ٱ��� ���ڰ� ���Ե� �����͸� ȿ�������� ó���� �� �ִ�.

--VARCHAR2�� �ΰ��� ������� ���̸� ���� : ����Ʈ�� ����
--���� Ȯ�� ���
SELECT *
FROM v$nls_parameters
WHERE parameter = 'NLS_LENGTH_SEMANTICS';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
--�������� : 
--PRIMARY KEY : �� ���� �����ϰ� �ĺ��ϴ� ��(�Ǵ� ������ ����). �ߺ��ǰų� NULL ���� ������� �ʴ´�.
--FOREIGN KEY : �ٸ� ���̺��� �⺻ Ű�� �����ϴ� ��. ���� ���Ἲ�� ����
--UNIQUE : ���� �ߺ��� ���� ����� ���� ����. NULL���� ���
--NOT NULL : ���� NULL ���� ������� �ʴ´�.
--CHECK : �� ���� Ư�� ������ �����ؾ� ���� ���� (��: age > 18)
--DEFAULT : ���� ������� ���� �������� ���� ��� ���� �⺻���� ����

--AUTHOR ���̺� ����
CREATE TABLE authors (
    id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    nationality VARCHAR2(50)
);
DROP TABLE authors;

--Q. NEWBOOK�̶�� ���̺��� �����ϼ���
CREATE TABLE newbook (
    bookid NUMBER,
    isbn NUMBER(13),
    bookname VARCHAR2(50) NOT NULL,
    author VARCHAR2(50) NOT NULL,
    publisher VARCHAR2(30) NOT NULL,
    price NUMBER DEFAULT 10000 CHECK(price > 1000),
    publish_date DATE,
    PRIMARY KEY(bookid)
);
DROP TABLE newbook;
DESC newbook;
INSERT INTO newbook VALUES (1, 9781234567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));

SELECT * FROM newbook;
ALTER TABLE newbook MODIFY (ishn VARCHAR2(50));
DELETE FROM newbook;

INSERT INTO newbook VALUES (2, 9781234567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO newbook VALUES (3, 9781234567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20', 'YYYY-MM-DD HH24:MI:SS'));


DESC NEWBOOK;
--���̺� �������� ����, �߰�, �Ӽ��߰�, ����, ����
ALTER TABLE newbook MODIFY (isbn VARCHAR2(10));
ALTER TABLE newbook ADD author_id NUMBER;
ALTER TABLE newbook DROP COLUMN author_id;

--ON DELETS CASCADE �ɼ��� �����Ǿ� �־�, newcustomer ���̺��� � ���� ���ڵ尡 �����Ǹ�, �ش� ���� ��� �ֹ���
--neworders ���̺����� �ڵ����� ����
CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));

CREATE TABLE neworders(
orderid NUMBER,
custid NUMBER NOT NULL,
bookid NUMBER NOT NULL,
saleprice NUMBER,
orderdate DATE,
PRIMARY KEY(orderid),
FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE);
DESC NEWORDERS;

INSERT INTO newcustomer VALUES(1,'KEVIN','���ﵿ','010-1234-1234');
INSERT INTO neworders VALUES(10,1,100,1000,SYSDATE);

SELECT * FROM newcustomer;
SELECT * FROM neworders;
DELETE FROM newcustomer;
DELETE FROM neworders;

--Task1_0520. 10���� �Ӽ����� �����Ǵ� ���̺� 2���� �ۼ��ϼ��� �� FOREION KEY�� �����Ͽ� ���� ���̺��� �����͸� ���� �� �ٸ� ���̺���
--���õǴ� �����͵� ��� �����ǵ��� �ϼ��� (��� ���������� ���)
--��, �� ���̺� 5���� �����͸� �Է��ϰ� �ι�° ���̺� ù���� �����͸� �����ϰ� �ִ� �Ӽ��� �����Ͽ� ������ ����
DROP table mart;
DROP table department;
create table mart(
    custid number primary key
    , name varchar2(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- �湮 ��
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- ��������
    , family number -- ���� ������ ��
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(30));
alter table mart modify (phone varchar2(20));

DESC mart;
insert into mart values(1, '��浿', 32, '��', '010-1234-1234', '���� ����', 5, 1500000, 'N', 3);
insert into mart values(2, '�����', 31, '��', '010-7777-1234', '���� ��õ', 5, 200000000, 'Y', 4);
insert into mart values(3, '�̼���', 57, '��', '010-1592-1234', '�泲 �뿵', 5, 270000, 'N', 1);
insert into mart values(4, '������', 30, '��', '010-0516-1234', '���� ����', 5, 750000000, 'Y', 4);
insert into mart values(5, '�ӿ���', 30, '��', '010-0517-1235', '���� ����', 5, 75000000, 'Y', 2);

select * from mart;

create table department(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- ���� ã�� ����
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- �߷���ŷ ���� ��뿩��
    , rounge varchar2(20) -- vip ����� ��뿩��
    , foreign key (custid) references mart(custid) on delete cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
--alter table department add (custid number);
select * from department;

insert into department values(1, '�����', 31, '��', '010-7777-1234', '���� ��õ', 'LV', 900000000,'','');
insert into department values(2, '������', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','');
insert into department values(3, '������', 31, '��', '010-7775-1235', '���� ��õ', 'LV', 900000000,'','');
insert into department values(4, '�ڼ���', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','');
insert into department values(5, '�ӿ���', 30, '��', '010-0517-1235', '���� ����', 'ROLEX', 150000000,'','');

DELETE mart
WHERE custid = 1;
--Task2_0520. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
UPDATE Customer
SET address = (SELECT address FROM Customer WHERE name = '�迬��')
WHERE name = '�ڼ���';

SELECT name,address FROM Customer;

UPDATE Customer
SET address = (
    SELECT address
    FROM customer
    WHERE name = '�迬��'
)
WHERE name = '�ڼ���';

--Ȯ��
select address, name
from customer;

--�ٽ� �λ����� ����
UPDATE Customer
set address = '���ѹα� �λ�'
where name = '�ڼ���';

--���밪
SELECT abs(-70), ABS(+70)
FROM dual;

--�ݿø�
SELECT ROUND(4.975,1)
FROM dual;

--Q. ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
SELECT * FROM orders;
SELECT custid AS ����ȣ, ROUND(AVG(saleprice), -2)AS ����ֹ��ݾ�
FROM orders
GROUP BY custid;

--Task3_0520.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
SELECT bookid, REPLACE(bookname, '�߱�','��') bookname, publisher, price
FROM book;

--Q.'�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�
SELECT bookname ����, length(bookname) ���ڼ�, lengthb(bookname) ����Ʈ��
FROM book
WHERE publisher = '�½�����';

--Task4_0520. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
--substr(name,1,1) �Լ��� ���ڿ� name�� ù ��° ���ں��� �����Ͽ� �� ���ڸ� ��ȯ
--GROUP BY �������� ��Ī�� �ƴ� substr(name,1,1) ǥ������ ����ؾ� ��
select * from customer;
select substr(name,1,1) ��, count(*) �ο�
from customer
group by substr(name,1,1);
--Task5_0520. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
select * from orders;
SELECT orderid, orderdate AS �ֹ���, orderdate + 10 AS Ȯ������
FROM orders;

--Q. ���缭���� �ֹ��Ϸκ��� 2���� �� ������ Ȯ���Ѵ� �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�
SELECT orderid, orderdate AS �ֹ���, orderdate + 62 AS Ȯ������
FROM orders;

SELECT ORDERDATE "�ֹ� ����", add_months(ORDERDATE, 2) "Ȯ�� ����" FROM ORDERS;

--Task6_0520.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
SELECT orderid �ֹ���ȣ, orderdate, TO_CHAR(orderdate, 'YYYY-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = '2020-07-07';

--WHERE orderdate = TO_DATE('20/07/07', 'YY-MM-DD)';
--WHERE orderdate = TO_DATE('20/07/07', 'DD-MM-YY)';

--Task7_0520. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
select orderid, saleprice
from orders
where saleprice < (select avg(saleprice) from orders);

SELECT O1.ORDERID, O1.SALEPRICE 
FROM ORDERS O1
WHERE O1.SALEPRICE < (SELECT AVG(O2.SALEPRICE)
FROM ORDERS O2);

SELECT O1.ORDERID, O1.SALEPRICE 
FROM orders o1
JOIN (select avg(saleprice) AS avg_saleprice from orders) o2
ON o1.saleprice < o2.avg_saleprice;

--���������� o2 ��� ��Ī���� ���� saleprice�� ��� ���� avg_saleprice�� ���

--Task8_0520. ���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(O.saleprice) AS total_sales
FROM Orders O
INNER JOIN Customer C ON O.custid = C.custid
WHERE C.address LIKE '%���ѹα�%';

SELECT SUM(saleprice) AS ���Ǹž�
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');

--[�ǽ� -2�� 1��]
--�б� ������ ���Ͽ� ���̺� 2�� �̻����� db�� �����ϰ� 3�� �̻� Ȱ���� �� �ִ� case�� ���弼��
create table student (
    studentid number primary key,
    name varchar2(30),
    gender varchar2(10),
    grade varchar2(10),
    phone varchar2(15),
    address varchar2(100)
);

INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (1, 'ȫ�浿', '��', '3�г�', '010-0000-0000', '���� ������');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (2, '���ΰ�', '��', '2�г�', '010-1111-1111', '���� ���ϱ�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (3, '���߱�', '��', '1�г�', '010-2222-2222', '���� ���ʱ�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (4, '��ٹ�', '��', '3�г�', '010-3333-3333', '���� ���ı�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (5, '��âȣ', '��', '2�г�', '010-4444-4444', '���� ���۱�');

select * from student;

CREATE TABLE score (
    studentid NUMBER,
    korean VARCHAR2(10),
    english VARCHAR2(10),
    math VARCHAR2(10),
    science VARCHAR2(10),
    FOREIGN KEY(studentid) REFERENCES student(studentid) ON DELETE CASCADE
);

INSERT INTO score (studentid, korean, english, math, science) VALUES (1, '80', '75', '85', '90');
INSERT INTO score (studentid, korean, english, math, science) VALUES (2, '85', '90', '80', '70');
INSERT INTO score (studentid, korean, english, math, science) VALUES (3, '90', '85', '95', '80');
INSERT INTO score (studentid, korean, english, math, science) VALUES (4, '70', '80', '75', '85');
INSERT INTO score (studentid, korean, english, math, science) VALUES (5, '60', '45', '65', '95');
select * from score;

CREATE TABLE emergency_contact (
    contactid NUMBER PRIMARY KEY,
    studentid NUMBER,
    parent_name VARCHAR2(30),
    relationship VARCHAR2(20),
    phone VARCHAR2(15),
    address VARCHAR2(100),
    FOREIGN KEY(studentid) REFERENCES student(studentid) ON DELETE CASCADE
);

INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (1, 1, 'ȫ���', '��', '010-5555-5555', '���� ������');
INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (2, 2, '������', '��', '010-6666-6666', '���� ���ϱ�');
INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (3, 3, '�ȸ��', '��', '010-7777-7777', '���� ���ʱ�');
INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (4, 4, '������', '��', '010-8888-8888', '���� ���ı�');
INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (5, 5, '����ȫ', '��', '010-9999-9999', '���� ���۱�');

SELECT * FROM emergency_contact;

--�л��� ���� ��ձ��ϱ�
SELECT 
    s.studentid,
    s.name,
    ROUND(AVG((TO_NUMBER(sc.korean) + TO_NUMBER(sc.english) + TO_NUMBER(sc.math) + TO_NUMBER(sc.science)) / 4), 2) AS average_score
FROM 
    student s
JOIN 
    score sc ON s.studentid = sc.studentid
GROUP BY 
    s.studentid, s.name;
    
--�л����� ��ü ��� ���ϰ� ���� �ű��
SELECT 
    s.studentid,
    s.name,
    ROUND(AVG(TO_NUMBER(sc.korean) + TO_NUMBER(sc.english) + TO_NUMBER(sc.math) + TO_NUMBER(sc.science)), 2) AS average_score,
    RANK() OVER (ORDER BY AVG(TO_NUMBER(sc.korean) + TO_NUMBER(sc.english) + TO_NUMBER(sc.math) + TO_NUMBER(sc.science)) DESC) AS rank
FROM 
    student s
JOIN 
    score sc ON s.studentid = sc.studentid
GROUP BY 
    s.studentid, s.name
ORDER BY 
    average_score DESC;
    
--�л��߰��ϱ�
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (6, '�ڰ���', '��', '1�г�', '010-6666-6666', '���� �߶���');
--���� �߰��ϱ� 
INSERT INTO score (studentid, korean, english, math, science) VALUES (6, '10', '25', '35', '95');
--���� Ȯ���ϱ�
SELECT * FROM score
WHERE studentid = 5;
--���� �����ϱ�
UPDATE score
SET korean = '90'
WHERE studentid = 2;

select * from student;
select * from score;


--Ư�� �л��� �кθ� ��� ������ ��ȸ
SELECT 
    s.name AS student_name,
    ec.parent_name,
    ec.relationship,
    ec.phone AS parent_phone,
    ec.address AS parent_address
FROM 
    student s
JOIN 
    emergency_contact ec ON s.studentid = ec.studentid
WHERE 
    s.name = '���߱�';
    

SELECT SYSDATE FROM DUAL;
--Q. DBMS ������ ������ ���� ��¥�� �ð� ������ Ȯ���Ͻÿ�
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd HH:MI:SS day') SYSDATE1
FROM DUAL;
--Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ� �� ��ȭ��ȣ�� ���� ���� '����ó ����' ���� ǥ���Ͻÿ�
--NVL �Լ��� ���� NULL�� ��� �������� ����ϰ� NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�  �Լ�:NVL("��","������")
SELECT name �̸�, NVL,(phone,'����ó����') ��ȭ��ȣ
FROM customer;

select * from costomer;

--Q ����Ͽ��� ����ȣ ,�̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�
--ROWNUM ����Ŭ���� �ڵ����� �����ϴ� ��� ���� ������ ����Ǵ� ���� �� �࿡ �Ϸù�ȣ�� �ڵ����� �Ҵ�
SELECT rownum ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE rownum < 3;

SELECT * FROM orders;





------------------����-----------------------
create table student (
    studentid number primary key,
    name varchar2(30),
    gender varchar2(10),
    grade varchar2(10),
    phone varchar2(15),
    address varchar2(100)
);

INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (1, 'ȫ�浿', '��', '3�г�', '010-0000-0000', '���� ������');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (2, '���ΰ�', '��', '2�г�', '010-1111-1111', '���� ���ϱ�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (3, '���߱�', '��', '1�г�', '010-2222-2222', '���� ���ʱ�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (4, '��ٹ�', '��', '3�г�', '010-3333-3333', '���� ���ı�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (5, '��âȣ', '��', '2�г�', '010-4444-4444', '���� ���۱�');


select * from student;

CREATE TABLE score (
    studentid NUMBER,
    korean VARCHAR2(10),
    english VARCHAR2(10),
    math VARCHAR2(10),
    science VARCHAR2(10),
    FOREIGN KEY(studentid) REFERENCES student(studentid) ON DELETE CASCADE
);

INSERT INTO score (studentid, korean, english, math, science) VALUES (1, '80', '75', '85', '90');
INSERT INTO score (studentid, korean, english, math, science) VALUES (2, '85', '90', '80', '70');
INSERT INTO score (studentid, korean, english, math, science) VALUES (3, '90', '85', '95', '80');
INSERT INTO score (studentid, korean, english, math, science) VALUES (4, '70', '80', '75', '85');
INSERT INTO score (studentid, korean, english, math, science) VALUES (5, '60', '45', '65', '95');
select * from score;

--�л��߰��ϱ�
create table student (
    studentid number primary key,
    name varchar2(30),
    gender varchar2(10),
    grade varchar2(10),
    phone varchar2(15),
    address varchar2(100)
);

INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (1, 'ȫ�浿', '��', '3�г�', '010-0000-0000', '���� ������');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (2, '���ΰ�', '��', '2�г�', '010-1111-1111', '���� ���ϱ�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (3, '���߱�', '��', '1�г�', '010-2222-2222', '���� ���ʱ�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (4, '��ٹ�', '��', '3�г�', '010-3333-3333', '���� ���ı�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (5, '��âȣ', '��', '2�г�', '010-4444-4444', '���� ���۱�');


select * from student;

CREATE TABLE score (
    studentid NUMBER,
    korean VARCHAR2(10),
    english VARCHAR2(10),
    math VARCHAR2(10),
    science VARCHAR2(10),
    FOREIGN KEY(studentid) REFERENCES student(studentid) ON DELETE CASCADE
);

INSERT INTO score (studentid, korean, english, math, science) VALUES (1, '80', '75', '85', '90');
INSERT INTO score (studentid, korean, english, math, science) VALUES (2, '85', '90', '80', '70');
INSERT INTO score (studentid, korean, english, math, science) VALUES (3, '90', '85', '95', '80');
INSERT INTO score (studentid, korean, english, math, science) VALUES (4, '70', '80', '75', '85');
INSERT INTO score (studentid, korean, english, math, science) VALUES (5, '60', '45', '65', '95');
select * from score;


CREATE TABLE emergencycontact (
    contactid NUMBER PRIMARY KEY,
    studentid NUMBER,
    name VARCHAR2(10),
    relationship VARCHAR2(5),
    phone VARCHAR2(15),
    FOREIGN KEY (studentid) REFERENCES student(studentid) ON DELETE CASCADE
);
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (1, 1, 'ȫ���', '�θ�', '010-5555-5555');
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (2, 2, '���μ�', '�θ�', '010-6666-6666');
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (3, 3, '������', '�θ�', '010-7777-7777');
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (4, 4, '�����', '�θ�', '010-8888-8888');
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (5, 5, '', '�θ�', '010-9999-9999');



--�л��߰��ϱ�
create table student (
    studentid number primary key,
    name varchar2(30),
    gender varchar2(10),
    grade varchar2(10),
    phone varchar2(15),
    address varchar2(100)
);

INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (1, 'ȫ�浿', '��', '3�г�', '010-0000-0000', '���� ������');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (2, '���ΰ�', '��', '2�г�', '010-1111-1111', '���� ���ϱ�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (3, '���߱�', '��', '1�г�', '010-2222-2222', '���� ���ʱ�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (4, '��ٹ�', '��', '3�г�', '010-3333-3333', '���� ���ı�');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (5, '��âȣ', '��', '2�г�', '010-4444-4444', '���� ���۱�');


select * from student;

CREATE TABLE score (
    studentid NUMBER,
    korean VARCHAR2(10),
    english VARCHAR2(10),
    math VARCHAR2(10),
    science VARCHAR2(10),
    FOREIGN KEY(studentid) REFERENCES student(studentid) ON DELETE CASCADE
);

INSERT INTO score (studentid, korean, english, math, science) VALUES (1, '80', '75', '85', '90');
INSERT INTO score (studentid, korean, english, math, science) VALUES (2, '85', '90', '80', '70');
INSERT INTO score (studentid, korean, english, math, science) VALUES (3, '90', '85', '95', '80');
INSERT INTO score (studentid, korean, english, math, science) VALUES (4, '70', '80', '75', '85');
INSERT INTO score (studentid, korean, english, math, science) VALUES (5, '60', '45', '65', '95');
select * from score;

--��ü�л� ��ձ��ϱ�
SELECT 
    s.studentid,
    s.name,
    ROUND(AVG((TO_NUMBER(sc.korean) + TO_NUMBER(sc.english) + TO_NUMBER(sc.math) + TO_NUMBER(sc.science)) / 4), 2) AS average_score
FROM 
    student s
JOIN 
    score sc ON s.studentid = sc.studentid
GROUP BY 
    s.studentid, s.name;

--��ü �л����� ��� ������ ���ϰ� ������ �ű��
SELECT 
    s.studentid,
    s.name,
    ROUND(AVG(TO_NUMBER(sc.korean) + TO_NUMBER(sc.english) + TO_NUMBER(sc.math) + TO_NUMBER(sc.science)), 2) AS average_score,
    RANK() OVER (ORDER BY AVG(TO_NUMBER(sc.korean) + TO_NUMBER(sc.english) + TO_NUMBER(sc.math) + TO_NUMBER(sc.science)) DESC) AS rank
FROM 
    student s
JOIN 
    score sc ON s.studentid = sc.studentid
GROUP BY 
    s.studentid, s.name
ORDER BY 
    average_score DESC;

--Ư�� �л��� �кθ� ��� ������ ��ȸ
SELECT 
    s.name AS student_name,
    ec.parent_name,
    ec.relationship,
    ec.phone AS parent_phone,
    ec.address AS parent_address
FROM 
    student s
JOIN 
    emergency_contact ec ON s.studentid = ec.studentid
WHERE 
    s.name = '���߱�';
    
    
    
------------------����-----------------------