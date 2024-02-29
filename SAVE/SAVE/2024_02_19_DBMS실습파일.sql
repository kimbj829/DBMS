 /* 
 DDL
 - CREAT(생성), ALTER(수정), DROP(삭제), TAUNCATE
 
 DML
 - SELETE, INSERT, DELETE, UPDATE
 
 DCL
 - GRANT, REVOKE, COMMIT, ROLLBACK
 */
#auto_increment 들어오는 값을 순차적으로 넣음
#NOT NULL이 있으면 여기 NULL값이 못들어옴
#DATE 타입 : 날짜를 포함하지만 시간은 포함하지 않음 YYYY.MM.DD
#DATETIME 타입 : 날짜와 시간을 모두 포함할때 사용
#TIME 타입 : HH:MM:SS 시간에 대한 정보를 담는 타임
#TIMESTAMP 타입 : 날짜와 시간 모두를 포함한 타입
 
CREATE TABLE BOARD(
	BNO INT auto_increment primary KEY, 
    TITLE VARCHAR(50), 
    CONTENT VARCHAR(2000),
    WRITER VARCHAR(50) NOT NULL, 	
    REGDATE DATETIME default NOW() 		
);

/* BOARD에 내용을 삽입 */
INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('제목1', '내용1', '작성자1');

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('제목2', '내용2', '작성자2');

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('제목3', '내용3', '작성자3');

select * FROM BOARD;

CREATE TABLE REPLY(
	RNO INT NOT NULL primary KEY,
    BNO INT,
    RE_WRITER VARCHAR(50),
    RE_CONTENT VARCHAR(2000),
    RE_REGDATE DATETIME default NOW(),
    foreign key(BNO) references BOARD(BNO)
);
/* 테이블 제약조건 수정 */
ALTER TABLE REPLY MODIFY RNO INT NOT NULL auto_increment;

/* REPLY에 내용을 삽입 */
INSERT INTO REPLY(BNO, RE_WRITER, RE_CONTENT)
VALUES(3, '댓글1', '내용1');

INSERT INTO REPLY(BNO, RE_WRITER, RE_CONTENT)
VALUES(4, '4번댓글1', '4번댓글내용1');

SELECT * FROM REPLY;

DELETE FROM BOARD WHERE BNO = 2;	#BOARD에서 BNO 2번에 해당되는 정보를  삭제
DELETE FROM BOARD WHERE BNO = 3;	#REPLY에 해당 참조키 사용하는 테이블이 있어 삭제가 불가능
SELECT * FROM BOARD;

/* REPLY 테이블에 걸려있는 모든 제약조건을 조회하는 구문 */
SELECT constraint_name from information_schema.key_column_usage
where table_schema = 'dbexam' and table_name = 'REPLY';

/* 제약조건 삭제 */
ALTER TABLE REPLY DROP foreign key reply_ibfk_1;

/* 외래키 제약조건 추가 */ #부모가 삭제시 자식도 다 같이 삭제됨
ALTER TABLE REPLY ADD CONSTRAINT fk_reply_bno
foreign key(BNO) references BOARD(BNO) on delete cascade;

DELETE FROM BOARD WHERE BNO = 3;	#위에 제약조건 추가로 삭제가 안되던거 가능해짐
SELECT * FROM BOARD;
SELECT * FROM REPLY;

/* 
PK와 FK
PK(PRIMARY KEY)
- 유일성과 최소성을 만족
- 중복되지 않은 고유값만 허용
- NULL 값을 허용하지 않는다
- 테이블당 하나의 기본키만 지정 가능

FK(FOREIGN KEY)
- 다른 테이블의 PK와 연결되는 테이블의 column을 의미
- 한 테이블을 다른 테이블과 연결해주는 역할
- 하나의 테이블을 다른 테이블에 의존하게 만듬
- 외래키 제약 조건을 설정할 때 참조되는 테이블을 Primary Key, Unique 제약조건 설정 필수


* 유일성이란 : 릴레이션에 있는 모든 튜플에 대해 유일하게 식별되어야 한다.
* 최소성이란 : 유일성을 가진 키를 구성하는 속성 중 하나라도 제외하는 경우 유일성이 꺠지는 것을 의미
릴레이션의 모든 튜플을 유일하게 식별하는데 꼭 필요한 속성들로만 구성되어야 함
*/

/* 테이블 삭제 */
/* 
 - 제약조건에 의해 참조되고 있는 테이블(자식 테이블)이 있는 경우
 Drop TABLE [테이블명] 
 위의 명령을 사용해서 테이블을 삭제하려고 하면 외래키 제약조건으로 인해 오류 발생
 */
DROP TABLE BOARD;		#제약조건이 걸려있어서 삭제 불가
DROP TABLE REPLY;		#자식테이블(REPLY)은 삭제가 정상적으로 실행됨
DROP TABLE BOARD;		#자식테이블 제약이 걸려있는 테이블이 사라짐으로 부모 테이블(BOARD)도 삭제 가능

/* 
WHERE, ORDER BY, AND, OR, NOT, 집계함수, IF ELSE, CASE WHEN
*/

CREATE TABLE dept(
	deptno INT PRIMARY KEY,
    dname VARCHAR(14),
    loc VARCHAR(20)
);

CREATE TABLE emp(
	empno INT PRIMARY KEY,
    ename VARCHAR(14),
    job VARCHAR(10),
    hiredate DATETIME default NOW()
);

INSERT INTO dept VALUES(10, '회계팀', 'NEW YORK');
INSERT INTO dept VALUES(20, '연구팀', 'DALLAS');
INSERT INTO dept VALUES(30, '전산팀', 'BOSTON');
SELECT * FROM dept;

INSERT INTO emp VALUES(10001, '홍길동', '개발자', NOW());
INSERT INTO emp VALUES(10002, '김길동', '영업', NOW());
INSERT INTO emp VALUES(10003, '홍길순', '연구원', NOW());
INSERT INTO emp VALUES(10004, '윤준형', 'CEO', '2023-09-12');
INSERT INTO emp VALUES(10005, '김준형', '사무직', '2021-10-10');
INSERT INTO emp VALUES(10006, '김준형', '요리사', '2021-12-1');

/* 사원 테이블의 모든 데이터를 조회 */
SELECT * FROM emp;

/* 사원 번호와 이름만 조회 */
SELECT empno, ename FROM emp;

/* 별칭주기(as) */
SELECT empno as '사원번호', ename as '사원이름' from emp;

/* WHERE 절 
- 해당 테이블에서 필요한 데이터만 조회할 수 있는 조건을 주는 역할
AND, OR, NOT, >=, >, <, <=, =
*/

/* 사원번호가 10001번인 것만 조회 */
SELECT * FROM emp WHERE empno = 10001;

/* 사원번호가 10002번인 것을 조회하는데 이름과 사번, 직업만 출력하세요 */
SELECT ename as '사원이름', empno as '사원번호', job as'직업' FROM emp WHERE empno = 10002;

/* 이름이 홍길동인것만 조회 */
SELECT * FROM emp WHERE ename = '홍길동';
SELECT * FROM emp WHERE ename like '홍길동';

/*
like 사용법
- SELECT문 WHERE (조건)절에서 주로 사용됨
- 부분적으로 일치하는 컬럼을 조회할 떄 사용된다
SELECT * FROM [테이블명] WHERE 컬럼명 like '';
% : 문자열의 길이가 제한이 없다 ex)'%가나', '가%나', '가나%'
_ : 문자열의 길이를 지정해 준다
*/

/* % 활용법 */
#사원 테이블에서 이름이 홍으로 시작하는 모든 사원을 검색
SELECT * FROM emp WHERE ename like '홍%';		

/* 사원 테이블에서 윤이 포함된 사원을 검색 */
SELECT * FROM emp WHERE ename like '%윤%';

/* 사원 테이블에서 순으로 끝나는 이름만 검색 */
SELECT * FROM emp WHERE ename like '%순';

/*
학생 테이블을 만드세요
학생번호 : 유일키와 자동열 증가 하도록 생성
학생이름, 성별, 휴대폰 번호, 이메일, 
국어점수 int, 수학점수 int, 영어점수 int
 */
 
CREATE TABLE STUDENT(
	student_ID INT auto_increment PRIMARY KEY,
    stu_name VARCHAR(10),
    stu_gender VARCHAR(20),
    phone_number VARCHAR(20),
    email VARCHAR(40),
    kor INT,
    math INT,
    eng INT
);

INSERT INTO STUDENT(stu_name, stu_gender, phone_number, email, kor, math, eng)
VALUES('홍길동', '남자', '010-1111-1111', 'zzzz@naver.com', 90, 80, 70);

insert into STUDENT(stu_name, stu_gender, phone_number, email, kor, math, eng)
values('김길동', '남자', '010-2222-1111','wwww@naver.com', 90, 75, 60);

insert into STUDENT(stu_name, stu_gender, phone_number, email, kor, math, eng)
values('홍길순', '여자', '010-3588-1212','zzzz@naver.com', 70, 100, 85);

insert into STUDENT(stu_name, stu_gender, phone_number, email, kor, math, eng)
values('김지훈', '남자', '010-2321-2111','zzzz@naver.com', 100, 85, 76);

insert into STUDENT(stu_name, stu_gender, phone_number, email, kor, math, eng)
values('김지영', '여자', '010-1341-1211','wwww@daum.net', 40, 85, 20);

SELECT * FROM STUDENT;

/* 성별이 남자인 학생을 조회하는데 학생이름, 국어점수, 수학점수, 영어점수만 출력
그리고 컬럼에 별칭 추가 */
SELECT stu_name as '이름', kor as '국어', math as '수학', eng as '영어' FROM STUDENT WHERE stu_gender = '남자';

/* 이름에 홍자가 들어가는 학생들의 국어점수, 수학점수, 영어점수를 출력하세요 */
SELECT stu_name as '이름', kor as '국어', math as '수학', eng as '영어' FROM STUDENT WHERE stu_name like '%홍%';