---------------------------------------------------------
-- Phase 1: Data Quality Audit (Identifying Issues)
---------------------------------------------------------

-- Test 01: Ensure Primary Key Uniqueness
-- Expected: 0 rows. If rows appear, we have duplicate product entries.
SELECT product_id, COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Test 02: Identify Pricing Anomalies
-- Checks for NULL values or zero prices that could break financial calculations.
SELECT *
FROM Items
WHERE price IS NULL OR price <= 0;

-- Test 03: Logical Date Integrity Check
-- Finds orders where the 'Carrier Delivery Date' is recorded BEFORE the 'Purchase Date'.
-- This identifies potential system glitches or timezone logging errors.
SELECT order_id, order_purchase_timestamp, order_delivered_carrier_date
FROM Orders
WHERE order_delivered_carrier_date < order_purchase_timestamp;

-- Test 04: Missing Category Identification
-- Counts products that are missing a category name before the cleaning phase.
SELECT COUNT(product_id) AS missing_categories_count
FROM products
WHERE product_category_name IS NULL;

---------------------------------------------------------
-- Phase 2: Data Cleaning & Constraint Handling
---------------------------------------------------------

-- Step 1: Fix Referential Integrity
-- We must add 'Unknown' to the translation table first to satisfy the Foreign Key constraint.
INSERT INTO category_translation (product_category_name, product_category_name_english)
VALUES ('Unknown', 'Unknown')
ON CONFLICT (product_category_name) DO NOTHING; 

-- Step 2: Handle NULL values in Products table
-- Replacing NULLs with 'Unknown' ensures these products appear in future JOINs and reports.
UPDATE products
SET product_category_name = 'Unknown'
WHERE product_category_name IS NULL;

-- Verification: Ensure no NULLs remain
SELECT COUNT(*) FROM products WHERE product_category_name IS NULL;
