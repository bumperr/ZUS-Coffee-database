DROP VIEW MY_VIEW;
CREATE VIEW MY_VIEW AS
SELECT CUSTOMER.Cust_ID,
       DELIVERY.Dlvr_ID,
       ADDRESS.A_ID
FROM CUSTOMER
INNER JOIN DELIVERY ON Customer.Cust_ID = Delivery.Cust_ID
INNER JOIN ADDRESS ON Delivery.A_ID = Address.A_ID
WHERE ADDRESS.A_type= 'Home';

SELECT *
FROM MY_VIEW;

