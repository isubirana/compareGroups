combn2 <-
function(x){
  if (length(x)<2)
    return(x)
  else
    return(combn(x,2))
}

