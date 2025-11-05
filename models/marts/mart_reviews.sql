WITH fct_orders_reviews AS 
(
    SELECT * FROM {{ref('fct_orders_reviews')}}
),
fct_orders AS 
(
    SELECT * FROM {{ref('fct_orders')}}
),

dim_customers AS 
(
    SELECT * FROM {{ref('dim_customers')}}
),

dim_sellers AS
(
    SELECT * FROM {{ref('dim_sellers')}}
),

dim_products AS
(
    SELECT * FROM {{ref('dim_products')}}
),

dim_date AS 
(
    SELECT * FROM {{ref('dim_date')}}
)

SELECT
d.date_day,
c.customer_pk,
s.SELLER_PK,
p.PRODUCT_PK,

AVG(fr.REVIEW_SCORE) as avg_review_score,
COUNT(fr.REVIEW_ID) as total_review,
COUNT(CASE WHEN fr.REVIEW_SCORE <= 3 THEN 1 END) AS negative_reviews,
COUNT(CASE WHEN fr.REVIEW_SCORE >= 4 THEN 1 END) AS positive_reviews,
COUNT(CASE WHEN fr.REVIEW_SCORE <= 3 THEN 1 END)* 100.0 / COUNT(*) AS pct_negative_reviews,
COUNT(CASE WHEN fr.REVIEW_SCORE >= 4 THEN 1 END)* 100.0 / COUNT(*) AS pct_positive_reviews

FROM
fct_orders_reviews fr 
LEFT JOIN dim_customers c ON c.customer_pk = fr.customer_pk
LEFT JOIN dim_sellers s ON s.SELLER_PK = fr.SELLER_PK
LEFT JOIN dim_date d ON d.date_day = DATE(fr.REVIEW_DATE)
LEFT JOIN fct_orders fo ON fo.order_id = fr.order_id
LEFT JOIN dim_products p ON p.PRODUCT_PK = fo.PRODUCT_PK

GROUP BY 1,2,3,4