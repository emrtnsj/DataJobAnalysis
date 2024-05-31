CREATE DATABASE IF NOT EXISTS pro_data;
USE pro_data;

DROP TABLE IF EXISTS data_job_analysis;
CREATE TABLE data_job_analysis (
    work_year INT,
    job_title VARCHAR(100),
    job_category VARCHAR(50),
    salary_currency VARCHAR(10),
    salary INT,
    salary_in_usd INT,
    employee_residence VARCHAR(50),
    experience_level VARCHAR(20),
    employment_type VARCHAR(20),
    work_setting VARCHAR(20),
    company_location VARCHAR(50),
    company_size VARCHAR(20)
);


-- ALTER TABLE data_job_analysis
-- ADD COLUMN job_id INT AUTO_INCREMENT PRIMARY KEY;
SELECT * FROM data_job_analysis;


SELECT job_title, AVG(salary_in_usd) AS average_salary
FROM data_job_analysis
GROUP BY job_title
ORDER BY average_salary DESC;

SELECT job_category, MAX(salary_in_usd), MIN(salary_in_usd) 
FROM data_job_analysis
GROUP BY job_category;

-- 1st hypothesis
SELECT work_year, ROUND(AVG(salary_in_usd)/1000,2) AS average_sal
FROM data_job_analysis
GROUP BY work_year ORDER BY work_year;

-- 2nd hypothesis
SELECT employment_type, ROUND(AVG(salary_in_usd)/ 1000, 2) as average_salary_in_K, job_category FROM data_job_analysis
WHERE job_category LIKE "%Data%"
GROUP BY employment_type, job_category
ORDER BY employment_type, average_salary_in_K DESC;

-- 3thrd ypothesis
-- by employee residence
SELECT
   CASE
        WHEN employee_residence IN ('United States', 'Canada') THEN 'North America'
        WHEN employee_residence IN ('Germany', 'United Kingdom', 'Spain', 'Ireland', 'Poland', 'France', 'Netherlands', 'Luxembourg', 'Lithuania', 'Portugal', 'Gibraltar', 'Ukraine', 'Slovenia', 'Romania', 'Greece', 'Latvia', 'Russia', 'Italy', 'Estonia', 'Czech Republic', 'Denmark', 'Sweden', 'Switzerland', 'Andorra', 'Finland', 'Croatia', 'Bosnia and Herzegovina', 'Austria', 'Belgium', 'Malta') THEN 'Europe'
        WHEN employee_residence IN ('India', 'South Korea', 'Brazil', 'Qatar', 'Kenya', 'Ghana', 'Turkey', 'Israel', 'Nigeria', 'Saudi Arabia', 'Argentina', 'Japan', 'Central African Republic', 'Singapore', 'Armenia', 'Pakistan', 'Iran', 'Bahamas', 'Puerto Rico', 'American Samoa', 'Thailand', 'Philippines', 'Egypt', 'Indonesia', 'United Arab Emirates', 'Malaysia', 'Honduras', 'Algeria', 'Iraq', 'China', 'Moldova') THEN 'Asia'
        ELSE 'Other' 
	END AS region,
  COUNT(employee_residence) as number_of_jobs_in_residence,  ROUND(AVG(salary_in_usd)/1000,2) AS average_salary FROM data_job_analysis
WHERE job_category LIKE '%Data%'
GROUP BY region
ORDER BY average_salary DESC;

-- by company location
SELECT
   CASE
        WHEN company_location IN ('United States', 'Canada') THEN 'North America'
        WHEN company_location IN ('Germany', 'United Kingdom', 'Spain', 'Ireland', 'Poland', 'France', 'Netherlands', 'Luxembourg', 'Lithuania', 'Portugal', 'Gibraltar', 'Ukraine', 'Slovenia', 'Romania', 'Greece', 'Latvia', 'Russia', 'Italy', 'Estonia', 'Czech Republic', 'Denmark', 'Sweden', 'Switzerland', 'Andorra', 'Finland', 'Croatia', 'Bosnia and Herzegovina', 'Austria', 'Belgium', 'Malta') THEN 'Europe'
        WHEN company_location IN ('India', 'South Korea', 'Brazil', 'Qatar', 'Kenya', 'Ghana', 'Turkey', 'Israel', 'Nigeria', 'Saudi Arabia', 'Argentina', 'Japan', 'Central African Republic', 'Singapore', 'Armenia', 'Pakistan', 'Iran', 'Bahamas', 'Puerto Rico', 'American Samoa', 'Thailand', 'Philippines', 'Egypt', 'Indonesia', 'United Arab Emirates', 'Malaysia', 'Honduras', 'Algeria', 'Iraq', 'China', 'Moldova') THEN 'Asia'
        ELSE 'Other' 
	END AS region,
  COUNT(company_location) as number_of_jobs_comploc,  ROUND(AVG(salary_in_usd)/1000,2) AS average_salary FROM data_job_analysis
WHERE job_category LIKE '%Data%'
GROUP BY region
ORDER BY average_salary DESC;

-- earnings per job_category
SELECT job_category, 
	   COUNT(*) AS num_employees,
       ROUND(MAX(salary_in_usd)/ 1000, 2) AS max_salary, 
       ROUND(MIN(salary_in_usd)/ 1000, 2) AS min_salary FROM data_job_analysis
WHERE job_category LIKE '%Data%' 
GROUP BY job_category
ORDER BY max_salary DESC;

-- experience level salary
SELECT 
    experience_level, 
    ROUND(AVG(salary_in_usd)/ 1000, 2) AS avg_salary_usd,
    ROUND(MIN(salary_in_usd)/ 1000, 2) AS min_salary_usd,
    ROUND(MAX(salary_in_usd)/ 1000, 2) AS max_salary_usd,
    COUNT(*) AS num_employees
FROM 
    data_job_analysis
GROUP BY 
    experience_level
ORDER BY 
    avg_salary_usd DESC;
    
    
-- work setting
SELECT
    work_year,
    work_setting,
    COUNT(*) AS job_count
FROM
    data_job_analysis
GROUP BY
    work_year,
    work_setting
ORDER BY
    work_year, work_setting;
    

