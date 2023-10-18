# North Carolina and South Carolina Cable Prioritization Analysis

The Wind Team within NCCOS is appointed by BOEM to provide guidance on cables that will connect the offshore wind areas in federal waters off the coast of North Carolina and South Carolina.

**Points of contact**
* **Region manager:** [Jennifer Wright](jennifer.wright@noaa.gov)
* **Data manager:** [Breanna Xiong](breanna.xiong@noaa.gov)
* **Data manager:** [Bryce O'brien](bryce.obrien@noaa.gov)

#### **Repository Structure**
-   **data**
    -   **raw_data:** the raw data integrated in the analysis (**Note:** original data name and structure were kept as downloaded except when either name was not descriptive or similar data were put in same directory to simplify input directories)
    -   **intermediate_data:** cleaned and transformed data
    -   **analysis_data:** processed data for analyzing in the constraints and cost models
    -   **lcp_data:** components required for the least cost path analysis
    -   **final_data:** final least cost path outputs for the cable prioritization
-   **code:** scripts for cleaning, processing, and analyzing data
-   **figures:** figures generated to visualize analysis
-   **methodology:** detailed [methods]() for the data and analysis

***Note for PC users:*** The code was written on a Mac so to run the scripts replace "/" in the pathnames for directories with two "\\".

Please contact Brian Free ([brian.free\@noaa.gov](mailto:brian.free@noaa.gov)) with any questions.

#### **Data sources**
##### *Generic Data*
| Layer | Data Source | Data Name | Metadata | Notes |
|---------------|---------------|---------------|---------------|---------------|
| Wind Areas | BOEM | [Renewable Energy Leases and Planning Areas](https://www.boem.gov/renewable-energy/boem-renewable-energy-geodatabase) | [Metadata](https://metadata.boem.gov/geospatial/boem_renewable_lease_areas.xml), [Renewable Energy GIS Data](https://www.boem.gov/renewable-energy/mapping-and-data/renewable-energy-gis-data) | Data are also accessible for download on [MarineCadastre](https://marinecadastre.gov/) (under "Active Renewable Energy Leases") |
