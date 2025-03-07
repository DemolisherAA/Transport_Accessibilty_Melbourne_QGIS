-- 1. Listing the Agencies Operating in Melbourne

SELECT agency_id, agency_name, agency_url, agency_timezone 
FROM ptv.agency;
-- Insight: PTV is only included and their area of responsibility. 

-- 2. Counting Routes by Vehicle Type (Mode)
SELECT 
    CASE 
        WHEN route_type = 0 THEN 'Tram'
        WHEN route_type = 2 THEN 'Train'
        WHEN route_type = 3 THEN 'Bus'
        ELSE 'Unknown'
    END AS vehicle_type,
    COUNT(route_id) AS route_count
FROM ptv.routes
GROUP BY vehicle_type;
-- Insight: Identify how many tram, train, and bus routes operate in Melbourne, giving an overview of service distribution by mode.

-- 3.1 Identifying Days with Maximum Service Availability
SELECT 
    SUM(monday) AS monday_services,
    SUM(tuesday) AS tuesday_services,
    SUM(wednesday) AS wednesday_services,
    SUM(thursday) AS thursday_services,
    SUM(friday) AS friday_services,
    SUM(saturday) AS saturday_services,
    SUM(sunday) AS sunday_services
FROM ptv.calendar;
-- Insight: Determine whether transport services are more active on weekdays or weekends, giving insights into travel patterns and accessibility.

-- 3.2. Identifying Calendar Date Exceptions (Special Events or Holidays)
SELECT 
    service_id, date, 
    CASE WHEN exception_type = 1 THEN 'Added Service'
         WHEN exception_type = 2 THEN 'Removed Service'
    END AS exception_type
FROM ptv.calendar_dates;
-- Insight: Understand how services are modified during holidays or special events, which can impact accessibility.

-- 4. Counting Total Trips per Route
SELECT 
	r.route_short_name, 
    t.route_id, COUNT(t.trip_id) AS trip_count
FROM ptv.trips t
LEFT JOIN ptv.routes r ON t.route_id = r.route_id
WHERE r.route_id IS NOT NULL
GROUP BY t.route_id, r.route_short_name
ORDER BY trip_count DESC;
-- Insight: Identify routes with the most and least number of trips, which might highlight accessibility issues on under-served routes.






