-- Maintenance Cost by Type-- 
 
SELECT
    maintenance_type,
    COUNT(*) AS Total_Repairs,
    ROUND(SUM(total_cost),2) AS Total_Cost,
    ROUND(AVG(total_cost),2) AS Average_Cost
FROM maintenance_records
GROUP BY maintenance_type
ORDER BY Total_Cost DESC;


 
-- Top 10 Most Expensive Trucks to Maintain-- 
 
SELECT
    truck_id,
    COUNT(*) AS Maintenance_Count,
    ROUND(SUM(total_cost),2) AS Maintenance_Cost
FROM maintenance_records
GROUP BY truck_id
ORDER BY Maintenance_Cost DESC
LIMIT 10;


 
-- Query 28 : Trucks with Highest Number of Repairs-- 
 
SELECT
    truck_id,
    COUNT(*) AS Total_Repairs
FROM maintenance_records
GROUP BY truck_id
ORDER BY Total_Repairs DESC
LIMIT 10;


 
-- Average Downtime by Maintenance Type-- 
 
SELECT
    maintenance_type,
    ROUND(AVG(downtime_hours),2) AS Average_Downtime
FROM maintenance_records
GROUP BY maintenance_type
ORDER BY Average_Downtime DESC;


 
-- Total Downtime by Truck-- 
 
SELECT
    truck_id,
    ROUND(SUM(downtime_hours),2) AS Total_Downtime
FROM maintenance_records
GROUP BY truck_id
ORDER BY Total_Downtime DESC;


 
-- Query 31 : Monthly Maintenance Cost Trend-- 
 
SELECT
    YEAR(maintenance_date) AS Year,
    MONTH(maintenance_date) AS Month,
    ROUND(SUM(total_cost),2) AS Monthly_Cost
FROM maintenance_records
GROUP BY
    YEAR(maintenance_date),
    MONTH(maintenance_date)
ORDER BY
    Year,
    Month;


 
-- Monthly Number of Repairs-- 
 
SELECT
    YEAR(maintenance_date) AS Year,
    MONTH(maintenance_date) AS Month,
    COUNT(*) AS Total_Repairs
FROM maintenance_records
GROUP BY
    YEAR(maintenance_date),
    MONTH(maintenance_date)
ORDER BY
    Year,
    Month;


 
-- Facility-wise Maintenance Cost-- 
 
SELECT
    facility_location,
    ROUND(SUM(total_cost),2) AS Total_Cost
FROM maintenance_records
GROUP BY facility_location
ORDER BY Total_Cost DESC;


 
-- Average Labor Hours by Maintenance Type-- 
 
SELECT
    maintenance_type,
    ROUND(AVG(labor_hours),2) AS Average_Labor_Hours
FROM maintenance_records
GROUP BY maintenance_type
ORDER BY Average_Labor_Hours DESC;


 
-- Top 10 Highest Labor Cost Repairs-- 
 
SELECT
    maintenance_id,
    truck_id,
    maintenance_type,
    labor_cost
FROM maintenance_records
ORDER BY labor_cost DESC
LIMIT 10;


 
-- Parts Cost Analysis-- 
 
SELECT
    maintenance_type,
    ROUND(SUM(parts_cost),2) AS Total_Parts_Cost,
    ROUND(AVG(parts_cost),2) AS Average_Parts_Cost
FROM maintenance_records
GROUP BY maintenance_type
ORDER BY Total_Parts_Cost DESC;


 
-- Maintenance Cost Distribution-- 
 
SELECT
    CASE
        WHEN total_cost < 500 THEN 'Below $500'
        WHEN total_cost BETWEEN 500 AND 1000 THEN '$500 - $1000'
        WHEN total_cost BETWEEN 1001 AND 2000 THEN '$1001 - $2000'
        ELSE 'Above $2000'
    END AS Cost_Range,
    COUNT(*) AS Total_Repairs
FROM maintenance_records
GROUP BY Cost_Range
ORDER BY Total_Repairs DESC;


 
-- Average Cost Per Repair-- 
 
SELECT
    ROUND(AVG(total_cost),2) AS Average_Repair_Cost
FROM maintenance_records;


 
-- Maintenance Summary by Truck-- 
 
SELECT
    truck_id,
    COUNT(*) AS Repairs,
    ROUND(SUM(total_cost),2) AS Total_Cost,
    ROUND(SUM(downtime_hours),2) AS Downtime_Hours
FROM maintenance_records
GROUP BY truck_id
ORDER BY Total_Cost DESC;


 
-- Most Frequent Maintenance Type-- 
 
SELECT
    maintenance_type,
    COUNT(*) AS Frequency
FROM maintenance_records
GROUP BY maintenance_type
ORDER BY Frequency DESC;