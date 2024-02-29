CREATE DEFINER=`root`@`localhost` PROCEDURE `even_odd`(
	num int
)
BEGIN
	if num % 2 = 0 then
		select("짝수");
	else
		select("홀수");
	end if;
END