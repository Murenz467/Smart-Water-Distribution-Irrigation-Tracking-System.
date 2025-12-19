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

**Phase V Completion:** ✔ Tables created ✔ Support tables added ✔ Data inserted ✔ Integrity verified

---

**Next Phases:** Phase VI (PL/SQL Development) and Phase VII (Advanced Programming & Auditing) will build procedures, functions, packages, triggers, and business rules.

---

**Declaration:**  
I confirm that this work is original and complies with AUCA’s academic integrity policy. All code, documentation, and testing results were generated individually for this Capstone Project.

