"[.compareGroups" <- function(x, i, ...)
{
# i <- 1:2
# x <- compareGroups(~age+age+sex, predimed, method=c("age.1"=2))
  cg <- unclass(x)
  cg.list <- cg[i]
  names(cg.list) <- names(cg)[i]
  # attr(cg.list,"call") <- attr(cg, "call")
  attr(cg.list,"ny") <- attr(cg, "ny")
  attr(cg.list,"varnames.orig") <- attr(cg, "varnames.orig")[i]
  attr(cg.list,"yname") <- attr(cg, "yname")
  attr(cg.list,"yname.orig") <- attr(cg, "yname.orig")
  attr(cg.list,"groups") <- attr(cg, "groups")
  attr(cg.list,"Xlong") <- attr(cg, "Xlong")[i]
  attr(cg.list,"ylong") <- attr(cg, "ylong")
  attr(cg.list,"method") <- attr(cg, "method")[i]
  attr(cg.list,"ylong") <- attr(cg, "ylong")
  attr(cg.list,"Q1") <- attr(cg, "Q1")
  attr(cg.list,"Q3") <- attr(cg, "Q3")
  attr(cg.list,"byrow") <- attr(cg, "byrow")
  # attr(cg.list,"class") <- attr(cg, "class")
  class(cg.list) <- "compareGroups"
  # attr(cg.list,"form") <- attr(cg, "form")
  return(cg.list)
}


