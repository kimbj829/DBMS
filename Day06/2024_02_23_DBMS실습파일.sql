/*
퀴즈1)
product1 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL문을 작성
이때 컬럼명은 각각 컬럼명은 PRICE_GROUPO, PRODUCTS로 지정해주시고 가격대 정보는
각 구간의 최소금액(10,000원이상 ~ 20,000미만인 구간인 경우 10,000)으로 표시
결과는 가격대를 기준으로 오름차순 정렬alter

PRICE_GROUP		PRODUCTS
0				1
10000			3
20000			1
30000			1
*/


create table product1(
product_id int,
    product_code varchar(8),
    price int
);

insert into product1(product_id, product_code, price)
values(1, 'A1000011', 10000);
insert into product1(product_id, product_code, price)
values(2, 'A1000045', 9000);
insert into product1(product_id, product_code, price)
values(3, 'C3000002', 22000);
insert into product1(product_id, product_code, price)
values(4, 'C3000006', 15000);
insert into product1(product_id, product_code, price)
values(5, 'C3000010', 30000);
insert into product1(product_id, product_code, price)
values(6, 'K1000023', 17000);

SELECT * FROM product1;
SELECT
	CASE WHEN price < 10000 THEN 0
		 WHEN price >= 10000 AND price < 20000 THEN 10000
		 WHEN price >= 20000 AND price < 30000 THEN 20000
		 WHEN price >= 30000 AND price < 40000 THEN 30000
	END as PRICE_GROUP, count(product_id) as PRODUCTS
FROM product1 GROUP BY PRICE_GROUP Order by PRICE_GROUP;

SELECT truncate(price, -4) as PRICE_GROUP,
COUNT(PRODUCT_ID) AS PRODUCTS FROM PRODUCT1
GROUP BY PRICE_GROUP ORDER BY PRICE_GROUP;


create table people(
id int,
    name varchar(30),
    age int
);

create table university(
uid int,
    school varchar(30),
    explanation varchar(100)
);

insert into people(id, name, age)
values(1,'임대필',28);
insert into people(id, name, age)
values(2,'나일규',28);
insert into people(id, name, age)
values(3,'서진영',23);
insert into people(id, name, age)
values(4,'김진철',31);
insert into people(id, name, age)
values(5,'박성준',20);
insert into people(id, name, age)
values(6,'이진성',22);

insert into university(uid, school,explanation)
values(1, '서울대', '한국최고대학교');
insert into university(uid, school,explanation)
values(2, '고려대', '최고대학교');
insert into university(uid, school,explanation)
values(3, '연세대', '최고대학교');
insert into university(uid, school,explanation)
values(4, '중앙대', '중간짬');
insert into university(uid, school,explanation)
values(5, '치킨대학교', '치킨');

/*
JOIN
- JOIN 연산은 두 테이블을 결합하는 연산이다
- 데이터의 규모가 커지면서 하나의 테이블로 정보를 수용하기 어렵다
  그래서 테이블을 분할하고 테이블 간의 관계를 맺는다
  
INNER JOIN
- 서로 같은 데이터만 나타냄
  이름1.기준컬럼, 이름2.기준컬럼의 동일한 값을 가진 컬럼을 총 출력함
  
LEFT JOIN
- 왼쪽 테이블을 기준으로 오른쪽의 테이블을 매칭
- 왼쪽을 표시하고 매칭되는 레코드가 없으면 NULL을 표시

RIGHT JOIN
- 오른쪽 테이블을 기준으로 왼쪽 테이블을 매칭
- 오른쪽을 표시하고 매칭되는 레코드가 없으면 NULL을 표시

CROSS JOIN
- 두 테이블의 교집합을 수행하는 교차결합
  
형식)
SELECT * FROM 테이블1 as 이름1
INNER JOIN 테이블 2 as 이름2
ON 이름1.기준컬럼 = 이름2.기준컬럼;

이름1.기준컬럼, 이름2.기준컬럼의 동일한 값을 가진 컬럼을 총 출력함
*/

-- INNER JOIN : 서로 같은 데이터만 나타냄
SELECT * FROM people AS p
inner join university AS u
on p.id = u.uid;

-- LEFT JOIN : 왼쪽 테이블을 기준으로 오른쪽의 테이블을 매칭
SELECT * FROM people AS p
left join university AS u
on p.id = u.uid;

-- RIGHT JOIN : 오른쪽 테이블을 기준으로 왼쪽 테이블을 매칭
SELECT * FROM people AS p
RIGHT JOIN university AS u
ON p.id = u.uid;

-- CROSS JOIN : 두 테이블dl 있다면 행 하나당 다른쪽 테이블의 모든 행을 하나씩 각각 조인
SELECT * FROM people AS p
CROSS JOIN university AS u;

/*
경제 카테고리에 속하는 도서들의 도서id, 저자명, 출판일 리스트를 출력하는 SQL을 작성
결과는 출판일을 기준으로 오름차순 정렬
BOOK_ID		AUTHOR_NAME		PUBLISHDED_DATE
3			김영호			2021-02-05
2			홍길동			2021-04-11
*/

create table book(
book_id int,
    category varchar(100),
    author_id int,
    price int,
    published_date date
);

create table author(
author_id int,
    author_name varchar(100)
);

insert into book(book_id, category, author_id, price, 
published_date) values(1, '인문', 1, 10000, '2020-01-01');
insert into book(book_id, category, author_id, price, 
published_date) values(2, '경제', 1, 9000, '2021-04-11');
insert into book(book_id, category, author_id, price, 
published_date) values(3, '경제', 2, 11000, '2021-02-05');

insert into author(author_id, author_name)
values(1, '홍길동');
insert into author(author_id, author_name)
values(2, '김영호');

SELECT book_id, author_name, published_date FROM author AS a
inner join book AS b
on b.author_id = a.author_id 
WHERE category = '경제'  order by published_date;
#동일한 컬럼이 있는 경우 해당 테이블.컬럼으로 구분
SELECT b.book_id, a.author_name, published_date FROM book AS b
inner join author AS a
on b.author_id = a.author_id 
WHERE b.category = '경제'  order by published_date;

/*
서브쿼리(Subquery)
- 서브쿼리란 다른 쿼리 내부에 포함되어 있는 SQL

서브쿼리 장점
- 쿼리의 각 부분을 명확히 구분할 수 있다
- JOIN이나 UNION(테이블 합치기)와 같은 동작을 수행할 수 있는 또 다른 방법

서브쿼리를 사용 가능 한 곳
1. WHERE절
- 복잡한 조건을 기반으로 데이터를 필터링 할 수 있다
- IN, EXISTS, ALL 등의 연산자와 함께 사용될 수 있다
2. HAVING절
- 그룹화된 결과에 대해 조건을 적용할 시 사용
3. SELECT
- 하나의 컬럼 값으로 결과를 반환 할 수 있다 
4. UPDATE SET부분
- SET절이나 WHERE절 내에서 서브쿼리를 사용하여 
  Update할 값이나 Update할 행을 동적으로 결정할 수 있다
5. INSERT문
- 해당 테이블의 컬럼에 해당하는 값을 수동으로 넣지않고 데이터를 조회하여 삽입

형식)
SELECT * FROM 테이블 WHERE 컬럼 IN (서브쿼리)
*/
CREATE table employee(
	id int auto_increment primary key,
    name varchar(100),
    sal int,
    worker varchar(100)
    );
    
insert into employee (name, sal, worker)
values('허대표', 20000000, '사장');
insert into employee (name, sal, worker)
values('정부장', 6000000, '부장');
insert into employee (name, sal, worker)
values('박차장', 5000000, '차장');
insert into employee (name, sal, worker)
values('장과장', 4000000, '과장');
insert into employee (name, sal, worker)
values('정대리', 3000000, '대리');
insert into employee (name, sal, worker)
values('노사원', 2500000, '사원');
insert into employee (name, sal, worker)
values('하사원', 2400000, '사원');
insert into employee (name, sal, worker)
values('정인턴', 1000000, '인턴');

SELECT * FROM employee;

/* 정대리 직급*/
select worker from employee
where worker = (select worker from employee where name = '정대리');

-- 정대리보다 급여가 높은 사람들
select * from employee
where sal > (select sal from employee where name = '정대리');

-- INSERT문 서브쿼리
CREATE table tbl1(
	id int auto_increment primary key,
    name varchar(100),
    sal int,
    worker varchar(100)
    );
insert into tbl1(select * from employee);
select * from tbl1;

-- 인턴의 정보를 가져와서 급여를 10만원 인상
/*
mysql에서 update문은 동일한 테이블을 대상으로 하는 서브쿼리 사용에 제한이 있음 
이걸 우회하는 방법으로는 join을 사용하는 것임 
즉) employee 테이블을 자기 자신과 join 하여 업데이트를 수행할 수 있다 
중간에 별칭을 사용하는 방식으로 처리함 
*/
SELECT * FROM employee;
update employee as e
inner join (select id from employee where worker = '인턴')
as sub on e.id = sub.id set e.sal = e.sal + 100000;
