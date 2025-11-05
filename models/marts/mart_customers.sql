WITH fct_orders AS (
    SELECT * FROM {{ ref('fct_orders') }}
),

fct_orders_items AS (
    SELECT * FROM {{ ref('fct_orders_items') }}
),

fct_orders_payments AS (
    SELECT * FROM {{ ref('fct_orders_payments') }}
),

dim_customers AS (
    SELECT * FROM {{ ref('dim_customers') }}
),

dim_date AS (
    SELECT * FROM {{ ref('dim_date') }}
)

SELECT 
    c.customer_pk,

    COUNT(DISTINCT fo.order_id) AS total_orders,
    SUM(foi.total_value) AS total_spent,
    AVG(foi.total_value) AS avg_order_value,

    COUNT(CASE WHEN fo.order_status = 'CANCELED' THEN 1 END) * 100.0 / COUNT(fo.order_id) AS pct_canceled_orders,

    MIN(d.date_day) AS first_purchase_date,
    MAX(d.date_day) AS last_purchase_date,

    SUM(fop.payment_value) AS total_payment_value,
    AVG(fop.payment_value) AS avg_payment_value

FROM fct_orders fo
LEFT JOIN fct_orders_items foi ON foi.order_id = fo.order_id
LEFT JOIN fct_orders_payments fop ON fop.order_id = fo.order_id
LEFT JOIN dim_customers c ON c.customer_pk = fo.customer_pk
LEFT JOIN dim_date d ON d.date_day = DATE(fo.order_purchase_timestamp)

GROUP BY 
    1
