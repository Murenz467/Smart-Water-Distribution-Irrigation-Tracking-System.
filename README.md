# Smart Water Distribution & Irrigation Management System

** PL/SQL  Project**


![Status](https://img.shields.io/badge/Status-Completed-success)
![Phases](https://img.shields.io/badge/Phases-I_to_VIII_Done-blue)
![Database](https://img.shields.io/badge/Oracle-21c_XE-red)

---

### Student Information
- **Name:** Charles Murenzi
- **Student ID:** 27386
- **Institution:** Adventist University of Central Africa (AUCA)
- **Course:** Database Development with PL/SQL (INSY 8311)
- **Lecturer:** Eric Maniraguha
- **Submission Date:** December 2025

---

## Project Overview
The Smart Water Distribution & Irrigation Management System automates water consumption tracking, meter monitoring, sector-level analytics, and auditing. The system enforces business rules to prevent unauthorized updates on weekdays and public holidays, and supports BI-ready data for reporting and analysis.


---


---

## **Objective**

Identify real-world problems in water consumption tracking and define a system scope with Oracle PL/SQL database and BI potential.

---

## **Problem Definition**

* Manual recording leads to errors, delays, and inconsistent data.
* Difficulty auditing consumption and tracking anomalies.
* Reporting is slow and not real-time, affecting decision-making.

---

## **Context**

The system will operate across **districts, sectors, and irrigation zones**, used by administrators, technicians, auditors, and planners to ensure accurate water tracking and reporting.

---

## **Target Users**

1. Water Meter Administrators
2. Field Technicians / Employees
3. Auditors / Managers
4. Government / Water Authorities

---

## **Project Goals / Expected Outcomes**

* Automate consumption recording
* Enforce business rules (weekday/holiday restrictions)
* Audit all changes
* Accurate reporting and BI dashboards
* Reduce errors, improve operational efficiency

---

## **BI Potential**

* Track sector/location water usage trends
* Identify anomalies and potential leaks
* Generate KPIs for resource planning
* Support predictive irrigation management

---


---

## **Deliverable**



* (https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Document/Phase_I_Problem_Identification.pdf) → This PDF includes all above sections, ready for GitHub submission.

---



---

## Phase II – Business Process Modeling (BPMN)

**Objective:** Model the business process for recording and managing water consumption to ensure accurate tracking, auditing, and reporting.

**Actors / Swimlanes:**
1. Water Meter Administrator – Adds and maintains meters
2. System User (Employee/Technician) – Records consumption
3. System / Database – Validates, stores, and enforces rules
4. Auditor / Manager – Reviews consumption and generates reports

**Key Activities:**
- Start Event: Employee initiates consumption recording
- Validate Meter ID (active/inactive)
- Check Date Restrictions (weekday/public holiday)
- Record Consumption (insert if allowed)
- Audit Logging (log all attempts)
- Update BI Dashboard
- End Event: Process complete

**Decision Points:**
- Meter Active? → Yes: proceed / No: stop & log error
- Day Allowed? → Yes: insert / No: log denied attempt


**Tools:** bpmn
![Here are the bpmn that shows my project ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Diagram/bpmn-c.jpeg?raw=true)

---

## Phase III – Logical Database Design (ER Diagram & Data Dictionary)

**Entities (Tables):**
- **LOCATIONS:** LOCATION_ID (PK), DISTRICT, SECTOR, ZONE
- **WATER_SECTORS:** SECTOR_ID (PK), SECTOR_NAME
- **WATER_METERS:** METER_ID (PK), LOCATION_ID (FK), SECTOR_ID (FK), METER_STATUS
- **WATER_CONSUMPTION:** CONSUMPTION_ID (PK), METER_ID (FK), CONSUMPTION_DATE, VOLUME
- **SYSTEM_USERS:** USER_ID (PK), USERNAME, ROLE

**Support Tables:**
- HOLIDAYS – Restricted DML dates
- AUDIT_LOG – Records all data operations

**Relationships:**
- LOCATIONS → WATER_METERS (1:N)
- WATER_SECTORS → WATER_METERS (1:N)
- WATER_METERS → WATER_CONSUMPTION (1:N)
- SYSTEM_USERS → AUDIT_LOG (1:N)

**Normalization:** All tables in 3NF (no repeating groups, no partial or transitive dependencies)

**Sequences:** LOCATIONS_SEQ, SECTORS_SEQ, METER_SEQ, CONSUMPTION_SEQ, USERS_SEQ

**BI Considerations:** Fact table = WATER_CONSUMPTION; Dimensions = LOCATIONS, WATER_SECTORS, SYSTEM_USERS

![Here are the ER diagram that shows my project ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Diagram/ER%20diagram-c.jpeg?raw=true)

![Here are the ER diagram that shows my project ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Diagram/er%20diagram%20of%20the%20project.png?raw=true)



---



# **Phase IV: Database Creation (Oracle PDB) -

## **Overview**
Successfully created a complete Oracle database environment for the Smart Water Tracker system using Oracle's Pluggable Database (PDB) architecture.

## **Accomplished Tasks**

### **1. Database Setup**
- Created Pluggable Database (PDB): **`Thur_27386_charles_SWIT_DB`**
- Configured with admin user: **`switracker`** (password: `Murenzi`)
- Database files stored in: `C:\dbms_oracle\oradata\XE\Thur_27386_charles_SWIT_DB\`
![Database created and operational  ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/creation%20of%20pdb%20and%20tablespace.png?raw=true)

### **2. Storage Structure**
Created three specialized storage areas (tablespaces):
- **`water_consomation`** - Main storage for application data (100MB, auto-extending)
- **`water_index`** - For database performance indexes (50MB, auto-extending)  
- **`water_temp`** - Temporary workspace for database operations (50MB, auto-extending)
![table space ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/creation%20of%20pdb%20and%20tablespace.png?raw=true)

### **3. Security & Access**
- Created dedicated admin account: **`switracker`**
- Granted full privileges: CONNECT, RESOURCE, and DBA roles
- Configured proper access controls and storage quotas

### **4. Connection Ready**
- Database is open and accessible
- Can connect via SQL Developer using:
- Admin user created with full privileges  
  - Username: `switracker`
  - Password: `Murenzi`
  - Service: `Thur_27386_charles_SWIT_DB`
![Admin user created with full privileges ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/pldeveloper%20for%20pdb%20connection.png?raw=true)



## Phase V – Table Implementation & Data Insertion

**Objective:** Implement physical tables, populate with realistic test data, and validate integrity.

**Table Implementation:**
- Core tables and support tables created with proper Oracle data types
- PKs, FKs, and constraints (NOT NULL, UNIQUE, CHECK, DEFAULT) enforced
- Indexes created for performance optimization
![Here are the tables shows my project ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/creation%20of%20tables.png?raw=true)


**Data Insertion:**
- Hundreds of realistic rows per main table
- Includes normal and edge cases
- Validates all constraints and business rules
[data insering](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Script/insert%20test%20phasev.sql)

**Data Integrity Verification:**
- All constraints enforced
- Foreign key relationships verified
- Completeness and logical consistency checked

**Testing Coverage:**
- Basic retrieval queries
- Multi-table joins
- Aggregations
- Logical consistency confirmed

[data testing](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Script/insert%20test%20phasev.sql)

---


---



## **Phase VI – Database Interaction & Transactions**

**Objective:** Implement PL/SQL procedures, functions, cursors, window functions, and packages to interact with the database.

**Deliverables:**

* 5 functions for validation, calculation, and lookup:

  * `is_valid_meter`, `get_total_consumption`, `get_average_consumption`, `get_max_consumption`, `get_user_role`

→  [function script](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Script/all-function.sql)

   ![Here are the function that shows my project ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/creation%20of%20function.png)

 * Procedure to log DML operations consistently

 → [procedure ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Script/all-procedure%20created.sql)
   
  ![Here are the procedure that shows my project ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/creation%20of%20the%20all%20procedures.png)

* Explicit and bulk collect cursors for multi-row processing
→ [cursor script ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Script/all-cursor.sql)
  
![Here are the cursor that shows my project ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/cursor%20creation%20.png)
    
* Window functions (`RANK()`, `DENSE_RANK()`, `LAG()`, `LEAD()`) for ranking and month-to-month comparisons

→ [Window function queries](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Script/window%20functio.sql)
 
![Here are the window function that shows my project ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/table%20of%20windowfunction1.png)
  
* PL/SQL package `switracker_pkg` containing all procedures and functions with exception handling

[Package specification & Package body](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./tree/main/Script)



![Here are the package and exception handling  for my project ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/package%20creation.png)
* Testing scripts to validate functions, cursors, and packages

**Where to Put Scripts:**


---
---

## **Phase VII – Advanced Programming & Auditing**

**Objective:**
Enforce business rules using triggers and ensure all database activities are audited.

---

### **Business Rule**

Employees are **NOT allowed** to perform **INSERT, UPDATE, or DELETE** operations:

* ❌ On **weekdays (Monday–Friday)**
* ❌ On **public holidays**

Only **weekend operations** are allowed.

---

### **Support Tables**

* **HOLIDAYS**
  Stores official public holiday dates used to restrict database operations.

* **AUDIT_LOG**
  Records **all DML attempts** (allowed or denied), including:

  * Username
  * Operation type
  * Date & time
  * Status (ALLOWED / DENIED)
 
    [table support creation ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Script/phase7%20creation%20of%20tables.sql)

 ![creation of suport tables ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/creation%20of%20the%20tables%20for%20phase7.png?raw=true)

---

### **Triggers & Enforcement**

* **Restriction Trigger**

  * Checks the current day and holiday status before any DML operation
  * Blocks restricted operations with a clear error message

* **Audit Trigger**

  * Logs every INSERT, UPDATE, or DELETE attempt
  * Records both successful and blocked actions

---
[trigers script](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/Script/trigers%20.sql)

 ![creation of triggers ](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/all_screenshots/trigers%20creation%20.png?raw=true)


**Deliverables:**

* `HOLIDAYS` table → Stores restricted dates
* `AUDIT_LOG` table → Logs all DML attempts (user, action, table, timestamp, status, message)
* 
* Procedure to log DML operations consistently
* Function to check restriction based on day and holidays
* Simple triggers enforcing restriction rules and logging attempts
* Compound triggers for statement-level auditing and enforcement
* Tested all scenarios: weekdays (DENIED), weekends (ALLOWED), public holidays (DENIED)

--- 
---



# **PHASE VIII – Business Intelligence & Oracle Enterprise Manager (OEM)**

## **Objective**

To monitor database performance using **Oracle Enterprise Manager (OEM)** and apply **Business Intelligence (BI)** techniques to support decision-making through analytics, KPIs, and dashboards.

---

## **Part A: Oracle Enterprise Manager (OEM)**

### **Purpose of OEM**

Oracle Enterprise Manager is used to:

* Monitor database performance
* Track resource usage
* Detect bottlenecks
* Ensure system stability and availability

---

### **OEM Configuration**

* Connected to Oracle Database 21c XE
* Logged in using:

  * **Username:** Thur_27386_charles_SWIT_DB **
  * container :** switracker **
  * **Password:** Murenzi
* Database monitored locally through OEM web console

---

### **OEM Monitoring Areas Covered**
[oracle enterprise login](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/OEM/oem%20login.png)
* CPU usage
* Memory utilization
* Active sessions
* Tablespace usage
* SQL execution performance

---

### **OEM Evidence **


* OEM dashboard overview
  ![the dashboard overview](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/OEM/oem.html)
* CPU and memory performance graphs
  ![ CPU and memory performance graphs](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/OEM/oem%20performance.png)
  
* Active sessions monitoring
  ![Active sessions monitoring](https://github.com/Murenz467/Smart-Water-Distribution-Irrigation-Tracking-System./blob/main/OEM/oem%20performance.png)
* Database health status
---

## **Part B: Business Intelligence (BI)**

### **BI Objective**

To transform water consumption data into **meaningful insights** that support planning, monitoring, and policy decisions.

---

### **Key Stakeholders**

* Water utility managers
* System administrators
* Auditors
* Government planners

---

### **Key Performance Indicators (KPIs)**

* Total water consumption per sector
* Monthly consumption trends
* Highest and lowest consuming meters
* Consumption growth or decline by location
* Number of restricted or denied transactions

---



---

### **Dashboard Mockups**

The following BI dashboards were designed:

1. **Executive Summary Dashboard**

   * KPI cards
   * Monthly consumption trends

2. **Audit & Compliance Dashboard**

   * Denied vs allowed operations
   * Activity over time

3. **Performance Dashboard**

   * Sector-wise consumption
   * Meter efficiency comparison



---





## **References**

* Oracle Corporation. (2021). Oracle Database 21c Documentation. [https://docs.oracle.com/en/database/oracle/oracle-database/21/](https://docs.oracle.com/en/database/oracle/oracle-database/21/)
* Feuerstein, S., & Pribyl, B. (2021). Oracle PL/SQL Programming (7th ed.). O'Reilly Media.
* Connolly, T., & Begg, C. (2015). Database Systems: A Practical Approach to Design, Implementation, and Management (6th ed.). Pearson.
* Elmasri, R., & Navathe, S. B. (2016). Fundamentals of Database Systems (7th ed.). Pearson.
* Date, C. J. (2019). Database Design and Relational Theory: Normal Forms and All That Jazz (2nd ed.). Apress.

---

## **Acknowledgment**

I sincerely thank Mr. Eric Maniraguha and the IT Faculty at AUCA for their guidance, support, and advice while I was studing this course.

---


---

**Declaration:**  

I confirm that this work is original and complies with AUCA’s academic integrity 
policy. All code, documentation, and testing results were generated individually 
for this Capstone Project.


---

## **Delivery Requirements**

* **Course:** Database Development with PL/SQL (INSY 8311)
* **Academic Year:** 2025-2026 | Semester: I
* **Institution:** Adventist University of Central Africa (AUCA)
* **Project Completion Date:** December 9, 2025

---



---

> "Good health starts with proper tracking and care."

---

