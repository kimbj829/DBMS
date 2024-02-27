/*
ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. 
ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, 
DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 
각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 
이름, 성별 및 중성화 여부를 나타냅니다.

ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. 
ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, 
DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 
생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다. 
ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다

천재지변으로 인해 일부 데이터가 유실되었습니다. 입양을 간 기록은 있는데, 
보호소에 들어온 기록이 없는 동물의 ID와 
이름을 ID 순으로 조회하는 SQL문을 작성해주세요.

결과)
ANIMAL_ID	NAME
A349733		Allie
A349990		Spice
*/
create table animal_ins(
animal_id varchar(30),
    animal_type varchar(30),
    datetime datetime,
    intake_condition varchar(100),
    name varchar(100),
    sex_upon_intake varchar(100)
);

create table animal_outs(
animal_id varchar(30),
    animal_type varchar(30),
    datetime datetime,
    name varchar(100),
    sex_upon_outcome varchar(100)
);

insert into animal_ins(animal_id, animal_type, datetime,
intake_condition, name, SEX_UPON_INTAKE)
values('A352713','Cat','2017-04-13 16:29:00','Normal','Gia','Spayed Female'),
('A350375','Cat','2017-03-06 15:01:00','Normal','Meo', 'Neutered Male');

insert into animal_outs(animal_id, animal_type, datetime,
name, sex_upon_outcome)
values('A349733','Dog','2017-09-27 19:09:00','Allie','Spayed Female'),
('A352713','Cat','2017-04-25 12:25:00','Gia','Spayed Female'),
('A349990','Cat','2018-02-02 14:18:00','Spice','Spayed Female');
SELECT * FROM animal_ins;
SELECT * FROM animal_outs;

select o.animal_id, o.name from animal_outs as o
left join animal_ins as i 
on o.name = i.name where i.animal_id is null;

SELECT ao.animal_id, ao.name from animal_outs as ao
left outer join animal_ins as ai
on ao.animal_id = ai.animal_id where ai.animal_id is null;

/*
SELECT ai.animal_id, ai.name from animal_ins as ai
left join animal_outs as ao
on ai.animal_id = ao.animal_id where ai.animal_id is null;

SELECT ao.animal_id, ao.name from animal_outs as ao
left join animal_ins as ai
on ai.animal_id = ao.animal_id where ao.animal_id is null;
*/

/*
프로시저
- 프로시저(Procedure)란 일련의 쿼리를 마치 하나의 함수처럼 실행하기
위한 퀴러의 집합

프로시저와 함수
- 함수는 특정 계산을 수행하고 리턴값을 반드시 가져야 한다
- 프로시저는 특정 작업을 수행하고 리턴값을 안가질 수도 있다 또한 여러개일 수 있음

프로시저 장점
- 하나의 요청으로 여러 SQL문을 싱행할 수 있다
- 네트워크 소요 시간을 줄일 수 있다
- 개발 업무를 구분해서 개발 할 수 있다
* 순수한 애플리케이션만 개발하는 부분과 DBMS 관련 코드를 개발하는 조직이
따로 있다면 DBMS 개발하는 조직에서는 데이터베이스 관련 처리만 만들어 api처럼 제공하고
애플리케이션 개발자는 sp를 호출해서 사용하는 형식으로 역활을 명확히 구분할 수 있다

프로시저 단점
- 처리성능이 낮다
* 문자나 숫자 연산에 저장 프로시저를 사용하면 오히려 C나 Java보다 느린 성능
- 디버깅이 힘듬
- DB확장이 힘듬

동적쿼리 정적쿼리
정적쿼리 : 어떤 조건 또는 상황에도 변경되지 않으면 정적쿼리
동적쿼리 : 특정 조건들이나 상황에 따라 변경되면 동적쿼리
*/

create table pro_test1(
	num int,
    name varchar(20),
    age int
    );
-- 프로시저 호출
call proc_test1('테스트1', 30);
select * from pro_test1;

call `Add`(10, 20, @result);
select @result;

/*
프로시저 조건문
유형1) 특정 조건이 참인 경우에만 수행 작업 지정하기
IF 조건식 THEN
	조건이 맞을 때 실행할 SQL문장
END IF;

유형2) 특정 조건이 참일 대와 거짓을 때 수행할 작업 모두 지정
IF 조건식 THEN
	조건이 맞을때 실행할 sSQL문장
ELSE
	조건이 틀릴때 실행할 SQL문장
END IF;

유형3) 여러가지 조건을 지정하여 수행할 작업 지정
IF 조건식1 THEN
	조건식1이 맞을 때 실행할 SQL문장
ELSEIF 조건식2 THEN
	조건식2가 맞을때 실행할 SQL문장
ELSEIF 조건식3 THEN
	조건식3이 맞을 떄 실행할 SQL문장
ELSE
	위의 모든 조건이 틀릴 떄 실행할 문장
END IF;
*/
call if_pro_1();

/*
숫자 하나를 입력받아서 입력받은 
숫자가 100보다 큰 수 이면 100보다 큽니다. 
숫자가 100보다 작을 경우 100보다 크지않습니다.
*/
call if_pro_2(100);

/* 수를 입력받아 짝수인지 홀수인지 판단하는 프로시저를 작성 (if, else) */
call even_odd(2);
/* 과일 구매하기 (if, elseif, else) */
call if_pro_4('사과');
call if_pro_4("포도");
/* 과일 구매하기 (case, when, then) */
call if_pro_5('포도');