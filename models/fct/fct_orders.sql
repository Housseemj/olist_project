WITH ods_orders AS (
    SELECT * FROM {{ref("ods_orders")}}
),

dim_dates AS (
    SELECT * 
    FROM {{ ref('dim_date') }}
),

dim_customers AS (
    SELECT * 
    FROM {{ ref('dim_customers') }}
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

    o.order_id,
    c.customer_pk,
    s.SELLER_PK,
    p.PRODUCT_PK,
    UPPER(ORDER_STATUS) as ORDER_STATUS,
    DATE(o.ORDER_PURCHASE_TIMESTAMP) AS ORDER_PURCHASE_TIMESTAMP,
    DATEDIFF(day, o.ORDER_PURCHASE_TIMESTAMP, o.ORDER_DELIVERED_CUSTOMER_DATE) AS order_delivered_delay,
    CASE 
        WHEN DATEDIFF(day, o.ORDER_PURCHASE_TIMESTAMP, o.ORDER_DELIVERED_CUSTOMER_DATE) <= 0 
        THEN 1 ELSE 0 END AS is_delivered_on_time,
    COUNT (o.*) AS total_orders,
    COUNT(CASE WHEN o.order_status = 'canceled' THEN 1 END) AS canceled_orders,
    100.0 * COUNT(CASE WHEN o.order_status = 'canceled' THEN 1 END) / COUNT(*) AS pct_canceled,
    COUNT(CASE WHEN o.order_status='delivered' THEN 1 END)/COUNT(*)*100 AS pct_completed
FROM ods_orders o
INNER JOIN {{ref("ods_orders_items")}} oi ON oi.ORDER_ID = o.ORDER_ID
LEFT JOIN dim_dates d ON DATE(o.ORDER_PURCHASE_TIMESTAMP) = d.date_day
LEFT JOIN dim_customers c ON o.CUSTOMER_ID = c.CUSTOMER_ID
INNER JOIN dim_sellers s ON oi.SELLER_ID = s.SELLER_ID
INNER JOIN dim_products p ON p.PRODUCT_ID = oi.PRODUCT_ID
GROUP BY 
o.order_id,
    c.customer_pk,
    s.SELLER_PK,
    p.PRODUCT_PK,
    UPPER(ORDER_STATUS),
    DATEDIFF(day, o.ORDER_PURCHASE_TIMESTAMP, o.ORDER_DELIVERED_CUSTOMER_DATE),
      DATE(o.ORDER_PURCHASE_TIMESTAMP) 


