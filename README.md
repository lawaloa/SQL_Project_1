# PROJECT 1 | 💧 Maji Ndogo Water Services – SQL Data Analysis
---

## Table of Contents
---

- [Project Overview](#project-overview)
- [Data Familiarization](#data-familiarization)
- [Key SQL Queries 1](#key-sql-queries-1)
- [Steps](#steps)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Result/Findings](#resultfindings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [References](#references)


### Project Overview
---

 📌 This project focuses on analyzing a newly collected **database of 60,000 records** for **Maji Ndogo Water Services**.  
The data, gathered by engineers, scientists, field workers, and analysts, holds crucial insights to address the region’s ongoing water crisis.  

The goal is to **explore, clean, and analyze** this extensive dataset to uncover patterns, identify challenges, and support data-driven decision-making.  
As part of the project, we broke down the work into actionable steps:  

1. **Data Familiarization** – Load and inspect all tables to understand structure, relationships, and variables.  
2. **Water Source Analysis** – Identify all unique water source types and their distributions.  
3. **Visit Pattern Exploration** – Analyze visit frequencies to different sources and flag high-traffic locations.  
4. **Water Quality Assessment** – Filter sources with high subjective quality scores and frequent visits.  
5. **Pollution Investigation** – Identify contaminated sources requiring urgent intervention.  

By executing these tasks, I translate raw data into **meaningful insights** that can guide interventions, improve infrastructure planning, and ultimately bring Maji Ndogo closer to resolving its water crisis.  

**Skills Applied**: SQL · Data Exploration · Data Cleaning · Aggregation · Filtering · Conditional Queries · Pattern Detection  

---

### Data Familiarization  🔍
---

I started this project by exploring the structure of the `md_water_services` database.  
First, I ran a query to check **how many tables** were in the database and to get a list of their names.  

Once I had the table names, I wrote `SELECT` statements to view the **first five records** from each one.  
While reviewing the results, I paid close attention to:  
- The **column names** and their **data types**.  
- The kind of information stored in each table and how they might relate to each other.  
- Any patterns, inconsistencies, or key fields that could be useful for joining tables later.  

This initial exploration gave me a clear understanding of the **scope** and **structure** of the dataset, which helped me plan the rest of my analysis.

---

### Key SQL Queries 1 📊

#### 1. Show All Tables: This give a list of all the tables in the database.
```sql
SHOW TABLES;
```
The database contains 8 tables:  
`data_dictionary`, `employee`, `global_water_access`, `location`, `visits`, `water_quality`, `water_source`, and `well_pollution`.

#### 2. Preview First 5 Records From Each Table

```sql
SELECT *
  FROM md_water_services.employee
LIMIT 5;

SELECT *
  FROM md_water_services.global_water_access
LIMIT 5;

SELECT *
  FROM md_water_services.location
LIMIT 5;

SELECT *
  FROM md_water_services.visits LIMIT 5;

SELECT *
  FROM md_water_services.water_quality
LIMIT 5;

SELECT *
  FROM md_water_services.water_source
LIMIT 5;

SELECT *
  FROM md_water_services.well_pollution
LIMIT 5;

```

