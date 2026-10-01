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

