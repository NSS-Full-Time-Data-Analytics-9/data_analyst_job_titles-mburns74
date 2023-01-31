--1.How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs;
-- 1793

--2.Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;
--ExxonMobil

--3.How many postings are in Tennessee? 

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';
-- 21

--How many are there in either Tennessee or Kentucky?

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location IN ('TN','KY');
-- 27

--How many postings in Tennessee have a star rating above 4?

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN'
AND star_rating > 4;
-- 3

--5.How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
-- 151

--6.Show the average star rating for companies in each state. 
--The output should show the state as `state` and the average rating for the state as `avg_rating`. 
--Which state shows the highest average rating?

SELECT DISTINCT location AS state,
	AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL --Added IS NOT NUll to remove Null values
GROUP BY location
ORDER BY avg_rating DESC; --Ordered by for ease of seeing who was on top. 
-- NE

--7.Select unique job titles from the data_analyst_jobs table. 

SELECT DISTINCT title
FROM data_analyst_jobs;

--How many are there?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;
--881

--8.How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';
--230

--9.Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations.

SELECT company,
	AVG(star_rating) AS avg_star_rating,
	SUM(review_count) AS total_review_count
FROM data_analyst_jobs
WHERE review_count > 5000
	AND company IS NOT NULL --Added to remove null company name
GROUP BY company;


--How many companies are there with more that 5000 reviews across all locations?

SELECT COUNT(company)AS comp_w_more_than_5000,
	SUM(review_count) AS sum_review_count
FROM data_analyst_jobs
WHERE review_count > 5000
	AND company IS NOT NULL;
--184

--10.Add the code to order the query in #9 from highest to lowest average star rating. 
--Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? 
--What is that rating?

SELECT company,
	AVG(star_rating) AS avg_star_rating,
	SUM(review_count) AS total_review_count
FROM data_analyst_jobs
WHERE review_count > 5000
	AND company IS NOT NULL --Added to remove null company name
GROUP BY company
ORDER BY avg_star_rating DESC;
--4.1999998090000000

--11.	Find all the job titles that contain the word ‘Analyst’. 

SELECT title AS job_title_with_analyst
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';

--How many different job titles are there?

SELECT COUNT(DISTINCT title) AS count_job_title_with_analyst
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';
--754

12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? 

SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE title NOT LIKE '%Analyst%' 
	AND title NOT LIKE '%Analytics%';

--What word do these positions have in common?
-- "WHERE NOT LIKE" statement is CASE Sensitive. Those in ALL CAPS were not removed.

--BONUS--
--You want to understand which jobs requiring SQL are hard to fill. 
--Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
--Disregard any postings where the domain is NULL. 
--Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
--Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT DISTINCT domain,COUNT(DISTINCT title) AS hard_to_fill
FROM data_analyst_jobs
WHERE skill LIKE '%SQL%' 
	AND days_since_posting > 21 
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY hard_to_fill DESC;

---Internet/Software, Health Care, Services - Banks and Financial Services & Consulting and Business Services---
--- 151


