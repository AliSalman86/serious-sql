/* selecting everything from table "table_name" in schema "schema_name" */
SELECT * FROM dvd_rentals.language;

/* selecting columns column_name_1, column_name_2 from table "table_name" in schema "schema_name" */
SELECT language_id, name FROM dvd_rentals.language;

/* selecting everything from table "table_name" in schema "schema_name" and limit output to the first 10 records only */
SELECT * FROM dvd_rentals.actor LIMIT 10;

/* selecting the first 5 records in the column_name_1 column from table "table_name" by alphabetical order */
SELECT country FROM dvd_rentals.country ORDER BY country LIMIT 5;

/* Descending order */
SELECT total_sales FROM dvd_rentals.sales_by_film_category ORDER BY total_sales LIMIT 5;

SELECT country FROM dvd_rentals.country ORDER BY country DESC LIMIT 5;

SELECT category, total_sales FROM dvd_rentals.sales_by_film_category ORDER BY 2 LIMIT 1;

SELECT payment_date FROM dvd_rentals.payment ORDER BY payment_date DESC LIMIT 1;

/* 
1- Check if there is a table exist with name sample_table and delete if true;
2- Create a temp table called sample_table with raw_data in 3 columns (id, column_a, column_b) and fill with following values:
(1, 0, A),
(2, 0, B),
(5, 2, D),
(3, 1, C),
(6, 3, D),
(4, 1, D)

3- Select all values from raw_data
This script won't return anything as we didn't ask for anything
*/
DROP TABLE IF EXISTS sample_table;
CREATE TEMP TABLE sample_table AS
WITH raw_data (id, column_a, column_b) AS (
    VALUES
    (1, 0, 'A'),
    (2, 0, 'B'),
    (5, 2, 'D'),
    (3, 1, 'C'),
    (6, 3, 'D'),
    (4, 1, 'D')
)
SELECT * FROM raw_data;

/* Sort the above sample data by 2 columns ascending */
SELECT * FROM sample_table ORDER BY column_a, column_b;

/* Sort the data with column_a ascending, and column_b descending */
SELECT * FROM sample_table ORDER BY column_a, column_b DESC;
/* Notice when the order of columns after the ORDER BY change that would change the result output */
SELECT * FROM sample_table ORDER BY column_b, column_a DESC;
/* also sort for all columns can be in descending order */
SELECT * FROM sample_table ORDER BY column_a DESC, column_b DESC;

/* Employees seniority in years: the below script retuen the seniority for each employee in years by caculating difference between hiring day and current day */
SELECT
  first_name
  ,last_name
  ,hire_date
  ,DATE_PART('year', NOW()::date)-DATE_PART('year', hire_date::date) AS seniority_in_years
FROM employees.employee;

/* Records COUNT and DISTINCT values */
/* Records count example */
SELECT COUNT(*) AS rows_count FROM dvd_rentals.film_list;

/* Distinct values example */
SELECT DISTINCT rating AS dist_rating FROM dvd_rentals.film;

/* Distinct combination of multiple columns */
SELECT DISTINCT category, rating FROM dvd_rentals.film_list;

/* COUNT of DISTINCT values */
SELECT COUNT(DISTINCT category) AS unique_cat_count FROM dvd_rentals.film_list;

/* Count frequency of occurance, GROUP BY COUNT */
SELECT category, COUNT(*) AS frequency FROM dvd_rentals.film_list GROUP BY category

/* Employees seniority in years: This second script shows the frequency of employees with same years seniority */
SELECT
  DATE_PART('year', NOW()::date)-DATE_PART('year', hire_date::date) AS seniority_in_years
  ,COUNT(*)
FROM employees.employee
GROUP BY seniority_in_years
ORDER BY seniority_in_years DESC;

/* GROUP BY COUNT */
SELECT 
  rating, 
  COUNT(*) AS frequency
FROM dvd_rentals.film_list 
GROUP BY rating 
ORDER BY frequency DESC;

/* GROUP BY COUNT, calculating percentage */
SELECT 
  rating
  ,COUNT(*) AS frequency
  ,COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER() AS percentage
FROM dvd_rentals.film_list
GROUP BY rating
ORDER BY frequency DESC;