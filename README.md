# PROJECT 1 | 💧 Maji Ndogo Water Services – SQL Data Analysis
---

## Table of Contents
---

- [Project Overview](#project-overview)
- [Data Familiarization](#data-familiarization)
- [Key SQL Queries 1](#key-sql-queries-1)
- [Water Source Analysis](#water-source-analysis)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Result/Findings](#resultfindings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [References](#references)


### Project Overview
---

![Maji Ndogo](https://github.com/lawaloa/SQL_Project_1/blob/main/Picture_1.png)

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

### Data Familiarization  
---

🔍
I started this project by exploring the structure of the `md_water_services` database.  
First, I ran a query to check **how many tables** were in the database and to get a list of their names.  

Once I had the table names, I wrote `SELECT` statements to view the **first five records** from each one.  
While reviewing the results, I paid close attention to:  
- The **column names** and their **data types**.  
- The kind of information stored in each table and how they might relate to each other.  
- Any patterns, inconsistencies, or key fields that could be useful for joining tables later.  

This initial exploration gave me a clear understanding of the **scope** and **structure** of the dataset, which helped me plan the rest of my analysis.

---

### Key SQL Queries 1 

#### 1. 📊 Show All Tables: This give a list of all the tables in the database.

```sql
SHOW TABLES;
```
The database contains 8 tables:  
`data_dictionary`, `employee`, `global_water_access`, `location`, `visits`, `water_quality`, `water_source`, and `well_pollution`.

| Tables in `md_water_services_student` |
|---------------------------------------|
| data_dictionary                       |
| employee                              |
| global_water_access                   |
| location                              |
| water_quality                         |
| visits                                |
| water_source                          |
| well_pollution                        |


#### 2. 📊 Preview First 5 Records From Each Table

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
  FROM md_water_services.visits
LIMIT 5;

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

1. **Sample Output – Location Table**

| location_id | address               | province_name | town_name | location_type |
|-------------|-----------------------|---------------|-----------|---------------|
| AkHa00000   | 2 Addis Ababa Road    | Akatsi        | Harare    | Urban         |
| AkHa00001   | 10 Addis Ababa Road   | Akatsi        | Harare    | Urban         |
| AkHa00002   | 9 Addis Ababa Road    | Akatsi        | Harare    | Urban         |
| AkHa00003   | 139 Addis Ababa Road  | Akatsi        | Harare    | Urban         |
| AkHa00004   | 17 Addis Ababa Road   | Akatsi        | Harare    | Urban         |

> This table contains details about specific locations, including their `address`, the `province` and `town` they belong to, and whether they are classified as urban or not. While it doesn’t provide a descriptive name for the location, each entry includes a unique `location_id` that serves as an identifier.

2.  **Sample Output – Visits Table**

| record_id | location_id | source_id     | time_of_record       | visit_count | time_in_queue | assigned_employee_id |
|-----------|-------------|---------------|----------------------|-------------|---------------|----------------------|
| 0         | SoIl32582   | SoIl32582224  | 2021-01-01 09:10:00  | 1           | 15            | 12                   |
| 1         | KiRu28935   | KiRu28935224  | 2021-01-01 09:17:00  | 1           | 0             | 46                   |
| 2         | HaRu19752   | HaRu19752224  | 2021-01-01 09:36:00  | 1           | 62            | 40                   |
| 3         | AkLu01628   | AkLu01628224  | 2021-01-01 09:53:00  | 1           | 0             | 1                    |
| 4         | AkRu03357   | AkRu03357224  | 2021-01-01 10:11:00  | 1           | 28            | 14                   |

> This table records visits to specific locations, including the `location_id`, `source_id`, `record_id`, and the `date` and time of each visit (`time_of_record`). It also tracks which employee (`assigned_employee_id`) carried out the visit, the number of visits (`visit_count`), and the time spent in queue (`time_in_queue`). The `_id` columns often link to other tables—here, the `source_id` in the visits table corresponds to the `source_id` in the `water_source` table. This relationship is an example of a foreign key.

3. **Sample Output – Water Source Table**

| source_id     | type_of_water_source  | number_of_people_served |
|---------------|-----------------------|--------------------------|
| AkHa00000224  | tap_in_home           | 956                      |
| AkHa00001224  | tap_in_home_broken    | 930                      |
| AkHa00002224  | tap_in_home_broken    | 486                      |
| AkHa00003224  | clean_well            | 364                      |
| AkHa00004224  | tap_in_home_broken    | 94                       |
  
> This table contains information on the various water sources available in Maji Ndogo. Each water source is uniquely identified by a `source_id`, classified by its `type_of_water_source`, and includes the estimated `number_of_people_served`. Water sources are where residents collect water, ranging from taps in homes to clean wells and other supply points.  

> The database also contains a **data dictionary** table (`data_dictionary`) that documents each column’s meaning across all tables. Referring to it is an essential step in understanding the dataset and maintaining accurate analysis.


## Water Source Analysis
---

🚰
To better understand the water infrastructure in Maji Ndogo, I first needed to identify the different types of water sources available.  
By inspecting the database structure, I determined that this information is stored in the `water_source` table.  

I then ran the following SQL query to retrieve all unique water source types:  

```sql
SELECT DISTINCT
    type_of_water_source
FROM
    water_source;
```

**Query Output – Unique Water Source Types**

| type_of_water_source  |
|-----------------------|
| tap_in_home           |
| tap_in_home_broken    |
| well                  |
| shared_tap            |
| river                 |

**Description:**

> This table lists the five unique types of water sources recorded in the database, retrieved from the water_source table. These range from private taps in homes to shared taps, wells, and natural sources like rivers. Understanding these categories is key to assessing water accessibility in Maji Ndogo.
