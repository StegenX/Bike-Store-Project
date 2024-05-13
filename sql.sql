SELECT * FROM stores;
SELECT * FROM Stocks;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM customers;
SELECT * FROM staffs;
SELECT * FROM brands;
SELECT * FROM products;
SELECT * FROM categories;

-- Which store has more sales

SELECT S.store_name,
SUM((Ot.quantity * Ot.list_price) * (1 - Ot.discount)) AS Revenue,
ROUND((SUM((Ot.quantity * Ot.list_price) * (1 - Ot.discount)) / (SELECT SUM((Ot1.quantity * Ot1.list_price) * (1 - Ot1.discount)) 
FROM orders O1 JOIN order_items Ot1 ON Ot1.order_id = O1.order_id)) * 100, 2) AS Percentage
FROM stores S
JOIN orders O ON O.store_id = S.store_id
JOIN order_items Ot ON Ot.order_id = O.order_id
GROUP BY S.store_name
ORDER BY Revenue DESC ;



-- Most valuable costumer

SELECT O.customer_id,
CONCAT(C.First_Name, " ", C.Last_Name) AS Full_Name,
ROUND(SUM((Ot.quantity * Ot.list_price) * (1 - Ot.discount)), 2) AS Revenue
FROM orders O
JOIN order_items Ot ON Ot.order_id = O.order_id
JOIN customers C ON C.customer_id = O.customer_id
GROUP BY O.customer_id, Full_Name
ORDER BY 3 DESC LIMIT 10;


-- Year and Month with most revenue

SELECT
YEAR(O.order_date) AS Year,
ROUND(SUM((Ot.quantity * Ot.list_price) * (1 - Ot.discount)), 2) AS Revenue
FROM Orders O
JOIN order_items Ot ON Ot.order_id = O.order_id
GROUP BY YEAR(O.order_date)
ORDER BY Year;

SELECT
month(O.order_date) AS Month,
ROUND(SUM((Ot.quantity * Ot.list_price) * (1 - Ot.discount)), 2) AS Revenue
FROM Orders O
JOIN order_items Ot ON Ot.order_id = O.order_id
GROUP BY Month(O.order_date)
ORDER BY Revenue DESC;

--  Most selled products Per Year
 

SELECT P.product_Name, SUM(S.Quantity) AS Quantity ,Sum(Ot.List_price) AS Revenue FROM products P
JOIN Stocks S ON S.product_id = P.Product_id
JOIN order_items Ot ON Ot.product_id = P.product_id
WHERE model_year = "2018"
GROUP BY model_year, P.product_name
ORDER BY 3 DESC LIMIT 10;

-- - Best staff seller
SELECT St.staff_id ,CONCAT(first_name, " ", Last_Name) AS Full_Name, ROUND(SUM(((Oi.quantity * Oi.list_price) * (1 - Oi.discount))),2) AS Revenue FROM order_items Oi
JOIN Orders O ON Oi.order_id = O.Order_id
Right JOIN Staffs St ON St.Staff_id = O.Staff_id
GROUP BY St.staff_id, Full_Name
ORDER BY 3 DESC ;










