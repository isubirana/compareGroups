trim <- function(x){
  x <- gsub("^[ ]+","",x)
  x <- gsub("[ ]+$","",x)
  x
}