# 🏠 Airbnb Analytics Engineering Platform using Snowflake, dbt & AWS

## 📌 Project Overview

This project demonstrates the implementation of an end-to-end cloud-based Analytics Engineering platform using Snowflake, dbt, and AWS.

The solution follows the Medallion Architecture pattern (Bronze → Silver → Gold) to transform raw Airbnb operational data into trusted, analytics-ready datasets. The project incorporates modern data engineering best practices including incremental data loading, Slowly Changing Dimensions (SCD Type 2), data quality testing, reusable macros, and dimensional modeling.

The primary goal is to simulate a real-world analytics environment where raw business data is transformed into reliable datasets for reporting, dashboarding, and decision-making.

---

## 🎯 Business Problem

Airbnb generates large volumes of operational data related to:

* Property Listings
* Hosts
* Bookings

Raw source data is not immediately suitable for analytical consumption because:

* Data quality issues may exist
* Historical changes are not tracked
* Business metrics are not readily available
* Data resides across multiple datasets

This project addresses these challenges by building a scalable ELT pipeline that standardizes, validates, enriches, and models Airbnb data for downstream analytics.

---

# 🏗️ Solution Architecture

## High-Level Architecture

```text
                 ┌─────────────────┐
                 │ Airbnb CSV Data │
                 └────────┬────────┘
                          │
                          ▼
                 ┌─────────────────┐
                 │     AWS S3      │
                 │ Landing Zone    │
                 └────────┬────────┘
                          │
                          ▼
                 ┌─────────────────┐
                 │   Snowflake     │
                 │ Staging Layer   │
                 └────────┬────────┘
                          │
      ┌───────────────────┼───────────────────┐
      ▼                   ▼                   ▼

 Bronze Layer      Silver Layer        Gold Layer

 Raw Data          Cleaned Data      Analytics Data
 Incremental       Standardized      Fact Tables
 Processing        Enriched          OBT
                                      Reporting

                          │
                          ▼

               BI / Reporting / Analytics
```

---

# 🛠️ Technology Stack

| Category             | Technology             |
| -------------------- | ---------------------- |
| Cloud Data Warehouse | Snowflake              |
| Transformation Layer | dbt                    |
| Cloud Storage        | AWS S3                 |
| Programming Language | Python                 |
| Version Control      | Git                    |
| SQL Templating       | Jinja                  |
| Data Modeling        | Star Schema            |
| Historical Tracking  | SCD Type 2             |
| Architecture         | Medallion Architecture |

---

# 📊 Data Architecture

## 🥉 Bronze Layer

Purpose:

Store raw source data with minimal transformations.

Models:

* bronze_bookings
* bronze_hosts
* bronze_listings

Responsibilities:

* Preserve source data
* Enable incremental ingestion
* Maintain auditability
* Serve as source of truth

---

## 🥈 Silver Layer

Purpose:

Clean, validate, and standardize raw datasets.

Transformations:

* Data type standardization
* Null handling
* Data quality validation
* Attribute enrichment
* Price categorization

Models:

* silver_bookings
* silver_hosts
* silver_listings

---

## 🥇 Gold Layer

Purpose:

Provide analytics-ready datasets for business users.

Models:

* fact
* obt (One Big Table)
* ephemeral models

Business Use Cases:

* Revenue Analysis
* Booking Trend Analysis
* Host Performance Tracking
* Listing Performance Analysis
* Occupancy Reporting

---

# 📚 Slowly Changing Dimensions (SCD Type 2)

The project uses dbt Snapshots to maintain historical changes.

Snapshot Models:

* dim_bookings
* dim_hosts
* dim_listings

Benefits:

* Historical reporting
* Point-in-time analysis
* Change tracking
* Auditability

---

# 📁 Project Structure

```text
AWS_DBT_Snowflake/
│
├── README.md
├── pyproject.toml
├── main.py
│
├── SourceData/
│   ├── bookings.csv
│   ├── hosts.csv
│   └── listings.csv
│
├── DDL/
│   ├── ddl.sql
│   └── resources.sql
│
└── aws_dbt_snowflake_project/
    │
    ├── dbt_project.yml
    ├── ExampleProfiles.yml
    │
    ├── models/
    │   ├── sources/
    │   ├── bronze/
    │   ├── silver/
    │   └── gold/
    │
    ├── macros/
    ├── snapshots/
    ├── analyses/
    ├── tests/
    └── seeds/
```

---

# 🚀 Getting Started

## Prerequisites

Before running this project, ensure the following are available:

### Snowflake

* Snowflake Account
* Database Access
* Warehouse Access

### Python

* Python 3.12+
* pip

### AWS

* AWS Account
* S3 Bucket (optional)

---

# ⚙️ Installation

## Clone Repository

```bash
git clone <repository-url>
cd AWS_DBT_Snowflake
```

---

## Create Virtual Environment

### Windows

```bash
python -m venv .venv
.venv\Scripts\Activate.ps1
```

### Linux / Mac

```bash
python -m venv .venv
source .venv/bin/activate
```

---

## Install Dependencies

```bash
pip install -r requirements.txt
```

or

```bash
pip install -e .
```

---

## Core Dependencies

```text
dbt-core>=1.11
dbt-snowflake>=1.11
sqlfmt
```

---

# 🔑 Snowflake Configuration

Create:

```text
~/.dbt/profiles.yml
```

```yaml
aws_dbt_snowflake_project:
  outputs:
    dev:
      account: <account_identifier>
      database: AIRBNB
      password: <password>
      role: ACCOUNTADMIN
      schema: dbt_schema
      threads: 4
      type: snowflake
      user: <username>
      warehouse: COMPUTE_WH
  target: dev
```

---

# 🏗️ Database Setup

Execute DDL scripts located inside:

```text
DDL/
```

This creates:

* Staging Tables
* Required Database Objects

---

# 📥 Source Data Loading

Load source CSV files into Snowflake staging schema.

| File         | Target Table            |
| ------------ | ----------------------- |
| bookings.csv | AIRBNB.STAGING.BOOKINGS |
| hosts.csv    | AIRBNB.STAGING.HOSTS    |
| listings.csv | AIRBNB.STAGING.LISTINGS |

---

# ▶️ Running dbt

## Verify Connection

```bash
dbt debug
```

---

## Install Packages

```bash
dbt deps
```

---

## Run All Models

```bash
dbt run
```

---

## Run Bronze Layer

```bash
dbt run --select bronze.*
```

---

## Run Silver Layer

```bash
dbt run --select silver.*
```

---

## Run Gold Layer

```bash
dbt run --select gold.*
```

---

## Execute Tests

```bash
dbt test
```

---

## Run Snapshots

```bash
dbt snapshot
```

---

## Build Entire Project

```bash
dbt build
```

---

## Generate Documentation

```bash
dbt docs generate
dbt docs serve
```

---

# ⚡ Key Features

## Incremental Processing

The Bronze and Silver layers use incremental materialization to process only newly arrived records.

Example:

```sql
{{ config(materialized='incremental') }}

{% if is_incremental() %}

WHERE CREATED_AT >
(
    SELECT COALESCE(MAX(CREATED_AT),'1900-01-01')
    FROM {{ this }}
)

{% endif %}
```

Benefits:

* Reduced warehouse costs
* Faster execution
* Scalable architecture

---

## Custom Macros

Reusable business logic is implemented using dbt macros.

Example:

```sql
{{ tag('CAST(PRICE_PER_NIGHT AS INT)') }}
```

Output:

```text
LOW
MEDIUM
HIGH
```

---

## Dynamic SQL using Jinja

The OBT model leverages Jinja loops to dynamically generate SQL.

Example:

```sql
{% set configs = [...] %}

SELECT

{% for config in configs %}

...

{% endfor %}
```

Benefits:

* Less repetitive code
* Improved maintainability
* Easier model expansion

---

## SCD Type 2 Snapshots

Historical records are tracked using dbt snapshots.

Features:

* Valid From Date
* Valid To Date
* Current Record Indicator
* Historical State Tracking

---

## Schema Management

Custom schema generation automatically routes models into dedicated schemas.

Example:

```text
AIRBNB.BRONZE
AIRBNB.SILVER
AIRBNB.GOLD
```

---

# ✅ Data Quality Framework

Implemented Data Quality Checks:

* Unique Key Validation
* Not Null Validation
* Source Integrity Checks
* Business Rule Validation
* Referential Integrity Testing

Example:

```bash
dbt test
```

---

# 🔍 Data Lineage

dbt automatically generates lineage graphs showing:

* Source Dependencies
* Upstream Relationships
* Downstream Impacts
* Model Dependencies

Generate lineage using:

```bash
dbt docs generate
dbt docs serve
```

---

# 📈 Analytics Use Cases

The Gold Layer supports the following analytical use cases:

### Revenue Analysis

Identify top-performing properties and revenue trends.

### Host Performance

Evaluate host effectiveness and booking performance.

### Booking Trends

Analyze booking behavior over time.

### Property Analysis

Compare listing performance across categories.

### Historical Reporting

Leverage SCD Type 2 snapshots for point-in-time analysis.

---

# 💡 Skills Demonstrated

This project demonstrates hands-on experience in:

* Snowflake Data Warehousing
* Analytics Engineering
* dbt Development
* ELT Pipeline Design
* Medallion Architecture
* Incremental Loading
* SCD Type 2 Snapshots
* Data Modeling
* Fact & Dimension Design
* Data Quality Engineering
* SQL Development
* Jinja Templating
* Git Version Control
* AWS S3 Integration

---

# 🔒 Security Best Practices

* Credentials excluded from version control
* Role-Based Access Control (RBAC)
* Environment-specific configurations
* Schema-level separation
* Principle of least privilege

---

# 🐛 Troubleshooting

## Snowflake Connection Errors

```bash
dbt debug
```

Verify:

* Username
* Password
* Account Identifier
* Warehouse Name

---

## Compilation Errors

Verify:

* dbt_project.yml
* Jinja Syntax
* Source Definitions
* Model Dependencies

---

## Incremental Model Issues

Run full refresh:

```bash
dbt run --full-refresh
```

---

# 📊 Future Enhancements

* Apache Airflow Orchestration
* CI/CD using GitHub Actions
* Data Observability
* Automated Monitoring
* Power BI Integration
* Tableau Integration
* Data Masking for PII
* Real-Time Data Ingestion
* Cost Optimization Dashboards

---

# 👨‍💻 Author

**Project:** Airbnb Analytics Engineering Platform

**Tech Stack:** Snowflake | dbt | AWS | SQL | Python | Git

This project was developed as a hands-on implementation of modern Data Engineering and Analytics Engineering practices using the Modern Data Stack.


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
