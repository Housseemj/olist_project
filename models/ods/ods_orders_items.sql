WITH ods_orders_items as 
(   
    SELECT * FROM {{source('stg','stg_orders_items')}}
)

SELECT
    ORDER_ID,
    ORDER_ITEM_ID,
    PRODUCT_ID,
    SELLER_ID,
    cast(SHIPPING_LIMIT_DATE as timestamp) as SHIPPING_LIMIT_DATE,
    cast(PRICE as double) as PRICE,
    FREIGHT_VALUE,
    CURRENT_TIMESTAMP() AS created_at,
    CURRENT_TIMESTAMP() AS updated_at
FROM ods_orders_items
WHERE ORDER_ID IS NOT NULL AND ORDER_ITEM_ID IS NOT NULL AND PRODUCT_ID IS NOT NULL AND SELLER_ID IS NOT NULL