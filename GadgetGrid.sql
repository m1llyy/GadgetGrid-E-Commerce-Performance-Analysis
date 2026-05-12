-- Adhoc questions and queries

-- What is the date of the earliest and latest order?
SELECT MAX (purchase_ts) AS latest, MIN (purchase_ts) AS earliest
FROM core.orders;

-- What is the average order value for purchases made in USD? What about average order value for purchases made in USD in 2019?
SELECT AVG (usd_price)
FROM core.orders
WHERE currency LIKE 'USD';

SELECT AVG (usd_price)
FROM core.orders
WHERE EXTRACT (YEAR from purchase_ts) = 2019;


-- Return the id, loyalty program status, and account creation date for customers who made an account on desktop or mobile. Rename the columns to more descriptive names.
SELECT id AS customer_id, loyalty_program AS loyalty_status, created_on AS creation_date
FROM core.customers
WHERE account_creation_method LIKE 'desktop' OR account_creation_method LIKE 'mobile';


-- What are all the unique products that were sold in AUD on website, sorted alphabetically?
SELECT DISTINCT (product_name)
FROM core.orders
WHERE currency LIKE 'AUD' AND purchase_platform LIKE 'website'
ORDER BY product_name ASC;


-- What are the first 10 countries in the North American region, sorted in descending alphabetical order?
SELECT country_code
FROM core.geo_lookup
WHERE region LIKE 'NA'
ORDER BY country_code ASC
LIMIT 10;


-- What is the total number of orders by shipping month, sorted from most recent to oldest?
SELECT COUNT(id), EXTRACT(MONTH from purchase_ts) AS month
FROM core.orders
GROUP BY month
ORDER BY month ASC;


-- What is the average order value by year? Can you round the results to 2 decimals?
SELECT ROUND (AVG(usd_price), 2), EXTRACT (YEAR FROM purchase_ts) AS year
FROM core.orders
GROUP BY year;


-- Refund status
SELECT *, IF(refund_ts IS NULL, 0, 1) AS is_refund
FROM core.order_status
LIMIT 20;


-- Return the product IDs and product names of all Apple products.
SELECT DISTINCT product_name, product_id
FROM core.orders
WHERE product_name IN ('Apple Airpods Headphones', 'Apple iPhone', 'Macbook Air Laptop');


-- Calculate the time to ship in days for each order
SELECT *, DATE_DIFF(ship_ts, purchase_ts, DAY) AS time_ship
FROM core.order_status;


-- Throughout 2019-2020, how many macbooks were ordered in usd?
SELECT COUNT (id) AS order_count, EXTRACT (YEAR FROM purchase_ts) AS purchase_year
FROM core.orders
WHERE currency LIKE 'USD' AND 
  EXTRACT (YEAR FROM purchase_ts) IN (2019, 2020)
  AND product_name LIKE 'Macbook Air Laptop'
GROUP BY EXTRACT (YEAR FROM purchase_ts);


-- What were the order counts and total sales in USD for macbooks every year?
SELECT COUNT(id) AS order_counts, SUM(usd_price) AS total_sales, EXTRACT (YEAR FROM purchase_ts) AS year
FROM core.orders
WHERE product_name LIKE 'Macbook Air Laptop'
GROUP BY year;


-- Return the purchase_month, shipping month, time to ship (in days) and product name for each order placed in 2020
SELECT EXTRACT (MONTH FROM os.purchase_ts) AS purchase_month, EXTRACT (MONTH FROM os.ship_ts) AS ship_month, DATE_DIFF(os.ship_ts, os.purchase_ts, DAY) AS ship_time, orders.product_name
FROM core.order_status AS os
INNER JOIN core.orders AS orders ON os.order_id = orders.id
WHERE os.purchase_ts BETWEEN '2020-01-01' AND '2020-12-31'

  
-- What is the average order value per year for products that are NOT laptops or headphones? Round this to 2 decimals.
SELECT EXTRACT (YEAR FROM purchase_ts) AS year, ROUND (avg (usd_price), 2) AS AOV
FROM core.orders
WHERE lower(product_name) NOT LIKE '%laptop%' AND lower(product_name) NOT LIKE '%headphones'
GROUP BY year

  
-- How many **refunds** were there for **each month in 2021**? What about each quarter and week?
SELECT COUNT (os.refund_ts) AS refund_count
FROM core.order_status AS os
WHERE EXTRACT (YEAR FROM purchase_ts) AS year


-- What was the most-purchased brand in the APAC region?
SELECT COUNT (o.id) AS order_count, 
  CASE WHEN product_name LIKE 'Apple%' OR product_name LIKE 'Macbook%' THEN 'Apple'
  WHEN product_name LIKE 'Samsung%' THEN 'Samsung'
  WHEN product_name LIKE 'ThinkPad%' THEN 'ThinkPad'
  WHEN product_name LIKE 'bose%' THEN 'Bose'
  ELSE 'Unknown' END AS brand, 
  
FROM core.orders AS o
LEFT JOIN core.customers AS c ON o.customer_id = c.id
LEFT JOIN core.geo_lookup AS g ON g.country_code = c.country_code
WHERE g.region = 'APAC'    
GROUP BY product_name
ORDER BY order_count DESC
LIMIT 1

  
-- Within each purchase platform, what are the top two marketing channels ranked by average order value?
with marketing_cte AS (
  SELECT AVG (usd_price) as aov, o.purchase_platform, c.marketing_channel
  FROM core.orders AS o
  LEFT JOIN core.customers AS c ON c.id = o.customer_id
  GROUP BY  2, 3
),

ranking_cte AS (
  SELECT *, 
  row_number() over (partition BY purchase_platform ORDER BY aov DESC) AS ranking
  FROM marketing_cte
)

SELECT *
FROM ranking_cte
WHERE RANKING <=2


-- For each supplier, what is the most popular product?
WITH supplier_cte AS (
  SELECT COUNT (o.id) AS num_sold, s.supplier, s.product_name
  FROM core.orders AS o
  LEFT JOIN core.suppliers AS s USING (product_name, product_id)
  GROUP BY supplier, 3
),

ranking_cte AS (
  SELECT *, row_number() over (PARTITION BY supplier ORDER BY num_sold DESC) AS ranking
  FROM supplier_cte
)

SELECT *
FROM ranking_cte
WHERE ranking = 1


-- What were the order counts, sales, and AOV for Macbooks sold in North America for each quarter across all years? 
WITH quarterly_metrics AS (
  
  SELECT COUNT (DISTINCT o.id) AS order_count, ROUND(SUM (usd_price), 2) AS sales, ROUND (avg (usd_price), 2) AS AOV, date_trunc (purchase_ts, quarter) AS quarter
  FROM core.orders AS o
  LEFT JOIN core.customers AS c ON o.customer_id = c.id
  LEFT JOIN core.geo_lookup AS g ON g.country_code = c.country_code
  WHERE g.region = 'NA' AND LOWER(o.product_name) LIKE '%macbook%'
  GROUP BY quarter
  ORDER BY quarter ASC
)

SELECT AVG(order_count) AS average_units_sold_per_quarter, AVG (sales) AS average_sales_per_quarter
FROM quarterly_metrics


-- 2) For products purchased in 2022 on the website or products purchased on mobile in any year, which region has the average highest time to deliver? 
SELECT AVG (date_diff(os.delivery_ts, os.purchase_ts, DAY)) AS average_time_to_deliver, g.region
FROM core.orders AS o
LEFT JOIN core.order_status AS os ON os.order_id = o.id
LEFT JOIN core.customers AS c ON o.customer_id = c.id
LEFT JOIN core.geo_lookup AS g ON c.country_code = g.country_code
WHERE (EXTRACT (YEAR FROM o.purchase_ts) = 2022 AND o.purchase_platform = 'website') OR (o.purchase_platform = 'mobile')  
GROUP BY g.region
ORDER BY average_time_to_deliver DESC;


-- 3) What was the refund rate and refund count for each product overall? 
SELECT CASE WHEN product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor' ELSE product_name END AS product_clean, avg(is_refund) AS refund_rate, sum (is_refund) AS refund_count
FROM 
  (SELECT IF(refund_ts IS NULL, 0, 1) as is_refund, product_name
    FROM core.order_status as os
    LEFT JOIN core.orders as o ON o.id = os.order_id
  )
GROUP BY product_clean
ORDER BY refund_rate DESC;


-- Within each region, what is the most popular product? 
WITH order_count_cte AS (
  SELECT COUNT(o.id) AS total_count, CASE WHEN product_name = '27in"" 4k gaming monitor' THEN '27in 4K gaming monitor' ELSE product_name END AS product_clean, g.region
  FROM core.orders AS o
  LEFT JOIN core.customers as c ON o.customer_id = c.id
  LEFT JOIN core.geo_lookup as g ON g.country_code = c.country_code
  GROUP BY product_clean, g.region
),

 ranking_cte AS (
  SELECT *, 
    row_number() over (partition BY region ORDER BY total_count DESC) AS ranking
  FROM order_count_cte)

SELECT *
FROM ranking_cte
WHERE ranking = 1;


-- How does the time to make a purchase differ between loyalty customers vs. non-loyalty customers? 
SELECT AVG (DATE_DIFF(o.purchase_ts, c.created_on, DAY)) AS time_to_purchase_days, AVG (DATE_DIFF(o.purchase_ts, c.created_on, MONTH)) AS time_to_purchase_months, c.loyalty_program
FROM core.orders AS o
LEFT JOIN core.customers AS c ON c.id = o.customer_id
GROUP BY c.loyalty_program;


-- For each purchase platform, return the top 3 customers by the number of purchases and order them within that platform. If there is a tie, break the tie using any order. 
WITH purchase_count_cte AS (
  
  SELECT COUNT (DISTINCT o.id) AS num_purchases, o.purchase_platform, customer_id
  FROM core.orders AS o
  LEFT JOIN core.customers AS c ON c.id = o.customer_id
  GROUP BY purchase_platform, 3
),

ranking_cte AS (
  SELECT *, 
    row_number() over (partition BY purchase_platform ORDER BY num_purchases DESC) AS order_ranking
  FROM purchase_count_cte)

SELECT *
FROM ranking_cte
WHERE order_ranking <= 3


-- Who was the supplier for the product in each order? Use an explicit join on all necessary columns.
SELECT o.product_name, s.supplier
FROM core.orders AS o
INNER JOIN core.suppliers AS s ON s.product_id = o.product_id AND o.product_name = s.product_name
GROUP BY 1, 2;
