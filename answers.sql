-- Question 1

WITH RECURSIVE split_cte AS (
  SELECT 
    OrderID,
    CustomerName,
    SUBSTRING_INDEX(Products, ',', 1) AS Product,
    SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS Rest
  FROM ProductDetail
  UNION ALL
  SELECT 
    OrderID,
    CustomerName,
    SUBSTRING_INDEX(Rest, ',', 1),
    SUBSTRING(Rest, LENGTH(SUBSTRING_INDEX(Rest, ',', 1)) + 2)
  FROM split_cte
  WHERE Rest != ''
)
SELECT 
    OrderID,
    CustomerName,
    TRIM(Product) AS Product
FROM split_cte;

-- Question 2 
-- step 1: Create the orders table with distinct OrderID and CustomerName
SELECT DISTINCT 
    OrderID, 
    CustomerName
FROM 
    OrderDetails;

-- step 2: Create the OrderProducts table (OrderID + Product → Quantity)
SELECT 
    OrderID, 
    Product, 
    Quantity
FROM 
    OrderDetails;
