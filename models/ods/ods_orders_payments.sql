WITH ods_orders_payments as 
(
    SELECT * FROM {{source('stg','stg_orders_payments')}}
)

SELECT
    ORDER_ID,
    PAYMENT_SEQUENTIAL,
    PAYMENT_TYPE,
    PAYMENT_INSTALLMENTS,
    PAYMENT_VALUE,
    CURRENT_TIMESTAMP() AS created_at,
    CURRENT_TIMESTAMP() AS updated_at
FROM ods_orders_payments
WHERE ORDER_ID is not null 