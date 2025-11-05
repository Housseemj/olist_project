-- Cutomer analysis

CREATE MATERIALIZED VIEW mv_customer_analysis AS 
SELECT
    c.CUSTOMER_PK as customer,
    AVG(fr.REVIEW_SCORE) AS avg_reviw_score,
    SUM(CASE WHEN sentiment_analysis(fr.REVIEW_COMMENT_MESSAGE) = 'positive' THEN 1 ELSE 0 END) AS total_positive_reviews,
    SUM(CASE WHEN sentiment_analysis(fr.REVIEW_COMMENT_MESSAGE) = 'negative' THEN 1 ELSE 0 END) AS total_negative_reviews
FROM FCT_ORDERS_REVIEWS fr
JOIN DIM_CUSTOMERS c ON c.CUSTOMER_PK = fr.CUSTOMER_PK
GROUP BY 1
HAVING total_positive_reviews <> 0 or total_negative_reviews <> 0

-- Delivery delay per month

CREATE MATERIALIZED VIEW mv_delivery_delay_month AS 
SELECT 
    s.SELLER_PK as Seller,
    DATE_TRUNC('month',fo.ORDER_PURCHASE_TIMESTAMP) as month,
    AVG(fo.ORDER_DELIVERED_DELAY) AS avg_delivery_delay,
    COUNT(CASE WHEN fo.ORDER_STATUS='CANCELED' THEN 1 END) AS canceled_orders
FROM FCT_ORDERS fo
JOIN DIM_SELLERS s ON s.SELLER_PK = fo.SELLER_PK
GROUP BY s.SELLER_PK , DATE_TRUNC('month',fo.ORDER_PURCHASE_TIMESTAMP)

-- Customer financials and review  

CREATE MATERIALIZED VIEW mv_customer_financials_reviews AS 
SELECT
    c.customer_pk as customer,
    AVG(fo.review_score) as avg_review_score,
    COUNT(fo.review_id) as total_review,
    SUM(CASE WHEN sentiment_analysis(fo.REVIEW_COMMENT_MESSAGE) = 'positive' THEN 1 ELSE 0 END) AS total_positive_reviews,
    SUM(CASE WHEN sentiment_analysis(fo.REVIEW_COMMENT_MESSAGE) = 'negative' THEN 1 ELSE 0 END) AS total_negative_reviews,
    SUM(fop.payment_value) as total_payments,
    AVG(fop.payment_value) as avg_payments
FROM fct_orders_reviews fo 
JOIN dim_customers c ON fo.customer_pk = c.customer_pk
JOIN fct_orders_payments fop ON fop.order_id = fo.order_id
GROUP BY 1
