DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(20),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT

);

-- Data Cleaning
select * from retail_sales;
where 
	transactions_id is null 
	or 
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null 
	or 
	gender is null 
	or
	age is null 
	or 
	category is null 
	or 
	quantity is null 
	or 
	price_per_unit is null 
	or 
	cogs is null 
	or 
	total_sale is null


DELETE FROM retail_sales 
where 
	transactions_id is null 
	or 
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null 
	or 
	gender is null 
	or
	age is null 
	or 
	category is null 
	or 
	quantity is null 
	or 
	price_per_unit is null 
	or 
	cogs is null 
	or 
	total_sale is null

--DATA EXPLORATION

--How many sales we have?

select
	count(*)
from retail_sales

-- How many unique customers we have?
select
	count(distinct customer_id)
from retail_sales

-- Data Analysis and Business key problems & Answers

--Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
	select
		*
	from retail_sales
	where sale_date = '2022-11-05'

--Q.2 Write a SQL query to calculate total_sales for each category.

	select
		category,
		sum(total_sale) as total_category_sale
	from retail_sales
	group by 1
	


---Q3. Write a SQL query to retrieve all transactions where the category is 'Clothing' amd quantity sold is more than 3 in the month of nov-22.


select
	*
from retail_sales
where category = 'Clothing' and to_char(sale_date, 'YYYY-MM') = '2022-11' AND quantity >= 4

--Q4. Write a SQL query to find the average age of customers who purchased items from "Beauty" category.
select
	category,
	sum(total_sale) as net_sales,
	count(*) as total_orders
from retail_sales
group by 1 



select
	round(avg(age),2) as average_age
from retail_sales
where category = 'Beauty'

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where  total_sale > 1000



--Q.6 Write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category.

select
	category,
	gender,
	count(transactions_id) as total_transactions
from retail_sales
group by 1,2 
order by 1 asc , 2 asc


--Q.7 Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year.
select
	year,
	month,
	avg_sale
from(
	select
		extract(year from sale_date) as year,
		extract(month from sale_date) as month,
		avg(total_sale) as avg_sale,
		rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc)  as rn 
from retail_sales 
group by 1,2
order by 1 asc,3 desc) as t1
where rn = 1

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

select
	customer_id,
	sum(total_sale) as net_sale
from retail_sales
group by 1 
order by 2 desc
limit 5

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category?

select
	category,
	count(Distinct(customer_id)) as cnt_unique_cs
from retail_sales
group by category


--Q10. Write a SQL query to create each shift and number of orders.(Ex: Morning <= 12, Afternoon Between 12 & 17, Evening> 17 )
with shift_sales as(
select
	*,
	case 
		when extract(hour from sale_time) < 12 then 'morning'
		when extract(hour from sale_time) between 12 and 17 then 'afternoon' 
		else 'Evening'
	end as shift
from retail_sales)
select
	shift,
	count(transactions_id)
from shift_sales
group by shift

--End of project























































