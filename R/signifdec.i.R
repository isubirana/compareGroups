signifdec.i <-
function(x,digits){
  if (length(x)>1)
    stop("x must be a single number")
  left<-unlist(strsplit(as.character(x),"\\."))[1]
  nc <- nchar(left)
  format(round(x,digits-nc+1))
}

