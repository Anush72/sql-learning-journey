-- Window Function

select gender, avg(salary) as avg_salary
from employee_demographics dem 
JOIN employee_salary sal
on dem.employee_id = sal.employee_id
group by gender;


-- Over and Partition by
select dem.first_name,dem.last_name,gender, avg(salary) OVER(partition by gender)
from employee_demographics dem 
JOIN employee_salary sal
on dem.employee_id = sal.employee_id;


-- Rolling Total
select dem.first_name,dem.last_name,gender,sal.salary,sum(salary) OVER( order by dem.employee_id) as Rolling_Total
from employee_demographics dem 
JOIN employee_salary sal
on dem.employee_id = sal.employee_id;

-- Row Number
select dem.first_name,dem.last_name,gender,sal.salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) rank_num,
dense_rank() over(partition by gender order by salary desc) demse_rank_num
from employee_demographics dem 
JOIN employee_salary sal
on dem.employee_id = sal.employee_id;