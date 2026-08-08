USE fleet_maintenance_db;

-- ==========================================================
-- DROP TABLES (Run only if recreating the database)
-- ==========================================================

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS truck_utilization_metrics;
DROP TABLE IF EXISTS fuel_purchases;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS maintenance_records;
DROP TABLE IF EXISTS loads;
DROP TABLE IF EXISTS trailers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS facilities;
DROP TABLE IF EXISTS routes;
DROP TABLE IF EXISTS drivers;
DROP TABLE IF EXISTS trucks;

SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================================
-- TABLE : TRUCKS
-- ==========================================================

CREATE TABLE trucks (

    truck_id VARCHAR(20) PRIMARY KEY,

    unit_number INT NOT NULL,

    make VARCHAR(50),

    model_year INT,

    vin VARCHAR(30),

    acquisition_date DATE,

    acquisition_mileage INT,

    fuel_type VARCHAR(30),

    tank_capacity_gallons INT,

    status VARCHAR(30),

    home_terminal VARCHAR(100)

);

-- ==========================================================
-- TABLE : DRIVERS
-- ==========================================================



CREATE TABLE drivers (

    driver_id VARCHAR(20) PRIMARY KEY,

    first_name VARCHAR(50),

    last_name VARCHAR(50),
    
    hire_date VARCHAR(20),

    license_number VARCHAR(50),

    license_state VARCHAR(10),

    date_of_birth VARCHAR(20),

    home_terminal VARCHAR(100),

    employment_status VARCHAR(30),

    cdl_class VARCHAR(10),

    years_experience INT

);

-- ==========================================================
-- TABLE : ROUTES
-- ==========================================================

CREATE TABLE routes (

    route_id VARCHAR(20) PRIMARY KEY,

    origin_city VARCHAR(100),

    origin_state VARCHAR(50),

    destination_city VARCHAR(100),

    destination_state VARCHAR(50),

    typical_distance_miles INT,

    base_rate_per_mile DECIMAL(10,2),

    fuel_surcharge_rate DECIMAL(10,2),

    typical_transit_days INT

);

-- ==========================================================
-- TABLE : FACILITIES
-- ==========================================================

CREATE TABLE facilities (

    facility_id VARCHAR(20) PRIMARY KEY,

    facility_name VARCHAR(100),

    facility_type VARCHAR(50),

    city VARCHAR(100),

    state VARCHAR(50),

    latitude DECIMAL(10,6),

    longitude DECIMAL(10,6),

    dock_doors INT,

    operating_hours VARCHAR(100)

);


CREATE TABLE trips (

    trip_id VARCHAR(20) PRIMARY KEY,

    load_id VARCHAR(20),

    driver_id VARCHAR(20),

    truck_id VARCHAR(20),

    trailer_id VARCHAR(20),

    dispatch_date DATE,

    actual_distance_miles DECIMAL(10,2),

    actual_duration_hours DECIMAL(10,2),

    fuel_gallons_used DECIMAL(10,2),

    average_mpg DECIMAL(10,2),

    idle_time_hours DECIMAL(10,2),

    trip_status VARCHAR(50)

);


CREATE TABLE truck_utilization_metrics (


    truck_id VARCHAR(20),

    month DATE,

    trips_completed INT,

    total_miles DECIMAL(12,2),

    total_revenue DECIMAL(15,2),

    average_mpg DECIMAL(10,2),

    maintenance_events INT,

    maintenance_cost DECIMAL(15,2),

    downtime_hours DECIMAL(10,2),

    utilization_rate DECIMAL(10,2)

);



CREATE TABLE maintenance_records (

    maintenance_id VARCHAR(20) PRIMARY KEY,

    truck_id VARCHAR(20) NOT NULL,

    maintenance_date DATE,

    maintenance_type VARCHAR(100),

    odometer_reading INT,

    labor_hours DECIMAL(10,2),

    labor_cost DECIMAL(12,2),

    parts_cost DECIMAL(12,2),

    total_cost DECIMAL(12,2),

    facility_location VARCHAR(100),

    downtime_hours DECIMAL(10,2),

    service_description VARCHAR(255)

);


CREATE TABLE fuel_purchases (

    fuel_purchase_id VARCHAR(20) PRIMARY KEY,

    trip_id VARCHAR(20),

    truck_id VARCHAR(20) NOT NULL,

    driver_id VARCHAR(20) NOT NULL,

    purchase_date DATETIME,

    location_city VARCHAR(100),

    location_state VARCHAR(50),

    gallons DECIMAL(10,2),

    price_per_gallon DECIMAL(10,2),

    total_cost DECIMAL(12,2),

    fuel_card_number VARCHAR(50)

);

SELECT 'trucks' AS Table_Name, COUNT(*) AS Total_Rows FROM trucks
UNION ALL
SELECT 'drivers', COUNT(*) FROM drivers
UNION ALL
SELECT 'maintenance_records', COUNT(*) FROM maintenance_records
UNION ALL
SELECT 'fuel_purchases', COUNT(*) FROM fuel_purchases
UNION ALL
SELECT 'trips', COUNT(*) FROM trips
UNION ALL
SELECT 'routes', COUNT(*) FROM routes
UNION ALL
SELECT 'truck_utilization_metrics', COUNT(*) FROM truck_utilization_metrics
UNION ALL
SELECT 'facilities', COUNT(*) FROM facilities;


ALTER TABLE maintenance_records
ADD CONSTRAINT fk_maintenance_truck
FOREIGN KEY (truck_id)
REFERENCES trucks(truck_id);

ALTER TABLE fuel_purchases
ADD CONSTRAINT fk_fuel_truck
FOREIGN KEY (truck_id)
REFERENCES trucks(truck_id);

ALTER TABLE fuel_purchases
ADD CONSTRAINT fk_fuel_driver
FOREIGN KEY (driver_id)
REFERENCES drivers(driver_id);

ALTER TABLE trips
ADD CONSTRAINT fk_trip_truck
FOREIGN KEY (truck_id)
REFERENCES trucks(truck_id);

ALTER TABLE trips
ADD CONSTRAINT fk_trip_driver
FOREIGN KEY (driver_id)
REFERENCES drivers(driver_id);