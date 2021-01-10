--DML Queries:

-- Average total units sold per year utilizing subqueries:

SELECT year_id, AVG(total_units_sold) 
FROM
(SELECT order_date, year_id, SUM(quantity) AS total_units_sold FROM date_info
JOIN order_info ON order_info.id = date_info.oi_id
JOIN sales_info ON sales_info.oi_id = order_info.id
WHERE year_id = 2003 OR year_id = 2004
GROUP BY order_date, year_id
)AS T
GROUP BY year_id;
-- 2003: 407.2 and 2004: 400.2

-- What is the total sales revenue year over year by week?

SELECT order_date, year_id, SUM(total_sales) AS total_sales_revenue FROM date_info
JOIN order_info ON order_info.id = date_info.oi_id
JOIN sales_info ON sales_info.oi_id = order_info.id
WHERE year_id = 2003 OR year_id = 2004
GROUP BY order_date, year_id
ORDER BY order_date;

--Average total sales revenue by year?

SELECT year_id, AVG(total_sales_revenue) 
FROM
(SELECT order_date, year_id, SUM(total_sales) AS total_sales_revenue FROM date_info
JOIN order_info ON order_info.id = date_info.oi_id
JOIN sales_info ON sales_info.oi_id = order_info.id
WHERE year_id = 2003 OR year_id = 2004
GROUP BY order_date, year_id
)AS T
GROUP BY year_id;
--2003: $41,376 and 2004: $40,377

--What time of year are our sales the highest?

SELECT qtr_id, month_id, ROUND(SUM(total_sales), 2) AS total_sales FROM date_info
JOIN order_info ON order_info.id = date_info.oi_id
JOIN sales_info ON sales_info.oi_id = order_info.id
WHERE year_id = 2003 OR year_id = 2004
GROUP BY qtr_id, month_id
ORDER BY ROUND(SUM(total_sales), 2) DESC;

--What is the most popular type of product sold? (based on units sold)

SELECT product_line, SUM(quantity) AS total_quantity FROM order_info
JOIN sales_info ON sales_info.oi_id = order_info.id
GROUP BY product_line
ORDER BY SUM(quantity) DESC;
-- Wound care supplies are the most popular type of product sold by the company. Nearly doubling in sales of the next most popular type of product.

--Highest and lowest average sales around the U.S? (used for map)

SELECT total_sales, address_line_1, city, state, zipcode FROM address_info
JOIN order_info ON order_info.id = address_info.oi_id
JOIN sales_info ON sales_info.oi_id = order_info.id;
--keep in mind that a longitude and latitude is still needed. Will calculate on Tableau.
