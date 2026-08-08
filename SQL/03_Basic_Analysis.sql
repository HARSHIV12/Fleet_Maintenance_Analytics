-- Total Trucks--  

SELECT
COUNT(*) AS Total_Trucks
FROM trucks;


-- Active Trucks-- 

SELECT status,COUNT(*) AS Total
FROM trucks
GROUP BY status;

-- Total Drivers-- 

SELECT
COUNT(*) AS Total_Drivers
FROM drivers;


-- Driver Employment Status-- 

SELECT
employment_status,
COUNT(*) AS Total
FROM drivers
GROUP BY employment_status;


-- Total Trips-- 

SELECT
COUNT(*) AS Total_Trips
FROM trips;

-- Trip Status-- 

SELECT
trip_status,
COUNT(*) AS Trips
FROM trips
GROUP BY trip_status;


-- Total Maintenance Records-- 

SELECT
COUNT(*) AS Maintenance_Records
FROM maintenance_records;

-- Total Fuel Purchases-- 

SELECT
COUNT(*) AS Fuel_Transactions
FROM fuel_purchases;


-- Average Fuel Price-- 

SELECT
ROUND(AVG(price_per_gallon),2) AS Average_Fuel_Price
FROM fuel_purchases;


-- Total Fuel Cost-- 

SELECT
ROUND(SUM(total_cost),2) AS Total_Fuel_Cost
FROM fuel_purchases;

-- Total Maintenance Cost--

SELECT
ROUND(SUM(total_cost),2) AS Total_Maintenance_Cost
FROM maintenance_records;


-- Average Maintenance Cost--  

SELECT
ROUND(AVG(total_cost),2) AS Average_Maintenance_Cost
FROM maintenance_records;


-- Total Downtime Hours-- 

SELECT
ROUND(SUM(downtime_hours),2) AS Total_Downtime
FROM maintenance_records;

-- Average Truck Utilization-- 

SELECT
ROUND(AVG(utilization_rate),2) AS Avg_Utilization
FROM truck_utilization_metrics;

-- Total Revenue-- 

SELECT
ROUND(SUM(total_revenue)) AS Fleet_Revenue
FROM truck_utilization_metrics;


