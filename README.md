# 🏗️ Data Warehouse & Analytics Project

Welcome to the **Data Warehouse & Analytics** project! This repository contains all the code, documentation, and SQL scripts for building a data warehouse and performing data analysis to generate business insights.

---

## 📊 Project Overview

This project is designed to:
- Build a scalable **data warehouse** architecture.
- Ingest, clean, and transform raw data using **ETL processes**.
- Design **fact and dimension tables** (star schema).
- Perform **data analysis** using SQLs.
- Enable **historical tracking**, **KPI generation**, and **dashboarding**.

---

## 🧱 Data Warehouse Design

We follow a **star schema** with the following components:

### 🔹 Fact Table(s)
- `fact_sales`
- `fact_orders` *(optional)*

### 🔸 Dimension Tables
- `dim_customer`
- `dim_product`
- `dim_time`
- `dim_location`
- `dim_employee`

Each dimension includes:
- Business attributes
- Surrogate keys
- Technical columns for tracking (`insert_date`, `is_active`, `effective_date`, etc.)

---
### Analysis
- exploratory_analysis
- advanced_analysis
- advanced_analysis
- SQL_reports
## ⚙️ Tech Stack

- **Database**: SQL server
- **ETL**: Python (Pandas, SQLAlchemy) or Apache Airflow
- **Data Modeling**: dbt (optional)
- **Analytics & Visualization**: SQL + Power BI / Tableau / Metabase
- **Version Control**: Git + GitHub

---


