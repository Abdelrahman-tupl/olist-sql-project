# olist-sql-project
This version includes the core 4-stage SQL pipeline: Schema Creation, Data Ingestion with Duplicate Removal, Constraints Enforcement, and Final Data Validation.
# Olist E-Commerce Database Architecture & ETL Pipeline

## 📌 Overview
This project implements a relational database schema for the **Olist Brazilian E-Commerce dataset**. The focus is on the **Data Engineering** phase: transforming raw CSV files into a structured PostgreSQL database while ensuring data integrity and resolving quality issues inherent in the original dataset.

## 🛠️ Tech Stack
* **Database Engine:** PostgreSQL
* **Language:** SQL (PostgreSQL Dialect)
* **Model:** Relational (OLTP)
* **Version:** v1.0.0 (Initial Stable Release)

## 📂 Project Structure
The implementation is divided into four sequential SQL scripts:

1.  **`01_create_tables.sql`**: Defines the database schema, table structures, and appropriate data types for each attribute.
2.  **`02_copy_data.sql`**: Handles bulk data ingestion. It includes a specific fix for the `Reviews` table, where duplicate `review_id` entries were removed using the `ctid` method to allow for Primary Key enforcement.
3.  **`03_constraints_and_relationships.sql`**: Establishes Primary and Foreign Key relationships. It includes a proactive step to insert missing product categories into the translation table to prevent referential integrity violations.
4.  **`04_data_validation_and_cleaning.sql`**: Conducts a final data quality audit, identifying anomalies (like logical date errors) and standardizing `NULL` category values to an `Unknown` label.

## 🏗️ Technical Challenges Addressed
* **Duplicate Records:** The raw data for reviews contained non-unique IDs. I resolved this by loading the data into a temporary unconstrained state and then purging duplicates to maintain data uniqueness.
* **Referential Integrity Gaps:** Some product categories existed in the fact tables but were missing from the translation lookup table. I synchronized these dynamically to ensure the schema remains strictly relational.
* **Data Completeness:** Handled missing product categories by mapping them to an "Unknown" category, preserving the associated transactional data for future analysis without losing records.

## 🚀 Execution Order
1.  Create a PostgreSQL database.
2.  Update the directory paths in `02_copy_data.sql` to match your local dataset location.
3.  Run the scripts in order: `01` → `02` → `03` → `04`.

---
*This project is part of my continuous learning journey in Data Engineering, focusing on building reliable and scalable data architectures.*
