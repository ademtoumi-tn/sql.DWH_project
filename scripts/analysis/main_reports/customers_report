--this sql query analyse the database providing a repport that contains all the necessary informations for the customers
CREATE VIEW customers_repo AS
WITH customers as (select c.customer_key,
c.firstname + ' ' +c.lastname as  name,
c.country,
c.gender,
c.marital_status,
datediff(year,c.birthdate,GETDATE()) as age,
MAX(s.order_date) as last_order,
datediff(month ,MIN(s.order_date),MAX(s.order_date) ) as lifespan,
COUNT( DISTINCT s.order_date) as orders_number,
SUM(s.sales) as revenue
from gold.fact_sales s 
left join gold.dim_customers c
on s.customer_key=c.customer_key
group by c.customer_key,
firstname + ' ' +lastname,
c.country,
c.gender,
c.marital_status,
datediff(year,c.birthdate,GETDATE()))
select
      customer_key,
	  name,
	  country,
	  gender,
	  marital_status,
	  age,
	  last_order,
	  lifespan,
	  orders_number,
	  revenue,
	  case when lifespan >=12 and revenue>=5000 THEN 'VIP'
	  when lifespan >= 12 and revenue <5000 THEN 'Regular'
	  ELSE 'New'
	  END as cust_class,
	  case
	  when age >50 THEN '>50'
	  when 50 <=age and age >=30 THEN '30-50'
	  ELSE '<30'
	  END AS age_class,
	  CASE when orders_number=0 THEN revenue
	  ELSE (revenue / orders_number) 
	  END AS revenue_per_order,
	  CASE WHEN lifespan=0 THEN revenue
	  ELSE (revenue/lifespan)
	  END AS revenue_per_month
from customers
