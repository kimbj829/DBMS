CREATE DEFINER=`root`@`localhost` PROCEDURE `new_procedure`()
BEGIN
	declare total int default 0;
    declare i int default 1;
    
    while i < 10 do
		set total = total + i;
        set i = i + 1;
	end while;

	select total;
END