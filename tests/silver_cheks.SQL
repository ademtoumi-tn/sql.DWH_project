USE DataWarehouse;
GO

-- =====================================================================
-- Silver Layer Test Suite
-- Purpose: Validate integrity, transformation accuracy, and data quality
--          of the silver layer after executing silver.load_silver.
-- =====================================================================

-- 1. Check for NULL customer IDs (cst_id) in silver.crm_cust_info
-- Reason: Customer ID is a key field and should never be NULL.
SELECT COUNT(*) AS NullCustomerIDs
FROM silver.crm_cust_info
WHERE cst_id IS NULL;


-- 2. Verify customer deduplication: only one row per cst_id
-- Reason: Deduplication should retain only one record per customer ID.
SELECT cst_id, COUNT(*) AS DuplicateCount
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;


-- 3. Check for mismatches between calculated and actual sales
-- Reason: Ensure sls_sales = sls_quantity * sls_price after transformation.
SELECT *
FROM silver.crm_sales_details
WHERE ABS(sls_sales - (sls_quantity * sls_price)) > 0.01;


-- 4. Ensure only valid standardized gender values in silver.erp_CUST_AZ12
-- Reason: Gender should be cleaned to only 'Male', 'Female', or NULL.
SELECT DISTINCT GEN AS DistinctGenders
FROM silver.erp_CUST_AZ12;


-- 5. Compare row counts between bronze and silver for crm_prd_info
-- Reason: Detect any data loss during transformation.
SELECT 
    (SELECT COUNT(*) FROM bronze.crm_prd_info) AS BronzeCount,
    (SELECT COUNT(*) FROM silver.crm_prd_info) AS SilverCount;


-- 6. Check if product categories were standardized properly in crm_prd_info
-- Reason: prd_line should only contain mapped categories like ROAD, MOUNTAIN, etc.
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;


-- 7. Check if erp_LOC_A101 country codes were normalized correctly
-- Reason: Country values should be unified to standardized names.
SELECT DISTINCT CNTRY
FROM silver.erp_LOC_A101;
