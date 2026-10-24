-- Creating Table Teachers

CREATE TABLE teachers (
	id bigserial,
	first_name varchar(25),
	last_name varchar(25),
	school varchar(50),
	hire_date date,
	salary numeric
);

-- INSERTING ROWS
INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
       ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
       ('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
       ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
       ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
       ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);

	   
-- CREATING table animals

CREATE TABLE animal_types(
	animal_type_id bigserial,
	common_name text NOT NULL,
	scientific_name text NOT NULL,
	conservation_status text NOT NULL,
	constraint  common_name_unique UNIQUE(common_name)
);

-- creating another table
CREATE TABLE menagerie (
   menagerie_id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
   common_name text REFERENCES animal_types (common_name),
   date_acquired date NOT NULL,
   gender text,
   acquired_from text,
   name text,
   notes text
);

-- Insering values into both table

INSERT INTO animal_types (common_name, scientific_name, conservation_status)
VALUES ('Bengal Tiger', 'Panthera tigris tigris', 'Endangered'),
       ('Arctic Wolf', 'Canis lupus arctos', 'Least Concern');

	   
INSERT INTO menagerie (common_name, date_acquired, gender, acquired_from, name, notes)
VALUES
('Bengal Tiger', '12/03/1996', 'F', 'Dhaka Zoo', 'Ariel', 'Healthy coat at last exam.'),
('Arctic Wolf','30/09/2000', 'F', 'National Zoo', 'Freddy', 'Strong appetite.');


-- SELECT Syntax
SELECT * 
FROM teachers;

-- Quering a Subset of Columns
SELECT last_name,first_name,salary
from teachers;

-- Sorting Data with Order BY
SELECT first_name,last_name,salary
from teachers
order by salary DESC;

-- Sorting Data with Order BY Column Name
SELECT first_name,last_name,salary
from teachers
order by 3 DESC;

-- Sorting multiple coulmns with order by
SELECT last_name,school,hire_date
from teachers
ORDER BY school ASC, hire_date DESC;

-- Using Distinct to find Unique Values
SELECT DISTINCT school
FROM teachers
ORDER BY school;

-- Quering distinct pairs of values in the school and salary columns
SELECT DISTINCT school, salary
FROM teachers
ORDER BY school,salary;

-- Filtering Rows with WHERE
SELECT last_name,school,hire_date
from teachers
WHERE  school = 'Myers Middle School';

-- Using LIKE and ILIKE with WHERE
-- LIKE is case sensitive and ILIKE is not case sensitive
SELECT first_name
from teachers
WHERE first_name LIKE 'sam%';

SELECT first_name
from teachers
WHERE first_name ILIKE 'sam%';

-- Combining Operators with AND and OR
SELECT * 
FROM teachers
WHERE school = 'Myers Middle School'
	AND salary < 40000;

SELECT * 
FROM teachers
WHERE last_name = 'Cole'
	OR last_name = 'Bush';

SELECT *
FROM teachers
WHERE school = 'F.D. Roosevelt HS'
      AND (salary < 38000 OR salary > 40000);


-- Basic Excerise 1
SELECT * 
FROM teachers
ORDER BY first_name;

-- Excerise 2 - Name Starts with Letter S and Who earn More than 40000
SELECT * 
FROM teachers
WHERE first_name ILIKE 'S%' AND salary > 40000;

-- Excerise 3 - Rank teachers since January 1, 2010 ordered by Highest to Lowest
SELECT first_name,salary,hire_date
FROM teachers
WHERE hire_date >= '2010-01-01'
ORDER BY salary DESC;


-- Chapter 4 Understanding Data Types
CREATE TABLE eagle_watch (
	observation_date date,
	eagles_seen integer,
	notes text
);

-- charactes data types
-- char(n) - fixed length (fixed space allocated), 
-- varchar(n) -- fixed length (variable space allocated based on charcter you put)
-- text -- unlimited length

CREATE TABLE char_data_types (
	char_column char(10),
	varchar_column varchar(10),
	text_colum text
);

INSERT INTO char_data_types
VALUES
	('abc','abc','abc'),
	('defghi','defghi','defghi');

COPY char_data_types TO 'd:\sql-learning-journey\PostgreSQL\typestext.txt'
WITH (FORMAT CSV,HEADER,DELIMITER '|');

-- numeric data types 
-- small int, integer, big init
-- auto increment number smallserial, serial and bigserial
CREATE TABLE people (
	id serial,
	person_name varchar(100)
);

-- Auto Incrementing with IDENTITY
-- CREATE TABLE people (
-- 	id integer GENERATED ALWAYS AS IDENTITY,
-- 	person_name varchar(100)
-- );

-- Decimal Number
-- numeric, decimal variable fixed point
-- real floating point 6 decimal digits precision
-- double precision floating point 15 decimal digits precision
CREATE TABLE number_data_types (
	numeric_column numeric(20,5),
	real_column real,
	double_column double precision
);

 INSERT INTO number_data_types
VALUES
    (.7, .7, .7),
    (2.13579, 2.13579, 2.13579),
    (2.1357987654, 2.1357987654, 2.1357987654);
SELECT * FROM number_data_types;

-- Dates and Times
-- timestamp - Date and Time
-- date - date only
-- time - time only
-- interval -- time interval

CREATE TABLE date_time_types (
	timestamp_column timestamp with time zone,
	interval_column interval
);

INSERT INTO date_time_types
VALUES
    ('2022-12-31 01:00 EST','2 days'),
    ('2022-12-31 01:00 -8','1 month'),
    ('2022-12-31 01:00 Australia/Melbourne','1 century'),
    (now(),'1 week');

SELECT * FROM date_time_types;


SELECT 
	timestamp_column,
	interval_column,
	timestamp_column - interval_Column as new_date
	FROM date_time_types;

-- casting
SELECT timestamp_column , CAST(timestamp_column AS varchar(10))
	FROM date_time_types;

SELECT 	numeric_column,
		CAST(numeric_column as integer),
		CAST(numeric_column as text)
FROM number_data_types;

-- Using CAST Shortcut Notation
SELECT timestamp_column :: varchar(10)
FROM date_time_types;


-- Creating table us_counties_pop_est_2019
CREATE TABLE  us_counties_pop_est_2019 (
	state_fips text,
	county_fips text,
	region smallint,
	state_name text,
	county_name text,
	area_land bigint,
	area_water bigint,
	internal_point_lat numeric(10,7),
	internal_point_lon numeric(10,7),
	pop_est_2018 integer,
	pop_est_2019 integer,
	births_2019 integer,
	deaths_2019 integer,
	international_migr_2019 integer,
	domestic_migr_2019 integer,
	residual_2019 integer,
	CONSTRAINT counties_2019_key PRIMARY KEY (state_fips, county_fips)
);

SELECT * 
FROM us_counties_pop_est_2019;

-- Performing the Census Import with COpy
COPY  us_counties_pop_est_2019
FROM 'D:\sql-learning-journey\PostgreSQL\us_counties_pop_est_2019.csv'
WITH (FORMAT CSV, HEADER);


SELECT * 
FROM us_counties_pop_est_2019;


-- SELECTING SUBSET OF COLUMNS
SELECT county_name, state_name, area_land
FROM us_counties_pop_est_2019
ORDER BY area_land DESC
LIMIT 3;

-- lets look at long and lat
SELECT county_name, state_name, internal_point_lat,internal_point_lon
FROM us_counties_pop_est_2019
ORDER BY internal_point_lon DESC
LIMIT 5;

-- Importing the subset of columns with COPY
CREATE TABLE supervisor_salaries (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    town text,
    county text,
    supervisor text,
    start_date date,
    salary numeric(10,2),
    benefits numeric(10,2)
);

-- Importing the Sub Columns from CSV file
COPY supervisor_salaries (town,supervisor,salary)
FROM 'D:\sql-learning-journey\PostgreSQL\supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

SELECT * 
FROM supervisor_salaries;

DELETE FROM supervisor_salaries;

-- Copying with where condition
COPY supervisor_salaries (town,supervisor,salary)
FROM 'D:\sql-learning-journey\PostgreSQL\supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER)
WHERE town = 'New Brillig';

SELECT * 
FROM supervisor_salaries;

-- Adding value to a column During Import
CREATE TEMPORARY TABLE supervisor_salaries_temp
	(LIKE supervisor_salaries INCLUDING ALL);
COPY supervisor_salaries_temp (town,supervisor,salary)
FROM 'D:\sql-learning-journey\PostgreSQL\supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

INSERT INTO supervisor_salaries (town,county,supervisor,salary)
SELECT town, 'Mills',supervisor,salary
FROM supervisor_salaries_temp;


DROP TABLE supervisor_salaries_temp;

-- Using Copy to export Data

COPY us_counties_pop_est_2019
TO 'D:\sql-learning-journey\PostgreSQL\us_counties_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

-- Exporting Partcular Columns
COPY us_counties_pop_est_2019
	(county_name,internal_point_lat,internal_point_lon)
TO 'D:\sql-learning-journey\PostgreSQL\us_counties_latlon_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

-- Exporting Query Results
COPY 
	(SELECT county_name,state_name
	FROM us_counties_pop_est_2019
	WHERE county_name ILIKE '%mill%')
TO 'D:\sql-learning-journey\PostgreSQL\us_counties_mill_export.csv'
WITH (FORMAT CSV, HEADER);


-- Imagine Copy the imaginary data 
-- id:movie:actor
-- 50:#Mission: Impossible#:Tom Cruise
COPY actor(id,movie,actor)
FROM 'D:\hello.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ':',QUOTE '#');

-- Saving the file where Us Counties birth is more than other
COPY 
	(SELECT county_name,state_name,births_2019 as birth_count
	FROM us_counties_pop_est_2019
	ORDER BY births_2019 DESC
	LIMIT 20)
TO 'D:\sql-learning-journey\PostgreSQL\us_counties_mostbirth_export.csv'
WITH (FORMAT CSV, HEADER);

-- Basic Maths and Statistics with SQL

-- operator (+, addition), (-,substraction), (*,multiplication)
-- (/, division), (%, modulo), (^,Exponentation),(|/, Square Root), (||/, Cube Root)
-- (!,factorial)


-- Adding subtracting and multiplying
SELECT 2+ 2;
SELECT 9-1;
SELECT 3*4;

-- Performing Division and Module
SELECT 11/6;
SELECT 11 % 6;
SELECT 11.0/6;
SELECT CAST(11 AS NUMERIC(3,1))/6;

-- Using Exponents, Roots and Factorials
SELECT 3 ^4;

SELECT |/10;

SELECT sqrt(10);

SELECT ||/10;

SELECT factorial(4);

--- Order of Operations

-- 1. Exponents and roots
-- 2. Multiplication, divison and modulo
-- 3. Addition and subtraction

SELECT 7+8*9;
SELECT (7+8)*9;

-- Second example using exponents
SELECT 3 ^ 3-1;
SELECT 3 ^ (3-1);


-- Adding and Subtracting Columns
SELECT county_name AS county,
state_name AS state,
births_2019 AS births,
deaths_2019 AS deaths,
births_2019 - deaths_2019 AS natural_increase
FROM us_counties_pop_est_2019
ORDER BY state_name, county_name;


SELECT county_name AS county,
state_name AS state,
pop_est_2019 AS pop,
pop_est_2018+births_2019-deaths_2019+
international_migr_2019+ domestic_migr_2019+ residual_2019 AS components_total,
pop_est_2019 - (pop_est_2018 + births_2019 - deaths_2019 +
international_migr_2019 + domestic_migr_2019 +
residual_2019) AS difference
FROM us_counties_pop_est_2019
ORDER BY difference DESC;

-- Finding Percentages of the Whole
SELECT county_name as county,
state_name AS state,
area_water::numeric / (area_land + area_water) * 100 as pct_water
FROM us_counties_pop_est_2019
ORDER BY pct_water DESC;

-- Tracking percentage Change
CREATE TABLE percent_change (
	department text,
	spend_2019 numeric(10,2),
	spend_2022 numeric(10,2)
);

-- Inserting the values in percentage change
INSERT INTO percent_change
VALUES
	('Assessor',178556,179500),
	('Building',250000,289000),
	('Clerk',451980,650000),
	('Library',87777,9001),
	('Parks',250000,223000),
	('Water',199000,195000)
;

SELECT department,
spend_2019,
spend_2022,
round((spend_2022-spend_2019)/spend_2019*100,1) AS pct_change
FROM percent_change;


-- Using Aggregate Functions for Averages and Sums
SELECT sum(pop_est_2019) AS county_sum,
	round(avg(pop_est_2019),0) AS county_average
FROM us_counties_pop_est_2019;

-- Median
-- We use pecentile_cont function to calculate median, q1 and q3
CREATE TABLE percentile_test (
numbers integer
);

INSERT INTO percentile_test (numbers) VALUES
 (1), (2), (3),(4),(5),(6);

SELECT 
	percentile_cont(.5)
	WITHIN GROUP (ORDER BY numbers),
	percentile_disc(.5)
	WITHIN GROUP (ORDER BY numbers)
FROM percentile_test;


-- Finding Mean and Percentiles with census data
SELECT sum(pop_est_2019) AS county_sum,
	round(avg(pop_est_2019),0) AS county_average,
	percentile_cont(.5)
	WITHIN GROUP (ORDER BY pop_est_2019) AS county_median
	FROM us_counties_pop_est_2019;

-- finding other quantiles with percentile functions
SELECT percentile_cont(ARRAY[.25,.5,.75])
 WITHIN GROUP (ORDER BY pop_est_2019) as quartiles
FROM us_counties_pop_est_2019;

-- Using Unnest
SELECT unnest(percentile_cont(ARRAY[.25,.5,.75])
 WITHIN GROUP (ORDER BY pop_est_2019))as quartiles
FROM us_counties_pop_est_2019;

-- finding the mode
SELECT mode() WITHIN GROUP(ORDER BY births_2019)
FROM us_counties_pop_est_2019;


-- Area Of Circle
SELECT CAST(22/7*(5 ^2) as numeric(10,2));

-- ratios of births to deaths
select county_name,
state_name,
births_2019 AS births,
deaths_2019 AS deaths,
births_2019 :: numeric / deaths_2019 AS birth_death_ratio
FROM us_counties_pop_est_2019
WHERE state_name = 'New York'
ORDER BY birth_death_ratio DESC;

-- median for Californa and New York
SELECT percentile_cont(0.5)
	WITHIN GROUP (ORDER BY pop_est_2019) as median
FROM us_counties_pop_est_2019
WHERE state_name = 'California';

SELECT percentile_cont(0.5)
	WITHIN GROUP (ORDER BY pop_est_2019) as median
FROM us_counties_pop_est_2019
WHERE state_name = 'New York';

-- Both 
SELECT state_name,
	percentile_cont(0.5)
	WITHIN GROUP (ORDER BY pop_est_2019) as median
FROM us_counties_pop_est_2019
WHERE state_name IN  ('New York','California')
GROUP by state_name;

-- Joining tales in a relational database

CREATE TABLE departments (
    dept_id integer,
    dept text,
    city text,
   CONSTRAINT dept_key PRIMARY KEY (dept_id),
   CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
    emp_id integer,
    first_name text,
    last_name text,
    salary numeric(10,2),
   dept_id integer REFERENCES departments (dept_id),
   CONSTRAINT emp_key PRIMARY KEY (emp_id)
);

INSERT INTO departments
VALUES
    (1, 'Tax', 'Atlanta'),
    (2, 'IT', 'Boston');

INSERT INTO employees
VALUES
    (1, 'Julia', 'Reyes', 115300, 1),
    (2, 'Janet', 'King', 98000, 1),
    (3, 'Arthur', 'Pappas', 72700, 2),
    (4, 'Michael', 'Taylor', 89500, 2);


SELECT * 
FROM departments;

SELECT * 
FROM employees;


-- Quering Multiple Tables Using JOIN

SELECT * 
FROM employees JOIN departments
ON employees.dept_id = departments.dept_id
ORDER BY employees.dept_id;

-- Types of Join

-- Join - return rows from both table where mathcing values are found
-- Left Join - return every row from left table and show mathcing value of right table
-- Right Join - return every row from right table and show matching value of left table
-- FULL outer Join - returns every value from both table and joins the value where the value matched
-- CROSS Join - returns every possible combination from both tables

CREATE TABLE district_2020 (
  id integer CONSTRAINT id_key_2020 PRIMARY KEY,
    school_2020 text
);

CREATE TABLE district_2035 (
   id integer CONSTRAINT id_key_2035 PRIMARY KEY,
    school_2035 text
);

INSERT INTO district_2020 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (5, 'Dover Middle School'),
    (6, 'Webutuck High School');

INSERT INTO district_2035 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (3, 'Morrison Elementary'),
    (4, 'Chase Magnet Academy'),
    (6, 'Webutuck High School');

-- Join
SELECT * 
FROM district_2020 JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;


-- JOIN with USING
SELECT * 
FROM district_2020 JOIN district_2035
USING(id)
ORDER BY district_2020.id;

-- Left Join
SELECT * 
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- Right Join
SELECT * 
FROM district_2020 RIGHT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;


-- Full Outer Join
SELECT * 
FROM district_2020 FULL OUTER JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- CROSS JOIN
SELECT *
FROM district_2020 CROSS JOIN district_2035
ORDER BY district_2020.id, district_2035.id;


-- Finding Nulls using Join over the time
SELECT * 
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
WHERE district_2035.id IS NULL;


-- One to One Relationship - One table of  row match with only one row of other table
-- Example: State Population of Australia and State Income of Australia - We can have only 7 row in total if we join
-- One to Many Relationship - One row of table match with many row of other table
-- Example: One state of Australia has many cities and suburbs.
-- Many to Many Relation - one table can relate to multiple items in another table and vice versa
-- Example: one state can many laws and one law can implement in many state

-- selecting specific columns
SELECT district_2020.id,school_2020,school_2035
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id

-- Simpliyfying JOIN syntax with Table Aliases
SELECT d20.id,d20.school_2020,d35.school_2035
FROM district_2020 AS d20 LEFT JOIN district_2035 AS d35
ON d20.id = d35.id
ORDER BY d20.id;

-- Joining Multiple Table
CREATE TABLE district_2020_enrollment (
    id integer,
    enrollment integer
);

CREATE TABLE district_2020_grades (
    id integer,
    grades varchar(10)
);

INSERT INTO district_2020_enrollment
VALUES
    (1, 360),
    (2, 1001),
    (5, 450),
    (6, 927);

INSERT INTO district_2020_grades
VALUES
    (1, 'K-3'),
    (2, '9-12'),
    (5, '6-8'),
    (6, '9-12');

SELECT d20.id,d20.school_2020,en.enrollment,gr.grades
FROM district_2020 AS d20 JOIN district_2020_enrollment AS en
on d20.id = en.id
JOIN district_2020_grades AS gr
on d20.id = gr.id
ORDER BY d20.id;

-- creating table us_counties_pop_est_2010

CREATE TABLE us_counties_pop_est_2010 (
	state_fips text,
	county_fips text,
	region smallint,
	state_name text,
	county_name text,
	estimates_base_2010 integer,
	CONSTRAINT counties_2010_key PRIMARY KEY (state_fips,county_fips)
);


COPY us_counties_pop_est_2010 
FROM 'D:\sql-learning-journey\PostgreSQL\us_counties_pop_est_2010.csv'
WITH (FORMAT CSV, HEADER);


SELECT c2019.county_name,
c2019.state_name,c2019.pop_est_2019 as pop_2019,
c2010.estimates_base_2010 as pop_2010,
c2019.pop_est_2019 - c2010.estimates_base_2010 as raw_change,
round((c2019.pop_est_2019::numeric - c2010.estimates_base_2010)/c2010.estimates_base_2010 *100,1)AS pct_change
FROM us_counties_pop_est_2019 as c2019
JOIN us_counties_pop_est_2010 as c2010
on c2019.state_fips = c2010.state_fips
	AND c2019.county_fips = c2010.county_fips
ORDER BY pct_change DESC;


-- GREATEST PERCENTAGE LOSS IN POPULATION
SELECT c2019.county_name,
c2019.state_name,c2019.pop_est_2019 as pop_2019,
c2010.estimates_base_2010 as pop_2010,
c2019.pop_est_2019 - c2010.estimates_base_2010 as raw_change,
round((c2019.pop_est_2019::numeric - c2010.estimates_base_2010)/c2010.estimates_base_2010 *100,1)AS pct_change
FROM us_counties_pop_est_2019 as c2019
JOIN us_counties_pop_est_2010 as c2010
on c2019.state_fips = c2010.state_fips
	AND c2019.county_fips = c2010.county_fips
ORDER BY pct_change ASC;


-- UNION To combine 2010 and 2019

SELECT county_name, state_name,
pop_est_2019,'2019' AS year_of_pop
FROM
us_counties_pop_est_2019
UNION ALL
SELECT county_name, state_name,
estimates_base_2010,'2010' AS year_of_pop
FROM
us_counties_pop_est_2010
ORDER BY county_name;


-- Mean of Percent change in estimated Population between 2010 and 2019
SELECT PERCENTILE_CONT(.5)
WITHIN GROUP (ORDER BY ROUND((c2019.pop_est_2019::numeric - c2010.estimates_base_2010)/
c2010.estimates_base_2010*100,1)) AS percentile_50th
FROM us_counties_pop_est_2019 AS c2019
JOIN us_counties_pop_est_2010 AS c2010
ON c2019.state_fips = c2010.state_fips
    AND c2019.county_fips = c2010.county_fips;


-- Primary Keys = Natural Keys and Surrogate keys

-- Natural Keys = Using the one or more columns of table that meet critriea for primary key

-- Surrogate Keys = single column where we fill with artifical values

-- Creating the natural primary key
CREATE TABLE natural_key_example (
	license_id text CONSTRAINT license_key PRIMARY KEY,
	first_name text,
	last_name text
);

DROP TABLE natural_key_example;

CREATE TABLE natural_key_example (
	license_id text,
	first_name text,
	last_name text,
	CONSTRAINT license_key PRIMARY KEY (license_id)
);


INSERT INTO natural_key_example (license_id,first_name,last_name)
VALUES ('T229901','Gem','Godfrey');

INSERT INTO natural_key_example (license_id,first_name,last_name)
VALUES ('T229901','John','Mitchell');


-- Creating a Composite Primary Key

CREATE TABLE natural_key_composite_example (
	student_id text,
	school_day date,
	present boolean,
	CONSTRAINT student_key PRIMARY KEY (student_id, school_day)
);

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2022-01-22', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2022-01-23', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2022-01-23', 'N')


-- Creating an Auto Increment Surrogate Key
CREATE TABLE surrogate_key_example (
	order_number bigint GENERATED ALWAYS AS IDENTITY,
	product_name text,
	order_time timestamp with time zone,
	CONSTRAINT order_number_key PRIMARY KEY (order_number)
);

INSERT INTO surrogate_key_example (product_name, order_time)
VALUES ('Beachball Polish', '2020-03-15 09:21-07'),
       ('Wrinkle De-Atomizer', '2017-05-22 14:00-07'),
       ('Flux Capacitor', '1985-10-26 01:18:00-07');

SELECT * FROM surrogate_key_example;


INSERT INTO surrogate_key_example
OVERRIDING SYSTEM VALUE
VALUES (6,'Chicken Coop','2021-09-03 10:33-07');

ALTER TABLE surrogate_key_example ALTER COLUMN order_number RESTART WITH 5;
INSERT INTO surrogate_key_example (product_name, order_time)
VALUES ('Aloe Plant', '2020-03-15 10:09-07');


-- Foreign Keys = Used for establish relationship between tables

CREATE TABLE licenses (
	license_id text,
	first_name text,
	last_name text,
	CONSTRAINT licenses_key PRIMARY KEY (license_id)
);

CREATE TABLE registrations (
	registration_id text,
	registration_date timestamp with time zone,
	license_id text REFERENCES licenses (license_id),
	CONSTRAINT registartion_key PRIMARY KEY (registration_id,license_id)
);

INSERT INTO licenses (license_id, first_name, last_name)
VALUES ('T229901', 'Steve', 'Rothery');
INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A203391', '2022-03-17', 'T229901')
INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A75772', '2022-03-17', 'T000001');


-- We can use CASCADED when we delete row of one table which primary key linked to other
-- it automatically delete the row of another table
CREATE TABLE registrations (
	registration_id text,
	registration_date timestamp with time zone,
	license_id text REFERENCES licenses (license_id) ON DELETE CASCADE ,
	CONSTRAINT registartion_key PRIMARY KEY (registration_id,license_id)
);


-- The CHECK Constraint
-- Ensure that data put their meet the condition like primary key
-- What value to be put and so on.
CREATE TABLE check_constraint_example (
	user_id bigint GENERATED ALWAYS AS IDENTITY,
	user_role text,
	salary numeric(10,2),
	CONSTRAINT user_id_key PRIMARY KEY (user_id),
	CONSTRAINT check_role_in_list CHECK(user_role IN ('Admin','Staff')),
	CONSTRAINT check_salary_not_below_zero CHECK (salary >= 0)
);


-- The UNIQUE Constraint
-- Ensure that the value inside the constraints should be unique

CREATE TABLE unique_constraint_example (
contact_id bigint GENERATED ALWAYS AS IDENTITY,
first_name text,
last_name text,
email text,
CONSTRAINT contact_id_key PRIMARY KEY (contact_id),
CONSTRAINT email_unique UNIQUE(email)
);

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Samantha', 'Lee', 'slee@example.org');

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Betty', 'Diaz', 'bdiaz@example.org');

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Sasha', 'Lee', 'slee@example.org');


-- Not Null Constraints

-- Ensure that the row value shouldnot be null
CREATE TABLE not_null_example (
    student_id bigint GENERATED ALWAYS AS IDENTITY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    CONSTRAINT student_id_key PRIMARY KEY (student_id)
);


-- Remove or Add them Later
ALTER TABLE not_null_example DROP CONSTRAINT student_id_key;
ALTER TABLE not_null_example ADD CONSTRAINT student_id_key PRIMARY KEY (student_id);
ALTER TABLE not_null_example ALTER COLUMN first_name DROP NOT NULL;
ALTER TABLE not_null_example ALTER COLUMN first_name SET NOT NULL;

-- Speeding Up Quries with Indexes
CREATE TABLE new_york_addresses (
    longitude numeric(9,6),
    latitude numeric(9,6),
    street_number text,
    street text,
    unit text,
    postcode text,
    id integer CONSTRAINT new_york_key PRIMARY KEY
)

COPY new_york_addresses
FROM 'D:\sql-learning-journey\PostgreSQL\city_of_new_york.csv'
WITH (FORMAT CSV,HEADER);

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'BROADWAY';

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = '52 STREET';

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'ZWICKY AVENUE';


-- Adding Index 
CREATE INDEX street_idx ON new_york_addresses (street);

CREATE TABLE albums (
    album_id bigint GENERATED ALWAYS AS IDENTITY,
    catalog_code text,
    title text,
    artist text,
    release_date date,
    genre text,
    description text,
	CONSTRAINT primary_key PRIMARY KEY(album_id)
);

CREATE TABLE songs (
    song_id bigint GENERATED ALWAYS AS IDENTITY,
    title text,
    composers text,
    album_id bigint REFERENCES albums(album_id),
	CONSTRAINT primary_key2 PRIMARY KEY(song_id)
);

-- Creating the 2018 Library Survey Tables
CREATE TABLE pls_fy2018_libraries (
    stabr text NOT NULL,
    fscskey text CONSTRAINT fscskey_2018_pkey PRIMARY KEY,
    libid text NOT NULL,
    libname text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    zip text NOT NULL,
    county text NOT NULL,
    phone text NOT NULL,
    c_relatn text NOT NULL,
    c_legbas text NOT NULL,
    c_admin text NOT NULL,
    c_fscs text NOT NULL,
    geocode text NOT NULL,
    lsabound text NOT NULL,
    startdate text NOT NULL,
    enddate text NOT NULL,
    popu_lsa integer NOT NULL,
    popu_und integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl integer NOT NULL,
    video_ph integer NOT NULL,
    video_dl integer NOT NULL,
    ec_lo_ot integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    reference integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    totpro integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    obereg text NOT NULL,
    statstru text NOT NULL,
    statname text NOT NULL,
    stataddr text NOT NULL,
    longitude numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL
);

COPY pls_fy2018_libraries
FROM 'D:\sql-learning-journey\PostgreSQL\pls_fy2018_libraries.csv'
WITH (FORMAT CSV, HEADER);


-- 2017 and 2016
CREATE TABLE pls_fy2017_libraries (
    stabr text NOT NULL,
    fscskey text CONSTRAINT fscskey_2017_pkey PRIMARY KEY,
    libid text NOT NULL,
    libname text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    zip text NOT NULL,
    county text NOT NULL,
    phone text NOT NULL,
    c_relatn text NOT NULL,
    c_legbas text NOT NULL,
    c_admin text NOT NULL,
    c_fscs text NOT NULL,
    geocode text NOT NULL,
    lsabound text NOT NULL,
    startdate text NOT NULL,
    enddate text NOT NULL,
    popu_lsa integer NOT NULL,
    popu_und integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl integer NOT NULL,
    video_ph integer NOT NULL,
    video_dl integer NOT NULL,
    ec_lo_ot integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    reference integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    totpro integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    obereg text NOT NULL,
    statstru text NOT NULL,
    statname text NOT NULL,
    stataddr text NOT NULL,
    longitude numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL
);

COPY pls_fy2017_libraries
FROM 'D:\sql-learning-journey\PostgreSQL\pls_fy2017_libraries.csv'
WITH (FORMAT CSV, HEADER);


CREATE TABLE pls_fy2016_libraries (
    stabr text NOT NULL,
    fscskey text CONSTRAINT fscskey_2016_pkey PRIMARY KEY,
    libid text NOT NULL,
    libname text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    zip text NOT NULL,
    county text NOT NULL,
    phone text NOT NULL,
    c_relatn text NOT NULL,
    c_legbas text NOT NULL,
    c_admin text NOT NULL,
    c_fscs text NOT NULL,
    geocode text NOT NULL,
    lsabound text NOT NULL,
    startdate text NOT NULL,
    enddate text NOT NULL,
    popu_lsa integer NOT NULL,
    popu_und integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl integer NOT NULL,
    video_ph integer NOT NULL,
    video_dl integer NOT NULL,
    ec_lo_ot integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    reference integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    totpro integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    obereg text NOT NULL,
    statstru text NOT NULL,
    statname text NOT NULL,
    stataddr text NOT NULL,
    longitude numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL
);

COPY pls_fy2016_libraries
FROM 'D:\sql-learning-journey\PostgreSQL\pls_fy2016_libraries.csv'
WITH (FORMAT CSV, HEADER);


-- Creating indexing
CREATE INDEX libname_2018_idx ON pls_fy2018_libraries(libname);
CREATE INDEX libname_2017_idx ON pls_fy2017_libraries(libname);
CREATE INDEX libname_2016_idx ON pls_fy2016_libraries(libname);

-- Count Aggregate Function
SELECT count(*) FROM pls_fy2018_libraries;
SELECT  count(*) FROM pls_fy2017_libraries;
SELECT  count(*) FROM pls_fy2016_libraries;
-- Count Values Present in a column
SELECT count(phone)
FROM pls_fy2018_libraries;

-- Distinct Values in a COlumn
SELECT count(libname)
FROM pls_fy2018_libraries;

SELECT count(DISTINCT libname)
FROM pls_fy2018_libraries;

-- max and min 
SELECT max(visits),min(visits)
FROM pls_fy2018_libraries;


-- Group by
SELECT stabr
FROM pls_fy2018_libraries
GROUP BY stabr
ORDER BY stabr;


SELECT city, stabr
FROM pls_fy2018_libraries
GROUP BY city, stabr
ORDER BY city, stabr;

-- Group by with count
SELECT stabr, count(*)
FROM pls_fy2018_libraries
GROUP BY stabr
ORDER BY count(*) DESC;


-- sum function

SELECT SUM(visits) as visits_2018
FROM pls_fy2018_libraries
WHERE visits >=0;

SELECT SUM(visits) as visits_2017
FROM pls_fy2017_libraries
WHERE visits >=0;

SELECT SUM(visits) as visits_2016
FROM pls_fy2016_libraries
WHERE visits >=0;


SELECT sum(pls18.visits) AS visits_2018,
       sum(pls17.visits) AS visits_2017,
       sum(pls16.visits) AS visits_2016
FROM pls_fy2018_libraries pls18
       JOIN pls_fy2017_libraries pls17 ON pls18.fscskey = pls17.fscskey
       JOIN pls_fy2016_libraries pls16 ON pls18.fscskey = pls16.fscskey
WHERE pls18.visits >= 0
       AND pls17.visits >= 0
       AND pls16.visits >= 0;


SELECT pls18.stabr,
	   sum(pls18.visits) AS visits_2018,
       sum(pls17.visits) AS visits_2017,
       sum(pls16.visits) AS visits_2016
FROM pls_fy2018_libraries pls18
       JOIN pls_fy2017_libraries pls17 ON pls18.fscskey = pls17.fscskey
       JOIN pls_fy2016_libraries pls16 ON pls18.fscskey = pls16.fscskey
WHERE pls18.visits >= 0
       AND pls17.visits >= 0
       AND pls16.visits >= 0
GROUP BY pls18.stabr;


-- Having Clause
SELECT pls18.stabr,
	   sum(pls18.visits) AS visits_2018,
       sum(pls17.visits) AS visits_2017,
       sum(pls16.visits) AS visits_2016
FROM pls_fy2018_libraries pls18
       JOIN pls_fy2017_libraries pls17 ON pls18.fscskey = pls17.fscskey
       JOIN pls_fy2016_libraries pls16 ON pls18.fscskey = pls16.fscskey
WHERE pls18.visits >= 0
       AND pls17.visits >= 0
       AND pls16.visits >= 0
GROUP BY pls18.stabr
HAVING sum(pls18.visits) > 50000000;



SELECT pls18.stabr,
sum(pls18.totstaff) as Total_Staff_2018,
sum(pls17.totstaff) as Total_Staff_2017,
sum(pls16.totstaff) as Total_Staff_2016
FROM pls_fy2018_libraries pls18
JOIN pls_fy2017_libraries pls17 ON pls18.fscskey = pls17.fscskey
JOIN pls_fy2016_libraries pls16 ON pls18.fscskey = pls16.fscskey 
GROUP BY pls18.stabr
ORDER BY sum(pls18.totstaff);


SELECT pls18.obereg,
       sum(pls18.visits) AS visits_2018,
       sum(pls17.visits) AS visits_2017,
       sum(pls16.visits) AS visits_2016,
       round( (sum(pls18.visits::numeric) - sum(pls17.visits)) /
            sum(pls17.visits) * 100, 1 ) AS chg_2018_17,
       round( (sum(pls17.visits::numeric) - sum(pls16.visits)) /
            sum(pls16.visits) * 100, 1 ) AS chg_2017_16
FROM pls_fy2018_libraries pls18
       JOIN pls_fy2017_libraries pls17 ON pls18.fscskey = pls17.fscskey
       JOIN pls_fy2016_libraries pls16 ON pls18.fscskey = pls16.fscskey
WHERE pls18.visits >= 0
       AND pls17.visits >= 0
       AND pls16.visits >= 0
GROUP BY pls18.obereg
ORDER BY chg_2018_17 DESC;

-- CREATE Table
CREATE TABLE meat_poultry_egg_establishments (
  	establishment_number text CONSTRAINT est_number_key PRIMARY KEY,
    company text,
    street text,
    city text,
    st text,
    zip text,
    phone text,
    grant_date date,
    activities text,
    dbas text
);


-- Copying the data
COPY meat_poultry_egg_establishments
FROM 'D:\sql-learning-journey\PostgreSQL\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV,HEADER);


-- Creting index on company column
CREATE INDEX company_idx on meat_poultry_egg_establishments (company);


SELECT COUNT(*) FROM meat_poultry_egg_establishments;


-- Interviewing the dataset

-- finidng the multiple companies at same address

SELECT company,street,city,st,
count(*) as address_count
FROM meat_poultry_egg_establishments
GROUP BY company,street,city,st
HAVING COUNT(*) > 1
ORDER BY company,street,city,st;


-- Checking for missing values
SELECT st,count(*) AS st_count
FROM meat_poultry_egg_establishments
GROUP BY st
ORDER BY st;


-- looking the details where st is null
SELECT establishment_number,company,city,st,zip
FROM meat_poultry_egg_establishments
WHERE st IS NULL;

-- Checking for Inconsistent Data Values
SELECT company,count(*) AS company_count 
FROM meat_poultry_egg_establishments
GROUP BY company
ORDER BY company ASC;

-- Checking the Zip Code
SELECT length(zip),
count(*) as zip_length
FROM meat_poultry_egg_establishments
GROUP BY length(zip)
ORDER BY length(zip) ASC;

-- filtering out the state where zip is less tan 5
SELECT st,count(*) as st_count
FROM meat_poultry_egg_establishments
WHERE length(zip) < 5
GROUP BY st
ORDER BY st ASC;


-- Before Modifying the table -- create backup table
CREATE TABLE meat_poultry_egg_establishments_backup as
SELECT * FROM meat_poultry_egg_establishments;

SELECT 
(SELECT count(*) FROM meat_poultry_egg_establishments) AS original,
    (SELECT count(*) FROM meat_poultry_egg_establishments_backup) AS backup;

-- We know that some st column has missing values
-- so update making the another copy of column st

-- Adding column
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN st_copy text

UPDATE meat_poultry_egg_establishments
SET st_copy = st;


SELECT st,
st_copy
from meat_poultry_egg_establishments
WHERE st IS DISTINCT FROM st_copy
ORDER BY st;


-- Updating the rows where values are missing
UPDATE meat_poultry_egg_establishments
SET st = 'MN'
WHERE establishment_number = 'V18677A';

UPDATE meat_poultry_egg_establishments
SET st = 'AL'
WHERE establishment_number = 'M45319+P45319';

UPDATE meat_poultry_egg_establishments
SET st = 'WI'
WHERE establishment_number = 'M263A+P263A+V263A'
RETURNING establishment_number, company, city, st, zip;


-- Updating the values for Consistency
SELECT company
FROM meat_poultry_egg_establishments
WHERE company LIKE 'Armour%';


-- Making the Copy of Company
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN company_standard text;

UPDATE meat_poultry_egg_establishments
SET company_standard = company;

-- Updating the Value
-- Returning tells which row has been updated
UPDATE meat_poultry_egg_establishments
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE '%Armour%'
RETURNING company, company_standard;


-- Repairing Zip Code
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN zip_copy text;

UPDATE meat_poultry_egg_establishments
set zip_copy = zip;

-- Updating the zip
UPDATE meat_poultry_egg_establishments
SET zip = '00' || zip
WHERE st IN('PR','VI') AND length(zip) = 3;


UPDATE meat_poultry_egg_establishments
SET zip = '0' || zip
WHERE st IN('CT','MA','ME','NH','NJ','RI','VT') AND length(zip) = 4;


-- Creating Table state_regions

CREATE TABLE state_regions (
	st text CONSTRAINT st_key PRIMARY KEY,
	region text NOT NULL
);

-- Copying the data from table
COPY state_regions
FROM 'D:\sql-learning-journey\PostgreSQL\state_regions.csv'
WITH (FORMAT CSV, HEADER);


-- Inspection data with the help of another table

ALTER TABLE meat_poultry_egg_establishments
ADD COLUMN inspection_deadline timestamp with time zone;

UPDATE meat_poultry_egg_establishments establishments
SET inspection_deadline = '2022-12-01 00:00 EST'
WHERE EXISTS (select state_regions.region FROM
state_regions
WHERE establishments.st = state_regions.st
AND state_regions.region = 'New England')
RETURNING establishments.st,inspection_deadline;


-- Using Transaction to Revert or Save Change

START TRANSACTION;
UPDATE meat_poultry_egg_establishments
SET company = 'AGRO Merchantss Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC'

SELECT company
FROM meat_poultry_egg_establishments
WHERE company LIKE 'AGRO%'
ORDER BY company;

ROLLBACK;

-- How many plant in table process meat and how many process poultry
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN meat_processing boolean;
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN poultry_processing boolean;

UPDATE meat_poultry_egg_establishments 
SET meat_processing = TRUE
WHERE LOWER(activities) LIKE '%meat processing';

UPDATE meat_poultry_egg_establishments 
SET poultry_processing = TRUE
WHERE LOWER(activities) LIKE '%poultry processing';


SELECT count(meat_processing), count(poultry_processing)
FROM meat_poultry_egg_establishments;

-- creating the census data
CREATE TABLE acs_2014_2018_stats (
	geoid text CONSTRAINT geo_id PRIMARY KEY,
	county text NOT NULL,
	st text NOT NULL,
	pct_travel_60_min numeric(5,2),
	pct_bachelors_higher numeric(5,2),
	pct_masters_higher numeric(5,2),
	median_hh_income integer,
	CHECK (pct_masters_higher <= pct_bachelors_higher)

);

COPY acs_2014_2018_stats 
FROM 'D:\sql-learning-journey\PostgreSQL\acs_2014_2018_stats.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM acs_2014_2018_stats;

-- Correlation
-- Correlation between bachelor people and median high income
SELECT corr(median_hh_income,pct_bachelors_higher) as bachelor_income_r
FROM acs_2014_2018_stats;


-- Checking Additional Correlation
SELECT round(corr(median_hh_income,pct_bachelors_higher)::numeric,2) as bachelor_income_r,
	   round(corr(median_hh_income,pct_travel_60_min)::numeric,2) as travel_income_r,
	   round(corr(pct_travel_60_min,pct_bachelors_higher)::numeric,2) as bachelor_travel_r
FROM acs_2014_2018_stats;


-- Predicting Values with Regression Analysis
SELECT 
	round(
		regr_slope(median_hh_income,pct_bachelors_higher) ::numeric,2) as slope,
	round(
		regr_intercept(median_hh_income,pct_bachelors_higher) ::numeric,2) as y_intercept
FROM 
acs_2014_2018_stats;

-- slope = 1016.55, y intercept = 29651

-- variation in indepenedent variable can explain variation in dependent variable using r-squared
SELECT 
	round(
		regr_r2(median_hh_income,pct_bachelors_higher) ::numeric,2) as slope
FROM 
acs_2014_2018_stats;
	
-- Ranks in SQL
CREATE TABLE widget_companies (
    id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    company text NOT NULL,
    widget_output integer NOT NULL
);

INSERT INTO widget_companies (company, widget_output)
VALUES
    ('Dom Widgets', 125000),
    ('Ariadne Widget Masters', 143000),
    ('Saito Widget Co.', 201000),
    ('Mal Inc.', 133000),
    ('Dream Widget Inc.', 196000),
    ('Miles Amalgamated', 620000),
    ('Arthur Industries', 244000),
    ('Fischer Worldwide', 201000);

-- Ranking with Subgroups
SELECT company, widget_output,
	rank() over (ORDER BY widget_output DESC),
	dense_rank() over (ORDER BY widget_output DESC)
FROM widget_companies
ORDER BY widget_output DESC;
	
CREATE TABLE store_sales (
    store text NOT NULL,
    category text NOT NULL,
    unit_sales bigint NOT NULL,
    CONSTRAINT store_category_key PRIMARY KEY (store, category)
);

INSERT INTO store_sales (store, category, unit_sales)
VALUES
    ('Broders', 'Cereal', 1104),
    ('Wallace', 'Ice Cream', 1863),
    ('Broders', 'Ice Cream', 2517),
    ('Cramers', 'Ice Cream', 2112),
    ('Broders', 'Beer', 641),
    ('Cramers', 'Cereal', 1003),
    ('Cramers', 'Beer', 640),
    ('Wallace', 'Cereal', 980),
    ('Wallace', 'Beer', 988);
SELECT * FROM store_sales;

SELECT *,
rank() over(PARTITION BY category ORDER BY unit_sales DESC) 
FROM store_sales;

-- Correlation between pct_masters_high and median_hh_income
SELECT corr(median_hh_income,pct_masters_higher) as master_income_r
FROM acs_2014_2018_stats;

-- Creating table us_exports

CREATE TABLE us_exports (
	year smallint,
	month smallint,
	citrus_export_value bigint,
	soybeans_export_value bigint
);


-- Importing data from CSV files
COPY us_exports 
FROM 'D:\sql-learning-journey\PostgreSQL\us_exports.csv'
WITH (FORMAT CSV,HEADER)


SELECT * FROM us_exports;


-- Rolling Average 
SELECT *,
round(avg(citrus_export_value)
OVER(ORDER BY year,month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW),0) AS tweleve_month_avg
FROM us_exports
ORDER BY year,month;

-- Rolling sum of soybean 
SELECT *,
round(avg(soybeans_export_value)
OVER(ORDER BY year,month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW),0) AS tweleve_month_sum
FROM us_exports
ORDER BY year,month;

-- Looking at pls_fy2018_libraries data
SELECT * 
FROM pls_fy2018_libraries;

-- Ranking the Library based on Visits
SELECT libname,popu_lsa,
rank() OVER(ORDER BY popu_lsa DESC) as rank_of_library
FROM pls_fy2018_libraries
WHERE visits > 250000;