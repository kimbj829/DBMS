# 한줄 주석 /* */ 범위 주석
#테이블 만들기
create table tbl_user(
	num int auto_increment primary key,
    userId varchar(30),
    userPw varchar(100) not null
    );
#테이블 정보를 들고 옴
select * from tbl_user;
#테이블에 정보를 입력하기
insert into tbl_user(userId, userPw)
values('zzzz', '12345');

select * from tbl_user;
#비번이 없어서 에러가 뜸
insert into tbl_user(userId)
values('2w2w');
#아이디 없이 가능
insert into tbl_user(userPw)
values('2w2w');

insert into tbl_user(userId, userPw)
values('1234', '1234');
insert into tbl_user(userId, userPw)
values('12344', '12344');

select * from tbl_user;
#테이블에 데이터 삭제(num의 값이 2번이 삭제됨)
delete from tbl_user where num = 2;
#테이블에 데이터 정보 업데이트(num 3번의 데이터가 변경이 됨)
update tbl_user set userId = 'wwqq', userPw = '1q2w'
where num = 3;