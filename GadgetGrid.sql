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
SELECT EXTRACT (year from purchase_ts) as year, ROUND (avg (usd_price), 2) as AOV
FROM core.orders
WHERE lower(product_name) NOT LIKE '%laptop%' AND lower(product_name) NOT LIKE '%headphones'
GROUP BY year

  
-- How many **refunds** were there for **each month in 2021**? What about each quarter and week?
SELECT COUNT (os.refund_ts) AS refund_count
FROM core.order_status AS os
WHERE EXTRACT (YEAR FROM purchase_ts) AS year




