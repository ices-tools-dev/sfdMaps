library(RODBC)
library(rgeos)
library(rgdal)
library(raster)

# open dB connection for shape files
dbConnection <- 'Driver={SQL Server};Server=SQL06;Database=GDB;Trusted_Connection=yes'
conn <- odbcDriverConnect(connection = dbConnection)
helcom_regions <- sqlQuery(conn, "SELECT geom.STAsText() as wkt FROM QueryRef_Baltic_polygon", rows_at_time = 1)$wkt
odbcClose(conn)

# convert to spatial data
helcom_regions <- rgeos::readWKT(helcom_regions)
helcom_regions <- as(helcom_regions, "SpatialPolygonsDataFrame")
proj4string(helcom_regions) <- CRS("+init=epsg:4326")

usethis::use_data(helcom_regions, overwrite = TRUE)
