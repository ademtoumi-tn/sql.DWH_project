USE DataWarehouse;
GO

-- =============================================================================
-- Gold Layer Test Suite
-- Purpose: Ensure dimensional views and fact table are properly formed from
--          the silver layer and contain valid, expected results.
-- =============================================================================

-- 1. Check for NULL customer_key in dim_customers
-- Reason: Every customer in the dimension must have a surrogate key.
SELECT COUNT(*) AS NullCustomerKey
FROM gold.dim_customers
WHERE customer_key IS NULL;


-- 2. Check for rows in dim_customers with missing country info
-- Reason: Ensure country enrichment from ERP was successful.
SELECT COUNT(*) AS MissingCountry
FROM gold.dim_customers
WHERE country IS NULL;


-- 3. Validate gender field contains only expected values
-- Reason: Only 'male', 'female', or 'n/a' should appear.
SELECT DISTINCT gender
FROM gold.dim_customers;


-- 4. Ensure prd_end_dt filter is applied correctly in dim_products
-- Reason: Only active products (prd_end_dt IS NULL) should be in the product dimension.
SELECT COUNT(*) AS NonNullEndDateCount
FROM silver.crm_prd_info
WHERE prd_end_dt IS NOT NULL
AND prd_id IN (
    SELECT product_id FROM gold.dim_products
);


-- 5. Check if product_number is unique
-- Reason: Product dimension should have unique surrogate keys.
SELECT product_number, COUNT(*) AS cnt
FROM gold.dim_products
GROUP BY product_number
HAVING COUNT(*) > 1;


-- 6. Validate fact_sales joins (customer_key or product_number is NULL)
-- Reason: Any NULLs may indicate broken joins or missing dimensional data.
SELECT COUNT(*) AS BrokenJoins
FROM fact_sales
WHERE customer_key IS NULL OR product_number IS NULL;


-- 7. Check for sales values that are not equal to quantity * price
-- Reason: Detect transformation anomalies in silver layer before fact view.
SELECT COUNT(*) AS InvalidSales
FROM fact_sales
WHERE ABS(sales - (quantity * price)) > 0.01;


-- 8. Compare row counts: fact_sales vs. crm_sales_details
-- Reason: Ensure no records are lost during join with dimensions.
SELECT 
    (SELECT COUNT(*) FROM silver.crm_sales_details) AS SilverSalesCount,
    (SELECT COUNT(*) FROM fact_sales) AS FactSalesCount;


-- 9. Detect duplicate sales order numbers in fact_sales
-- Reason: Ensure one fact entry per sales transaction.
SELECT sls_ord_num, COUNT(*) AS cnt
FROM fact_sales
GROUP BY sls_ord_num
HAVING COUNT(*) > 1;
