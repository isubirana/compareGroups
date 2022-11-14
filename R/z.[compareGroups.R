"[.compareGroups" <- function(x, i, ...)
{
  if (is.character(i)){
    oo<-attr(x,"varnames.orig")
    oo<-structure(1:length(oo),names=oo)
    if (!all(i%in%names(oo)))
      warning("some specified variables in subsetting don't exist.\nBe sure to specify the name of selected variables by the 'original name' and not their label")
    i<-oo[i]
    i<-i[!is.na(i)]
  } 
  cg <- unclass(x)
  cg.list <- cg[i]
  names(cg.list) <- names(cg)[i]
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
  class(cg.list) <- "compareGroups"
  return(cg.list)
}


