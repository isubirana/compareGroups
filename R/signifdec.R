signifdec <-
function(x,digits){
  sapply(x,signifdec.i,digits=digits)
}

