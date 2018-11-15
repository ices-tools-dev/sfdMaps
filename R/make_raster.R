make_raster <- function(value, coords, resolution = 0.05) {
  # make a raster of the data
  loc <- as.matrix(coords)
  colnames(loc) <- c("X", "Y")

  # set up an 'empty' raster, here via an extent object derived from your data
  r <- raster::raster(raster::extent(loc) + resolution/2,
                      resolution = resolution,
                      crs = sp::CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))

  raster::rasterize(loc, r, value, fun = mean)
}
