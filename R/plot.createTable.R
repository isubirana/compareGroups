plot.createTable <- 
function(x,...){
  invisible(lapply(attr(x,"x"),plot.compareGroups,...))
}