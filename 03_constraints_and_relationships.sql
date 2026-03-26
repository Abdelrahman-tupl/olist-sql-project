/* Olist Database Constraints & Relationships
   Phase 03: Establishing Referential Integrity
*/

---------------------------------------------------------
-- 1. Fixing Translation Gaps
---------------------------------------------------------

-- Inserting missing categories from Products into Translation table 
-- to prevent Foreign Key violations.
INSERT INTO Category_Translation (product_category_name, product_category_name_english)
SELECT DISTINCT p.product_category_name, p.product_category_name
FROM Products p
LEFT JOIN Category_Translation t ON p.product_category_name = t.product_category_name
WHERE t.product_category_name IS NULL 
  AND p.product_category_name IS NOT NULL;

-- Defining Primary Key for the Translation table
ALTER TABLE Category_Translation ADD PRIMARY KEY (product_category_name);

---------------------------------------------------------
-- 2. Defining Foreign Key Relationships
---------------------------------------------------------

-- Linking Reviews to their respective Orders
ALTER TABLE Reviews
ADD CONSTRAINT fk_reviews_orders
FOREIGN KEY (order_id) REFERENCES Orders(order_id);

-- Linking Items to Orders (Each item belongs to an order)
ALTER TABLE Items
ADD CONSTRAINT fk_items_orders
FOREIGN KEY (order_id) REFERENCES Orders(order_id);

-- Linking Payments to Orders
ALTER TABLE Payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id) REFERENCES Orders(order_id);

-- Linking Orders to Customers (Identifying who placed the order)
ALTER TABLE Orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id);

-- Linking Items to Products (Identifying what was sold)
ALTER TABLE Items
ADD CONSTRAINT fk_items_products
FOREIGN KEY (product_id) REFERENCES Products(product_id);

-- Linking Items to Sellers (Identifying who sold the item)
ALTER TABLE Items
ADD CONSTRAINT fk_items_sellers
FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id);

-- Linking Products to their English translations
ALTER TABLE Products
ADD CONSTRAINT fk_products_translation
FOREIGN KEY (product_category_name) REFERENCES Category_Translation(product_category_name);