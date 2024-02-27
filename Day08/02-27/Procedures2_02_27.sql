CREATE DEFINER=`root`@`localhost` PROCEDURE `Add`(
	in num1 int,		-- 프로시저로 값을 받음
    in num2 int,		
    out result int		-- 처리 결과를 전달함
    
    /*
    IN OUT
    - IN과 OUT의 기능을 모두 갖고 있다
    - 프로시저에 전달하고 프로시저 내에서 변경된 값을 다시 돌려받을 수 있다
    */
    )
BEGIN
	-- num1과 num2를 더한 결과를 result라는 출력 파라미터에 저장
	set result = num1 + num2;
END