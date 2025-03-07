-- Loading agency.txt into ptv.agency
COPY ptv.agency FROM '/data/adata/gtfs/agency.txt' DELIMITER ',' CSV HEADER;

-- Loading calendar.txt into ptv.calendar
COPY ptv.calendar FROM '/data/adata/gtfs/calendar.txt' DELIMITER ',' CSV HEADER;

-- Loading calendar_dates.txt into ptv.calendar_dates
COPY ptv.calendar_dates FROM '/data/adata/gtfs/calendar_dates.txt' DELIMITER ',' CSV HEADER;

-- Loading routes.txt into ptv.routes
COPY ptv.routes FROM '/data/adata/gtfs/routes.txt' DELIMITER ',' CSV HEADER;

-- Loading stops.txt into ptv.stops
COPY ptv.stops FROM '/data/adata/gtfs/stops.txt' DELIMITER ',' CSV HEADER;

-- Loading trips.txt into ptv.trips
COPY ptv.trips FROM '/data/adata/gtfs/trips.txt' DELIMITER ',' CSV HEADER;

-- Loading stop_times.txt from the zip file
COPY ptv.stop_times FROM '/data/adata/gtfs/stop_times.txt' DELIMITER ',' CSV HEADER NULL '';

-- Loading shapes.txt from the zip file
COPY ptv.shapes FROM '/data/adata/gtfs/shapes.txt' DELIMITER ',' CSV HEADER;

-- another File

COPY ptv."LGA_2021" FROM '/data/adata/LGA_2021_AUST.csv' DELIMITER ',' CSV HEADER;

-- another File 

COPY ptv."SAL_2021" FROM '/data/adata/SAL_2021_AUST.csv' DELIMITER ',' CSV HEADER;

--Shape File

-- ogr2ogr PG:"dbname=gisdb user=postgres" "/data/adata/MB_2021_AUST_SHP_GDA2020/MB_2021_AUST_GDA2020.shp" -nln ptv.mb_2021 -overwrite -nlt MULTIPOLYGON
SELECT *
FROM ptv.mb_2021;

