WITH ods_orders_items AS (
    SELECT *
    FROM {{ref('ods_orders_items')}}
),

dim_dates AS (
    SELECT * 
    FROM {{ ref('dim_date') }}
),

dim_sellers AS (
    SELECT * 
    FROM {{ ref('dim_sellers') }}
),

dim_products AS(
    SELECT *
    FROM {{ ref('dim_products')}}
)

SELECT 
oi.ORDER_ITEM_ID,
o.order_id,
p.PRODUCT_PK,
s.SELLER_PK,
d.date_key AS order_item_date_key,
oi.PRICE,
oi.freight_value,
(oi.price + oi.freight_value) AS total_value
FROM ods_orders_items oi
INNER JOIN {{ref('ods_orders')}} o ON o.order_id = oi.order_id 
INNER JOIN dim_sellers s on s.seller_id = oi.seller_id
INNER JOIN dim_products p on p.PRODUCT_ID = oi.PRODUCT_ID
INNER JOIN dim_dates d on d.date_day = DATE(oi.SHIPPING_LIMIT_DATE)

