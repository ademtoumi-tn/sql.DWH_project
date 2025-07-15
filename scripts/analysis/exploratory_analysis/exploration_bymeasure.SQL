--this query gives the necessary aggregations on the values (sales,cost,quantity) by the measures(country,customer,category)


--total_customers by country
select 
country,
COUNT(distinct customer_key) as customer_number
from gold.dim_customers
group by country
order by customer_number desc;
-- total_customers by gender
select 
gender,
COUNT(distinct customer_key) as customer_number
from gold.dim_customers
group by gender;
--total_products by category
select 
category,
COUNT(distinct product_key) as products_number
from gold.dim_products
group by category
order by products_number desc;
--total cost by category
select
category,
avg(prd_cost) as avg_cost
from gold.dim_products
group by category
order by avg_cost desc;
--total revenue by category
select 
category ,
SUM(sales) as total_revenue
from gold.fact_sales s
left join gold.dim_products p
on p.product_number=s.product_number
group by category
order by total_revenue desc;
--total_revenue by customer
select 
customer_id,
firstname,
lastname,
SUM(sales) as total_revenue
from gold.fact_sales s
left join gold.dim_customers c
on c.customer_key=s.customer_key
group by customer_id,
firstname,
lastname
order by total_revenue desc
