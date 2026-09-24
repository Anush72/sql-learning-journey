-- GROUP BY 

select gender,count(age),min(age),avg(age),max(age)
from employee_demographics
group by gender;

-- order by
select *
from employee_demographics
order by first_name;

-- multiple columns in order by
select * 
from employee_demographics
order by gender,age;