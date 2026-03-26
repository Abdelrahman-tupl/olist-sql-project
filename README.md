# Olist E-commerce Data Pipeline (v1.0.0) 🏗️📊

## Project Overview
This project focuses on building a robust **Relational Database Infrastructure** for the Olist Brazilian E-commerce dataset. Instead of jumping straight to analysis, the goal was to engineer a scalable 4-stage SQL pipeline that transforms raw data into a structured PostgreSQL database, ensuring data integrity and optimized schema design.

This project is a practical application of the concepts learned in the **"Introduction to Relational Databases in SQL"** certification from DataCamp.

---

## Technical Stack
* **Database:** PostgreSQL
* **Language:** SQL
* **Tools:** GitHub, DataCamp Methodology
* **Dataset:** Olist E-commerce (Kaggle)

---

## Project Architecture (v1.0.0)
The pipeline is designed to handle 9 interconnected tables, focusing on:
1. **Schema Definition:** Creating tables with precise data types and constraints.
2. **Data Ingestion:** Preparing raw CSV files for relational mapping.
3. **Data Integrity:** Handling duplicate records (using `ctid` techniques) and enforcing Primary/Foreign Key relationships.
4. **Referential Integrity:** Bridging gaps in product category translations and ensuring consistency across the database.

---

## 📂 Repository Structure
* `/v1-sql-pipeline`: Contains the SQL scripts for schema creation, cleaning, and data transformation.
* `/docs`: Documentation on the database ERD and relational mapping.

---

## ⚠️ Important: Data Source
**Note:** Due to GitHub’s file size limitations, the raw dataset (CSV files) is not hosted directly in this repository. 

To replicate this project:
1. Download the dataset from [Kaggle - Olist Brazilian E-Commerce]([https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)).
2. Place the CSV files in your local data directory.
3. Run the scripts provided in the `/v1-sql-pipeline` folder.

---

## Future Roadmap (v2.0.0) 🚀
* [ ] Automating the ETL process using Python.
* [ ] Implementing a Star Schema for advanced analytical queries.
* [ ] Integrating the pipeline with a visualization tool (Tableau/Power BI).

---

## About the Author
**Abdelrahman Hossam**
Senior Economics Student at Cairo University (FEPS) | Minor in Social Computing.
Passionate about bridging the gap between economic data and robust technical architectures.
