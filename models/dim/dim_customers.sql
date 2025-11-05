WITH ods_customers AS 
(   
    SELECT *,
      ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY updated_at DESC NULLS LAST) AS rnk
     FROM {{ref('ods_customers')}}
)

SELECT 
    {{ dbt_utils.generate_surrogate_key(['customer_id','customer_city','customer_state']) }} as customer_pk,
    customer_id,
    customer_unique_id as Unique_ID,
    CASE 
    WHEN customer_city IS NULL 
    THEN 'UNKOWN' 
    ELSE customer_city 
    END as customer_city, 
    CASE 
    WHEN customer_state IS NULL 
    THEN 'UNKOWN' 
    ELSE customer_state 
    END as customer_state,
    customer_zip_code_prefix
FROM ods_customers