CREATE DATABASE swiggy_analysis;
USE swiggy_analysis;

-- Verify Dataset
SELECT * FROM swiggy
LIMIT 10;

-- Replace null values
UPDATE swiggy
SET `Food type` = 'Paneer Tikka'
WHERE TRIM(`Food type`) = ''
OR `Food type` IS NULL;

-- Total Restaurants
SELECT COUNT(DISTINCT Restaurant) 
FROM swiggy;

-- Total cities
SELECT COUNT(DISTINCT City)
FROM swiggy;

-- Different food type
SELECT DISTINCT `Food Type`
FROM swiggy;

-- ANALYSIS_1

-- top 10 high rated restaurants
SELECT Restaurant,
AVG(`Avg ratings`) AS avg_rating,
SUM(`Total ratings`) AS Total_reviews
FROM swiggy
GROUP BY Restaurant
HAVING Total_reviews > 1000
ORDER BY avg_rating DESC
LIMIT 10;

-- Cities with more restaurants
SELECT City, 
COUNT(DISTINCT Restaurant) AS Total_Restaurants
FROM swiggy
GROUP BY City
ORDER BY Total_Restaurants DESC;

-- Average delivery time by city
SELECT City,
AVG(`Delivery Time`) AS avg_delivery_time
FROM swiggy
GROUP BY City
ORDER BY avg_delivery_time ASC;

-- ANALYSIS_2

-- Expensive Resturant
SELECT Restaurant,
AVG(`Price`) AS avg_pricing
FROM swiggy
GROUP BY Restaurant
ORDER BY avg_pricing DESC
LIMIT 10;

-- Restaurant count by food type
SELECT `Food Type`,
COUNT(*) AS total_Restaurants
FROM swiggy
GROUP BY `Food Type`
ORDER BY Total_Restaurants DESC
LIMIT 10;

-- High rated food type based on ratings 
SELECT `Food Type`,
AVG(`Avg ratings`) AS High_rated,
SUM(`Total ratings`) AS total_review
FROM swiggy
GROUP BY `Food Type`
HAVING total_review > 100
ORDER BY High_rated DESC;

-- High rated restaurants in Bangalore
SELECT DISTINCT Restaurant,
City,
`Avg ratings`
FROM swiggy
WHERE City = 'Bangalore'
AND `Avg ratings` > 4.5
ORDER BY `Avg ratings` DESC;

-- Categorize restaurants by pricing
SELECT DISTINCT Restaurant,
Price,
CASE
    WHEN Price < 200 THEN 'Budget'
    WHEN Price BETWEEN 200 AND 500 THEN 'Mid-Range'
    ELSE 'Premium'
END AS price_category
FROM swiggy;

-- Restaurants with above average pricing
SELECT Restaurant,
Price
FROM swiggy
WHERE Price >
(
    SELECT AVG(Price)
    FROM swiggy
);

-- Rank Resturant based on Price
SELECT Restaurant,
City,
Price,
RANK() OVER(ORDER BY Price DESC) AS price_rank
FROM swiggy;







