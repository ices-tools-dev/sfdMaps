plot_legend <- function(breaks, col, title, digits = 0, greater_than_zero = TRUE) {

  ncol <- length(breaks) - 1
  fbreaks <- formatC(breaks, format = "f", digits = digits)

  if (greater_than_zero && fbreaks[1] == 0) {
    fbreaks[1] <- "> 0"
  }

  labels <- paste0(fbreaks[(ncol):1], " - ", fbreaks[(ncol + 1):2])

  par(fig = c(0, 1, 0, 1), oma = c(0.2, 0.2, 0.2, 0.2), mar = c(0, 0, 0, 0), new = TRUE)
  plot(0, 0, type = 'n', bty = 'n', xaxt = 'n', yaxt = 'n')

  legend("topright", y = NULL,
         legend = labels,
         title = title,
         col = col[ncol:1], pch = 15, pt.cex = 2.5,
         bg = "white", inset = c(0, 0), xpd = TRUE)
}
