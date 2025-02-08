CREATE DATABASE Incubyte_Assignment;
CREATE TABLE assessment_dataset (
    TransactionID INT,
    CustomerID VARCHAR(255) DEFAULT NULL,
    TransactionDate DATETIME,
    TransactionAmount DECIMAL(10 , 2 ) DEFAULT NULL,
    PaymentMethod VARCHAR(50) DEFAULT NULL,
    Quantity INT DEFAULT NULL,
    DiscountPercent DECIMAL(5 , 2 ) DEFAULT NULL,
    City VARCHAR(50) DEFAULT NULL,
    StoreType VARCHAR(50) DEFAULT NULL,
    CustomerAge VARCHAR(50) DEFAULT NULL,
    CustomerGender VARCHAR(10) DEFAULT NULL,
    LoyaltyPoints INT DEFAULT NULL,
    ProductName VARCHAR(255) DEFAULT NULL,
    Region VARCHAR(50) DEFAULT NULL,
    Returned VARCHAR(10) DEFAULT NULL,
    FeedbackScore INT DEFAULT NULL,
    ShippingCost DECIMAL(10 , 2 ) DEFAULT NULL,
    DeliveryTimeDays INT DEFAULT NULL,
    IsPromotional VARCHAR(10) DEFAULT NULL
);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\assessment_dataset.csv'
INTO TABLE assessment_dataset
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;  

SELECT 
    *
FROM
    assessment_dataset;

-- 1. Total Sales Calculation
SELECT 
    SUM(TransactionAmount) AS Total_Sale
FROM
    assessment_dataset;

-- 2. Average Transaction Amount
SELECT 
    AVG(TransactionAmount) AS Avg_Transaction_Amount
FROM
    assessment_dataset;

-- 3. Sales by Payment Method
SELECT 
    PaymentMethod,
    SUM(Quantity) AS Quantity,
    SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
GROUP BY PaymentMethod
ORDER BY SUM(TransactionAmount) DESC;

-- 4. City Wise Sale
SELECT 
    City,
    SUM(Quantity) AS Quantity,
    SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
GROUP BY City
ORDER BY SUM(TransactionAmount) DESC;

-- 5. Region Wise Sale
SELECT 
    Region,
    SUM(Quantity) AS Quantity,
    SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
GROUP BY Region
ORDER BY SUM(TransactionAmount) DESC;

-- 6. Top 3 Cities with Highest Sale
SELECT 
    City,
    SUM(Quantity) AS Quantity,
    SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
GROUP BY City
ORDER BY SUM(TransactionAmount) DESC
LIMIT 3;

-- 7. City wise Online vs In-Store Sale
SELECT 
    City,
    StoreType,
    SUM(Quantity) AS Quantity,
    SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
GROUP BY City , StoreType
ORDER BY City , Transaction_Amount DESC;

-- 8. City wise Return
SELECT 
    City,
    SUM(Quantity) AS Quantity,
    SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
WHERE
    Returned = 'Yes'
GROUP BY City
ORDER BY Transaction_Amount DESC;

-- 9. Top 3 Sellable Products
SELECT 
    ProductName,
    SUM(Quantity) AS Quantity,
    SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
GROUP BY ProductName
ORDER BY Quantity DESC
LIMIT 3;

-- 10. Most Returned Product
SELECT 
    ProductName, SUM(Quantity) AS Quantity
FROM
    assessment_dataset
WHERE
    Returned = 'Yes'
GROUP BY ProductName
ORDER BY Quantity DESC
LIMIT 1;

-- 11. Age Group wise Spend
SELECT 
    CASE 
        WHEN CustomerAge BETWEEN 18 AND 25 THEN '18-25'
        WHEN CustomerAge BETWEEN 26 AND 35 THEN '26-35'
        WHEN CustomerAge BETWEEN 36 AND 45 THEN '36-45'
        WHEN CustomerAge BETWEEN 46 AND 55 THEN '46-55'
        WHEN CustomerAge BETWEEN 56 AND 65 THEN '56-65'
        WHEN CustomerAge >65 Then '65+'
        ELSE 'Undefine'
    END AS AgeGroup,
    SUM(TransactionAmount) AS TotalSpend
FROM 
    assessment_dataset
GROUP BY 
    AgeGroup
ORDER BY 
    TotalSpend Desc;

	
    -- 12. Gender Wise Sale
    SELECT 
    CustomerGender, SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
GROUP BY CustomerGender
ORDER BY Transaction_Amount DESC;
    
    -- 13. Top 3 Cities with most no of Transaction
SELECT 
    City, COUNT(City) AS Total_Transaction
FROM
    assessment_dataset
GROUP BY City
ORDER BY Total_Transaction DESC
LIMIT 3;
    
    -- 14. top 3 Loyal Customers
SELECT 
    CustomerID, SUM(LoyaltyPoints) AS Total_Loyalty_Points
FROM
    assessment_dataset
WHERE
    CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Total_Loyalty_Points DESC
LIMIT 3;
    
    -- 15. Promotional vs Non-Promotional Sale
SELECT 
    IsPromotional, SUM(TransactionAmount) AS TotalSales
FROM
    assessment_dataset
GROUP BY IsPromotional;

-- 16. Discount Impact on Sale

SELECT 
    CASE
        WHEN DiscountPercent BETWEEN 0 AND 10 THEN '0-10%'
        WHEN DiscountPercent BETWEEN 11 AND 20 THEN '11-20%'
        WHEN DiscountPercent BETWEEN 21 AND 30 THEN '21-30%'
        WHEN DiscountPercent BETWEEN 31 AND 40 THEN '31-40%'
        WHEN DiscountPercent BETWEEN 41 AND 50 THEN '41-50%'
        WHEN DiscountPercent BETWEEN 51 AND 60 THEN '51-60%'
        WHEN DiscountPercent BETWEEN 61 AND 70 THEN '61-70%'
        WHEN DiscountPercent BETWEEN 71 AND 80 THEN '71-80%'
        WHEN DiscountPercent BETWEEN 81 AND 90 THEN '81-90%'
        WHEN DiscountPercent BETWEEN 91 AND 100 THEN '91-100%'
        ELSE '0-10%'
    END AS Discount,
    SUM(TransactionAmount) AS TotalSales
FROM
    assessment_dataset
GROUP BY Discount
ORDER BY TotalSales DESC;
    
-- 17. Monthly Sales Performance
SELECT 
    DATE_FORMAT(STR_TO_DATE(TransactionDate, '%d/%m/%Y %H:%i'),
            '%M') AS Months,
    SUM(TransactionAmount) AS TotalSales,
    COUNT(TransactionID) AS TotalTransactions
FROM
    assessment_dataset
WHERE
    TransactionDate IS NOT NULL
GROUP BY DATE_FORMAT(STR_TO_DATE(TransactionDate, '%d/%m/%Y %H:%i'),
        '%M')
ORDER BY TotalSales;