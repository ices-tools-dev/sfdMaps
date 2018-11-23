plotPages <- function(value, coords, by,
                      ices_ecoregion,
                      main_title = "", legend_title = "",
                      by_names = NULL,
                      breaks = NULL,
                      palette = RColorBrewer::brewer.pal(9, "YlOrRd"),
                      res = 0.05, digits = NULL) {
  # save par setting so we can reset
  op <- par(no.readonly = TRUE)
  on.exit(par(op))

  # default settings:
  if (is.null(by_names)) {
    by_names <- sort(unique(by))
    names(by_names) <- by_names
  }

  # default breaks for effort...
  if (is.null(breaks)) breaks <- c(0, 1, 2, 5,
                                   10, 20, 50,
                                   100, 200, 500,
                                   1000, 2000, 5000, 10000)

  if (is.null(digits)) {
    # how small is the smallest number (in magnitude)
    decimals <- -1 * min(log(abs(breaks)[breaks != 0], 10))
    # set digits to be the 1st sig fig of the smallest if smallest < 1, otherwise 0
    digits <- pmax(0, decimals)
  }

  # set up colour
  col <- colorRampPalette(palette)(length(breaks) - 1)

  # set up breaks - trim to max value
  maxvalue <- max(value, na.rm = TRUE)
  breaks <- c(breaks[breaks < maxvalue], maxvalue)
  col <- col[1:(length(breaks) - 1)]

  # set up breaks - trim to min value
  minvalue <- min(value, na.rm = TRUE)
  breaks <- c(minvalue, breaks[breaks > minvalue])
  col <- col[length(col) - length(breaks):1 + 1]

  # set up page
  nplots <- length(unique(by))
  mfrow <- layout(nplots)
  par(mfrow = mfrow, oma = c(1, 1, 2, 7.5), mar = c(2, 2, 2, 2))

  # for each by variable
  for(i in names(by_names)) {
    iwhich <- which(by == i)
    rast <- make_raster(value[iwhich], coords[iwhich, ], resolution = res)
    plot_raster(rast,
                ecoregion = ices_ecoregion,
                main = by_names[i],
                col = col, breaks = breaks)
  }

  # do legend
  plot_legend(breaks, col, legend_title, digits)
  mtext(main_title, outer = TRUE, line = -1)
}
