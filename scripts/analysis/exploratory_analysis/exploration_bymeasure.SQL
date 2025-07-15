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
sum(prd_cost) as total_cost
from gold.dim_products
group by category
order by total_cost desc
