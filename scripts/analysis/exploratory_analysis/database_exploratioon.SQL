--explore the tables in thee database
select * from INFORMATION_SCHEMA.TABLES ;





--explore the buseness countries
select distinct country from gold.dim_customers;



--explore the buseness time domain (years)
select distinct YEAR(order_date) as years from gold.fact_sales ;



--explore the distinct categories and subcategories
select 
distinct category,
sub_category
from gold.dim_products
where category is not null
