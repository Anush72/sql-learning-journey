-- Case Statements
select first_name,
last_name,age,
case 
	when age <=30 Then 'Young'
    When age between 31 and 50 Then 'Old'
    when age >= 50 Then 'Retire Age'
END as age_bracket
from
employee_demographics;

-- Pay Increase and Bonus
 -- < 50000 = 5%
 -- > 50000 = 7%
 
 select first_name,last_name,salary,
 case
 when salary <= 50000 then salary + (salary * 0.05)
 when salary > 50000 then salary + (salary * 0.07)
 END as NewSalary
 from employee_salary;


-- person who is in finance department got 10% bonus
select sal.first_name,sal.last_name,sal.salary,
dep.department_name,
case 
	when department_name = 'Finance' then salary * 0.1
    end as Bonus
from
employee_salary sal
join parks_departments dep
on  sal.dept_id = dep.department_id

