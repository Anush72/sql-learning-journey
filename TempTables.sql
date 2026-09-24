-- Temporary Tables

create  temporary table temp_table

(firstname varchar(50),
lastname varchar(50),
favourite_movie varchar(100)
);

select * 
from temp_table;

insert into temp_table
values('Anush','Giri','Splash');


select * 
from employee_salary;


create temporary table salary_over_50k
select * 
from
employee_salary
where salary >= 50000;


select * 
from 
salary_over_50k;