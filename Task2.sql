-- Mandatory Requirements Check

drop table ptv.mb2021_mel;

-- Filtering Mesh Blocks for Melbourne Metropolitan Area
CREATE TABLE ptv.mb2021_mel AS
SELECT *
FROM ptv.mb_2021
WHERE gcc_name21 = 'Greater Melbourne';
-- This step ensures that only mesh blocks relevant to the Melbourne Metropolitan area are included, 
-- optimizing query costs by limiting the scope.

SELECT *
FROM ptv.mb2021_mel;

-- Optional Requirements Check

drop table ptv.melbourne_boundary;

-- Creating a Polygon for the Melbourne Metropolitan Boundary
CREATE TABLE ptv.melbourne_boundary AS
SELECT ST_Union(wkb_geometry) AS boundary_geom
FROM ptv.mb2021_mel;
-- This boundary will be useful for spatial queries like identifying stops inside the region.

-- Adding a geometry column to the Stops table
ALTER TABLE ptv.stops ADD COLUMN geom GEOMETRY(Point, 7844);

-- Populating the new geometry column with lat/lon data converted to points
UPDATE ptv.stops
SET geom = ST_SetSRID(ST_MakePoint(stop_lon, stop_lat), 7844);

-- Filtering Stops within the Melbourne Metropolitan Boundary
SELECT s.stop_id, s.stop_name, s.geom
FROM ptv.stops s
INNER JOIN ptv.melbourne_boundary mb
ON ST_Within(s.geom, mb.boundary_geom);

-- Counting transport stops by vehicle type for the Melbourne Metropolitan region
SELECT 
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
INNER JOIN ptv.melbourne_boundary mb ON ST_Within(s.geom, mb.boundary_geom)
GROUP BY r.route_type;