WITH cumulative as(
SELECT 
YEAR(order_date) year_date,
SUM(sales) as total_sales,
SUM(quantity) total_quantity,
avg (sales) avg_sales,
COUNT(distinct s.customer_key) total_customers
from gold.fact_sales s
left join gold.dim_customers c
on c.customer_key=s.customer_key
left join gold.dim_products p
on p.product_number=s.product_number
where order_date is not null
group by YEAR(order_date))
select 
      year_date,
      SUM(total_sales) OVER(ORDER BY year_date) as runningsum_sales,
	  SUM(total_customers) OVER(ORDER BY year_date) as runningsum_customers,
	  SUM(total_quantity) OVER(ORDER BY year_date) as runningsum_quantity,
	  AVG(avg_sales) OVER(ORDER BY year_date) as movingavg_sales
from cumulative
