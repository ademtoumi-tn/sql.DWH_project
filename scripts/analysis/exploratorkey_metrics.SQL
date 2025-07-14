--this query gives all the KPIS for the buseness using high level aggregations
select 'total_sales' as measure_name, SUM(sales) as measure_value from gold.fact_sales 
UNION ALL
select 'total_quantity' , SUM(quantity) from gold.fact_sales
UNION ALL
select 'avg_price' , AVG(price) from gold.fact_sales
UNION ALL
select 'orders_number' ,COUNT(distinct order_number) from gold.fact_sales
UNION ALL
select 'products_number'  , COUNT(distinct product_key) from gold.dim_products
UNION ALL
select 'customers_number' , COUNT(distinct customer_key) from gold.dim_customers
