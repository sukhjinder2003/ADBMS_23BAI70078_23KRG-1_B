--------------------------------------------EXPERIMENT 05 (MEDIUM LEVEL)------------------------------

CREATE TABLE transaction_data (
    id INT,
    value INT
);


INSERT INTO transaction_data (id, value)
SELECT 1, random() * 1000  
FROM generate_series(1, 1000000);


INSERT INTO transaction_data (id, value)
SELECT 2, random() * 1000
FROM generate_series(1, 1000000);

SELECT *FROM transaction_data




CREATE OR REPLACE VIEW sales_summary_view AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(value) AS total_sales,
    AVG(value) AS avg_transaction
FROM transaction_data
GROUP BY id;


EXPLAIN ANALYZE
SELECT * FROM sales_summary_view;



CREATE MATERIALIZED VIEW sales_summary_mv AS
SELECT
    id,
    COUNT(*) AS total_orders,
    SUM(value) AS total_sales,
    AVG(value) AS avg_transaction
FROM transaction_data
GROUP BY id;



EXPLAIN ANALYZE
SELECT * FROM sales_summary_mv;



--------------------------------------------EXPERIMENT 05 (HARD LEVEL)------------------------------
CREATE VIEW vW_ORDER_SUMMARY
AS
SELECT 
    O.order_id,
    O.order_date,
    P.product_name,
    C.full_name,
    (P.unit_price * O.quantity) - ((P.unit_price * O.quantity) * O.discount_percent / 100) AS final_cost
FROM customer_master AS C
JOIN sales_orders AS O 
    ON O.customer_id = C.customer_id
JOIN product_catalog AS P
    ON P.product_id = O.product_id;


SELECT * FROM vW_ORDER_SUMMARY;


CREATE ROLE ALOK
LOGIN
PASSWORD 'alok';

GRANT SELECT ON vW_ORDER_SUMMARY TO ALOK;

REVOKE SELECT ON vW_ORDER_SUMMARY FROM ALOK;