# yelp-sentiment-analysis
# End-to-End Yelp Review Sentiment Analysis Project

## Project Overview
This project demonstrates an end-to-end cloud-based data analytics pipeline using the Yelp Open Dataset.  
The project includes data ingestion, cloud storage, sentiment analysis using Python UDFs, and business KPI analysis using Snowflake SQL.

---

## Architecture

Yelp JSON Dataset → Python Processing → AWS S3 → Snowflake → Sentiment Analysis → SQL KPIs

---
## AWS S3 Storage

Uploaded Yelp JSON datasets to AWS S3 for cloud-based ingestion into Snowflake.

![AWS S3 Bucket](screenshots/aws_s3_bucket.png)

## Technologies Used

- Python
- AWS S3
- Snowflake
- SQL
- Python UDF
- TextBlob
- JSON
- Window Functions
- CTEs
- Sentiment Analysis

---

## Dataset Source

Yelp Open Dataset:

- https://business.yelp.com/data/resources/open-dataset/

Yelp Data Resources:

- https://business.yelp.com/data/resources/pricing/

---

## Project Workflow

### 1. Data Extraction
- Downloaded Yelp Open Dataset JSON files
- Large review dataset (~5GB+) processed locally

### 2. Data Processing using Python
- Split large JSON files into smaller chunks
- Prepared files for cloud upload

### 3. Cloud Storage
- Uploaded JSON datasets to AWS S3 bucket

### 4. Snowflake Data Warehouse
- Created database and schemas
- Loaded JSON data from S3 into Snowflake
- Flattened semi-structured JSON data

### 5. Sentiment Analysis
- Created Python UDF using TextBlob
- Classified reviews into:
  - Positive
  - Neutral
  - Negative

### 6. Business KPI Analysis
Performed analytical SQL queries including:
- Top reviewed businesses
- Top restaurant reviewers
- 5-star review percentage
- Most recent reviews
- Business category analysis
- Positive sentiment rankings
- City-wise business review analysis

---

## Snowflake Features Used

- VARIANT data type
- LATERAL FLATTEN / SPLIT_TO_TABLE
- Window Functions
- CTEs
- Python UDFs
- Aggregations
- Joins
- Sentiment Classification

---

## Folder Structure

```text
project/
│
├── sql/
│   ├── 01_data_loading.sql
│   ├── 02_business_table_creation.sql
│   ├── 03_sentiment_analysis_udf.sql
│   └── 04_business_kpis.sql
│
├── screenshots/
│
├── architecture/
│
└── README.md
