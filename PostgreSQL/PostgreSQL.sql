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
