WITH ods_customers as 
(   
    SELECT * FROM {{source('stg','stg_customers')}}
)

SELECT 
     customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    upper(customer_city) as customer_city,
    upper(customer_state) as customer_state,
    CURRENT_TIMESTAMP() AS created_at,
    CURRENT_TIMESTAMP() AS updated_at

FROM ods_customers
WHERE customer_id is not null 