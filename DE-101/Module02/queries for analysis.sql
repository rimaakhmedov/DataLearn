-- Sales per Customer

SELECT
customer_name,
round(SUM(sales),2) as sales_per_customer 
FROM orders
GROUP BY customer_name
ORDER BY customer_name asc;


--Monthly Sales by Category

SELECT EXTRACT (year from order_date) as year,
EXTRACT (month from order_date) as month,
category,
round(SUM(sales)) as sales_by_category
FROM orders
GROUP BY year, month, category
ORDER BY year, month, category asc;


--Monthly Sales by Segment

SELECT EXTRACT (year from order_date) as year,
EXTRACT (month from order_date) as month,
segment,
round(SUM(sales)) as sales_by_segment
FROM orders
GROUP BY year, month, segment
ORDER BY year, month, segment asc;


--Sales and Profit by Customer

SELECT customer_name,
round(SUM(sales)) as sales_per_customer,
round(SUM(profit),2) as profit_per_customer
FROM orders
GROUP BY customer_name
ORDER BY customer_name asc;

--TOP 10 profit

SELECT customer_name,
round(SUM(profit)) as profit_per_customer
FROM orders
GROUP BY customer_name
ORDER BY profit_per_customer desc
limit 10;





