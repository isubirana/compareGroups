print.summary.createTable <-
function(x, ...) {
  if(!inherits(x, "summary.createTable"))
    stop("'object' must be of class 'summary.createTable'")
  class(x) <- class(x)[-1]
  print(x, which.table = 'avail', ...)
}