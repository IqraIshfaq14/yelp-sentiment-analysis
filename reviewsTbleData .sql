
USE WAREHOUSE COMPUTE_WH;

CREATE DATABASE IF NOT EXISTS yelp_db;
USE DATABASE yelp_db;

CREATE SCHEMA IF NOT EXISTS raw_data;
USE SCHEMA raw_data;

CREATE OR REPLACE TABLE yelp_reviews (
    review_text VARIANT
);

COPY INTO yelp_reviews
FROM 's3://ishfaq-yelp-data-2026/'
CREDENTIALS = (
    AWS_KEY_ID = '******'
    AWS_SECRET_KEY = '******'
)
FILE_FORMAT = (
    TYPE = JSON
);
 
CREATE OR REPLACE TABLE tbl_yelp_reviews AS
SELECT
    review_text:business_id::STRING AS business_id,
    review_text:date::DATE AS review_date,
    review_text:user_id::STRING AS user_id,
    review_text:stars::NUMBER AS review_stars,
    review_text:text::STRING AS review_text_value,
    analyze_sentiment(review_text:text::STRING) AS sentiment
FROM yelp_reviews;
--limit 1000

select * from ylp_table_reviews