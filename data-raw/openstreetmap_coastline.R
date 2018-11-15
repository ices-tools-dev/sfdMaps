library(rgeos)
library(rgdal)
library(raster)

# get european coastline shapefiles
download.file("http://data.openstreetmapdata.com/land-polygons-generalized-3857.zip",
              "data-raw/land-polygons-generalized-3857.zip")

unzip(zipfile = "data-raw/land-polygons-generalized-3857.zip",
      overwrite = TRUE,
      exdir = "data-raw")

unlink("data-raw/land-polygons-generalized-3857.zip")

# read coastline shapefiles and transform to wgs84
coastline <- readOGR("data-raw/land-polygons-generalized-3857", "land_polygons_z5", verbose = FALSE)
unlink("data-raw/land-polygons-generalized-3857", recursive = TRUE)

coastline <- spTransform(coastline, CRS("+init=epsg:4326"))

# trim coastline to extent for ploting
#bbox <- as(extent(bind(ospar_regions, helcom_regions, ices_ecoregions)), "SpatialPolygons")
bbox <- as(extent(c(-44, 68.5, 27.68229, 90)), "SpatialPolygons")
proj4string(bbox) <- CRS("+init=epsg:4326")
coastline <- gIntersection(coastline, bbox, byid = TRUE)
coastline <- gUnaryUnion(coastline)
coastline <- as(coastline, "SpatialPolygonsDataFrame")

# save coastline
usethis::use_data(coastline)
