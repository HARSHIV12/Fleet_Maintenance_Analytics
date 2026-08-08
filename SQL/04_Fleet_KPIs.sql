 -- Top 10 Trucks by Revenue-- 
 
 SELECT
    truck_id,
    ROUND(SUM(total_revenue),2) AS Total_Revenue
FROM truck_utilization_metrics
GROUP BY truck_id
ORDER BY Total_Revenue DESC
LIMIT 10;
 
 
 
 -- Top 10 Trucks by Maintenance Cost-- 
 
 SELECT
    truck_id,
    ROUND(SUM(total_cost),2) AS Maintenance_Cost
FROM maintenance_records
GROUP BY truck_id
ORDER BY Maintenance_Cost DESC
LIMIT 10;
 
 
 
 
-- Top 10 Trucks by Downtime -- 
 
 SELECT
    truck_id,
    ROUND(SUM(downtime_hours),2) AS Downtime_Hours
FROM maintenance_records
GROUP BY truck_id
ORDER BY Downtime_Hours DESC
LIMIT 10;
 
 
 
 -- Top 10 Trucks by Utilization-- 
 
 SELECT
    truck_id,
    ROUND(AVG(utilization_rate),2) AS Utilization_Percentage
FROM truck_utilization_metrics
GROUP BY truck_id
ORDER BY Utilization_Percentage DESC
LIMIT 10;
 
 
 
 -- Lowest Fuel Efficiency Trucks-- 
 
 SELECT
    truck_id,
    ROUND(AVG(average_mpg),2) AS Average_MPG
FROM truck_utilization_metrics
GROUP BY truck_id
ORDER BY Average_MPG ASC
LIMIT 10;
 
 
 
 -- Highest Fuel Consumption-- 
 
 SELECT
    truck_id,
    ROUND(SUM(fuel_gallons_used),2) AS Fuel_Used
FROM trips
GROUP BY truck_id
ORDER BY Fuel_Used DESC
LIMIT 10;




 -- Truck-wise Number of Trips-- 
 
 SELECT
    truck_id,
    COUNT(*) AS Total_Trips
FROM trips
GROUP BY truck_id
ORDER BY Total_Trips DESC;



-- Average Trip Distance per Truck-- 
 
 SELECT
    truck_id,
    ROUND(AVG(actual_distance_miles),2) AS Avg_Distance
FROM trips
GROUP BY truck_id
ORDER BY Avg_Distance DESC;
 
 
 
 
 -- Total Miles by Truck--
 SELECT
    truck_id,
    ROUND(SUM(actual_distance_miles),2) AS Total_Miles
FROM trips
GROUP BY truck_id
ORDER BY Total_Miles DESC;
 
 
 
 
 -- Truck Performance Score--  
 
 SELECT
    truck_id,
    ROUND(AVG(utilization_rate),2) AS Utilization,
    ROUND(AVG(average_mpg),2) AS MPG,
    ROUND(SUM(total_revenue),2) AS Revenue,
    ROUND(SUM(downtime_hours),2) AS Downtime
FROM truck_utilization_metrics
GROUP BY truck_id
ORDER BY Revenue DESC;