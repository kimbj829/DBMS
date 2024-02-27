CREATE DEFINER=`root`@`localhost` PROCEDURE `if_pro_4`(
	fruit varchar(30)
    )
BEGIN
	if fruit = '사과' then
		select("사과를 구매합니다");
	elseif fruit = '바나나' then
		select("바나나를 구매합니다");
	elseif fruit = '복숭아' then
		select("복숭아를 구매합니다");
	else
		select("저희 가게는 사과, 바나나, 복숭아 외에 팔지 않습니다.");
	end if;
END