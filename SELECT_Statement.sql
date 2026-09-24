# SELECT statement
use parks_and_recreation;
# select emplopyee demographic
select * 
from employee_demographics;

# selecting the column
select first_name,last_name,birth_date,age+10
from employee_demographics;

# PEDMAS - follow when you do mathematical calculation in selecting row in select statement
select first_name,last_name,birth_date,(age+10)*10+10
from employee_demographics;

# Using Distinct in select statement gives unique list
Select Distinct gender 
from employee_demographics;
