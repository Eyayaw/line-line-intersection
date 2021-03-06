# Given equations of the two lines as:
# y = ax+c
# y = bx+d

lines_intersect <- function(a, c, b, d) {
  # A %*% X = D
  # where A is a 2x2 coefficient matrix
  # X = a 2x1 variable vector
  # a 2x1 constant vector
  if (a==b) {
    message("System is exactly singular: det A = 0.")
    message("No intersection!")
    return(NULL)
  }
  else {
    A <- matrix(c(1, -a, 1, -b), nrow = 2, ncol = 2, byrow = TRUE)
    D <- matrix(c(c, d), nrow = 2, ncol = 1, byrow = TRUE)
    sol <- solve(A, D) # (y, x)
    rev(sol) # bring x first (x, y)
  }
}

slope <- function(x, y) {
  (y[[2]] - y[[1]]) / (x[[2]] - x[[1]])
}

equation <- function(x, y, env=parent.frame()) {
  m = (y[[2]] - y[[1]]) / (x[[2]] - x[[1]])
  part = m*x[[1]] + y[[1]]
  eval(call("function", as.pairlist(alist(x = )),
            bquote({.(m) * (x) - .(part)})), env)
}

equation2 <- function(x0, y0, m, env = parent.frame()) {
  part = m*x0 + y0
  eval(call("function",
            as.pairlist(alist(x = )),
            bquote(.(m) * (x) - .(part))), env)
}
