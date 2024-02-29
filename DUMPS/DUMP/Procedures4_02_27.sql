CREATE DEFINER=`root`@`localhost` PROCEDURE `if_pro_2`(
	num int
)
BEGIN
	if num > 100 then
		select("100보다 크다");
	else
		select("100보다 작다");
	end if;
END