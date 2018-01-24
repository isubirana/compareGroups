summary.createTable <-
function(object, ...) {
  if(!inherits(object, "createTable"))
    stop("'object' must be of class 'createTable'")
  if (inherits(object, "missingTable"))
    stop("summary cannot be applied to 'missingTable' objects")
  ans <- object
  class(ans) <- c("summary.createTable",class(ans))
  ans
}