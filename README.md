# Transport Accessibility in the Melbourne Metropolitan Area

This project explores transport accessibility within the Melbourne Metropolitan area using GTFS (General Transit Feed Specification) data and mesh block datasets. The focus is on understanding the spatial distribution of transport stops and routes for various modes such as buses, trains, and trams.

---

## Contents

### Main Files

1. **Documentation**: 
   - Provides detailed insights into the project's methodology, data preprocessing steps, and analysis findings.

2. **SQL Scripts**: 
   - Includes code for data restoration, preprocessing, and exploration in PostgreSQL.

3. **GeoSpatial Maps**:
   - Generated using QGIS to visualize public transport accessibility.

4. **GTFS Datasets**: 
   - Files include `agency.txt`, `calendar.txt`, `routes.txt`, `stops.txt`, and more.

5. **Spatial Datasets**:
   - Mesh blocks, local government areas, and statistical areas for Melbourne.

---

## Objectives

1. **Analyze the distribution of transport stops by vehicle type**.
2. **Evaluate proximity of stops to the Melbourne CBD**.
3. **Identify high-density and underserved areas using stop density heatmaps**.

---

## Methodology

1. **Data Restoration**
   - Datasets were restored into a PostgreSQL schema (`ptv`) using `COPY` statements.
   - Included tables for transport stops, routes, trips, and spatial datasets.

2. **Data Preprocessing**
   - Filtered mesh blocks to retain only those in the Melbourne Metropolitan area.
   - Added a geometry column to the stops table for spatial queries.

3. **Analysis & Visualizations**
   - Created visualizations to explore stop density, distribution by mode, and proximity to the CBD.
   - Tools used: PostgreSQL (via DBeaver) and QGIS.

---

## Results

### Key Findings

1. **Route Distribution by Vehicle Type**:
   - Bus routes dominate Melbourne's transport network, covering low-density outer suburbs.
   - Trams and trains focus on inner suburbs and key corridors.

2. **Stop Density**:
   - High density near the Melbourne CBD.
   - Sparse coverage in outer suburbs, highlighting underserved areas.

3. **Proximity Analysis**:
   - Stops within 5 km of the CBD exhibit high accessibility.
   - Declining accessibility beyond 20-30 km from the CBD.

---

## Visualizations

1. **Public Transport Stops by Vehicle Type**:
   - Tram (blue), Train (red), and Bus (green) stops visualized on a map.
2. **Heatmap of Stop Density**:
   - Red areas indicate high-density clusters near the CBD.

---

## Tools and Technologies

- **PostgreSQL via DBeaver**: For data restoration and analysis.
- **QGIS**: For generating geospatial visualizations.

---

## Future Directions

1. Enhance service frequency in underserved outer suburbs.
2. Improve connectivity between buses, trams, and trains.
3. Integrate demand-side data for better alignment with user needs.

---

## References

- [PostgreSQL Documentation](https://www.postgresql.org)
- [QGIS Documentation](https://qgis.org)
- [Public Transport Victoria](https://www.ptv.vic.gov.au)

---

## License

This project is licensed under GNU (General Public License). See the LICENSE file for details.
