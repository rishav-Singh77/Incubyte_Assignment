# Sales Data Analysis Assignment for Incubyte

This repository contains my solution to the Data Craftsperson assessment provided by Incubyte. The objective was to explore the provided sales dataset, generate key insights, and share SQL scripts used for analysis.

## 📊 Key Insights

- **Total Sales:** The cumulative sales amount was ₹10,20,26,62,960.  
- **Average Transaction Amount:** The average transaction value was ₹20,405.  
- **Top Cities and Regions:** Kolkata recorded the highest sales among cities, while the South region emerged as the best-performing region.  
- **Payment Method Analysis:** All four payment methods contributed almost equally to total sales.  
- **Promotional Impact:** Discounts in the 0-10% range accounted for 28% of the total sales, the highest among all discount ranges.  
- **Customer Insights:** The 46-65 age group contributed the most to sales.  
- **Gender-Wise Sales:** Sales distribution was almost equal across genders—Male, Female, and Other.  
- **Discount Analysis:** Higher sales volumes were consistently observed for the 0-10% discount range.  



## 📁 Dataset

- The dataset used for this assignment is available at <a href="https://incubytein-my.sharepoint.com/:x:/g/personal/akash_incubyte_co/EWbzbiLBCxNHogEQHUF0i7MBkK-86jKetzVDT4t0d-wZog?rtime=uhJY6RlI3Ug">`[assessment_dataset.csv]`</a>.

## ⚙️ Analysis Steps

1. **Data Cleaning:** Performed basic data validation and cleaning to handle missing or incorrect entries.
2. **Aggregate Analysis:** Computed total sales, average sales, and growth rates.
3. **Drill-Down Analysis:** Generated detailed insights based on product, region, and customer segments.

## 💾 SQL Scripts

The SQL scripts used for data analysis are located in the `sql-scripts` folder. Below are some key queries:

- **Total Sales Calculation:** 
  ```sql
SELECT 
    SUM(TransactionAmount) AS Total_Sale
FROM
    assessment_dataset;
    ```

- **Average Transaction Amount:** 
  ```sql
SELECT 
    AVG(TransactionAmount) AS Avg_Transaction_Amount
FROM
    assessment_dataset;```

- **City-Wise Online vs In-Store Sale:** 
  ```sql
SELECT 
    City,
    StoreType,
    SUM(Quantity) AS Quantity,
    SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
GROUP BY City , StoreType
ORDER BY City , Transaction_Amount DESC;```

- **City-Wise Return:** 
  ```sql
SELECT 
    City,
    SUM(Quantity) AS Quantity,
    SUM(TransactionAmount) AS Transaction_Amount
FROM
    assessment_dataset
WHERE
    Returned = 'Yes'
GROUP BY City
ORDER BY Transaction_Amount DESC;```

- **Discount Impact on Sale:** 
  ```sql
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
ORDER BY TotalSales DESC;```

- **Monthly Sales Performance:** 
  ```sql
SELECT 
    DATE_FORMAT(STR_TO_DATE(TransactionDate, '%d/%m/%Y %H:%i'),
            '%M') AS Months,
    SUM(TransactionAmount) AS TotalSales,
    COUNT(TransactionID) AS TotalTransactions
FROM
    assessment_dataset
WHERE
    TransactionDate IS NOT NULL
GROUP BY Months
ORDER BY TotalSales;```

## 📚 Instructions

- Copy and execute these queries in your SQL environment for data analysis.
- Replace `assessment_dataset` with your specific dataset name if necessary.
