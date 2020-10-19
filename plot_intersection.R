plot_intersection <- function(a, c, b, d, xlim=c(-20, 20), gg) {
  f1 <- function(x) a * x + c
  f2 <- function(x) b * x + d
  xll <- xlim[[1]] # x-axis lower limit
  xul <- xlim[[2]] # x-axis upper limit
  yll <- min(f1(xll), f2(xll), f1(xul), f2(xul)) # y-axis lower limit
  yul <- max(f1(xll), f2(xll), f1(xul), f2(xul)) # y-axis upper limit

  # create equation labels
  equ_label <- function() {
    slope <- c(a, b)
    paste0("y = ", ifelse(slope == 1, "", slope), "x + ", c(c, d))
  }
  labs <- equ_label()

  if (missing(gg)) gg <- ggplot()

  out = gg +
    geom_function(fun = f1, col = "red") +
    geom_label(aes(x = xul / 2, y = f1(xul / 2), label = labs[1]), col = "red") +
    geom_function(fun = f2, col = "blue") +
    geom_label(aes(x = -xul / 2, y = f2(-xul / 2), label = labs[2]), col = "blue")

  p <- lines_intersect(a, c, b, d) # point of intersection
  if (all(!is.null(p))) {
    lab.p <- paste0("(", paste(round(p, 2), collapse = ", "), ")")
    out = out +
    geom_point(aes(x = p[1], y = p[2])) +
    geom_label(aes(x = p[1], y = p[2]), label = lab.p) +
    # lims(x = c(xll, xul), y = c(yll, yul)) +
    labs(x = "x", y = "y")
    }
  out
}
