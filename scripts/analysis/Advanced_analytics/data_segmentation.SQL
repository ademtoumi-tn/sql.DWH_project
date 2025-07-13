WITH prd_segmentation AS(
select 
product_key,
prd_cost,
CASE
WHEN prd_cost<100 THEN 'Below 100'
WHEN prd_cost BETWEEN 100 and 500 THEN '100-500'
WHEN prd_cost BETWEEN 500 and 1000 THEN '500-1000'
ELSE 'Above 1000'
END as products_segmentation
from gold.dim_products)
select
COUNT(product_key) products_number,
products_segmentation
from prd_segmentation
group by products_segmentation;

WITH cust_segmentation AS(
select
s.customer_key,
DATEDIFF(month ,MIN(order_date),MAX(order_date)) lifespan,
SUM(sales) total_sales
from gold.fact_sales s
left join gold.dim_customers c
on s.customer_key=c.customer_key
group by s.customer_key)
select
      COUNT(customer_key) as customers_number,
	  customers_classes
from(
select
customer_key,
CASE WHEN lifespan >=12 and total_sales>=5000 THEN 'VIP'
WHEN lifespan <12 and total_sales>=5000 THEN 'regular'
ELSE 'new'
END AS customers_classes
from cust_segmentation) as sub_query
group by customers_classes
