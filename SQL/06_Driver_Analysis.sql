


-- Total Trips by Driver-- 

SELECT
    driver_id,
    COUNT(*) AS Total_Trips
FROM trips
GROUP BY driver_id
ORDER BY Total_Trips DESC;


--  Top 10 Drivers by Distance Covered

SELECT
    driver_id,
    ROUND(SUM(actual_distance_miles),2) AS Total_Miles
FROM trips
GROUP BY driver_id
ORDER BY Total_Miles DESC
LIMIT 10;


--  Average Fuel Consumption by Driver

SELECT
    driver_id,
    ROUND(AVG(fuel_gallons_used),2) AS Avg_Fuel_Used
FROM trips
GROUP BY driver_id
ORDER BY Avg_Fuel_Used DESC;


-- Top 10 Drivers by Fuel Efficiency

SELECT
    driver_id,
    ROUND(AVG(average_mpg),2) AS Average_MPG
FROM trips
GROUP BY driver_id
ORDER BY Average_MPG DESC
LIMIT 10;


--  Driver-wise Idle Time

SELECT
    driver_id,
    ROUND(SUM(idle_time_hours),2) AS Total_Idle_Time
FROM trips
GROUP BY driver_id
ORDER BY Total_Idle_Time DESC;


-- Completed Trips by Driver

SELECT
    driver_id,
    COUNT(*) AS Completed_Trips
FROM trips
WHERE trip_status='Completed'
GROUP BY driver_id
ORDER BY Completed_Trips DESC;


-- Driver Employment Status

SELECT
    employment_status,
    COUNT(*) AS Total_Drivers
FROM drivers
GROUP BY employment_status;


-- Drivers by CDL Class

SELECT
    cdl_class,
    COUNT(*) AS Drivers
FROM drivers
GROUP BY cdl_class
ORDER BY Drivers DESC;


--  Driver Experience Distribution

SELECT
    CASE
        WHEN years_experience < 5 THEN '0-4 Years'
        WHEN years_experience BETWEEN 5 AND 10 THEN '5-10 Years'
        WHEN years_experience BETWEEN 11 AND 20 THEN '11-20 Years'
        ELSE '20+ Years'
    END AS Experience_Level,
    COUNT(*) AS Total_Drivers
FROM drivers
GROUP BY Experience_Level;


--  Average Distance per Trip by Driver

SELECT
    driver_id,
    ROUND(AVG(actual_distance_miles),2) AS Avg_Trip_Distance
FROM trips
GROUP BY driver_id
ORDER BY Avg_Trip_Distance DESC;


--  Driver Performance Summary

SELECT
    driver_id,
    COUNT(*) AS Trips,
    ROUND(SUM(actual_distance_miles),2) AS Miles,
    ROUND(AVG(average_mpg),2) AS Avg_MPG,
    ROUND(SUM(idle_time_hours),2) AS Idle_Time
FROM trips
GROUP BY driver_id
ORDER BY Miles DESC;

-- Drivers with Highest Idle Time

SELECT
    driver_id,
    ROUND(SUM(idle_time_hours),2) AS Idle_Time
FROM trips
GROUP BY driver_id
ORDER BY Idle_Time DESC
LIMIT 10;

--  Driver-wise Fuel Usage

SELECT
    driver_id,
    ROUND(SUM(fuel_gallons_used),2) AS Fuel_Used
FROM trips
GROUP BY driver_id
ORDER BY Fuel_Used DESC;


--  Average Trip Duration by Driver

SELECT
    driver_id,
    ROUND(AVG(actual_duration_hours),2) AS Avg_Duration
FROM trips
GROUP BY driver_id
ORDER BY Avg_Duration DESC;


--  Top 10 Most Active Drivers

SELECT
    d.driver_id,
    CONCAT(d.first_name,' ',d.last_name) AS Driver_Name,
    COUNT(t.trip_id) AS Total_Trips
FROM drivers d
JOIN trips t
ON d.driver_id = t.driver_id
GROUP BY
    d.driver_id,
    Driver_Name
ORDER BY Total_Trips DESC
LIMIT 10;