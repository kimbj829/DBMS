/*
WHERE - 그룹화 하기전 
HAVING - 그룹화 후 조건
count(), sum(), avg()
*/

SELECT * FROM hero;
SELECT type, count(name) as 'cnt' FROM hero 
GROUP BY type having cnt >= 2;

/*
type이 2가 아닌 type을 그룹화하여 name의 갯수를 가져온 후
그중에서 갯수가 2개 이상인 데이터를 조회
*/
SELECT type, count(name) as 'cnt' FROM hero WHERE type != 2
GROUP BY type having cnt >= 2;

/*
type이 1초과인 type을 그룹화하여 name 갯수를 가져온 후 그 중에서
갯수가 2개 이상인 데이터를 type을 내림차순 정렬로 조회
*/
SELECT type, count(name) as 'cnt' FROM hero WHERE type > 1
GROUP BY type having cnt >= 2 ORDER BY type DESC;

CREATE TABLE product(
	productNum INT auto_increment primary key,
    productName VARCHAR(30),
    price int
    );
insert into product(productName, price) values('니트', 10000);
insert into product(productName, price) values('반팔티', 5000);
insert into product(productName, price) values('청바지', 8000);
insert into product(productName, price) values('코트', 20000);
insert into product(productName, price) values('후드티', 7500);
insert into product(productName, price) values('와이셔츠', 7000);

/* 다음 상품 테이블에서 가장 높은 가격 */
SELECT max(price) as max_price FROM product;
/* 다음 상품 테이블에서 가장 낮은 가격 */
SELECT min(price) as min_price FROM product;

/*
CASE WHEN
- 비교할 여러가지 조건들이 많을 경우 사용하면 된다 IF함수도 있지만 CASE문도 사용가능함
CASE문도 

형식)
CASE WHEN 조건1 THEN 결과값1
	 WHEN 조건2 THEN 결과값2
     WHEN 조건3 THEN 결과값3
     WHEN 조건4 THEN 결과값4
     ELSE 결과값5
end
*/
/*
상품테이블에서 7000원 미만인 상품은 저렴
7000이상 10000원 미만인 경우 보통
10000원 이상인 경우 고가
*/
SELECT productName, price,
	CASE WHEN price < 7000 THEN '저렴'
		 WHEN price >= 7000 AND price < 10000 THEN '보통'
         WHEN price >= 1000 THEN '고가'
	END as '상품구문'
FROM product;

/*
퀴즈)
어느 의류 쇼핑몰에 가입한 회원의 정보를 담은 user_info 테이블이다
user_info 테이블은 user_id, gender, age, joined는 각가 회원id, 성별, 나이,
가입일을 나타낸다 gender 컬럼은 0 또는 1 값을 가지며 0인경우 남자 1인경우 여자를 나타낸다
user_info 테이블에서 2021년 가입한 회원 중 나이가 20세이상 29세이하인 회원이
몇명인지 출력하는 쿼리를 작성하세요

정답)
USERS
3
*/

create table user_info(
user_id int,
    gender int,
    age int,
    joined date
);
insert into user_info(user_id, gender, age, joined)
values(1, 1, 26, '2021-10-05');
insert into user_info(user_id, gender, age, joined)
values(2, 0, NULL, '2021-11-25');
insert into user_info(user_id, gender, age, joined)
values(3, 1, 22, '2021-11-30');
insert into user_info(user_id, gender, age, joined)
values(4, 0, 31, '2021-12-03');
insert into user_info(user_id, gender, age, joined)
values(5, 0, 28, '2021-12-16');
insert into user_info(user_id, gender, age, joined)
values(6, 1, 24, '2022-01-03');
insert into user_info(user_id, gender, age, joined)
values(7, 1, NULL, '2022-01-09');

SELECT count(age) as 'USERS' FROM user_info 
WHERE (age >= 20 AND age <= 29) AND joined like '2021%';

SELECT count(age) as 'USERS' FROM user_info
WHERE date_format(joined, "%Y") = '2021'
AND age BETWEEN 20 AND 29;

/*
다음은 어느 자동차 대여 회사에서 대여중인 자동차들의 정보를 담은
car_rental_company_car 테이블이다
car_rental_company_car 테이블은 아래와 같은 구조로 되어있다
car_id, car_type, daily_fee, options는
각각 자동차 id, 종류, 일일대여요금, 자동차 옵션 리스트를 나타낸다

car_rental_company_car 테이블에서
통풍시트, 열선시트, 가죽시트 중 하나 이상의 옵션이 포함된 자동차가
자동차 종류 별로 몇대인지 출력하는 sql문을 작성하세요
이때 자동차 수에 대한 컬럼은 CARS로 지정하고 결과는 자동차 종류를 기준으로 오름차순 정렬

결과)
CAR_TYPE 	CARS
SUB			2
세단			1
트럭			1
*/
create table car_rental_company_car(
car_id int,
    car_type varchar(255),
    daily_fee int,
    options varchar(255)
);
insert into car_rental_company_car(car_id, car_type, daily_fee, options)
values(1, '세단', 16000, '가죽시트,열선시트,후방카메라');
insert into car_rental_company_car(car_id, car_type, daily_fee, options)
values(2, 'SUV', 14000, '스마트키,네비게이션,열선시트');
insert into car_rental_company_car(car_id, car_type, daily_fee, options)
values(3, 'SUV', 22000, '주차감지센서,후방카메라');
insert into car_rental_company_car(car_id, car_type, daily_fee, options)
values(4, '트럭', 35000, '주차감지센서,네비게이션,열선시트');
insert into car_rental_company_car(car_id, car_type, daily_fee, options)
values(5, 'SUV', 16000, '가죽시트,네비게이션,열선시트,후방카메라,주차감지센서');

SELECT car_type, count(car_type) as CARS
FROM car_rental_company_car 
WHERE options like '%가죽시트%' or 
options like '%통풍시트%' or options like '%열선시트%'
GROUP BY car_type ORDER BY car_type;

/*
used_goods_board 테이블에서 2022년 10월 5일에 등록된 중고거래 게시물의
게시글 id, 거래상태가 
SALE이면 판매중 
RESERVED이면 예약중
DONE이면 거래완료로
분류하여 출력하고 결과를 게시글 ID를 기준으로 내림차순 정렬해 주세요
*/

create table used_goods_board(
board_id varchar(5), /* 게시글 id*/
    writer_id varchar(50), /* 작성자 id*/
    title varchar(100), /* 제목 */
    contents varchar(2000), /* 내용 */
    price int, /* 가격 */
    created_date date, /* 작성일 */
    status varchar(10), /* 거래상태 */
    views int /* 조회수 */
);

insert into used_goods_board(board_id, writer_id, title, contents, 
price, created_date, status, views) 
values('B0007', 's2s2123', '커피글라인더', '내용1', 7000, '2022-10-04', 'DONE', 210);

insert into used_goods_board(board_id, writer_id, title, contents, 
price, created_date, status, views) 
values('B0008', 'hong02', '자전거 판매합니다', '내용1', 40000, '2022-10-04', 'SALE', 301);

insert into used_goods_board(board_id, writer_id, title, contents, 
price, created_date, status, views) 
values('B0009', 'yawoong67', '선반 팝니다', '내용1', 12000, '2022-10-05', 'DONE', 202);

insert into used_goods_board(board_id, writer_id, title, contents, 
price, created_date, status, views) 
values('B0010', 'keel1990', '철제선반5단', '내용1', 10000, '2022-10-05', 'SALE', 194);

select * FROM used_goods_board;
SELECT board_id, writer_id, title, price,
	CASE WHEN status = 'SALE' THEN '판매중'
		 WHEN status = 'RESERVED' THEN '예약중'
         WHEN status = 'DONE' THEN '거래완료'
	END as '거래상태'
FROM used_goods_board 
#WHERE created_date = '2022-10-05' order by board_id DESC;
WHERE DATE_FORMAT(created_date, '%Y-%m-%d') = '2022-10-05' order by board_id DESC;

create table stu(
user_id int auto_increment primary key,
    user_name varchar(30),
    age int,
    gender varchar(10) not null
);
insert into stu(user_name, age, gender) 
values('John', 25, '남성');

insert into stu(user_name, age, gender) 
values('Alice', 17, '여성');

insert into stu(user_name, age, gender) 
values('Bob', 20, '남성');

insert into stu(user_name, age, gender) 
values('Eve', 16, '여성');

insert into stu(user_name, age, gender) 
values('Milk', 27, '여성');

insert into stu(user_name, age, gender) 
values('Pat', 15, '남성');

/*
if()
- 조건에 따라 값을 반환하는데 사용된다
- if함수는 단순한 조건을 구현하는데 유용하다.
  더 복작합 조건이 걸릴시 case문과 함께 사용되기도 하고 case를 쓰는걸 권장
*/
SELECT * FROM stu;
SELECT user_name, if(age >= 20, '성인', '미성년자') as '성인/미성년자판별' from stu;

SELECT user_name, age, gender,
if(age >= 20, 
	if(gender = '남성', '성인 남성', '성인 여성'),
    if(gender = '남성', '미성년 남성', '미성년 여성')) as '결과값'
FROM stu;

/*
Case When은 복잡한 조건과 다중 분기를 처리하는데 유연하게 쿼리를 작성할 수 있다
반면에 if() 함수는 간단한 조건을 처리하는데 더 적합하다.
*/
SELECT user_name, age, gender,
CASE WHEN age >= 20 and gender = '남성' then '성인남성'
	 WHEN age >= 20 and gender = '여성' then '성인여성'
     WHEN age < 20 and gender = '남성' then '미성년 여성'
     WHEN age < 20 and gender = '여성' then '미성년 여성'
end as '결과값'
FROM stu;