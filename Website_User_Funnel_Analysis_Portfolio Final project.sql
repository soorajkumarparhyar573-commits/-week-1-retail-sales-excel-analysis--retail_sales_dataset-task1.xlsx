/*
=========================================================
Project : Website User Behavior & Conversion Funnel Analysis
Author  : SOORAJ KUMAR 
Purpose : LogicStack Internship + GitHub Portfolio
Tools   : SQL, Power BI
=========================================================
Assumed table name: client_site_dataset
=========================================================
*/

----------------------------------------------------------
-- SECTION 1 : DATA EXPLORATION
----------------------------------------------------------
SELECT COUNT(*) AS Total_Rows FROM client_site_dataset;

SELECT COUNT(DISTINCT [User ID]) AS Unique_Users
FROM client_site_dataset;

SELECT COUNT(DISTINCT [Session ID]) AS Unique_Sessions
FROM client_site_dataset;

SELECT DISTINCT Event FROM client_site_dataset;
SELECT DISTINCT Device FROM client_site_dataset;
SELECT DISTINCT Region FROM client_site_dataset;
SELECT DISTINCT Channel FROM client_site_dataset;
SELECT DISTINCT [Product Category] FROM client_site_dataset;

----------------------------------------------------------
-- SECTION 2 : DATA QUALITY
----------------------------------------------------------
SELECT COUNT(*) AS Null_Revenue
FROM client_site_dataset
WHERE Revenue IS NULL;

SELECT [User ID],COUNT(*) Duplicate_Count
FROM client_site_dataset
GROUP BY [User ID]
HAVING COUNT(*)>1;

----------------------------------------------------------
-- SECTION 3 : FUNNEL ANALYSIS
----------------------------------------------------------
SELECT Event,COUNT(*) AS Total_Events
FROM client_site_dataset
GROUP BY Event
ORDER BY Total_Events DESC;

SELECT Event,
COUNT(DISTINCT [User ID]) AS Users
FROM client_site_dataset
GROUP BY Event
ORDER BY Users DESC;

SELECT
COUNT(DISTINCT CASE WHEN Event='Browse' THEN [User ID] END) Browse_Users,
COUNT(DISTINCT CASE WHEN Event='Add to Cart' THEN [User ID] END) Cart_Users,
COUNT(DISTINCT CASE WHEN Event='Checkout' THEN [User ID] END) Checkout_Users,
COUNT(DISTINCT CASE WHEN Event='Purchase' THEN [User ID] END) Purchase_Users
FROM client_site_dataset;

----------------------------------------------------------
-- SECTION 4 : REVENUE ANALYSIS
----------------------------------------------------------
SELECT SUM(Revenue) Total_Revenue
FROM client_site_dataset;

SELECT AVG(Revenue) Avg_Revenue
FROM client_site_dataset;

SELECT Region,SUM(Revenue) Revenue
FROM client_site_dataset
GROUP BY Region
ORDER BY Revenue DESC;

SELECT Channel,SUM(Revenue) Revenue
FROM client_site_dataset
GROUP BY Channel
ORDER BY Revenue DESC;

SELECT Device,SUM(Revenue) Revenue
FROM client_site_dataset
GROUP BY Device
ORDER BY Revenue DESC;

SELECT [Product Category],SUM(Revenue) Revenue
FROM client_site_dataset
GROUP BY [Product Category]
ORDER BY Revenue DESC;

----------------------------------------------------------
-- SECTION 5 : BUSINESS INSIGHTS
----------------------------------------------------------
SELECT TOP 5 [User ID],SUM(Revenue) Revenue
FROM client_site_dataset
GROUP BY [User ID]
ORDER BY Revenue DESC;

SELECT TOP 5 Region,SUM(Revenue) Revenue
FROM client_site_dataset
GROUP BY Region
ORDER BY Revenue DESC;

SELECT TOP 5 Channel,SUM(Revenue) Revenue
FROM client_site_dataset
GROUP BY Channel
ORDER BY Revenue DESC;

SELECT TOP 5 Device,SUM(Revenue) Revenue
FROM client_site_dataset
GROUP BY Device
ORDER BY Revenue DESC;

----------------------------------------------------------
-- SECTION 6 : ADVANCED SQL
----------------------------------------------------------
WITH RevenueCTE AS(
SELECT Region,SUM(Revenue) Revenue
FROM client_site_dataset
GROUP BY Region)
SELECT *,
RANK() OVER(ORDER BY Revenue DESC) Region_Rank
FROM RevenueCTE;

SELECT
[User ID],
SUM(Revenue) Revenue,
ROW_NUMBER() OVER(ORDER BY SUM(Revenue) DESC) Row_Num,
DENSE_RANK() OVER(ORDER BY SUM(Revenue) DESC) Dense_Rank
FROM client_site_dataset
GROUP BY [User ID];

SELECT
Channel,
SUM(Revenue) Revenue,
ROUND(SUM(Revenue)*100.0/
(SUM(SUM(Revenue)) OVER()),2) Revenue_Percentage
FROM client_site_dataset
GROUP BY Channel;

----------------------------------------------------------
-- SECTION 7 : DROPOFF
----------------------------------------------------------
SELECT Event,
COUNT(DISTINCT [User ID]) Users
FROM client_site_dataset
GROUP BY Event
ORDER BY Users DESC;

/* End of Project */
