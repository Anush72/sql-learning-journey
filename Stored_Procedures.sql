-- stored procedures

-- creating procedure
create procedure large_salaries()
select * 
from employee_salary
where salary >=50000;


-- calling procedure
call large_salaries();


-- Storing two quries in same procedure
DELIMITER $$
CREATE procedure large_salaries2()
begin
	select * 
	from employee_salary
	where salary >=50000;
	select * 
	from employee_salary
	where salary >=10000;
END $$
DELIMITER ;

call  large_salaries2();


-- Parameter
DELIMITER $$
CREATE procedure large_salaries3(id INT)
begin
	select salary
	from employee_salary
	where employee_id = id;
END $$
DELIMITER ;

call large_salaries3(2)