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

--Task2_0520. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
UPDATE Customer
SET address = (SELECT address FROM Customer WHERE name = '�迬��')
WHERE name = '�ڼ���';

SELECT name,address FROM Customer;

--Task3_0520.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.

--Task4_0520. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.

--Task5_0520. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.

--Task6_0520.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.

--Task7_0520. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.

--Task8_0520. ���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(O.saleprice) AS total_sales
FROM Orders O
INNER JOIN Customer C ON O.custid = C.custid
WHERE C.address LIKE '%���ѹα�%';
