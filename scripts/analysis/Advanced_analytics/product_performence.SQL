WITH performence AS(
select 
      YEAR(s.order_date) as date_year,
	  p.product_name,
	  SUM(s.sales) as total_sales
from gold.fact_sales s
left join gold.dim_products p
on s.product_number=p.product_number
group by YEAR(s.order_date),p.product_name)
select
      product_name,
	  date_year,
	  total_sales,
	  LAG(total_sales) OVER(PARTITION BY product_name ORDER BY date_year) pervious_sales,
	  AVG(total_sales) OVER(PARTITION BY product_name) as avg_sales,
	  total_sales -AVG(total_sales) OVER(PARTITION BY product_name) as avg_diff,
	  total_sales -LAG(total_sales) OVER(PARTITION BY product_name ORDER BY date_year) as prvs_diff,
	  CASE WHEN total_sales -AVG(total_sales) OVER(PARTITION BY product_name) <0 THEN 'Above avg'
	  ELSE 'Below avg'
	  END AS avg_segmentation,
	  CASE WHEN total_sales -LAG(total_sales) OVER(PARTITION BY product_name ORDER BY date_year) <0 THEN 'increasing'
	  ELSE 'decreasing'
	  END AS prvs_segmentation
from performence
