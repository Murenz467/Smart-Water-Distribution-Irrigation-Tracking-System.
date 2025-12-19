# Smart-Water-Distribution-Irrigation-Tracking-System.

# Smart Water Distribution & Irrigation Management System
** PL/SQL  Project**

![Status](https://img.shields.io/badge/Status-Completed-success)
![Phases](https://img.shields.io/badge/Phases-II_to_V_Done-blue)
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

* `/documentation/Phase_I_Problem_Identification.pdf` → This PDF includes all above sections, ready for GitHub submission.

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


**Tools:** Lucidchart, draw.io, Canva (use swimlanes for actors)

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

---

## Phase V – Table Implementation & Data Insertion

**Objective:** Implement physical tables, populate with realistic test data, and validate integrity.

**Table Implementation:**
- Core tables and support tables created with proper Oracle data types
- PKs, FKs, and constraints (NOT NULL, UNIQUE, CHECK, DEFAULT) enforced
- Indexes created for performance optimization

**Support Tables:**
- HOLIDAYS: Stores restricted dates
- AUDIT_LOG: Tracks all insert/update/delete attempts

**Data Insertion:**
- Hundreds of realistic rows per main table
- Includes normal and edge cases
- Validates all constraints and business rules

**Data Integrity Verification:**
- All constraints enforced
- Foreign key relationships verified
- Completeness and logical consistency checked

**Testing Coverage:**
- Basic retrieval queries
- Multi-table joins
- Aggregations
- Logical consistency confirmed


---


---



## **Phase VI – Database Interaction & Transactions**

**Objective:** Implement PL/SQL procedures, functions, cursors, window functions, and packages to interact with the database.

**Deliverables:**

* 5 functions for validation, calculation, and lookup:

  * `is_valid_meter`, `get_total_consumption`, `get_average_consumption`, `get_max_consumption`, `get_user_role`
* Explicit and bulk collect cursors for multi-row processing
* Window functions (`RANK()`, `DENSE_RANK()`, `LAG()`, `LEAD()`) for ranking and month-to-month comparisons
* PL/SQL package `switracker_pkg` containing all procedures and functions with exception handling
* Testing scripts to validate functions, cursors, and packages

**Where to Put Scripts:**

* `/database/scripts/switracker_pkg_spec.sql` → Package specification
* `/database/scripts/switracker_pkg_body.sql` → Package body
* `/queries/analytics_queries.sql` → Window function queries
* `/queries/test_phaseVI.sql` → Test scripts

---

## **Phase VII – Advanced Programming & Auditing**

**Objective:** Enforce business rules, implement triggers, and perform auditing.

**Business Rules:**

* Employees cannot INSERT/UPDATE/DELETE:

  * ❌ Weekdays (Monday–Friday)
  * ❌ Public holidays
* Operations allowed only on weekends

**Deliverables:**

* `HOLIDAYS` table → Stores restricted dates
* `AUDIT_LOG` table → Logs all DML attempts (user, action, table, timestamp, status, message)
* Procedure to log DML operations consistently
* Function to check restriction based on day and holidays
* Simple triggers enforcing restriction rules and logging attempts
* Compound triggers for statement-level auditing and enforcement
* Tested all scenarios: weekdays (DENIED), weekends (ALLOWED), public holidays (DENIED)

**Where to Put Scripts:**

* `/database/scripts/11_Restriction_Trigger.sql` → Restriction triggers
* `/database/scripts/12_Audit_Trigger.sql` → Audit logging triggers














---

**Declaration:**  
I confirm that this work is original and complies with AUCA’s academic integrity policy. All code, documentation, and testing results were generated individually for this Capstone Project.







