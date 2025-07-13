SELECT DATETRUNC(month,order_date) as date_month,
SUM(sales) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by DATETRUNC(month,order_date)
