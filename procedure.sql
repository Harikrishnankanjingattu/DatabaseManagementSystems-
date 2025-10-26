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



DELIMITER //

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS new //

-- Create a procedure with IN and OUT parameters
CREATE PROCEDURE new(IN n1 INT, OUT n2 INT)
BEGIN
    SELECT salary INTO n2 
    FROM employee 
    WHERE emp_id = n1;
END //

DELIMITER ;

-- Call the procedure
CALL new(2, @s);

-- Display the OUT parameter result
SELECT @s AS n2;
