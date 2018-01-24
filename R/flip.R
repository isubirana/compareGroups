flip <-
function(x){
  sapply(x,function(y) paste(sort(strsplit(y,"-")[[1]]),collapse="-"))
}

