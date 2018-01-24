varinfo.compareGroups<-
function(x,...)
{
  if (!inherits(x,"compareGroups"))
    stop("x must be of character 'compareGroups'")
  varnames.orig<-attr(x,"varnames.orig")
  yname.orig<-attr(x,"yname.orig")  
  yname<-attr(x,"yname")
  varnames<-names(x)
  ans<-cbind(c(yname.orig,varnames.orig),c(yname,varnames))
  rownames(ans)<-1:nrow(ans)
  colnames(ans)<-c("Orig varname","Shown varname")
  cat("\n--- Analyzed variable names ----\n\n")
  print(ans,quote=FALSE)
  invisible(ans)
}