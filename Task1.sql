
CREATE SCHEMA IF NOT EXISTS ptv;

DROP TABLE IF EXISTS ptv.agency;

CREATE TABLE ptv.agency (
    agency_id TEXT,
    agency_name TEXT,
    agency_url TEXT,
    agency_timezone TEXT,
    agency_lang TEXT
);

DROP TABLE IF EXISTS ptv.calendar;

-- Create table for calendar.txt
CREATE TABLE ptv.calendar (
    service_id TEXT,
    monday INTEGER,
    tuesday INTEGER,
    wednesday INTEGER,
    thursday INTEGER,
    friday INTEGER,
    saturday INTEGER,
    sunday INTEGER,
    start_date TEXT,
    end_date TEXT
);

DROP TABLE IF EXISTS ptv.calendar_dates;

-- Create table for calendar_dates.txt
CREATE TABLE ptv.calendar_dates (
    service_id TEXT,
    date TEXT,
    exception_type INTEGER
);

DROP TABLE IF EXISTS ptv.routes;

CREATE TABLE ptv.routes (
    route_id TEXT,
    agency_id TEXT,
    route_short_name TEXT,
    route_long_name TEXT,
    route_type INTEGER,
    route_color TEXT,
    route_text_color TEXT
);

DROP TABLE IF EXISTS ptv.stops;

CREATE TABLE ptv.stops (
    stop_id TEXT,
    stop_name TEXT,
    stop_lat DOUBLE PRECISION,
    stop_lon DOUBLE PRECISION
);

DROP TABLE IF EXISTS ptv.trips;

CREATE TABLE ptv.trips (
    route_id TEXT,
    service_id TEXT,
    trip_id TEXT,
    shape_id TEXT,
    trip_headsign TEXT,
    direction_id INTEGER
);

DROP TABLE IF EXISTS ptv.stop_times;

CREATE TABLE ptv.stop_times (
    trip_id TEXT,
    arrival_time TEXT,
    departure_time TEXT,
    stop_id TEXT,
    stop_sequence INTEGER,
    stop_headsign TEXT,
    pickup_type INTEGER,
    drop_off_type INTEGER,
    shape_dist_traveled TEXT
);

DROP TABLE IF EXISTS ptv.shapes;

-- Create table for shapes.txt
CREATE TABLE ptv.shapes (
    shape_id TEXT,
    shape_pt_lat DOUBLE PRECISION,
    shape_pt_lon DOUBLE PRECISION,
    shape_pt_sequence INTEGER,
    shape_dist_traveled DOUBLE PRECISION
);

-- LGA_2021

DROP TABLE IF EXISTS ptv.LGA_2021;

CREATE TABLE ptv.LGA_2021 (
    MB_CODE_2021 TEXT,
    LGA_CODE_2021 TEXT,
    LGA_NAME_2021 TEXT,
    STATE_CODE_2021 TEXT,
    STATE_NAME_2021 TEXT,
    AUS_CODE_2021 TEXT,
    AUS_NAME_2021 TEXT,
    AREA_ALBERS_SQKM DOUBLE PRECISION,
    ASGS_LOCI_URI_2021 TEXT
);

-- SAL_2021

DROP TABLE IF EXISTS ptv.SAL_2021;

CREATE TABLE ptv.SAL_2021 (
    MB_CODE_2021 TEXT,
    SAL_CODE_2021 TEXT,
    SAL_NAME_2021 TEXT,
    STATE_CODE_2021 TEXT,
    STATE_NAME_2021 TEXT,
    AUS_CODE_2021 TEXT,
    AUS_NAME_2021 TEXT,
    AREA_ALBERS_SQKM DOUBLE PRECISION,
    ASGS_LOCI_URI_2021 TEXT
);


