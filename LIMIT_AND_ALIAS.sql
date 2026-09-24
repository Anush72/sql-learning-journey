-- LIMIT

select * 
from employee_salary
order by salary desc
limit 3;

-- seleting the rows by position
select * 
from employee_salary
order by salary desc
limit 2,1;


-- Alias
select dept_id , avg(salary) as average_salary
from employee_salary
group by dept_id
having average_salary > 60000;
