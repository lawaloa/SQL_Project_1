# SQL PROJECT 1 | 💧 Maji Ndogo Water Services – SQL Data Analysis & Integrity Validation
---

## Table of Contents
---

- [Project Overview](#project-overview)
- [Data Familiarization](#data-familiarization)
- [Water Source Analysis](#water-source-analysis)
- [Water Source Types – Description](#water-source-types--description)
- [Visit Pattern Exploration](#visit-pattern-exploration)
- [Water Quality Assessment](#water-quality-assessment)
- [Pollution Investigation](#pollution-investigation)
- [Conclusion](#conclusion)
- [Reference](#reference)


### Project Overview
---

![Maji Ndogo](https://github.com/lawaloa/SQL_Project_1/blob/main/Picture_1.png)

 📌 This project focuses on analyzing a newly collected **database of 60,000 records** for **Maji Ndogo Water Services**.  
The data, gathered by engineers, scientists, field workers, and analysts, holds crucial insights to address the region’s ongoing water crisis.  

The goal is to **explore, clean, and analyze** this extensive dataset to uncover patterns, identify challenges, and support data-driven decision-making.  
As part of the project, I broke down the work into actionable steps:  

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

#### 📊 Key SQL Queries 

##### 1. Show All Tables: This give a list of all the tables in the database.

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


##### 2. 📊 Preview First 5 Records From Each Table

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


### Water Source Analysis
---

#### 🚰 Step 1: Diving into the Water Source

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

###  Water Source Types – Description

🚰

#### 1. River

![](https://github.com/lawaloa/SQL_Project_1/blob/main/river.png)

An open water source where people collect drinking water directly from the river.  
While millions in Maji Ndogo rely on rivers, this source carries a **high risk of contamination** from biological and chemical pollutants, making it the **least safe** option for drinking water.

#### 2. Well

![](https://github.com/lawaloa/SQL_Project_1/blob/main/Picture_1.png)

Wells draw water from underground sources and are commonly shared within communities. Being closed water sources, they are generally **less prone to contamination** than rivers. However, due to aging infrastructure and past corruption, many wells in Maji Ndogo are no longer clean.

#### 3. Shared Tap

![](https://github.com/lawaloa/SQL_Project_1/blob/main/shared_tap.png)

A public tap located in a shared community area. These taps are a **more controlled source** compared to rivers and wells but still require regular maintenance to ensure safe water quality.

#### 4. Tap in Home

![](https://github.com/lawaloa/SQL_Project_1/blob/main/tap_in_home.png)

Taps installed inside citizens’ homes, typically serving about **six people per household**. This is one of the **most convenient and safest** water sources when infrastructure is properly maintained.

#### 5. Broken Tap in Home

![](https://github.com/lawaloa/SQL_Project_1/blob/main/water_treatment.png)

Home-installed taps that are **non-functional** due to issues like burst pipes, broken pumps, or non-operational water treatment plants. Despite existing infrastructure, these taps cannot provide water until repairs are made.

### Visit Pattern Exploration
---

> #### 🏠 Important note on Home Taps
> 
> In Maji Ndogo, between **6–10 million people** have running water installed in their homes — this includes both working taps (`tap_in_home`) and non-functional taps (`tap_in_home_broken`).  
> 
> If we were to store this information at the **household level** (one record per home), our database would contain around **1 million rows**. While accurate, this volume of data could significantly slow down the system. To keep the dataset manageable, surveyors **aggregated multiple households** into a single record.  
> 
> **Example:**  
> The record with `source_id = AkHa00000224` refers to a `tap_in_home` serving **956 people**.  
> This represents approximately **160 homes**, with an average of **6 people per home** (`160 × 6 ≈ 956`).  
> 
> **Key takeaway:** One `tap_in_home` or `tap_in_home_broken` record in our dataset actually represents multiple households, and the `number_of_people_served` column is the total population across those households.


---

#### ⏳ Step 2: Unpacking the Visits Table

The `visits` table logs trips made to various water sources, including details like queue time, location, and assigned employees.  
To understand extreme waiting times, I queried all records where the `time_in_queue` exceeded **500 minutes** (over 8 hours of waiting).  

```sql
SELECT
    *
FROM
    md_water_services.visits
WHERE
    time_in_queue > 500;
```

**Query Output – Water Sources with Extreme Queue Times**

| record_id | location_id | source_id     | time_of_record       | visit_count | time_in_queue | assigned_employee_id |
|-----------|-------------|---------------|----------------------|-------------|---------------|----------------------|
| 899       | SoRu35083   | SoRu35083224  | 2021-01-16 10:14:00  | 6           | 515           | 28                   |
| 2304      | SoKo33124   | SoKo33124224  | 2021-02-06 07:53:00  | 5           | 512           | 16                   |
| 2315      | KiRu26095   | KiRu26095224  | 2021-02-06 14:32:00  | 3           | 529           | 8                    |
| 3206      | SoRu38776   | SoRu38776224  | 2021-02-20 15:03:00  | 5           | 509           | 46                   |
| 3701      | HaRu19601   | HaRu19601224  | 2021-02-27 12:53:00  | 3           | 504           | 0                    |
| 4154      | SoRu38869   | SoRu38869224  | 2021-03-06 10:44:00  | 2           | 533           | 24                   |
| 5483      | AmRu14089   | AmRu14089224  | 2021-03-27 18:15:00  | 4           | 509           | 12                   |
| 9177      | SoRu37635   | SoRu37635224  | 2021-05-22 18:48:00  | 2           | 515           | 1                    |
| 9648      | SoRu36096   | SoRu36096224  | 2021-05-29 11:24:00  | 2           | 533           | 3                    |
| 11631     | AkKi00881   | AkKi00881224  | 2021-06-26 06:15:00  | 6           | 502           | 32                   |

**Description:**  
This table shows the results of a query filtering for visits where `time_in_queue` exceeded **500 minutes** (over 8 hours).  
Such extended wait times point to **severe access challenges** in these locations, potentially caused by limited water availability, infrastructure breakdowns, or operational bottlenecks.  
Highlighting these cases helps prioritize interventions in the areas where residents endure the longest waits for water.

#### 🔍 Step 3: Investigating Water Source Types for Long Queue Times

After identifying visits with **extremely long queue times** (over 500 minutes), I wanted to know **what types of water sources** were causing such delays.  
The `water_source` table contains the columns `type_of_water_source` and `source_id`, so I cross-referenced the `source_id` values from the long-wait records.

From the previous query, I selected a few `source_id` values to investigate:

- `AkKi00881224`
- `SoRu37635224`
- `SoRu36096224`

I then ran the following SQL query:

```sql
SELECT 
    *
FROM 
    water_source
WHERE 
    source_id IN ('AkKi00881224', 'SoRu37635224', 'SoRu36096224');
```

**Query Output – Water Source Types for Long Queue Times**

| source_id     | type_of_water_source | number_of_people_served |
|---------------|----------------------|-------------------------|
| AkKi00881224  | shared_tap           | 3398                    |
| AkLu01628224  | bio_dirty_well       | 210                     |
| AkRu05234224  | tap_in_home_broken   | 496                     |
| HaRu19601224  | shared_tap           | 3322                    |
| HaZa21742224  | pol_dirty_well       | 308                     |
| SoRu36096224  | shared_tap           | 3786                    |
| SoRu37635224  | shared_tap           | 3920                    |
| SoRu38776224  | shared_tap           | 3180                    |

**Description:**  
This table cross-references the `source_id` values from visits with **extreme queue times** against the `water_source` table to reveal the type of water source and how many people each serves.  

The findings indicate that:
- **Shared taps** dominate the list, often serving thousands of people, leading to inevitable congestion.
- A few **wells** are also present, but they are marked as either biologically or pollution-contaminated, which could reduce usage or slow distribution.
- **Broken in-home taps** appear, suggesting that even household infrastructure issues contribute to long queues elsewhere.

These insights reinforce that **infrastructure improvements** must target both **high-demand shared facilities** and **failing household connections** to reduce excessive wait times.

### Water Quality Assessment
---

#### 💧 Step 4 – Assessing the Quality of Water Sources

The **quality of water sources** is a central focus of this survey.  
The `water_quality` table records a **subjective quality score** for each visit, assigned by a field surveyor:  
- **Score 1** → Terrible water quality  
- **Score 10** → Excellent, clean water (usually in homes)  

Shared taps are generally rated lower, and queue times also affect the score.  
For this query, I looked for **sources rated the highest (10)** but with exactly **two recorded visits**.

**SQL Query:**

```sql
SELECT
    *
FROM 
    water_quality
WHERE
    subjective_quality_score = 10
    AND visit_count = 2;
```

> #### ⚠️ Data Integrity Concern
> 
> I retrieved **218 rows** matching these criteria — but this result raises some concerns.  
> At this scale, it’s almost inevitable that **errors will creep into the dataset**.  
> It’s possible that some field surveyors or data entry staff **misjudged water quality scores** or recorded them inaccurately.  
> 
> To ensure the integrity of our findings, I’ll recommend to President Naledi that we **re-audit these specific sources**.  
> An independent auditor can recheck a sample of these water points on-site, validating the recorded scores and ensuring that our data truly reflects real-world conditions.  
> 
> **Why this matters:** Even small inaccuracies in our quality assessments could mislead decision-making, divert resources, and delay solutions for communities in urgent need.

### Pollution Investigation
---

#### 🧪 Step 5 – Investigating Pollution Issues

For well water sources, we also recorded detailed **contamination and pollution data**.  
To start, I identified the correct table (`well_pollution`) and previewed the first five rows to understand its structure.

**SQL Query:**

```sql
SELECT 
    * 
FROM 
    well_pollution 
LIMIT 5;
```

**Query Output**

| source_id     | date                | description                              | pollutant_ppm | biological | results                   |
|---------------|---------------------|------------------------------------------|---------------|------------|---------------------------|
| KiRu28935224  | 2021-01-04 09:17:00 | Bacteria: Giardia Lamblia               | 0.0           | 495.898    | Contaminated: Biological  |
| AkLu01628224  | 2021-01-04 09:53:00 | Bacteria: Salmonella Typhi               | 0.0           | 376.572    | Contaminated: Biological  |
| HaZa21742224  | 2021-01-04 10:37:00 | Inorganic contaminants: Zinc...          | 2.715         | 0.0        | Contaminated: Chemical    |
| HaRu19725224  | 2021-01-04 11:04:00 | Clean                                    | 0.0288593     | 0.0        | Clean                     |
| SoRu35703224  | 2021-01-04 11:29:00 | Bacteria: E. coli                        | 0.0           | 296.437    | Contaminated: Biological  |

---

**Description:**  
The `well_pollution` table records contamination levels for each well in Maji Ndogo. It includes both **biological contaminants** (e.g., *E. coli*, *Giardia Lamblia*, *Salmonella Typhi*) and **chemical pollutants** (e.g., toxic metals like zinc).  

Each well is classified into one of three categories:  
- **Clean** – Safe for consumption.  
- **Contaminated: Biological** – Unsafe due to harmful microorganisms.  
- **Contaminated: Chemical** – Unsafe due to toxic substances.  

This classification is vital for **public health monitoring** and **intervention planning**. Since each record contains a `source_id`, I would have prefer to link it back to its corresponding location in the database — allowing for identifation and mapping contamination hotspots across Maji Ndogo.

#### ⚠️ Step 6 – Data Integrity Check for Well Pollution

The `well_pollution` table contains **scientist notes** in the `description` column, which makes it harder to process consistently.  
The **biological column** (measured in **CFU/mL**) is the reliable indicator of contamination:  
- `0` → Clean water.  
- `> 0.01` → Contaminated water.  

The **worst-case scenario** is when a well is marked as `Clean` but the biological contamination is actually higher than `0.01`. This would mean contaminated water is being incorrectly classified as safe — a serious **public health risk**.

---

🔍 **SQL Query**

```sql
SELECT 
    * 
FROM 
    well_pollution 
WHERE 
    results = 'Clean' 
    AND biological > 0.01
LIMIT 7;
```

📊 **Query Output**

| source_id     | date                | description                      | pollutant_ppm | biological | results |
|---------------|---------------------|----------------------------------|---------------|------------|---------|
| AkRu08936224  | 2021-01-08 09:22:00 | Bacteria: E. coli                | 0.0406458     | 35.0068    | Clean   |
| AkRu06489224  | 2021-01-10 09:44:00 | Clean Bacteria: Giardia Lamblia  | 0.0897904     | 38.467     | Clean   |
| SoRu38011224  | 2021-01-14 15:35:00 | Bacteria: E. coli                | 0.0425095     | 19.2897    | Clean   |
| AkKi00955224  | 2021-01-22 12:47:00 | Bacteria: E. coli                | 0.0812092     | 40.2273    | Clean   |
| KiHa22929224  | 2021-02-06 13:54:00 | Bacteria: E. coli                | 0.0722537     | 18.4482    | Clean   |
| KiRu25473224  | 2021-02-07 15:51:00 | Clean Bacteria: Giardia Lamblia  | 0.0630094     | 24.4536    | Clean   |
| HaRu17401224  | 2021-03-01 13:44:00 | Clean Bacteria: Giardia Lamblia  | 0.0649209     | 25.8129    | Clean   |

---

📝 **Interpretation**  

The results reveal **data integrity issues** in the `well_pollution` table. Although these wells are labeled as **"Clean"** in the `results` column, their **biological contamination levels** are well above the safe threshold (`> 0.01 CFU/mL`).  

This suggests that:  
- Some data entry personnel may have mistakenly relied on the **description text** instead of the **measured biological values**.  
- Contaminated wells could have been misclassified as clean, posing a **public health risk**.  

> **Key Takeaway:** Proper **data validation and auditing** are essential to prevent misclassifications that could endanger entire communities relying on these water sources.


#### 🔎 Step 7: Fixing Data Anomalies in `well_pollution`

During inspection, we discovered **38 incorrect records** in the `well_pollution` table.  
The issue stems from **misleading descriptions** and **incorrect results classification**:  

1. Some descriptions mistakenly included the word **"Clean"**, even though the water was contaminated.  
   - `Clean Bacteria: E. coli` → should be → `Bacteria: E. coli`  
   - `Clean Bacteria: Giardia Lamblia` → should be → `Bacteria: Giardia Lamblia`  

2. Some wells were marked as **"Clean"** in the `results` column, even when their **biological contamination** exceeded the safe threshold of `0.01 CFU/mL`.  
   - These should be updated to → `Contaminated: Biological`.

---

 📝 **Query to Identify Wrong Records**
 
```sql
SELECT 
    * 
FROM 
    well_pollution 
WHERE 
    description LIKE 'Clean%' 
    AND biological > 0.01;
```

👉 This query returned **38 wrong descriptions**.

##### 🛠️ Safe Fixing Process

Since modifying production tables directly can introduce new errors, I first create a **copy** of the table, apply updates there, and validate results.

1. **Create a Copy of the Table**

```sql
CREATE TABLE md_water_services.well_pollution_copy AS
(
 SELECT * 
    FROM md_water_services.well_pollution
);
```

2. **Disable SQL Safe Updates (if enabled)**

```sql
SET SQL_SAFE_UPDATES = 0;
```

3. **Fix Descriptions**

```sql
-- Case 1a: Fix incorrect E. coli descriptions
UPDATE well_pollution_copy
SET description = 'Bacteria: E. coli'
WHERE description LIKE 'Clean Bacteria: E. coli';

-- Case 1b: Fix incorrect Giardia Lamblia descriptions
UPDATE well_pollution_copy
SET description = 'Bacteria: Giardia Lamblia'
WHERE description LIKE 'Clean Bacteria: Giardia Lamblia';
```

4. **Fix Results Column**

```sql
-- Case 2: Update wrong results
UPDATE well_pollution_copy
SET results = 'Contaminated: Biological'
WHERE biological > 0.01 
  AND results = 'Clean';
```

##### ✅ Validation Check

After applying fixes, I confirmed that no incorrect records remain:

```sql
SELECT *
FROM well_pollution_copy
WHERE description LIKE "Clean_%"
   OR (results = "Clean" AND biological > 0.01);
```

This query returns **0 rows**, which indicates that the fixes worked correctly. 🎉

#### 🗑️ Final Step: Apply Fixes and Clean Up

Once I verified that my updates worked correctly on the **copy table**, I went ahead and applied the same fixes to the original dataset. This way, the `well_pollution` table now contains accurate descriptions and contamination results.

---

##### 🔧 Apply Updates to `well_pollution`

```sql
-- Fix descriptions for E. coli
UPDATE well_pollution
SET description = 'Bacteria: E. coli'
WHERE description = 'Clean Bacteria: E. coli';

-- Fix descriptions for Giardia Lamblia
UPDATE well_pollution
SET description = 'Bacteria: Giardia Lamblia'
WHERE description = 'Clean Bacteria: Giardia Lamblia';

-- Fix incorrect results
UPDATE well_pollution
SET results = 'Contaminated: Biological'
WHERE biological > 0.01 
  AND results = 'Clean';
```

##### ✅ Validation Check (Again)

```sql
SELECT *
FROM well_pollution
WHERE description LIKE 'Clean%'
   OR (results = 'Clean' AND biological > 0.01);
```


👉 If this query returned **0 rows**, it meant my fixes worked perfectly.

##### 🗑️ Clean Up Temporary Table

Once I was confident with the results, I removed the temporary copy and kept only the corrected dataset:

```sql
DROP TABLE
  md_water_services.well_pollution_copy;
```

##### 💡 Reflection  

This step-by-step journey really showed me the **importance of data integrity validation**. Even with over **60,000 records**, small inconsistencies—like mislabeled descriptions—could easily mislead the analysis.  

By applying **controlled updates**, testing them on a safe copy of the table, and validating results before cleanup, I learned that **data cleaning is not just technical**—it’s fundamental to building **trustworthy insights** and ensuring that decisions are backed by reliable information.  

---

###### 🧹 Before Cleaning  

Here’s a snapshot of inconsistent records **before applying the cleaning process**:

| source_id     | date                | description                      | pollutant_ppm | biological | results |
|---------------|---------------------|----------------------------------|---------------|------------|---------|
| AkRu08936224  | 2021-01-08 09:22:00 | Bacteria: E. coli                | 0.0406458     | 35.0068    | Clean   |
| AkRu06489224  | 2021-01-10 09:44:00 | Clean Bacteria: Giardia Lamblia  | 0.0897904     | 38.467     | Clean   |
| SoRu38011224  | 2021-01-14 15:35:00 | Bacteria: E. coli                | 0.0425095     | 19.2897    | Clean   |
| AkKi00955224  | 2021-01-22 12:47:00 | Bacteria: E. coli                | 0.0812092     | 40.2273    | Clean   |
| KiHa22929224  | 2021-02-06 13:54:00 | Bacteria: E. coli                | 0.0722537     | 18.4482    | Clean   |
| KiRu25473224  | 2021-02-07 15:51:00 | Clean Bacteria: Giardia Lamblia  | 0.0630094     | 24.4536    | Clean   |
| HaRu17401224  | 2021-03-01 13:44:00 | Clean Bacteria: Giardia Lamblia  | 0.0649209     | 25.8129    | Clean   |

---

###### ✅ After Cleaning  

Here’s the corrected version **after fixing the anomalies**:

| source_id     | date                | description               | pollutant_ppm | biological | results                  |
|---------------|---------------------|---------------------------|---------------|------------|--------------------------|
| AkRu08936224  | 2021-01-08 09:22:00 | Bacteria: E. coli         | 0.0406458     | 35.0068    | Contaminated: Biological |
| AkRu06489224  | 2021-01-10 09:44:00 | Bacteria: Giardia Lamblia | 0.0897904     | 38.467     | Contaminated: Biological |
| SoRu38011224  | 2021-01-14 15:35:00 | Bacteria: E. coli         | 0.0425095     | 19.2897    | Contaminated: Biological |
| AkKi00955224  | 2021-01-22 12:47:00 | Bacteria: E. coli         | 0.0812092     | 40.2273    | Contaminated: Biological |
| KiHa22929224  | 2021-02-06 13:54:00 | Bacteria: E. coli         | 0.0722537     | 18.4482    | Contaminated: Biological |
| KiRu25473224  | 2021-02-07 15:51:00 | Bacteria: Giardia Lamblia | 0.0630094     | 24.4536    | Contaminated: Biological |
| HaRu17401224  | 2021-03-01 13:44:00 | Bacteria: Giardia Lamblia | 0.0649209     | 25.8129    | Contaminated: Biological |

---

###### 📌 Interpretation  

- **Before Cleaning** → Several wells were **mislabeled as Clean** even though their biological contamination was above safe limits.  
- **After Cleaning** → Both `description` and `results` were corrected, ensuring contaminated wells are flagged properly.  

This correction ensures that **no unsafe wells are reported as safe**, strengthening the **reliability of analysis** and safeguarding **public health**.  

---

##### 🔄 Summary  

To ensure the integrity of the **well pollution dataset**, I followed a structured cleaning workflow:  

📝 **Detect Issue** → 🔧 **Apply Fix** → ✅ **Validate** → 🗑️ **Clean Up**  

1. **📝 Detect Issue** – Identified mislabeled contamination data.  
2. **🔧 Apply Fix** – Corrected `description` and `results` values.  
3. **✅ Validate** – Verified corrections on a safe copy (`well_pollution_copy`).  
4. **🗑️ Clean Up** – Removed the temporary copy, keeping only the cleaned dataset.  

---

###### 🔍 Visual Workflow  

```text
📝 Detect Issue  →  🔧 Apply Fix  →  ✅ Validate  →  🗑️ Clean Up
```



### Conclusion
---

#### 🎯 Project Goal  

The goal of this project was to **explore, clean, and analyze an extensive dataset** from Maji Ndogo’s water services to uncover patterns, identify challenges, and support **data-driven decision-making**.  

To achieve this, I broke the work into **actionable steps**:  

1. **📂 Data Familiarization** – Loaded and inspected all tables to understand their structure, relationships, and variables.  
2. **🚰 Water Source Analysis** – Identified unique water source types and studied their distribution across the community.  
3. **👥 Visit Pattern Exploration** – Analyzed visit frequencies to different water sources and flagged high-traffic locations.  
4. **💧 Water Quality Assessment** – Filtered sources with high subjective quality scores and frequent visits.  
5. **🧪 Pollution Investigation** – Detected contaminated sources and identified anomalies requiring urgent intervention.  

---

### Reference
---

- 📚 ALX Data Programs: Querying Data: Integrated Project 1 – Maji Ndogo: From Analysis to Action.

- Dataset: Maji Ndogo Water Services – a fictional but realistic dataset designed for SQL practice, data cleaning, and exploratory analysis.

- Author’s Contribution: All SQL queries, cleaning steps, and analysis documented here were personally executed as part of this project build.
