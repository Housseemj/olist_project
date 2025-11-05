USE DATABASE OLIST_DB;
USE SCHEMA olist_db.raw;



CREATE OR REPLACE TABLE orders_raw(
    order_id varchar,
    customer_id varchar,
    order_status varchar,
    order_purchase_timestamp varchar,
    order_approved_at varchar,
    order_delivered_carrier varchar,
    order_delivered_customer_date varchar,
    order_estimated_delivery_date varchar,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
    );

update orders_raw
SET created_at = CURRENT_TIMESTAMP(),
    updated_at = CURRENT_TIMESTAMP();

CREATE OR REPLACE TABLE seller_raw(
    seller_id varchar,
    seller_zip_code_prefix varchar ,
    seller_city varchar,
    seller_state varchar,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);


    
CREATE OR REPLACE TABLE customers_raw(
    customer_id varchar,
    customer_unique_id varchar, 
    customer_zip_code_prefix varchar,
    customer_city varchar,
    customer_state varchar,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);



CREATE OR REPLACE TABLE orders_items_raw(
    order_id varchar,
    order_item_id varchar, 
    product_id varchar,
    seller_id varchar,
    shipping_limit_date varchar,
    price varchar,
    freight_value varchar ,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);




CREATE OR REPLACE TABLE geolocation_raw(
    geolocation_zip_code_prefix varchar,
    geolocation_lat varchar, 
    geolocation_lng varchar,
    geolocation_city varchar,
    geolocation_state varchar,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
); 



CREATE OR REPLACE TABLE orders_payments_raw(
    order_id varchar,
    payment_sequential varchar, 
    payment_type varchar,
    payment_installments varchar,
    payment_value varchar,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);



CREATE OR REPLACE TABLE orders_reviews_raw(
    review_id varchar,
    order_id varchar, 
    review_score varchar,
    review_comment_title varchar,
    review_comment_message varchar,
    review_creation_date varchar, 
    review_answer_timestamp varchar,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);



CREATE OR REPLACE TABLE products_raw(
    product_id varchar,
    product_category_name varchar, 
    product_name_lenght varchar,
    product_description_lenght varchar,
    product_photos_qty varchar,
    product_weight_g varchar, 
    product_length_cm varchar,
    product_height_cm varchar, 
    product_width_cm varchar,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);




CREATE OR REPLACE TABLE product_category_name_translation_raw (
    product_category_name varchar,
    product_category_name_english varchar,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp 
    
);
