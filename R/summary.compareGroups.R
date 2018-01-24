summary.compareGroups <-
function(object, ...) {
  if(!inherits(object, "compareGroups"))
    stop("'object' must be of class 'compareGroups'")
  ans <- lapply(object, FUN = summ.i)
  attr(ans,"yname")<-attr(object,"yname")
  attr(ans,"groups")<-attr(object,"groups")
  class(ans) <- "summary.compareGroups"
  ans
}

