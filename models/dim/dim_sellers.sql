WITH ods_sellers AS 
(
     SELECT
      *,
      ROW_NUMBER() OVER (PARTITION BY seller_id ORDER BY updated_at DESC NULLS LAST) AS rnk
  FROM {{ ref('ods_sellers') }}
)
SELECT 
    {{ dbt_utils.generate_surrogate_key(['SELLER_ID','SELLER_CITY','SELLER_STATE']) }} as SELLER_PK,
    SELLER_ID,
    CASE 
    WHEN SELLER_ZIP_CODE_PREFIX IS NULL 
    THEN 0 
    ELSE SELLER_ZIP_CODE_PREFIX 
    END as SELLER_ZIP_CODE_PREFIX, 
    CASE 
    WHEN SELLER_CITY IS NULL 
    THEN 'UNKNOWN'
    ELSE SELLER_CITY 
    END as SELLER_CITY, 
    CASE 
    WHEN SELLER_STATE IS NULL 
    THEN 'UNKNOWN'
    ELSE SELLER_STATE 
    END as SELLER_STATE 

FROM ods_sellers
WHERE rnk = 1