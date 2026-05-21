USE DATABASE yelp_db;

create or replace table yelp_businesses(review_text variant)



COPY INTO yelp_businesses
FROM 's3://ishfaq-yelp-data-2026/yelp_academic_dataset_business.json'
CREDENTIALS = (
    AWS_KEY_ID = '****'
    AWS_SECRET_KEY = '***********'
)
FILE_FORMAT = (
    TYPE = JSON
);

CREATE OR REPLACE TABLE tbl_yelp_businesses AS 
SELECT 
    REVIEW_TEXT:business_id::STRING AS business_id,
    REVIEW_TEXT:name::STRING AS name,
    REVIEW_TEXT:city::STRING AS city,
    REVIEW_TEXT:state::STRING AS state,
    REVIEW_TEXT:review_count::NUMBER AS review_count,
    REVIEW_TEXT:stars::NUMBER AS stars,
    REVIEW_TEXT:categories::STRING AS categories
FROM yelp_businesses



DESC TABLE yelp_businesses;
select * from tbl_yelp_businesses 
