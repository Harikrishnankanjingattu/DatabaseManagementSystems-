DELIMITER //
CREATE PROCEDURE procedure_name
AS
BEGIN
   -- SQL statements
END;
DELIMITER ;

----------------------------------------------
EG:- 
  
delimiter //
drop procedure if exists hello//
create procedure hello(in cour int )
begin
select * from courses where course_id=cour; 
end //
delimter ;
