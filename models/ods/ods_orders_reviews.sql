WITH ods_orders_reviews as 
(   
    SELECT * FROM {{source('stg','stg_orders_reviews')}}
)
SELECT
    REVIEW_ID, 
    ORDER_ID, 
    REVIEW_SCORE, 
    REVIEW_COMMENT_TITLE, 
    REVIEW_COMMENT_MESSAGE, 
    cast(REVIEW_CREATION_DATE as timestamp) as REVIEW_CREATION_DATE, 
    cast(REVIEW_ANSWER_TIMESTAMP as timestamp) as REVIEW_ANSWER_TIMESTAMP,
    CURRENT_TIMESTAMP() AS created_at,
    CURRENT_TIMESTAMP() AS updated_at
FROM ods_orders_reviews 
WHERE REVIEW_ID is not null and ORDER_ID is not null 