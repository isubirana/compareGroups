export2latex <- function(x, ...)
{
  if (!inherits(x,"createTable"))
    stop("x must be of class 'createTable'")
  UseMethod("export2latex")  
}    

