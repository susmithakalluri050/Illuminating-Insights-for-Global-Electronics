create database Project_2;
show databases;
use Project_2;

-- gender count
SELECT gender, COUNT(*) AS Count_gender
FROM customers
GROUP BY gender;


-- age bucketing
SELECT
    age_bucket,
    COUNT(*) AS count
FROM (
    SELECT
        *,
        CASE
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) <= 18 THEN '<=18'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 18 AND 25 THEN '18-25'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 25 AND 35 THEN '25-35'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 35 AND 45 THEN '35-45'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 45 AND 55 THEN '45-55'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 55 AND 65 THEN '55-65'
            ELSE '>65'
        END AS age_bucket
    FROM overall
) AS age_groups
GROUP BY age_bucket;


-- countery wise customer count
SELECT 
    continent,country,state,city, 
    COUNT(CustomerKey) AS customer_count
FROM 
    CUSTOMERS
GROUP BY 
    continent,country,state,city
ORDER BY 
    customer_count DESC
    
    
-- Catagory and sub catagory analysis
SELECT  category,subcategory,
    ROUND(SUM(unit_price_usd * quantity),2) AS total_sales
FROM overall
GROUP BY category,subcategoryIdentify the most and least popular products based on sales data.

##  Identify the most and least popular products based on sales data.
select distinct(product_name),sum(quantity) as Quantity
from overall
group by product_name
order by Quantity desc
limit 10

-- Sales Analysis
SELECT
  MONTHNAME(order_date) AS month,
  ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
  overall
GROUP BY
  MONTHNAME(order_date);
  
  
-- sales by top product performance

SELECT
  product_name,
  SUM(quantity) AS total_quantity
FROM
   overall
GROUP BY
  product_name
Order by total_quantity Desc  
Limit 10   

-- sales by revenue performance
SELECT
  product_name,
  ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
  overall
GROUP BY
  product_name
order by total_revenue_USD desc 
limit 10;

--  Storekey vs Country vs Continent vs State
SELECT
  storekey,Country,Continent,State,
  ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
  overall
GROUP BY
  storekey,Country,Continent,State
order by total_revenue_USD desc


-- store_age_bucket vs total sales    

SELECT
    CASE
        WHEN YEAR(CURDATE()) - YEAR(open_date) <= 5 THEN '<=5'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 6 AND  10 THEN '5 to 10'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 11 AND 15 THEN '10 to 15'
        WHEN YEAR(CURDATE()) - YEAR(open_date) BETWEEN 16 AND 20 THEN '15 to 20'
    END AS store_age_bucket,
    ROUND(SUM(unit_price_usd * quantity), 2) AS total_sales
FROM overall
GROUP BY store_age_bucket
ORDER BY store_age_bucket

-- sales by stores

SELECT
  storekey,
  ROUND(SUM((unit_price_usd)*quantity),2) AS total_revenue_USD
FROM
  overall
GROUP BY
  storekey
order by total_revenue_USD desc

