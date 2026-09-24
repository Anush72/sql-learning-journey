-- CTEs

with cte_example as
(

select gender, avg(salary) avg_salary, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem 
JOIN employee_salary sal
on dem.employee_id = sal.employee_id
group by gender
)
select avg(avg_salary)
from cte_example;