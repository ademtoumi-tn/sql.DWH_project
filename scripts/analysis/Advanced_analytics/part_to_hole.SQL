WITH part_to_hole AS
(select
     category,
	 SUM(sales) as total_sales
from gold.fact_sales s
left join gold.dim_products p
on s.product_number=p.product_number
group by category)
select
      category,
	  total_sales,
	  CONCAT(ROUND((CAST (total_sales AS float)/ SUM(total_sales) OVER())*100,2),'%') as prcntg
from part_to_hole
