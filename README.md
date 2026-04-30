# Zepto Product Analysis (SQL)

## Overview
A SQL-based deep dive into Zepto's product data to optimize pricing and inventory. The core logic is contained in **"zepto sql data analysis.sql"**.

## Process
* **Schema Design**: Built a structured table with precise data types for SKUs, prices, and stock.
* **Data Cleaning**: Normalized prices to Rupees, removed zero-MRP anomalies, and audited for null values.
* **Business EDA**: 
    * Calculated **Revenue per Category**.
    * Identified **Top 10 Best-Value** products by discount %.
    * Classified inventory into **Low, Medium, and Bulk** weight groups.
    * Flagged **High-Value Out-of-Stock** items (> ₹300).

## Skills
* **Aggregations**: `SUM`, `AVG`, `COUNT`, `ROUND`.
* **Logic**: `CASE WHEN`, `HAVING`, `DISTINCT`.
* **DML/DDL**: `UPDATE`, `DELETE`, `CREATE`, `DROP`.
