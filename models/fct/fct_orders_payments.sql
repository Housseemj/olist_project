WITH ods_orders_payments AS 
(
    SELECT * FROM {{ref('ods_orders_payments')}}
)
,

 dim_date AS 
(
    SELECT * FROM {{ref('dim_date')}}
)
,
 dim_customers AS 
(
    SELECT * FROM {{ref('dim_customers')}}
)

SELECT 
o.order_id,
op.PAYMENT_VALUE,
op.PAYMENT_INSTALLMENTS,
op.PAYMENT_TYPE,
c.customer_pk,
d.date_key
FROM ods_orders_payments op 
INNER JOIN {{ref('ods_orders')}} o on o.order_id = op.order_id
INNER JOIN dim_customers c ON o.CUSTOMER_ID = c.CUSTOMER_ID
LEFT JOIN dim_date d ON d.date_day = DATE(o.ORDER_PURCHASE_TIMESTAMP) 