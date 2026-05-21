01-- Find number of business in each category
USE DATABASE yelp_db;
USE SCHEMA raw_data;

SELECT * 
FROM tbl_yelp_businesses
LIMIT 10;

WITH bht AS (
    SELECT 
        business_id,
        TRIM(x.value::STRING) AS category
    FROM tbl_yelp_businesses,
    LATERAL SPLIT_TO_TABLE(categories, ',') AS x
)
SELECT 
    category,
    COUNT(*) AS nm_of_business
FROM bht
GROUP BY category
ORDER BY nm_of_business DESC;


----02 Find the top 10 user who have reviewed the most businesses in the restaurants category 

SELECT 
    r.user_id, 
    COUNT(DISTINCT b.business_id) AS number_of_businesses
FROM tbl_yelp_reviews r 
INNER JOIN tbl_yelp_businesses b 
    ON r.business_id = b.business_id
WHERE b.categories ILIKE '%restaurant%'
GROUP BY r.user_id
ORDER BY number_of_businesses DESC
LIMIT 10;

--03 Find the most popular categories of businesses(based on reviews)
WITH bht AS (
    SELECT 
        business_id,
        TRIM(x.value::STRING) AS category
    FROM tbl_yelp_businesses,
    LATERAL SPLIT_TO_TABLE(categories, ',') AS x
)
select category, count(*) as nm_of_reviews
from bht
inner join tbl_yelp_reviews r on bht.business_id= r.business_id
group by 1
order by 2 desc;

--04 Find the top 3 most recent reviews for each business 
WITH cte AS (
    SELECT 
        r.*,
        b.name,
        ROW_NUMBER() OVER (
            PARTITION BY r.business_id 
            ORDER BY r.review_date DESC
        ) AS rn
    FROM tbl_yelp_reviews r
    INNER JOIN tbl_yelp_businesses b 
        ON r.business_id = b.business_id
    WHERE r.review_date IS NOT NULL
      AND r.user_id IS NOT NULL
      AND r.review_text_value IS NOT NULL
)
SELECT *
FROM cte
WHERE rn <= 3;

-- 05 Find the month with highest number of reviews
select  month(review_date) as review_month, count(*) as nm_of_reviews

from tbl_yelp_reviews
group by 1
order by 2 desc;

--06 Find the % of 5 star review of each businesses
SELECT 
    b.business_id, 
    b.name, 
    COUNT(*) AS total_reviews,
    SUM(CASE WHEN r.review_stars = 5 THEN 1 ELSE 0 END) AS five_star_reviews,
    ROUND(
        SUM(CASE WHEN r.review_stars = 5 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS five_star_percentage
FROM tbl_yelp_reviews r 
INNER JOIN tbl_yelp_businesses b 
    ON r.business_id = b.business_id
GROUP BY b.business_id, b.name
ORDER BY five_star_percentage DESC;

--07 Find top most reviewd businesses in each city

with bht as(
select b.city, b.business_id, b.name, count(*) as total_reviews

from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id=b.business_id
group by 1,2,3
)
select * 
from bht
qualify row_number() over (partition by city order by total_reviews desc) <= 5


 --08 Find the average rating of businesses that have at least 100 reviews,
SELECT 
    b.business_id, 
    b.name, 
    COUNT(*) AS total_reviews,
    avg(review_stars) as avg_reviews
FROM tbl_yelp_reviews r 
INNER JOIN tbl_yelp_businesses b 
    ON r.business_id = b.business_id
GROUP BY 1,2
having COUNT(*) >= 100


 --09 List the top 10 user who have written the most reviews along with the businesses they reviewed
 with bht as (
 SELECT 
    r.user_id, 
  
    COUNT(*) AS total_reviews,
    
FROM tbl_yelp_reviews r 
INNER JOIN tbl_yelp_businesses b 
    ON r.business_id = b.business_id
GROUP BY 1
order by 2 desc
)
select user_id, business_id
from tbl_yelp_reviews where user_id in (select user_id from bht )
group by 1,2
order by user_id
limit 10;
 
--10 Find the top 10 businesses with highest positive sentiment reviews
SELECT 
    r.business_id, b.name,
  
    COUNT(*) AS total_reviews,
    FROM tbl_yelp_reviews r 
INNER JOIN tbl_yelp_businesses b 
    ON r.business_id = b.business_id
where sentiment='Positive'
GROUP BY 1,2
order by 3 desc
limit 10;



