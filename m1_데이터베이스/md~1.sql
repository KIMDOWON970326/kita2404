SELECT * FROM book;
SELECT bookid,price FROM book;

SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM imported_book;

--중복없이 출력
SELECT DISTINCT publisher FROM book;

--Q.가격이 10,000원 이상인 도서를 검색
SELECT * FROM book
WHERE price > 10000;

--Q. 가격이 10,000원 이상 20,000 이하인 도서를 검색 하시오(2가지 방법)
SELECT * FROM book
WHERE price >= 10000 AND price <= 20000;

SELECT * FROM book
WHERE price BETWEEN 10000 AND 20000;

--Task1_0517. 출판사가 '굿스포츠' 혹은 '대한미디어' 인 도서를 검색하시오 (3가지 방법)
SELECT * FROM book
WHERE (publisher='굿스포츠') or (publisher='대한미디어');

SELECT * FROM book
WHERE publisher IN ('굿스포츠','대한미디어');

SELECT * FROM book
WHERE publisher = '굿스포츠'
UNION
SELECT * FROM book
WHERE publisher = '대한미디어';

--Task2_0517. 출판사가 '굿스포츠' 혹은 '대한미디어' 가 아닌 도서를 검색
SELECT * FROM book
WHERE publisher NOT IN ('굿스포츠','대한미디어');

--LIKE는 정확히 '축구의 역사'와 일치하는 행만 선택
SELECT bookname, publisher FROM book
WHERE bookname LIKE '축구의 역사';

--'축구' 가 포함된 출판사
SELECT bookname, publisher FROM book
WHERE bookname LIKE '%축구%';

--도서이름의 왼쪽 두번째 위치에 '구' 라는 문자열을 갖는 도서
SELECT bookname, publisher FROM book
WHERE bookname LIKE '_구%';

--Task3_0517. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT bookname,price FROM book
WHERE bookname LIKE '%축구%' AND price >= 20000;

--ORDER BY : 올림차순 정렬
SELECT * FROM book
ORDER BY price;

--내림차순
SELECT * FROM book
ORDER BY price DESC;

--Q. 도서를 가격순으로 검색하고 , 가격이 같으면 이름순으로 검색하시오
SELECT * FROM book
ORDER BY price, bookname;

--2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오
SELECT custid FROM customer
WHERE customer = "김연아";
SELECT SUM(saleprice) AS "총 판매액"
FROM orders
WHERE custid = 2;

--GROUP BY : 데이터를 특정 기준에 따라 그룹화하는데 사용. 이를 통해 집계 함수(SUM,AVG,MAX,MIN,COUNT)를 이용, 계산 
SELECT SUM(saleprice) AS total,
AVG(saleprice) AS average,
MIN(saleprice) AS mininum,
MAX(saleprice) AS maximum
FROM orders;

--총 판매액을 custid 기준으로 그룹화
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
GROUP BY custid;


--bookid가 5보다 큰 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
WHERE bookid > 5
GROUP BY custid;

--도서수량이 2보다 큰 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
WHERE bookid > 5
GROUP BY custid
HAVING COUNT(*) > 2;


--Task4_0517. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT customer.name, orders.custid, sum(orders.saleprice) AS "총 판매액"
from orders, customer
where orders.custid = 2 and orders.custid=customer.custid
GROUP BY customer.name, orders.custid;

--Task4_0517. 2번 김연아 고객이 주문한 도서의 개수와 총 판매액을 구하시오.
SELECT customer.name, orders.custid, count(orders.saleprice) AS"도서수량",sum(orders.saleprice) "총 판매액"
from orders, customer
where orders.custid = 2 and orders.custid=customer.custid
GROUP BY customer.name, orders.custid;

--Task5_0517. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.
SELECT custid, COUNT(*) AS 도서수량
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2
ORDER BY custid;

--Task6_0517. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--Task7_0517. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT custid, SUM(saleprice) "총 판매액"
FROM orders
GROUP BY custid
ORDER BY custid;

SELECT name, SUM(saleprice) "총 판매액"
FROM customer C, orders O
WHERE C.custid = O.custid
GROUP BY C.name
ORDER BY C.name;

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid = O.custid AND O.bookid = B.bookid;

SELECT customer.name, book.bookname
FROM orders
INNER JOIN customer ON orders.custid = customer.custid
INNER JOIN book ON orders.bookid = book.bookid;

--Q. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT C.name, B.bookname
FROM book B, customer C, orders O
WHERE C.custid = O.custid AND O.bookid = B.bookid AND B.price = 20000;

--JOIN은 두개 이상의 테이블을 연결하여 관련된 데이터를 결합할 떄 사용
--내부 조인 (INNER JOIN)
SELECT customer.name, orders.saleprice
FROM customer
INNER JOIN orders ON customer.custid=orders.custid;

--왼쪽 외부 조인 (Left Outer Join) : . 두 번쨰 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT customer.name, orders.saleprice
FROM customer
LEFT OUTER JOIN orders ON customer.custid=orders.custid;

--오른쪽 외부 조인 (Right Outer Join) : 첫 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT customer.name, orders.saleprice
FROM customer
RIGHT OUTER JOIN
orders ON customer.custid=orders.custid;

--FULL OUTER JOIN : 일치하는 데이터가 없는 경우 해당 테이블에서는 NULL 값이 사용
SELECT customer.name, orders.saleprice
FROM customer
FULL OUTER JOIN orders ON customer.custid=orders.custid;
--CROSS JOIN : 두 테이블 간의 모든 가능한 조합을 생성
SELECT customer.name, orders.saleprice
FROM customer
CROSS JOIN orders;

--Q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.(2가지 방법,WHERER,JOIN)
SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

SELECT customer.name, orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

SELECT C.name, O.saleprice
FROM customer C
LEFT JOIN orders O ON C.custid = O.custid;

--부속 질의
SELECT * FROM customer;
SELECT * FROM orders;
--도서를 구매한 적이 있는 고객의 이름을 검색하시오
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--Q. ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT C.name
FROM customer C
INNER JOIN orders O ON C.custid = O.custid
INNER JOIN book B ON O.bookid = B.bookid
WHERE B.publisher = '대한미디어';

SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders
WHERE bookid IN (SELECT bookid FROM book
WHERE publisher = '대한미디어'));
--Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT avg(b2.price)
FROM book b2
WHERE b2.publisher = b1.publisher);
--Q. 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT name
FROM customer
WHERE custid NOT IN (SELECT custid FROM orders);
--Q. 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT name "고객이름", address "고객주소"
FROM customer
WHERE custid IN (SELECT custid FROM orders);


--데이터 타입
--숫자형 (Numeric Types)
--NUMBER: 가장 범용적인 숫자 데이터 타입. 정수, 실수, 고정 소수점, 부동 소수점 수를 저장
--NUMBER는 NUMBER(30,0)와 같은 의미로 해석, precision 30은 자릿수,Scale 0은 소수점 이하 자리수
--NUMBER(30), NUMBER(0,2)
--문자형 (Character Types)
--VARCHAR2(size): 가변 길이 문자열을 저장. size는 최대 문자 길이를 바이트로 지정
--NVARCHAR2(size)의 사이즈를 지정할 때는 바이트 단위 대신 항상 문자 단위로 크기가 지정
--CHAR(size): 고정 길이 문자열을 저장. 지정된 길이보다 짧은 문자열이 입력되면 나머지는 공백으로 채워짐
--날짜 및 시간형 (Date and Time Types)
--DATE: 날짜와 시간을 저장. 데이터 타입은 년, 월, 일, 시, 분, 초를 포함
--DATE 타입은 날짜와 시간을 YYYY-MM-DD HH24:MI:SS 형식으로 저장합니다.
--예를 들어, 2024년 5월 20일 오후 3시 45분 30초는 2024-05-20 15:45:30으로 저장
--TIMESTAMP: 날짜와 시간을 더 상세히 나노초 단위까지 저장
--이진 데이터형 (Binary Data Types)
--BLOB: 대량의 이진 데이터를 저장. 이미지, 오디오 파일 등을 저장하는 데 적합
--대규모 객체형 (Large Object Types)
--CLOB: 대량의 문자 데이터를 저장
--NCLOB: 대량의 국가별 문자 집합 데이터를 저장

--문자 인코딩의 의미
--컴퓨터는 숫자로 이루어진 데이터를 처리. 인코딩을 통해 문자(예: 'A', '가', '?')를 
--숫자(코드 포인트)로 변환하여 컴퓨터가 이해하고 저장할 수 있게 한다.
--예를 들어, ASCII 인코딩에서는 대문자 'A'를 65로, 소문자 'a'를 97로 인코딩. 
--유니코드 인코딩에서는 'A'를 U+0041, 한글 '가'를 U+AC00, 이모티콘 '?'를 U+1F60A로 인코딩
--아스키는 7비트를 사용하여 총 128개의 문자를 표현하는 반면 유니코드는 최대 1,114,112개의 문자를 표현

--ASCII 인코딩:
--문자 'A' -> 65 (10진수) -> 01000001 (2진수)
--문자 'B' -> 66 (10진수) -> 01000010 (2진수)

--유니코드(UTF-8) 인코딩: 
--문자 'A' -> U+0041 -> 41 (16진수) -> 01000001 (2진수, ASCII와 동일)
--문자 '가' -> U+AC00 -> EC 95 80 (16진수) -> 11101100 10010101 10000000 (2진수)

--CLOB: CLOB은 일반적으로 데이터베이스의 기본 문자 집합(예: ASCII, LATIN1 등)을 사용하여 텍스트 데이터를 저장. 
--이 때문에 주로 영어와 같은 단일 바이트 문자로 이루어진 텍스트를 저장하는 데 사용.
--NCLOB: NCLOB은 유니코드(UTF-16)를 사용하여 텍스트 데이터를 저장. 따라서 다국어 지원이 필요할 때, \
--즉 다양한 언어로 구성된 텍스트 데이터를 저장할 때 적합. 다국어 문자가 포함된 데이터를 효율적으로 처리할 수 있다.

--VARCHAR2는 두가지 방식으로 길이를 점의 : 바이트와 문자
--설정 확인 방법
SELECT *
FROM v$nls_parameters
WHERE parameter = 'NLS_LENGTH_SEMANTICS';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
--제약조건 : 
--PRIMARY KEY : 각 행을 고유하게 식별하는 열(또는 열들의 조합). 중복되거나 NULL 값을 허용하지 않는다.
--FOREIGN KEY : 다른 테이블의 기본 키를 참조하는 열. 참조 무결성을 유지
--UNIQUE : 열에 중복된 값이 없어야 함을 지정. NULL값이 허용
--NOT NULL : 열에 NULL 값을 허용하지 않는다.
--CHECK : 열 값이 특정 조건을 만족해야 함을 지정 (예: age > 18)
--DEFAULT : 열에 명시적인 값이 제공되지 않을 경우 사용될 기본값을 지정

--AUTHOR 테이블 생성
CREATE TABLE authors (
    id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    nationality VARCHAR2(50)
);
DROP TABLE authors;

--Q. NEWBOOK이라는 테이블을 생성하세요
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
--테이블 제약조건 수정, 추가, 속성추가, 삭제, 수정
ALTER TABLE newbook MODIFY (isbn VARCHAR2(10));
ALTER TABLE newbook ADD author_id NUMBER;
ALTER TABLE newbook DROP COLUMN author_id;

--ON DELETS CASCADE 옵션이 설정되어 있어, newcustomer 테이블에서 어떤 고객의 레코드가 삭제되면, 해당 고객의 모든 주문이
--neworders 테이블에서도 자동으로 삭제
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

INSERT INTO newcustomer VALUES(1,'KEVIN','역삼동','010-1234-1234');
INSERT INTO neworders VALUES(10,1,100,1000,SYSDATE);

SELECT * FROM newcustomer;
SELECT * FROM neworders;
DELETE FROM newcustomer;
DELETE FROM neworders;

--Task1_0520. 10개의 속성으로 구성되는 테이블 2개를 작성하세요 단 FOREION KEY를 적용하여 한쪽 테이블의 데이터를 삭제 시 다른 테이블의
--관련되는 데이터도 모두 삭제되도록 하세요 (모든 제약조건을 사용)
--단, 각 테이블에 5개의 데이터를 입력하고 두번째 테이블에 첫번재 데이터를 참조하고 있는 속성을 선택하여 데이터 삭제
DROP table mart;
DROP table department;
create table mart(
    custid number primary key
    , name varchar2(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- 방문 빈도
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- 주차여부
    , family number -- 가족 구성원 수
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(30));
alter table mart modify (phone varchar2(20));

DESC mart;
insert into mart values(1, '고길동', 32, '남', '010-1234-1234', '서울 강남', 5, 1500000, 'N', 3);
insert into mart values(2, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 5, 200000000, 'Y', 4);
insert into mart values(3, '이순신', 57, '남', '010-1592-1234', '경남 통영', 5, 270000, 'N', 1);
insert into mart values(4, '아이유', 30, '여', '010-0516-1234', '서울 서초', 5, 750000000, 'Y', 4);
insert into mart values(5, '임영웅', 30, '남', '010-0517-1235', '서울 역삼', 5, 75000000, 'Y', 2);

select * from mart;

create table department(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- 자주 찾는 매장
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- 발렛파킹 서비스 사용여부
    , rounge varchar2(20) -- vip 라운지 사용여부
    , foreign key (custid) references mart(custid) on delete cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
--alter table department add (custid number);
select * from department;

insert into department values(1, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 'LV', 900000000,'','');
insert into department values(2, '아이유', 30, '여', '010-0516-1234', '서울 서초', 'GUCCI', 1500000000,'','');
insert into department values(3, '박지성', 31, '남', '010-7775-1235', '강원 춘천', 'LV', 900000000,'','');
insert into department values(4, '박세리', 30, '여', '010-0516-1234', '서울 서초', 'GUCCI', 1500000000,'','');
insert into department values(5, '임영웅', 30, '남', '010-0517-1235', '서울 역삼', 'ROLEX', 150000000,'','');

DELETE mart
WHERE custid = 1;
--Task2_0520. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
UPDATE Customer
SET address = (SELECT address FROM Customer WHERE name = '김연아')
WHERE name = '박세리';

SELECT name,address FROM Customer;

UPDATE Customer
SET address = (
    SELECT address
    FROM customer
    WHERE name = '김연아'
)
WHERE name = '박세리';

--확인
select address, name
from customer;

--다시 부산으로 변경
UPDATE Customer
set address = '대한민국 부산'
where name = '박세리';

--절대값
SELECT abs(-70), ABS(+70)
FROM dual;

--반올림
SELECT ROUND(4.975,1)
FROM dual;

--Q. 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
SELECT * FROM orders;
SELECT custid AS 고객번호, ROUND(AVG(saleprice), -2)AS 평균주문금액
FROM orders
GROUP BY custid;

--Task3_0520.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
SELECT bookid, REPLACE(bookname, '야구','농구') bookname, publisher, price
FROM book;

--Q.'굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오
SELECT bookname 제목, length(bookname) 글자수, lengthb(bookname) 바이트수
FROM book
WHERE publisher = '굿스포츠';

--Task4_0520. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
--substr(name,1,1) 함수는 문자열 name의 첫 번째 글자부터 시작하여 한 글자를 반환
--GROUP BY 절에서는 별칭이 아닌 substr(name,1,1) 표현식을 사용해야 함
select * from customer;
select substr(name,1,1) 성, count(*) 인원
from customer
group by substr(name,1,1);
--Task5_0520. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
select * from orders;
SELECT orderid, orderdate AS 주문일, orderdate + 10 AS 확정일자
FROM orders;

--Q. 마당서점은 주문일로부터 2개월 후 매출을 확정한다 각 주문의 확정일자를 구하시오
SELECT orderid, orderdate AS 주문일, orderdate + 62 AS 확정일자
FROM orders;

SELECT ORDERDATE "주문 일자", add_months(ORDERDATE, 2) "확정 일자" FROM ORDERS;

--Task6_0520.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
--단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
SELECT orderid 주문번호, orderdate, TO_CHAR(orderdate, 'YYYY-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate = '2020-07-07';

--WHERE orderdate = TO_DATE('20/07/07', 'YY-MM-DD)';
--WHERE orderdate = TO_DATE('20/07/07', 'DD-MM-YY)';

--Task7_0520. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
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

--서브쿼리를 o2 라는 별칭으로 지정 saleprice의 평균 값을 avg_saleprice로 계산

--Task8_0520. 대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(O.saleprice) AS total_sales
FROM Orders O
INNER JOIN Customer C ON O.custid = C.custid
WHERE C.address LIKE '%대한민국%';

SELECT SUM(saleprice) AS 총판매액
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%대한민국%');

--[실습 -2인 1조]
--학교 관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요
create table student (
    studentid number primary key,
    name varchar2(30),
    gender varchar2(10),
    grade varchar2(10),
    phone varchar2(15),
    address varchar2(100)
);

INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (1, '홍길동', '남', '3학년', '010-0000-0000', '서울 강남구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (2, '강민경', '여', '2학년', '010-1111-1111', '서울 강북구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (3, '안중근', '남', '1학년', '010-2222-2222', '서울 서초구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (4, '김다미', '여', '3학년', '010-3333-3333', '서울 송파구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (5, '안창호', '남', '2학년', '010-4444-4444', '서울 동작구');

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

INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (1, 1, '홍길순', '모', '010-5555-5555', '서울 강남구');
INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (2, 2, '강영희', '모', '010-6666-6666', '서울 강북구');
INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (3, 3, '안명숙', '모', '010-7777-7777', '서울 서초구');
INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (4, 4, '김정희', '모', '010-8888-8888', '서울 송파구');
INSERT INTO emergency_contact (contactid, studentid, parent_name, relationship, phone, address) VALUES (5, 5, '안재홍', '부', '010-9999-9999', '서울 동작구');

SELECT * FROM emergency_contact;

--학생들 점수 평균구하기
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
    
--학생들의 전체 평균 구하고 순위 매기기
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
    
--학생추가하기
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (6, '박격포', '남', '1학년', '010-6666-6666', '서울 중랑구');
--성적 추가하기 
INSERT INTO score (studentid, korean, english, math, science) VALUES (6, '10', '25', '35', '95');
--성적 확인하기
SELECT * FROM score
WHERE studentid = 5;
--성적 수정하기
UPDATE score
SET korean = '90'
WHERE studentid = 2;

select * from student;
select * from score;


--특정 학생의 학부모 비상 연락망 조회
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
    s.name = '안중근';
    

SELECT SYSDATE FROM DUAL;
--Q. DBMS 서버에 설정된 현재 날짜와 시간 요일을 확인하시오
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd HH:MI:SS day') SYSDATE1
FROM DUAL;
--Q. 이름, 전화번호가 포함된 고객목록을 보이시오 단 전화번호가 없는 고객은 '연락처 없음' 으로 표시하시오
--NVL 함수는 값이 NULL인 경우 지정값을 출력하고 NULL이 아니면 원래 값을 그대로 출력한다  함수:NVL("값","지정값")
SELECT name 이름, NVL,(phone,'연락처없음') 전화번호
FROM customer;

select * from costomer;

--Q 고객목록에서 고객번호 ,이름, 전화번호를 앞의 두 명만 보이시오
--ROWNUM 오라클에서 자동으로 제공하는 기상 열로 쿼리가 진행되는 동안 각 행에 일련번호를 자동으로 할당
SELECT rownum 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE rownum < 3;

SELECT * FROM orders;





------------------과제-----------------------
create table student (
    studentid number primary key,
    name varchar2(30),
    gender varchar2(10),
    grade varchar2(10),
    phone varchar2(15),
    address varchar2(100)
);

INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (1, '홍길동', '남', '3학년', '010-0000-0000', '서울 강남구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (2, '강민경', '여', '2학년', '010-1111-1111', '서울 강북구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (3, '안중근', '남', '1학년', '010-2222-2222', '서울 서초구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (4, '김다미', '여', '3학년', '010-3333-3333', '서울 송파구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (5, '안창호', '남', '2학년', '010-4444-4444', '서울 동작구');


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

--학생추가하기
create table student (
    studentid number primary key,
    name varchar2(30),
    gender varchar2(10),
    grade varchar2(10),
    phone varchar2(15),
    address varchar2(100)
);

INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (1, '홍길동', '남', '3학년', '010-0000-0000', '서울 강남구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (2, '강민경', '여', '2학년', '010-1111-1111', '서울 강북구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (3, '안중근', '남', '1학년', '010-2222-2222', '서울 서초구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (4, '김다미', '여', '3학년', '010-3333-3333', '서울 송파구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (5, '안창호', '남', '2학년', '010-4444-4444', '서울 동작구');


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
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (1, 1, '홍길순', '부모', '010-5555-5555');
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (2, 2, '강민서', '부모', '010-6666-6666');
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (3, 3, '안정근', '부모', '010-7777-7777');
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (4, 4, '김다해', '부모', '010-8888-8888');
INSERT INTO emergencycontact (contactid, studentid, name, relationship, phone) VALUES (5, 5, '', '부모', '010-9999-9999');



--학생추가하기
create table student (
    studentid number primary key,
    name varchar2(30),
    gender varchar2(10),
    grade varchar2(10),
    phone varchar2(15),
    address varchar2(100)
);

INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (1, '홍길동', '남', '3학년', '010-0000-0000', '서울 강남구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (2, '강민경', '여', '2학년', '010-1111-1111', '서울 강북구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (3, '안중근', '남', '1학년', '010-2222-2222', '서울 서초구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (4, '김다미', '여', '3학년', '010-3333-3333', '서울 송파구');
INSERT INTO student (studentid, name, gender, grade, phone, address) VALUES (5, '안창호', '남', '2학년', '010-4444-4444', '서울 동작구');


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

--전체학생 평균구하기
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

--전체 학생들의 평균 점수를 구하고 순위를 매기기
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

--특정 학생의 학부모 비상 연락망 조회
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
    s.name = '안중근';
    
    
    
------------------과제-----------------------