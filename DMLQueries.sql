--DML Queries:

--What is the total number of units sold year over year?

SELECT order_date, year_id, SUM(quantity) AS total_units_sold FROM date_info
JOIN order_info ON order_info.id = date_info.oi_id
JOIN sales_info ON sales_info.oi_id = order_info.id
GROUP BY order_date, year_id
ORDER BY order_date;

--What is the average total sales year over year?

SELECT order_date, year_id, ROUND(AVG(total_sales), 2) AS avg_total_sales FROM date_info
JOIN order_info ON order_info.id = date_info.oi_id
JOIN sales_info ON sales_info.oi_id = order_info.id
GROUP BY order_date, year_id
ORDER BY order_date;

--What time of year are our sales the highest?

SELECT qtr_id, month_id, ROUND(SUM(total_sales), 2) AS total_sales FROM date_info
JOIN order_info ON order_info.id = date_info.oi_id
JOIN sales_info ON sales_info.oi_id = order_info.id
GROUP BY qtr_id, month_id
ORDER BY ROUND(SUM(total_sales), 2) DESC;
-- Over the past 3 years, the total sales are the highest in Q4. Specifically in November generating $2,118,885.67 in total sales. 

--What was the gross revenue for each quarter between 2003-2005?

SELECT qtr_id, ROUND(SUM(total_sales), 2) AS total_sales FROM date_info
JOIN order_info ON order_info.id = date_info.oi_id
JOIN sales_info ON sales_info.oi_id = order_info.id
GROUP BY qtr_id
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
