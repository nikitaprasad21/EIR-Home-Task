-- Viewing Dataset
SELECT * FROM EIRHomeTask;


-- Total Transaction Amount:
-- 1. Top users by total transaction amount
SELECT USER_ID, ROUND(SUM(AMOUNT), 2) AS TotalAmount
FROM EIRHomeTask
GROUP BY USER_ID
ORDER BY TotalAmount DESC
limit 10;

-- 2. Total transaction amount for each transaction type
SELECT TYPE, ROUND(SUM(AMOUNT),2) AS TotalAmount, 
    ROUND(((SUM(AMOUNT) / (SELECT SUM(AMOUNT) FROM EIRHomeTask)) * 100), 2) AS PercentageDistribution
FROM EIRHomeTask
GROUP BY TYPE
ORDER BY PercentageDistribution DESC;

-- 3. Total transaction amount for each currency
SELECT CURRENCY, ROUND(SUM(AMOUNT),2) AS TotalAmount,  
   ROUND(((SUM(AMOUNT) / (SELECT SUM(AMOUNT) FROM EIRHomeTask)) * 100), 2)  AS PercentageDistribution
FROM EIRHomeTask
GROUP BY CURRENCY;



-- Transaction Counts:
-- 1. Users with the highest number of transactions
SELECT USER_ID, COUNT(*) AS TransactionCount
FROM EIRHomeTask
GROUP BY USER_ID
ORDER BY TransactionCount DESC
LIMIT 10;

-- 2. Distribution of transactions across different currencies
SELECT CURRENCY, COUNT(*) AS TransactionCount
FROM EIRHomeTask
GROUP BY CURRENCY
order by TransactionCount DESC;


-- Transaction Types:
-- 1. Most common transaction types
SELECT TYPE, COUNT(*) AS TransactionCount
FROM EIRHomeTask
GROUP BY TYPE
ORDER BY TransactionCount DESC
lIMIT 1;

-- 2. Least common transaction types
SELECT TYPE, COUNT(*) AS TransactionCount
FROM EIRHomeTask
GROUP BY TYPE
ORDER BY TransactionCount ASC
LIMIT 1;

-- 3. Transaction types with highest average amount
SELECT TYPE, ROUND(AVG(AMOUNT), 2) AS AvgAmount
FROM EIRHomeTask
GROUP BY TYPE
ORDER BY AvgAmount DESC;


-- Transaction Anomalies:
-- 1. Unusually high or low transaction amounts 
SELECT USER_ID, TRANSACTION_ID, AMOUNT
FROM EIRHomeTask
WHERE AMOUNT > 400 OR AMOUNT < 1;


-- Final Analysis
SELECT USER_ID, cOUNT(*) AS TransactionCount, ROUND(AVG(AMOUNT), 2) AS AvgAmount, ROUND(SUM(AMOUNT), 2) AS TotalAmount,
      CURRENCY,
      CASE
        WHEN SUM(AMOUNT) > 1000 THEN 'High-Value'
        WHEN SUM(AMOUNT) > 500 THEN 'Medium-Value'
        ELSE 'Low-Value'
    END AS UserSegment
FROM EIRHomeTask
GROUP BY USER_ID
ORDER by TransactionCount desc;