-- SQL Project 1 done by BT --
USE ironman;

-- Drop table if it exists --
DROP TABLE IF EXISTS ironman;

-- Create Table --
CREATE TABLE sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);


select * from sales ;

--it is used to get the count
select 
count(*)
from sales;

select * from sales
where transaction_id is NULL;

select * from sales
where sale_date is NULL;

select * from sales
where 
transaction_id is NULl 
or 
sale_date is NULL 
or  
gender Is NULL 
or  
category is NULL OR 
cogs  is NULL
or total_sale is NULL;

--data cleaning
------------------------------------------------------
DELETE from sales 

where sale_date is NULL;

select * from sales
where 
transaction_id is NULl 
or 
sale_date is NULL 
or  
gender Is NULL 
or  
category is NULL OR 
cogs  is NULL
or total_sale is NULL;

--DATA EXPLORATION
------------------------------------------------------------------
--how many sales we have?
select count(*) as total_sale from sales;

--how many unique customers we have 
select count(DISTINCT customer_id) as total_sale from sales;

select DISTINCT category form FROM sales;

--Data Analysis & Business key problems & Answers

--1.Write a sql query to retrieve all columns for sales made on '2022-11-05'
select * from sales
where sale_date='2022-11-05';
--2.Write a sql query to retrieve all transactions where the category is 'clothing'
--and the quantity is more than 10 in the month of 'Nov-2022

SELECT category, SUM(quantity)
FROM sales
WHERE category = 'Clothing'
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
AND quantity >= 4
GROUP BY category;

---3.Write a sql query to calculate the total sales (total_sales) for each category
SELECT category,
sum(total_sale) as net_sale,
count(*) as total_orders
 from sales
 GROUP BY 1;

--4.Write a SQL query to find the average age of customers who purchased items from the "beauty" category
select AVG(age)
as avg_age FRom sales 
where category='Beauty';

--5.Write a sql query to  find all transactions where th total_sale is greater than 1000 
select * from sales 
where total_sale >1000;
--6.Write a sql query to find the total number of transactions (transaction_id) made by each gender tin each category

select category,
gender ,
count(*) as total_trans
from sales
GROUP BY
category,gender;
--7.Write a sql query to calculate the average for each month.FInd out best selling month in each year

-- SELECT 
--     YEAR(sale_date) AS year,
--     MONTH(sale_date) AS month,
--     AVG(total_sale) AS avg_sale,
--     RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS `rank`
-- FROM sales 
-- GROUP BY YEAR(sale_date), MONTH(sale_date)
-- ORDER BY YEAR(sale_date), avg_sale DESC;

--8.Write a SQL query to find the top 5 customers based on the highest total sales

select customer_id,
sum(total_sale) as total_sales
from  sales
GROUP BY 1
order by 2 desc;

--9.Write a sql query to find the number of unique customers who purchased items from each category
SELECT category, 
       MAX(customer_id) AS example_customer
FROM sales
GROUP BY category;
--10.Write a Query to create each shift and number of orders (Example morning <=12,Afternoon between 12 and 17 evening >17)
SELECT 
    CASE 
        WHEN sale_time <= '12:00:00' THEN 'Morning'
        WHEN sale_time > '12:00:00' AND sale_time <= '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift_sales,
    COUNT(*) AS total_orders
FROM sales
GROUP BY shift_sales;
