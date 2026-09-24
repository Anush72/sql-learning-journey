# Where Clause Filter the rows

-- where statement with comparsion operator
select * 
from employee_salary
where salary = 50000;

select * 
from employee_salary 
where salary > 50000;

select * 
from employee_salary 
where salary < 50000;

-- we can use both equal and comparison operator
select * 
from employee_salary 
where salary <= 50000;

-- Logical Operator AND, OR, NOT
select * 
from employee_salary 
where salary > 50000 and dept_id = 3;

select * 
from employee_salary 
where salary > 50000 or dept_id = 3;

select * 
from employee_salary 
where not dept_id = 3;

select * 
from employee_salary 
where (first_name = 'Lesile' and dept_id = '1') or dept_id != 1;

-- Like operator (% and _)
select * 
from employee_salary 
where first_name like 'a%';

select * 
from employee_salary 
where first_name like 'a__';