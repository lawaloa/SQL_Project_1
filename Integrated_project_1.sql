/*This query below shows all the tables in our database*/;

SHOW TABLES;

/*There are 8 tables in the md_water_services database and they includes: data_dictionary, employee, global_water_access, location, visits, water_quality, water_source, and water_pollution. These queries below retrieve the first five records from each table.*/;
 
SELECT
	*
FROM
	md_water_services.employee
LIMIT 5;

SELECT
	*
FROM
	md_water_services.global_water_access
LIMIT 5;

SELECT
	*
FROM
	md_water_services.location
LIMIT 5;


SELECT
	*
FROM
md_water_services.visits
LIMIT 5;


SELECT
	*
FROM
    md_water_services.water_quality
LIMIT 5;

SELECT
	*
FROM
md_water_services.water_source
LIMIT 5;

SELECT
	*
FROM
	md_water_services.well_pollution
LIMIT 5;

/*There are 8 tables in the md_water_services database and they includes: data_dictionary, employee, global_water_access, location, visits, water_quality, water_source, and well_pollution.*/;

/*Now that you're familiar with the structure of the tables, let's dive deeper. We need to understand the types of water sources we're
dealing with. Can you figure out which table contains this information? Once you've identified the right table, write a SQL query to find all the unique types of water sources.*/;

SELECT DISTINCT
	type_of_water_source
FROM
	water_source;


/*3. Unpack the visits to water sources: We have a table in our database that logs the visits made to different water sources. Can you identify this table? Write an SQL query that retrieves all records from this table where the time_in_queue is more than some crazy time, say 500 min. How
would it feel to queue 8 hours for water?*/;

SELECT
	*
FROM
md_water_services.visits
WHERE
	time_in_queue > 500;



/*I am wondering what type of water sources take this long to queue for. We will have to find that information in another table that lists the types of water sources. If I remember correctly, the table has type_of_water_source, and a source_id column. So let's write
down a couple of these source_id values from our results, and search for them in the other table.
AkKi00881224
SoRu37635224
SoRu36096224*/;

SELECT 
	*
FROM 
	water_source
WHERE source_id IN ('AkKi00881224', 'SoRu37635224', 'SoRu36096224');


-- If we just select the first couple of records of the visits table without a WHERE filter, we can see that some of these rows also have 0 mins queue time. So let's write down one or two of these too.

SELECT 
	source_id, 
    time_in_queue
FROM 
	visits
WHERE 
	time_in_queue  = 0
LIMIT 5;


/*4. Assess the quality of water sources:
The quality of our water sources is the whole point of this survey. We have a table that contains a quality score for each visit made
about a water source that was assigned by a Field surveyor. They assigned a score to each source from 1, being terrible, to 10 for a
good, clean water source in a home. Shared taps are not rated as high, and the score also depends on how long the queue times are.

So please write a query to find records where the subject_quality_score is 10 -- only looking for home taps -- and where the source was visited a second time. What will this tell us?*/

SELECT
	*
FROM 
	water_quality
WHERE
	subjective_quality_score = 10
    AND visit_count =2;




/*5. Investigate pollution issues:
Did you notice that we recorded contamination/pollution data for all of the well sources? Find the right table and print the first few rows.

Find the right table and print the first few rows.*/;

SELECT 
* 
FROM 
well_pollution 
LIMIT 5;

-- write a query that checks if the results is Clean but the biological column is > 0.01.

SELECT 
* 
FROM 
well_pollution 
WHERE 
results = 'Clean' 
AND biological > 0.01;

/*If we compare the results of this query to the entire table it seems like we have some inconsistencies in how the well statuses are
recorded. Specifically, it seems that some data input personnel might have mistaken the description field for determining the cleanliness of the water.

To Find these descriptions, search for the word Clean with additional characters after it. As this is what separates incorrect descriptions from the records that should have "Clean".*/

SELECT 
* 
FROM 
well_pollution 
WHERE 
description LIKE 'Clean%' 
AND biological > 0.01;

/*Now, when we change any data on the database, we need to be SURE there are no errors, as this could fill the database with incorrect
values. A safer way to do the UPDATE is by testing the changes on a copy of the table first.

The CREATE TABLE new_table AS (query) approach is a neat trick that allows you to create a new table from the results set of a query.
This method is especially useful for creating backup tables or subsets without the need for a separate CREATE TABLE and INSERT INTO
statement.*/;

CREATE TABLE
md_water_services.well_pollution_copy
AS (
SELECT
*
FROM
md_water_services.well_pollution);


/*Looking at the results we can see two different descriptions that we need to fix:
1. All records that mistakenly have Clean Bacteria: E. coli should updated to Bacteria: E. coli
2. All records that mistakenly have Clean Bacteria: Giardia Lamblia should updated to Bacteria: Giardia Lamblia*/;

SET SQL_SAFE_UPDATES = 0;

-- Case 1a
UPDATE well_pollution_copy
-- Update well_pollution table
SET description = 'Bacteria: E. coli'
-- Change description to'Bacteria: E. coli'
WHERE description LIKE 'Clean Bacteria: E. coli';
-- Where the description is `Clean Bacteria: E. coli`

-- Case 1b
UPDATE well_pollution_copy
-- Update well_pollution table
SET description = 'Bacteria: Giardia Lamblia'
-- Change description to'Bacteria: Giardia Lamblia'
WHERE description LIKE 'Clean Bacteria: Giardia Lamblia';
-- Where the description is `Clean Bacteria: E. coli`

/*The second issue we need to fix is in our results column. We need to update the results column from Clean to Contaminated: Biological
where the biological column has a value greater than 0.01.*/;

-- Case 2
UPDATE well_pollution_copy
-- Update well_pollution table
SET results = 'Contaminated: Biological'
-- Change description to `Contaminated: Bacteria'
WHERE biological > 0.01 AND results = 'Clean';
-- Where the biological is > 0.01 and results Clean

/*We can then check if our errors are fixed using a SELECT query on the well_pollution_copy table:*/;

SELECT
*
FROM
well_pollution_copy
WHERE
description LIKE "Clean_%"
OR (results = "Clean" AND biological > 0.01);


/*Then if we're sure it works as intended, we can change the table back to the well_pollution and delete the well_pollution_copy
table.*/;

DROP TABLE
Md_water_services.well_pollution_copy;


-- Integrated project: Maji Ndogo part 1 [MCQ]

-- 1. What is the address of Bello Azibo?

SELECT
	employee_name,
           address
FROM 
	employee
WHERE
	employee_name = 'Bello Azibo';

-- 2. What is the name and phone number of our Microbiologist?

SELECT DISTINCT
    position
FROM 
	Employee;


SELECT
	employee_name,
     phone_number,
     position
FROM
employee
WHERE
	position = 'Micro Biologist';

-- 3. What is the source_id of the water source shared by the most number of people? Hint: Use a comparison operator.

SELECT * FROM md_water_services.water_source ;

-- 4. What is the population of Maji Ndogo?

SELECT SUM(number_of_people_served) AS total_population
FROM water_source;

-- Total Population is 27628140

-- 5. Which SQL query returns records of employees who are Civil Engineers residing in Dahabu or living on an avenue?

SELECT *
FROM employee
WHERE position = 'Civil Engineer'
     AND (province_name = 'Dahabu' OR address LIKE '%Avenue%');


/*6. Create a query to identify potentially suspicious field workers based on an anonymous tip. This is the description we are given:
 The employee’s phone number contained the digits 86 or 11. 
The employee’s last name started with either an A or an M. 
The employee was a Field Surveyor.*/;

SELECT *
FROM md_water_services.employee
WHERE
  (phone_number LIKE '%86%' OR phone_number LIKE '%11%')
  AND (
    SUBSTRING_INDEX(employee_name, ' ', -1) LIKE 'A%'
    OR SUBSTRING_INDEX(employee_name, ' ', -1) LIKE 'M%'
  )
  AND position = 'Field Surveyor';


-- 7. This Counts the number of rows based on the conditions specify

SELECT COUNT(*) AS total_records
FROM well_pollution
WHERE description LIKE 'Clean_%' OR results = 'Clean' AND biological < 0.01;

-- 8. You have been given a task to correct the phone number for the employee named 'Bello Azibo'. The correct number is +99643864786. Write the SQL query to accomplish this. Note: Running these queries on the employee table may create issues later, so use the knowledge you have learned to avoid that.


UPDATE employee_copy
SET phone_number = '+99643864786'
WHERE employee_name = 'Bello Azibo';


-- 9. How many rows of data are returned for the following query?
SELECT *
FROM well_pollution
WHERE description
IN ('Parasite: Cryptosporidium', 'biologically contaminated')
OR (results = 'Clean' AND biological > 0.01);

