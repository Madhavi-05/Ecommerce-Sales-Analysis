USE ecommerce_sales;

SELECT COUNT(*) AS Total_Rows
FROM superstore;

DESCRIBE superstore;

SELECT ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore;

SELECT ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore;

SELECT COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM superstore;

SELECT
    Category,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT
    Category,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore
GROUP BY Category
ORDER BY Total_Profit DESC;

SELECT
    Region,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

SELECT
    `Customer Name`,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT
    `Sub-Category`,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM superstore
GROUP BY `Sub-Category`
ORDER BY Total_Profit;

SELECT
    State,
    ROUND(SUM(Sales),2) AS Revenue
FROM superstore
GROUP BY State
ORDER BY Revenue DESC
LIMIT 10;

SELECT
    `Customer Name`,
    ROUND(SUM(Sales),2) AS Revenue
FROM superstore
GROUP BY `Customer Name`
HAVING SUM(Sales) > 10000
ORDER BY Revenue DESC;

SELECT
    Segment,
    ROUND(SUM(Profit),2) AS Profit
FROM superstore
GROUP BY Segment
ORDER BY Profit DESC;

SELECT
    `Order ID`,
    `Customer Name`,
    Sales,
    Profit
FROM superstore
WHERE Profit < 0
ORDER BY Profit;

SELECT
    `Order ID`,
    Sales,
    CASE
        WHEN Sales >= 1000 THEN 'High Value'
        WHEN Sales >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Order_Category
FROM superstore;

SELECT
    CASE
        WHEN Sales >= 1000 THEN 'High Value'
        WHEN Sales >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Order_Category,
    COUNT(*) AS Orders
FROM superstore
GROUP BY Order_Category;

SELECT
    Category,
    ROUND(SUM(Sales),2) AS Sales,
    ROUND(SUM(Profit),2) AS Profit,
    ROUND(
        (SUM(Profit)/SUM(Sales))*100,
        2
    ) AS Profit_Margin_Percent
FROM superstore
GROUP BY Category
ORDER BY Profit_Margin_Percent DESC;

SELECT
    `Customer Name`,
    Revenue,
    RANK() OVER (
        ORDER BY Revenue DESC
    ) AS Customer_Rank
FROM
(
    SELECT
        `Customer Name`,
        SUM(Sales) AS Revenue
    FROM superstore
    GROUP BY `Customer Name`
) t;

SELECT
    `Order Year`,
    SUM(Sales) AS Year_Sales,
    SUM(SUM(Sales))
        OVER(
            ORDER BY `Order Year`
        ) AS Running_Total
FROM superstore
GROUP BY `Order Year`;

WITH ProductSales AS
(
    SELECT
        Category,
        `Product Name`,
        SUM(Sales) AS TotalSales,
        RANK() OVER(
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS RankNum
    FROM superstore
    GROUP BY Category, `Product Name`
)

SELECT *
FROM ProductSales
WHERE RankNum = 1;