varinfo.createTable <- 
function(x,...){
  invisible(lapply(attr(x,"x"),varinfo))
}
