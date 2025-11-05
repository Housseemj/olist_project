WITH ods_orders_reviews AS 
(
    SELECT * FROM {{ref('ods_orders_reviews')}}
),

dim_date AS
(
    SELECT * FROM {{ref('dim_date')}}
)
,
dim_sellers AS 
(
    SELECT * FROM {{ref('dim_sellers')}}
)
,
dim_customers AS 
(
    SELECT * FROM {{ref('dim_customers')}}
)

SELECT 
orv.REVIEW_ID,
o.order_id,
orv.REVIEW_SCORE,
c.customer_pk,
s.SELLER_PK,
d.date_key as REVIEW_DATE,
orv.REVIEW_COMMENT_MESSAGE,
orv.REVIEW_COMMENT_TITLE
FROM ods_orders_reviews orv 
INNER JOIN {{ref('ods_orders')}} o ON o.order_id = orv.order_id
INNER JOIN {{ref('ods_orders_items')}} oi ON o.order_id = oi.order_id
INNER JOIN dim_sellers s ON s.seller_id = oi.seller_id
INNER JOIN dim_customers c ON c.CUSTOMER_ID = o.CUSTOMER_ID
INNER JOIN dim_date d ON d.date_day = DATE(orv.REVIEW_CREATION_DATE)