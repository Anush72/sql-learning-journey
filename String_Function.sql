-- string function

select * 
from employee_demographics;


-- length function
select first_name,length(first_name) as Length 
from employee_demographics
order by 2;

-- Upper Case and Lowercase
select first_name,upper(first_name),lower(first_name)
from employee_demographics;

-- Trim
select trim('  sky ');

-- left trim and right trim
select ltrim('  I   love sql');

select rtrim('I love SQL  ');

-- Left and Right 
-- left takes the charcter from left 
-- right takes the character from right
select first_name,left(first_name,4),right(first_name,4)
from employee_demographics;

-- substring to select month from birth_date
select first_name,substring(birth_date,6,2) as birth_month
from employee_demographics;

-- Replace 
select first_name,replace(first_name,'a','c')
from employee_demographics;

-- Locate
select locate('us','Anush');

-- concat 
select first_name,last_name,concat(first_name,' ',last_name) as full_name
from employee_demographics;



