library(RODBC)
library(rgeos)
library(rgdal)
library(raster)

# open dB connection for shape files
dbConnection <- 'Driver={SQL Server};Server=SQL06;Database=GDB;Trusted_Connection=yes'
conn <- odbcDriverConnect(connection = dbConnection)
ospar_regions <- sqlQuery(conn, "SELECT shape.STAsText() as wkt FROM QUERYREF_OSPAR_REGIONS_20181005", rows_at_time = 1)$wkt
odbcClose(conn)

# convert to spatial data
ospar_regions <- do.call(bind, lapply(ospar_regions, readWKT))
ospar_regions <- as(ospar_regions, "SpatialPolygonsDataFrame")
proj4string(ospar_regions) <- CRS("+init=epsg:4326")

usethis::use_data(ospar_regions, overwrite = TRUE)
