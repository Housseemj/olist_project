WITH ods_sellers AS
(
    SELECT * FROM {{source('stg','stg_seller')}}
)

SELECT
    SELLER_ID, 
    cast(SELLER_ZIP_CODE_PREFIX as number) as SELLER_ZIP_CODE_PREFIX, 
    upper(SELLER_CITY) as SELLER_CITY, 
    upper(SELLER_STATE) as SELLER_STATE,
    CURRENT_TIMESTAMP() AS created_at,
    CURRENT_TIMESTAMP() AS updated_at
FROM ods_sellers
WHERE SELLER_ID is not null