/* Olist Data Ingestion Script 
   Handling Bulk Load and Data Integrity Fixes
*/

---------------------------------------------------------
-- 1. Reference & Dimension Tables Load
---------------------------------------------------------

-- Note: Update the file path to your local repository location
COPY Category_Translation
FROM 'C:\YourPath\Olist_Data_Engineering_Project\raw_data\product_category_name_translation.csv'
DELIMITER ',' CSV HEADER;

COPY Geolocation
FROM 'C:\YourPath\Olist_Data_Engineering_Project\raw_data\olist_geolocation_dataset.csv'
DELIMITER ',' CSV HEADER;

COPY Products
FROM 'C:\YourPath\Olist_Data_Engineering_Project\raw_data\olist_products_dataset.csv'
DELIMITER ',' CSV HEADER;

COPY Customers
FROM 'C:\YourPath\Olist_Data_Engineering_Project\raw_data\olist_customers_dataset.csv'
DELIMITER ',' CSV HEADER;

COPY Sellers
FROM 'C:\YourPath\Olist_Data_Engineering_Project\raw_data\olist_sellers_dataset.csv'
DELIMITER ',' CSV HEADER;

---------------------------------------------------------
-- 2. Transactional Tables Load
---------------------------------------------------------

COPY Orders
FROM 'C:\YourPath\Olist_Data_Engineering_Project\raw_data\olist_orders_dataset.csv'
DELIMITER ',' CSV HEADER;

COPY Payments
FROM 'C:\YourPath\Olist_Data_Engineering_Project\raw_data\olist_order_payments_dataset.csv'
DELIMITER ',' CSV HEADER;

COPY Items
FROM 'C:\YourPath\Olist_Data_Engineering_Project\raw_data\olist_order_items_dataset.csv'
DELIMITER ',' CSV HEADER;

---------------------------------------------------------
-- 3. Specialized Handling for Reviews Table
---------------------------------------------------------

-- Temporary removal of constraints to handle duplicate/dirty raw data
TRUNCATE TABLE Reviews;
ALTER TABLE Reviews DROP CONSTRAINT reviews_pkey;

-- Bulk loading review data
COPY Reviews
FROM 'C:\YourPath\Olist_Data_Engineering_Project\raw_data\olist_order_reviews_dataset.csv'
DELIMITER ',' CSV HEADER;

-- Data Cleaning: Remove duplicates based on review_id keeping only the first entry
DELETE FROM Reviews
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM Reviews
    GROUP BY review_id
);

-- Re-applying Primary Key after cleaning
ALTER TABLE Reviews ADD PRIMARY KEY (review_id);