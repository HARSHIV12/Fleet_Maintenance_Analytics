-- Rank trucks based on maintenance cost-- 

SELECT
    truck_id,
    SUM(total_cost) AS Total_Maintenance_Cost,
    RANK() OVER (ORDER BY SUM(total_cost) DESC) AS Truck_Rank
FROM maintenance_records
GROUP BY truck_id;

-- Find trucks whose maintenance cost is above the average-- 

WITH TruckMaintenance AS
(
    SELECT
        truck_id,
        SUM(total_cost) AS Total_Cost
    FROM maintenance_records
    GROUP BY truck_id
)

SELECT *
FROM TruckMaintenance
WHERE Total_Cost >
(
    SELECT AVG(Total_Cost)
    FROM TruckMaintenance
);


-- Create a reusable summary of truck maintenance-- 


CREATE VIEW vw_truck_maintenance AS
SELECT
    truck_id,
    COUNT(*) AS Total_Repairs,
    SUM(total_cost) AS Total_Cost,
    SUM(downtime_hours) AS Total_Downtime
FROM maintenance_records
GROUP BY truck_id;


SELECT *
FROM vw_truck_maintenance;