-- Task 1.Creation of database and tables
CREATE DATABASE IF NOT EXISTS global_analysis;
USE global_analysis;

-- DROP DATABASE IF EXISTS global_analysis;

-- Create tables (gdp and covid tables) without foreign keys
SHOW DATABASES;

CREATE TABLE IF NOT EXISTS gdp_2020 (
    Country VARCHAR(100) PRIMARY KEY,
    Nominal_gdp_per_capita DECIMAL(15,3) NOT NULL,
    PPP_gdp_per_capita DECIMAL(15,3) NOT NULL,
    GDP_growth_percentage DECIMAL(5,3),
    Rise_fall_GDP VARCHAR(50)
);

ALTER TABLE gdp_2020 MODIFY Rise_fall_GDP VARCHAR(50);
show TABLES;
DESCRIBE table gdp_2020;
DROP table gdp_2020;

CREATE TABLE IF NOT EXISTS covid_19 (
    Country VARCHAR(100) PRIMARY KEY,
    Confirmed INT NOT NULL,
    Deaths INT NOT NULL,
    Recovered INT NOT NULL,
    Active INT NOT NULL,
    New_cases INT,
    New_deaths INT,
    New_recovered INT,
    WHO_Region VARCHAR(50)
);

-- Task 2. Loading data into the tables
LOAD DATA INFILE '/var/lib/mysql-files/gdp_2020.csv'
INTO TABLE gdp_2020
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load COVID data
LOAD DATA INFILE '/var/lib/mysql-files/covid_19.csv'
INTO TABLE covid_19
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT *
FROM covid_19;

USE global_analysis
-- Task 3. Countries in WHO within Europe with more than 10000 cases
SHOW COLUMNS FROM covid_19;
SELECT COUNT(*) 
FROM covid_19 
WHERE WHO_Region = 'Europe' AND Confirmed > 10000;

SELECT *
FROM covid_19 WHERE WHO_Region = 'Europe' ORDER BY Confirmed DESC LIMIT 20;
SELECT COUNT(DISTINCT Country) FROM covid_19 WHERE WHO_Region = 'Europe';

DELETE FROM covid_19 
WHERE Country NOT IN (SELECT Country FROM gdp_2020);

SELECT Country, Confirmed
FROM covid_19
WHERE WHO_Region = 'Europe'
  AND Confirmed > 10000;
  
UPDATE covid_19
SET WHO_Region = TRIM(REPLACE(REPLACE(REPLACE(WHO_Region, '\r', ''), '\n', ''), '\t', ''))
WHERE WHO_Region LIKE '%Europe%';
  
ALTER TABLE covid_19
ADD CONSTRAINT fk_covid_country
FOREIGN KEY (Country) REFERENCES gdp_2020(Country)
ON DELETE CASCADE
ON UPDATE CASCADE; 

-- Task 3. Countries from Europe with more than 10000 confirmed covid cases
SELECT 
    Country,
    Confirmed,
    Deaths,
    ROUND((Deaths * 100.0 / Confirmed), 2) AS death_rate_percentage
FROM 
    covid_19
WHERE 
    WHO_Region = 'Europe'
    AND CAST(Confirmed AS UNSIGNED) > 10000
ORDER BY 
    death_rate_percentage DESC;
    
-- Task 4: GDP growth rate & covid deaths for countries with GDP fall
USE global_analysis;

SELECT 
    g.country AS country,
    g.gdp_growth_percentage,
    c.Deaths AS Covid_deaths
FROM 
    gdp_2020 g
JOIN 
    covid_19 c ON g.country = c.country
WHERE 
    g.gdp_growth_percentage < 0
ORDER BY 
    g.gdp_growth_percentage ASC;

-- Task 5: Covid deaths Vs gdp per capita
-- First, we need to get the top 10% of GDP per capita

WITH ranked_gdp AS (
    SELECT 
        Country, 
        PPP_gdp_per_capita,
        NTILE(10) OVER (ORDER BY PPP_gdp_per_capita DESC) AS gdp_percentile
    FROM gdp_2020
),
-- Next, we write a query to get the top 10% of covid deaths
ranked_deaths AS (
    SELECT 
        Country, 
        Deaths,
        NTILE(10) OVER (ORDER BY Deaths DESC) AS death_percentile
    FROM covid_19
),
-- Then we get countries in the top 10% of gdp per capita
top_gdp AS (
    SELECT Country 
    FROM ranked_gdp
    WHERE gdp_percentile = 1
),
-- We are getting contries in the top 10% on covid deaths
top_deaths AS (
    SELECT Country 
    FROM ranked_deaths
    WHERE death_percentile = 1
),
-- Countries that are in either of the two; but not in both.
either_but_not_both AS (
        SELECT Country FROM top_gdp
        WHERE Country NOT IN (SELECT country FROM top_deaths)
    UNION
        SELECT Country FROM top_deaths
        WHERE Country NOT IN (SELECT country FROM top_gdp)
)
SELECT * 
FROM either_but_not_both;

-- Task 6: Find the AVE, MIN & MAX GDP growth %age from WHO regions with more than 5 countries. 

 SELECT 
    c.WHO_Region,
    COUNT(*) AS country_count,
    AVG(g.GDP_growth_percentage) AS avg_growth,
    MIN(g.GDP_growth_percentage) AS min_growth,
    MAX(g.GDP_growth_percentage) AS max_growth
FROM 
    gdp_2020 g
JOIN 
    covid_19 c ON g.Country = c.Country
WHERE 
    g.GDP_growth_percentage IS NOT NULL
GROUP BY 
    c.WHO_Region
HAVING 
    COUNT(*) > 5;
    
    -- Task 7: Economic impact score per country for the 10 worst hit.
USE global_analysis;

SELECT 
    c.Country,
    c.Deaths,
    g.GDP_growth_percentage,
    ROUND((c.Deaths * ABS(g.GDP_growth_percentage)) / 1000, 2) AS economic_impact_score
FROM 
    covid_19 c
JOIN 
    gdp_2020 g ON c.Country = g.Country
WHERE 
    c.Deaths IS NOT NULL 
    AND g.GDP_growth_percentage IS NOT NULL
ORDER BY 
    economic_impact_score DESC
LIMIT 10;

-- Task 8. List countries with GDP data, but not Covid data; put placeholder on Covid records.

-- Task 9. Economic implications of the results emanating from the above queries/tasks 3-7. 
-- Wealth does not equate to beng Immune to harsh effects of a pandemic. The rich countries were equally worst hit by high death tolls and also saw a decline in their economic situations. 
-- Health plays a big role in the economy of a country. Poor pandemic response led to/caused economies to be negatively affected. 
-- Missing data may lead to wrong interpretations of what measure needs to be taken to mitigate negative effects of a pandemic.
