/*
https://school.programmers.co.kr/learn/courses/30/lessons/59041
ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, 
ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 
각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.

동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 
이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.

결과)
NAME	COUNT
Lucy	3
Raven	2
*/

SELECT NAME, count(*) as 'COUNT' FROM ANIMAL_INS
where name is not null
group by NAME having count(*) >= 2
order by name;

/*
https://school.programmers.co.kr/learn/courses/30/lessons/151138
다음은 어느 자동차 대여 회사의 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 
테이블입니다. CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며, 
HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일,
 대여 종료일을 나타냅니다.
 
 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일이 2022년 9월에 속하는 대여 기록에 
 대해서 대여 기간이 30일 이상이면 '장기 대여' 그렇지 않으면 '단기 대여' 로 표시하는 
 컬럼(컬럼명: RENT_TYPE)을 추가하여 대여기록을 출력하는 SQL문을 작성해주세요. 
 결과는 대여 기록 ID를 기준으로 내림차순 정렬해주세요.
 
2022년 9월의 대여 기록 중 '장기 대여' 에 해당하는 기록은 대여 기록 ID가 1, 4인 기록이고, 
'단기 대여' 에 해당하는 기록은 대여 기록 ID가 3, 5 인 기록이므로 대여 기록 ID를 기준으로 
내림차순 정렬하면 다음과 같이 나와야 합니다.

결과)
HISTORY_ID	CAR_ID	START_DATE	END_DATE	RENT_TYPE
5	3	2022-09-16	2022-10-13	단기 대여
4	1	2022-09-01	2022-09-30	장기 대여
3	2	2022-09-05	2022-09-05	단기 대여
1	4	2022-09-27	2022-10-26	장기 대여
*/

SELECT HISTORY_ID, CAR_ID, 
date_format(START_DATE, '%Y-%m-%d') as START_DATE,
date_format(END_DATE, '%Y-%m-%d') as END_DATE,
if (DATEDIFF(END_DATE, START_DATE) >= 29, "장기 대여", "단기 대여") as RENT_TYPE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
where date_format(START_DATE, '%Y-%m') = '2022-09'
Order by HISTORY_ID desc;

/*
https://school.programmers.co.kr/learn/courses/30/lessons/62284
CART_PRODUCTS 테이블은 장바구니에 담긴 상품 정보를 담은 테이블입니다. 
CART_PRODUCTS 테이블의 구조는 다음과 같으며, ID, CART_ID, NAME, PRICE는 
각각 테이블의 아이디, 장바구니의 아이디, 상품 종류, 가격을 나타냅니다.

데이터 분석 팀에서는 우유(Milk)와 요거트(Yogurt)를 동시에 구입한 장바구니가 있는지 알아보려 합니다. 
우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회하는 SQL 문을 작성해주세요. 
이때 결과는 장바구니의 아이디 순으로 나와야 합니다.

결과)
CART_ID
286
448
*/
create table cart_products(
id int,
    cart_id int,
    name varchar(30),
    price int
);
insert into cart_products(id, cart_id, name, price)
values(1630,83,'Cereal',3980),
(1631,83,'Multipurpose Supply',3900),
(5491,286,'Yogurt',2980),
(5504,286,'Milk',1880),
(8435,448,'Milk',1880),
(8437,448,'Yogurt',2980),
(8438,448,'Tea',11000),
(20236,1034,'Yogurt',2980),
(20237,1034,'Butter',4890);

select CART_ID 
FROM
(select CART_ID, group_concat(name) as name from CART_PRODUCTS
group by CART_ID having name like "%Yogurt%" and name like "%Milk%") temp;

/*select cart_id from cart_products
where name in('Milk', 'Yogurt') group by cart_id
having count(distinct name) = 2;
*/

/*
MySQL 프로시저 내에서 반복문을 사용하여 반복적인 작업을 할 수 있다
- LOOP, WHILE
*/
call inc_counter(1,10);
call new_procedure();

/*
트리거(Trigger)
- 트리거란 테이블에서 어떤 이벤트(update, insert, delete)가 발생했을 때 자동으로 실행되는 것을 말함
*/
create table test1(
    num int auto_increment primary key,
	name varchar(30),
    age int
    );
    
create table test1Del(
    num int,
	name varchar(30),
    age int
    );
    
insert into test1(name, age) values('테스트1', 30);
insert into test1(name, age) values('테스트2', 30);
insert into test1(name, age) values('테스트3', 28);
insert into test1(name, age) values('테스트4', 24);
insert into test1(name, age) values('테스트5', 20);

-- 트리거 생성
DELIMITER //
create Trigger check_remove_name
	After DELETE
    ON test1
    FOR EACH ROW
    
    BEGIN
		INSERT INTO test1Del VALUES(old.num, old.name, old.age);
	END //
DELIMITER ;

 