-- Counting stops by region and vehicle type
SELECT 
    mb.gcc_name21 AS region_name,
    CASE 
        WHEN r.route_type = 0 THEN 'Tram'
        WHEN r.route_type = 2 THEN 'Train'
        WHEN r.route_type = 3 THEN 'Bus'
        ELSE 'Unknown'
    END AS vehicle_type,
    COUNT(DISTINCT s.stop_id) AS stop_count
FROM ptv.stops s
INNER JOIN ptv.stop_times st ON s.stop_id = st.stop_id
INNER JOIN ptv.trips t ON st.trip_id = t.trip_id
INNER JOIN ptv.routes r ON t.route_id = r.route_id
INNER JOIN ptv.mb2021_mel mb 
    ON ST_Within(s.geom, mb.wkb_geometry)
GROUP BY region_name, vehicle_type
ORDER BY region_name, vehicle_type;

-- Coordinates (144.9631, -37.8136), correspond to Melbourne’s central point, 
-- commonly known as the area around Federation Square or Flinders Street Station. 
-- These coordinates are used here as a reference for Melbourne’s city centre.

-- Adding the city centre of Melbourne CBD as a point geometry
WITH city_centre AS (
    SELECT ST_SetSRID(ST_MakePoint(144.9631, -37.8136), 7844) AS centre_geom
)
-- Calculating the distance of each stop from the city centre
SELECT 
    s.stop_id, 
    s.stop_name, 
    ST_Distance(s.geom, cc.centre_geom) AS distance_from_city_centre
FROM ptv.stops s
CROSS JOIN city_centre cc
INNER JOIN ptv.melbourne_boundary mb 
    ON ST_Within(s.geom, mb.boundary_geom)
ORDER BY distance_from_city_centre;


drop table ptv.stop_heatmap_data;

-- Creating stops with coordinates and vehicle types
CREATE TABLE ptv.stop_heatmap_data AS
SELECT 
    s.stop_id, 
    s.stop_name, 
    ST_X(s.geom) AS longitude, 
    ST_Y(s.geom) AS latitude, 
    s.geom, 
    CASE 
        WHEN r.route_type = 0 THEN 'Tram'
        WHEN r.route_type = 2 THEN 'Train'
        WHEN r.route_type = 3 THEN 'Bus'
        ELSE 'Unknown'
    END AS vehicle_type
FROM ptv.stops s
INNER JOIN ptv.stop_times st ON s.stop_id = st.stop_id
INNER JOIN ptv.trips t ON st.trip_id = t.trip_id
INNER JOIN ptv.routes r ON t.route_id = r.route_id
INNER JOIN ptv.melbourne_boundary mb 
    ON ST_Within(s.geom, mb.boundary_geom);

-- Verifying the Data in stop_heatmap_data Table
SELECT * 
FROM ptv.stop_heatmap_data
LIMIT 10;


-- Creating the stop density heatmap table with area and density
DROP TABLE IF EXISTS ptv.stop_density_heatmap;

CREATE TABLE ptv.stop_density_heatmap AS
SELECT 
    mb.mb_code21 AS mesh_block_code,
    mb.gcc_name21 AS region_name,
    COUNT(s.stop_id) AS num_stops,
    SUM(mb.areasqkm21) AS total_area,
    COUNT(s.stop_id) / NULLIF(SUM(mb.areasqkm21), 0) AS stops_per_sqkm,
    ST_Centroid(mb.wkb_geometry) AS centroid_geom
FROM ptv.mb2021_mel mb
LEFT JOIN ptv.stops s 
    ON ST_Within(s.geom, mb.wkb_geometry)
GROUP BY mb.mb_code21, mb.gcc_name21, mb.wkb_geometry;

-- Verifying the Data in stop_density_heatmap Table
SELECT * 
FROM ptv.stop_density_heatmap
LIMIT 10;




