With fct_orders AS 
(
    SELECT * FROM {{ref('fct_orders')}}
),

fct_orders_items AS
(
    SELECT * FROM {{ref('fct_orders_items')}}
),

fct_orders_payments AS 
(
    SELECT * FROM {{ref('fct_orders_payments')}}
),

dim_customers AS 
(
    SELECT * FROM {{ref('dim_customers')}}
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
d.date_day,
c.customer_pk,
s.SELLER_PK,
p.PRODUCT_PK,

COUNT(DISTINCT fo.order_id) as total_orders,
SUM(fot.total_value) as total_value,
SUM(fot.freight_value) as total_freight_value,

COUNT(CASE WHEN fo.ORDER_STATUS = 'CANCELED' THEN 1 END) AS canceled_orders,
COUNT(CASE WHEN fo.order_status = 'DELIVERED' THEN 1 END) AS delivered_orders,
ROUND(100.0 * COUNT(CASE WHEN fo.is_delivered_on_time = 1 THEN 1 END) / NULLIF(COUNT(*), 0), 2) AS pct_delivered_on_time,

ROUND(AVG(fo.order_delivered_delay), 2) AS avg_delivery_delay,
ROUND(AVG(fot.total_value), 2) AS avg_order_value,

SUM(fop.payment_value) AS total_payment_value


FROM fct_orders fo 
LEFT JOIN fct_orders_items fot on fot.order_id = fo.order_id
LEFT JOIN fct_orders_payments fop on fop.order_id = fo.order_id
LEFT JOIN dim_customers c on c.customer_pk = fo.customer_pk
LEFT JOIN dim_sellers s on s.SELLER_PK = fo.SELLER_PK
LEFT JOIN dim_products p on p.PRODUCT_PK = fo.PRODUCT_PK
LEFT JOIN dim_date d on d.date_day = fo.ORDER_PURCHASE_TIMESTAMP

GROUP BY 1,2,3,4