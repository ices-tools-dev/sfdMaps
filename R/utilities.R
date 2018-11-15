layout <- function(n.plots) {
    c <- r <- trunc(sqrt(n.plots))
    if (c < 1)
        r <- c <- 1
    if (c * r < n.plots)
        c <- c + 1
    if (c * r < n.plots)
        r <- r + 1
  c(r, c)
}
