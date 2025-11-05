WITH fct_orders AS
(
    SELECT * FROM {{ref('fct_orders')}}
),

fct_orders_items AS
(
    SELECT * FROM {{ref('fct_orders_items')}}
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
s.SELLER_PK,
p.PRODUCT_PK,
d.date_day,

AVG(order_delivered_delay) as avg_delai_livraison,
AVG(CASE WHEN order_delivered_delay <= 0 THEN 1 ELSE 0 END)*100 AS pct_delivered_on_time,
COUNT(canceled_orders) as canceled_orders,
COUNT(CASE WHEN fo.ORDER_STATUS = 'delivered' THEN 1 END) AS delivered_orders,
COUNT(fo.order_id) AS total_orders

FROM fct_orders fo 
LEFT JOIN fct_orders_items foi ON fo.order_id = foi. order_id
LEFT JOIN dim_sellers s ON s.SELLER_PK = fo.SELLER_PK
LEFT JOIN dim_products p ON p.PRODUCT_PK = fo.PRODUCT_PK
LEFT JOIN dim_date d ON d.date_day = DATE(fo.ORDER_PURCHASE_TIMESTAMP)
GROUP BY
1,2,3