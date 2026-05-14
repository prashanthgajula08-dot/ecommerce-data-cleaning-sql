use prashanthdb;
select * from eco;
USE prashanthdb;

ALTER TABLE eco 
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

UPDATE eco SET email = NULL WHERE email = 'NA' OR email = '';
UPDATE eco SET firstname = NULL WHERE firstname = 'NA' OR firstname = '';
UPDATE eco SET lastname = NULL WHERE lastname = 'NA' OR lastname = '';
UPDATE eco SET product = NULL WHERE product = 'NA' OR product = '';
UPDATE eco SET quantity = NULL WHERE quantity = 'NA' OR quantity = '';
UPDATE eco SET price = NULL WHERE price = 'NA' OR price = '';
UPDATE eco SET city = NULL WHERE city = 'NA' OR city = '';
UPDATE eco SET state = NULL WHERE state = 'NA' OR state = '';
UPDATE eco SET pincode = NULL WHERE pincode = 'NA' OR pincode = '';
UPDATE eco SET payment_method = NULL WHERE payment_method = 'NA' OR payment_method = '';
UPDATE eco SET status = NULL WHERE status = 'NA' OR status = '';

UPDATE eco SET quantity = 1 WHERE quantity IS NULL;

UPDATE eco SET city = 'Hyderabad' WHERE city IN ('Hyb','HYD');

UPDATE eco SET payment_method = 'UPI' WHERE payment_method IN ('Upi','upi');
UPDATE eco SET payment_method = 'Credit Card' WHERE payment_method IN ('Credit card','credit card');
UPDATE eco SET payment_method = 'Net Banking' WHERE payment_method = 'NetBanking';

UPDATE eco 
SET payment_method = (
    SELECT payment_method
    FROM eco
    WHERE payment_method IS NOT NULL
    GROUP BY payment_method
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
WHERE payment_method IS NULL;

UPDATE eco 
SET order_date = STR_TO_DATE(order_date,'%Y-%m-%d');

UPDATE eco 
SET price = (
    SELECT AVG(price)
    FROM eco e2
    WHERE e2.product = eco.product
)
WHERE price IS NULL;

UPDATE eco SET price = ROUND(price,2);

UPDATE eco 
SET city = CASE 
    WHEN state='DL' THEN 'Delhi'
    WHEN state='GJ' THEN 'Ahmedabad'
    WHEN state='KA' THEN 'Bangalore'
    WHEN state='MH' THEN 'Mumbai'
    WHEN state='TN' THEN 'Chennai'
    WHEN state='TS' THEN 'Hyderabad'
    WHEN state='WB' THEN 'Kolkata'
    ELSE city
END;

DELETE FROM eco
WHERE product IS NULL OR order_id IS NULL;

SELECT* FROM eco;