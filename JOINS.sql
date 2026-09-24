-- Join

select * 
from employee_demographics;

select * 
from employee_salary;

-- inner join

select dem.employee_id,age,occupation
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id;

-- Outer Joins
-- Left Joins
select dem.employee_id,age,occupation
from employee_demographics as dem
Left join employee_salary as sal
on dem.employee_id = sal.employee_id;

-- Right Joins
select *
from employee_demographics as dem
right join employee_salary as sal
on dem.employee_id = sal.employee_id;

-- self Join
select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name,
emp2.last_name as last_name
from employee_salary emp1
join employee_salary emp2
on emp1.employee_id + 1 = emp2.employee_id;


-- Joining the multiple tables
select *
from employee_demographics as dem
join employee_salary as sal
on dem.employee_id = sal.employee_id
join parks_departments park
on sal.dept_id = park.department_id;
