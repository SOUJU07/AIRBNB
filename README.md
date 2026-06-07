# Airbnb Analytics Platform | Snowflake + dbt + AWS

## Project Overview

This project demonstrates the design and implementation of a modern cloud-based data platform for Airbnb analytics using Snowflake, dbt, and AWS.

The solution follows the Medallion Architecture pattern (Bronze → Silver → Gold) to transform raw operational data into trusted, analytics-ready datasets. It incorporates data modeling best practices, incremental processing, Slowly Changing Dimensions (SCD Type 2), automated testing, and reusable transformation logic.

The objective of this project is to simulate a real-world analytics engineering workflow where raw business data is transformed into reliable datasets that support reporting, dashboarding, and decision-making.

---

## Business Problem

Airbnb generates large volumes of booking, host, and property listing data on a daily basis. Raw operational data is difficult for business users to consume directly because:

* Data quality issues may exist
* Historical changes need to be tracked
* Multiple datasets must be joined together
* Analytics teams require curated and trusted data assets

This project addresses these challenges by building a scalable ELT pipeline capable of transforming raw data into business-ready analytical models.

---

## Solution Architecture

```text
                ┌──────────────────┐
                │   Source CSVs    │
                └────────┬─────────┘
                         │
                         ▼
                ┌──────────────────┐
                │      AWS S3      │
                │   Data Landing   │
                └────────┬─────────┘
                         │
                         ▼
                ┌──────────────────┐
                │    Snowflake     │
                │  Staging Layer   │
                └────────┬─────────┘
                         │
         ┌───────────────┼────────────────┐
         ▼               ▼                ▼

    Bronze Layer    Silver Layer     Gold Layer
   (Raw Models)   (Clean Models)   (Business Models)

         ▼               ▼                ▼

   Incremental      Data Quality      Fact Tables
   Processing       Standardization   Dimensions
                                     Analytics OBT

                         ▼

                BI / Reporting Layer
```

---

## Technology Stack

| Component            | Technology             |
| -------------------- | ---------------------- |
| Cloud Data Warehouse | Snowflake              |
| Data Transformation  | dbt                    |
| Cloud Storage        | AWS S3                 |
| Programming Language | Python                 |
| Version Control      | Git                    |
| Data Modeling        | Star Schema            |
| Historical Tracking  | SCD Type 2             |
| Framework            | Medallion Architecture |

---

## Data Pipeline Design

### Bronze Layer

Purpose:
Store raw source data with minimal transformation.

Tables:

* bronze_bookings
* bronze_hosts
* bronze_listings

Responsibilities:

* Preserve source records
* Incremental ingestion
* Schema consistency
* Auditability

---

### Silver Layer

Purpose:
Create standardized and trusted datasets.

Transformations:

* Null handling
* Data type standardization
* Business rule validations
* Derived attributes
* Price categorization
* Data enrichment

Tables:

* silver_bookings
* silver_hosts
* silver_listings

---

### Gold Layer

Purpose:
Provide analytics-ready datasets for reporting and business intelligence.

Artifacts:

* Fact tables
* Dimensional models
* One Big Table (OBT)
* Reporting datasets

Business Use Cases:

* Revenue analysis
* Booking trends
* Host performance
* Listing performance
* Occupancy metrics

---

## Key Features

### Incremental Data Processing

Implemented incremental dbt models to process only new or modified records, reducing execution time and warehouse consumption.

Benefits:

* Faster runs
* Lower compute costs
* Scalable architecture

---

### Slowly Changing Dimensions (SCD Type 2)

Implemented snapshot-based historical tracking to preserve record changes over time.

Tracked Entities:

* Hosts
* Listings
* Bookings

Benefits:

* Historical reporting
* Point-in-time analysis
* Change tracking

---

### Reusable dbt Macros

Created custom Jinja macros to reduce code duplication and standardize transformation logic across models.

Examples:

* Price categorization
* String standardization
* Dynamic SQL generation

---

### Automated Data Quality Checks

Implemented testing framework to validate:

* Unique keys
* Null values
* Source integrity
* Business rules
* Referential consistency

---

## Data Modeling Approach

The project follows dimensional modeling principles.

### Fact Table

Contains measurable business events:

* Booking transactions
* Revenue metrics
* Stay duration

### Dimension Tables

Provide descriptive business context:

* Host information
* Listing information
* Historical attributes

This approach enables efficient analytical querying and dashboard development.

---

## dbt Capabilities Implemented

* Incremental Models
* Snapshots
* Custom Macros
* Source Definitions
* Data Tests
* Documentation Generation
* Jinja Templating
* Layered Data Architecture

---

## Sample Analytics Questions Answered

* Which listings generate the highest revenue?
* What is the booking trend over time?
* Which hosts have the highest occupancy rates?
* How do pricing categories impact bookings?
* How have listing attributes changed historically?

---

## Skills Demonstrated

* Snowflake Data Warehousing
* Analytics Engineering
* dbt Development
* Data Modeling
* SQL Optimization
* Incremental Loading
* SCD Type 2
* ELT Pipeline Design
* Data Quality Engineering
* Cloud Data Platforms

---

## Future Enhancements

* CI/CD Integration using GitHub Actions
* Automated Orchestration using Apache Airflow
* Real-time Data Ingestion
* Data Observability Layer
* BI Dashboard Integration
* Cost Monitoring and Optimization
* Role-Based Access Control (RBAC)

---

## Project Outcome

Successfully designed and implemented a scalable cloud-native analytics platform that transforms raw Airbnb operational data into trusted business datasets using Snowflake and dbt. The solution demonstrates modern data engineering and analytics engineering best practices including Medallion Architecture, Incremental Processing, SCD Type 2 implementation, Data Quality Testing, and Dimensional Modeling.



### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
