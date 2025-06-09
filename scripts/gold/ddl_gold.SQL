/*
    Project: DataWarehouse
    Goal: This script creates gold-layer dimensional and fact views based on the integrated silver-layer CRM and ERP tables.
    It includes:
    - Customer Dimension (dim_customers)
    - Product Dimension (dim_products)
    - Sales Fact Table (fact_sales)
    These views are designed for analytical querying in a star schema model.
*/

USE DataWarehouse;
GO

-- Drop view if it exists: gold.dim_customers
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
BEGIN
    DROP VIEW gold.dim_customers;
END;
GO

-- Create Customer Dimension View
CREATE VIEW gold.dim_customers AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,
    la.cntry AS country,
    ci.cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS firstname,
    ci.cst_lastname AS lastname,
    ci.cst_marital_status AS marital_status,
    -- Use gender from master CRM table if available, otherwise fallback to ERP table
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
        ELSE ISNULL(ca.GEN, 'n/a')
    END AS gender,
    ca.bdate AS birthdate,
    ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_AZ12 ca ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_LOC_A101 la ON la.CID = ci.cst_key;
GO

-- Drop view if it exists: gold.dim_products
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
BEGIN
    DROP VIEW gold.dim_products;
END;
GO

-- Create Product Dimension View
CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY prd_id) AS product_number,
    pf.prd_id AS product_id,
    pf.prd_key AS product_key,
    pf.cat_id AS category_id,
    ct.CAT AS category,
    ct.SUBCAT AS sub_category,
    pf.prd_nm AS product_name,
    ct.MAINTENANCE AS maintenance,
    pf.prd_line AS product_line,
    pf.prd_start_dt,
    pf.prd_cost
FROM silver.crm_prd_info pf
LEFT JOIN silver.erp_PX_CAT_G1V2 ct ON pf.cat_id = ct.ID
WHERE prd_end_dt IS NULL;
GO

-- Drop view if it exists: fact_sales
IF OBJECT_ID('fact_sales', 'V') IS NOT NULL
BEGIN
    DROP VIEW fact_sales;
END;
GO

-- Create Sales Fact View
CREATE VIEW fact_sales AS
SELECT 
    sl.sls_ord_num AS order_number,
    pr.product_number,
    cu.customer_key,
    sl.sls_order_dt AS order_date,
    sl.sls_ship_dt AS ship_date,
    sl.sls_due_dt AS due_date,
    sl.sls_sales AS sales,
    sl.sls_quantity AS quantity,
    sl.sls_price AS price
FROM silver.crm_sales_details sl
LEFT JOIN gold.dim_customers cu ON sl.sls_cust_id = cu.custommer_id
LEFT JOIN gold.dim_products pr ON sl.sls_prd_key = pr.product_key;
GO
