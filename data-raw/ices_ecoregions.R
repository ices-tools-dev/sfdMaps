library(RODBC)
library(rgeos)
library(rgdal)
library(raster)

# open dB connection for shape files
dbConnection <- 'Driver={SQL Server};Server=SQL06;Database=GDB;Trusted_Connection=yes'
conn <- odbcDriverConnect(connection = dbConnection)
iceseco_raw <- sqlQuery(conn, "SELECT Ecoregion, Shape.STAsText() as wkt FROM QUERYREF_ICES_ECOREGIONS_RAW_20150113", rows_at_time = 1)
odbcClose(conn)

# convert to spatial data
ices_ecoregions <- as(do.call(bind, lapply(iceseco_raw$wkt, rgeos::readWKT)),
              "SpatialPolygonsDataFrame")
proj4string(ices_ecoregions) <- CRS("+init=epsg:4326")
ices_ecoregions$Ecoregion <- iceseco_raw$Ecoregion


usethis::use_data(ices_ecoregions, overwrite = TRUE)
