CREATE DEFINER=`root`@`localhost` PROCEDURE `inc_counter`(
	in startNum int,
    in endNum int
)
BEGIN
	declare cnt int; -- 카운트 변수
    
    set cnt =startNum;
    
    -- cnt 값이 endNum보다 작거나 같을 때 까지 
    while cnt <= endNum Do
		-- 현재 숫자 출력
		SELECT cnt;
        -- cnt 변수값을 1씩 증가
        set cnt = cnt + 1;
	end while;
END