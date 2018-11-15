plot_raster <-
  function(x, value, ecoregion,
           col, breaks, resolution = 0.05, main = "") {

  # define bounding box based on ecoregion
  bbox <- as(raster::extent(ecoregion) + 1, "SpatialPolygons")
  sp::proj4string(bbox) <- sp::proj4string(ecoregion)

  # make base plot of land and ecoregion outline
  sp::plot(ecoregion, col = "#FF000001", axes = FALSE)
  sp::plot(ices_ecoregions, lwd = .5, add = TRUE)
  sp::degAxis(1, mgp = c(2, 0.5, 0))
  sp::degAxis(2, mgp = c(2, 0.75, 0), las = 1)
  graphics::box(bty = "o")
  sp::plot(coastline, col = "light grey", add = TRUE, lwd = 0.5)

  # plot raster
  raster::plot(x, col = col, breaks = breaks, add = TRUE, legend = FALSE)

  # add title
  mtext(main, outer = F, cex = 1, line = 0.5)
}
