-- Triggers and Events

select * 
from employee_demographics;


select * 
from employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert
	after insert on employee_salary
    for each row
begin
	insert into employee_demographics (employee_id,first_name,last_name)
    values (new.employee_id,new.first_name,new.last_name);
end $$
delimiter ;

INSERT INTO employee_salary (employee_id,first_name,last_name,occupation,salary,dept_id)
values (13,'Giri','Anush','CEO',100000,NULL);

-- Events
select * 
from employee_demographics;


delimiter $$
create event delete_retirees
on schedule every 30 second
do 
begin
	Delete
    from employee_demographics
    where age >= 60;
end $$
delimiter ;