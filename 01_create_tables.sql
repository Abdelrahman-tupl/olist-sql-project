---------------------------------------------------------
-- Project: E-Commerce Data Warehouse (Olist Dataset)
-- Author: Abdelrahman (Tupl)
-- Phase 01: Database Schema Creation
---------------------------------------------------------

-- Step 1: Cleaning Environment
-- Dropping existing tables to ensure a fresh build and avoid conflicts.
DROP TABLE IF EXISTS Items, Payments, Reviews, Orders, Products, Sellers, Customers, Category_Translation, Geolocation CASCADE;

---------------------------------------------------------
-- Step 2: Creating Reference Tables (Look-up Tables)
---------------------------------------------------------

-- Table: Category_Translation
-- Maps Brazilian category names to English for better accessibility.
CREATE TABLE Category_Translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);

-- Table: Geolocation
-- Stores location data for logistical and spatial analysis.
CREATE TABLE Geolocation (
    geolocation_zip_code_prefix CHAR(5),
    geolocation_lat DECIMAL,
    geolocation_lng DECIMAL,
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);

---------------------------------------------------------
-- Step 3: Creating Core Entity Tables (Main Dimensions)
---------------------------------------------------------

-- Table: Products
-- Detailed information about the items sold in the marketplace.
CREATE TABLE Products (
    product_id VARCHAR(100) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- Table: Customers
-- Information about registered customers and their locations.
CREATE TABLE Customers (
    customer_id VARCHAR(100) PRIMARY KEY,
    customer_unique_id VARCHAR(100),
    customer_zip_code_prefix CHAR(5),
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

-- Table: Sellers
-- Information about the sellers operating on the platform.
CREATE TABLE Sellers (
    seller_id VARCHAR(100) PRIMARY KEY,
    seller_zip_code_prefix CHAR(5),
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);

---------------------------------------------------------
-- Step 4: Creating Transactional Tables (Fact Tables)
---------------------------------------------------------

-- Table: Orders
-- The main table capturing order lifecycle and timestamps.
CREATE TABLE Orders (
    order_id VARCHAR(100) PRIMARY KEY,
    customer_id VARCHAR(100),
    order_status VARCHAR (50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- Table: Payments
-- Details regarding payment methods and values for each order.
CREATE TABLE Payments (
    order_id VARCHAR(100),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL
);

-- Table: Items
-- Breakdown of individual products included in each order.
CREATE TABLE Items (
    order_id VARCHAR(100),
    order_item_id INT,
    product_id VARCHAR(100),
    seller_id VARCHAR(100),
    shipping_limit_date TIMESTAMP,
    price DECIMAL,
    freight_value DECIMAL
);

-- Table: Reviews
-- Customer feedback and ratings for completed orders.
CREATE TABLE Reviews (
    review_id VARCHAR(100) PRIMARY KEY,
    order_id VARCHAR(100),
    review_score INT,
    review_comment_title VARCHAR(200),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

---------------------------------------------------------
-- End of Script
---------------------------------------------------------