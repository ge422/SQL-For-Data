-- Retrieve all transactions with valid customer and product data.
-- Order by transaction date to understand the chronological flow of
-- purchases.

SELECT *
FROM retail;

-- Clean the dataset by ensuring that numeric fields like Quantity,
-- Price per Unit, and Total Amount are properly formatted.
-- Remove duplicates or null values if any exist.

SELECT DISTINCT `Customer ID`, `Quantity`, `Price Per Unit`, `Total Amount`
FROM retail;

-- Calculate the total and average revenue for each product
-- category.
-- Which categories bring in the most and least revenue?

SELECT `Product Category`, SUM(`Total Amount`) AS Total_revenue,
AVG(`Total Amount`) AS Average_revenue
FROM retail
GROUP BY `Product Category`;

-- Analyze the monthly sales trend over the entire dataset period.
-- Summarize total revenue per month and order the results
-- chronologically.

SELECT `Date`, SUM(`Total Amount`) AS Monthly_trend
FROM retail;

-- Identify the top 10 customers by total spending.
-- Rank customers based on how much they’ve spent across all
-- transactions.

SELECT `Customer ID`, `Total Amount` AS Total_spending
FROM retail
ORDER BY `Customer ID`
LIMIT 10;

-- Calculate the average transaction value for each customer.
-- How much does each customer spend per transaction on
-- average?

SELECT `Transaction ID`, AVG(`Total Amount`) AS Average_transaction
FROM retail
GROUP BY `Customer ID`;

-- Group customers by gender and age brackets (e.g., 18–25, 26–35,
-- 36–50, etc.).
-- Summarize total revenue and transaction count for each group.

SELECT `Gender`, `Age`
FROM retail
where `Age` BETWEEN 26 AND 35;

-- Compare the number of one-time buyers versus repeat buyers.
-- Group customers by purchase frequency to determine repeat
-- behavior.

SELECT `Customer ID`, COUNT(DISTINCT `Transaction ID`) AS Purchase_frequency
FROM retail
GROUP BY `Customer ID`;

-- Identify inactive customers who have not made a purchase in the
-- last 6 months.
-- Use the most recent date in the dataset as the reference point.

SELECT DISTINCT `Date` AS Busiest_day, SUM(`Total Amount`) AS Revenue
FROM retail
GROUP BY `Date`
ORDER BY SUM(`Total Amount`) DESC;

-- Perform RFM (Recency, Frequency, Monetary) analysis for
-- customer segmentation.
-- Recency: Days since last purchase; Frequency: Number of
-- purchases; Monetary: Total amount spent.

SELECT `Customer ID`, COUNT(`Date`) AS Recency, COUNT(`Transaction ID`) AS Frequency,
SUM(`Total Amount`) AS Monetary
FROM retail
GROUP BY `Customer ID`;

-- Find the product categories with the highest average quantity per
-- transaction.
-- Which product types are purchased in bulk?

SELECT `Transaction ID`, AVG(`Quantity`) AS Highest_average
FROM retail
GROUP BY `Transaction ID`
ORDER BY AVG(`Quantity`);

-- Identify the busiest sales day of the week.
-- Which day(s) consistently have the highest transaction volume or
-- revenue?

SELECT DISTINCT `Date` AS Busiest_Day, SUM(`Total Amount`) AS Revenue
FROM retail
GROUP BY `Date`
ORDER BY  SUM(`Total Amount`) DESC;



-- Calculate total revenue and average spend per transaction by
-- gender.
-- Are there differences in spending patterns across genders?

SELECT DISTINCT `Gender`, AVG(`Total Amount`) AS Transaction_spent
FROM retail
GROUP BY `Gender`;

-- Find the top 5 most frequently purchased product categories.
-- Based on number of transactions involving each category.

SELECT DISTINCT `Product Category` AS Frequently_purchased, SUM(`Total Amount`) AS Revenue
FROM retail
GROUP BY `Product Category`
ORDER BY `Product Category` DESC
LIMIT 5;

-- Determine the percentage of total revenue contributed by each
-- age group.
-- Which customer age brackets are most valuable to the business?

WITH AgeGroups AS (
    SELECT 
        CASE 
            WHEN age < 20 THEN 'Under 20'
            WHEN age BETWEEN 20 AND 35 THEN 'Youth'
            WHEN age BETWEEN 36 AND 50 THEN 'Adults'
            ELSE 'Elderly'
        END AS age_group,
        `Total Amount`
    FROM retail
)
SELECT 
    age_group,
    SUM(`Total Amount`) AS total_revenue
FROM AgeGroups
GROUP BY age_group
ORDER BY total_revenue DESC;
