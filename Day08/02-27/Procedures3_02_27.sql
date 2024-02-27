CREATE DEFINER=`root`@`localhost` PROCEDURE `if_pro_1`()
BEGIN
	-- int형으로 변수 선언
	declare sal int;
    set sal = 100; -- 선언된 변수에 데이터 할당
    if sal <= 1000 then
		select(concat(sal, ' 연봉인상대상자'));
	end if;
END