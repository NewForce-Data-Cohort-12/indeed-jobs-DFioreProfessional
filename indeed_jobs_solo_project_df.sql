-- Indeed Jobs Solo Project

-- Test to confirm validity of Table
SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- Q1: How many rows are in the data analyst jobs table?
-- A: 1,793

SELECT COUNT(*)
FROM data_analyst_jobs;

-- Q2: Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
-- A: ExxonMobil

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- Q3: How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
-- A: 21 postings are in TN, 6 postings are in KY for a total of 27.

SELECT COUNT(state_abrv) AS state_count
FROM data_analyst_jobs
WHERE state_abrv = 'TN' OR state_abrv = 'KY';

-- Q4: How many postings in Tennessee have a star rating above 4?
-- A: 3 postings from TN have a rating above 4.

SELECT COUNT(star_rating) AS high_ratings_count
FROM data_analyst_jobs
WHERE star_rating > 4 AND state_abrv = 'TN';

-- Q5: How many postings in the dataset have a review count between 500 and 1000?
-- A: 150 postings

SELECT COUNT(review_count) AS mid_review_count
FROM data_analyst_jobs
WHERE review_count > 500 AND review_count < 1000;

-- Q6: Show the average star ratings for companies in each state. The output should show the state as 'state' and the average rating for the state as avg_rating. Which state shows the highest average rating?
-- A: NE shows the highest average rating at 4.20.

SELECT state_abrv, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
GROUP BY state_abrv
ORDER BY avg_rating DESC;

-- Q7: Select unique job titles from the data_analyst_jobs table. How many  are there?
-- A: There are 881 unique job titles.

SELECT DISTINCT title
FROM data_analyst_jobs;

-- Q8: How Many unique job titles are there for California companies?
-- A: There are 230 unique job titles for CA companies.

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE state_abrv = 'CA';

-- Q9: Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more than 5000 reviews across all locations?
-- A: There are 41 companies.

SELECT company, ROUND(AVG(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_rating DESC;

-- Q10: Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
-- A: code for #9 already includes this, highest star rating belongs to General Motors, and is 4.20 stars (rounded to the nearest two decimal places).

-- Q11: Find all the job titles that contain the word 'Analyst'. How many different job titles are there?
-- A: There are 774 different job titles.

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

-- Q12: How many different job titles do not contain either the word 'Analyst' or the word 'Analytics'? What word do these positions have in common?
-- A: There are 4 listings that contain neither word, they all mention 'Tableau'.

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
AND title NOT ILIKE '%Analytics%';

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of 'hard to fill' jobs is at the top.
-- Which three industries are in the top 4 on this list? How many jobs have bene listed for more than 3 weeks for each of the top 4?
-- A: The top 4 industries are Internet and Software, Banks and Financial Services, Consulting and Business Services, and Health Care. The number of jobs listed for each are 63, 63, 62 and 54 respectively. 

SELECT domain_all, COUNT(*) AS hard_to_fill_positions
FROM data_analyst_jobs
WHERE domain_all IS NOT NULL
AND skill ILIKE '%SQL%'
AND days_since_posting >= 21
GROUP BY domain_all
ORDER BY hard_to_fill_positions DESC;
