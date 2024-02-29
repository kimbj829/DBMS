CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_test1`(
	-- 파라미터 선언
	name varchar(20),
    age int
)
BEGIN
	-- 지연변수 선언
	declare proc_num int;
    
    select count(*) + 2
    into proc_num from pro_test1;

	insert into pro_test1(num, name, age)
    values(proc_num, name, age);
END