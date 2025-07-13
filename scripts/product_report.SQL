--this sql query generate a report on all of the necessary informations on the products
CREATE VIEW gold.product_repo AS
with products AS
(SELECT
      P.product_name,
	  P.category,
	  P.sub_category,
	  p.prd_cost,
	  SUM(s.quantity) quantity_sold,
	  COUNT(*) orders_number,
	  DATEDIFF(month, MIN(s.order_date),MAX (s.order_date) ) lifespan,
	  MAX (s.order_date) last_order,
	  SUM (s.sales) revenue,
	  COUNT(DISTINCT s.customer_key) customer_number
FROM gold.fact_sales s
LEFT JOIN gold.dim_products P
ON P.product_number=s.product_number
group by  P.product_name,P.category,P.sub_category,P.prd_cost)
SELECT 
      product_name,
	  category,
	  sub_category,
	  customer_number,
	  prd_cost,
	  orders_number,
	  quantity_sold,
	  DATEDIFF(month,last_order,GETDATE()) recency,
	  lifespan,
	  revenue,
	  revenue/orders_number AVG_order_revenue,
	  CASE
	      WHEN lifespan=0 THEN revenue
		  ELSE revenue/lifespan
	  END AS AVG_month_revenue,
	  CASE 
	      WHEN revenue<=10000 THEN 'low performence'
		  WHEN  revenue<50000  THEN'mid performence'
		  ELSE 'high performence'
	  END AS prd_performence
from products
