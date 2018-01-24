print.summary.compareGroups <-
function(x, digits=6,...) {
   if (!inherits(x,"summary.compareGroups"))
    stop("x must be of class 'summary.compareGroups'")
   nn<-names(x)
   if (attr(x,"groups")){
     yname<-attr(x,"yname")
     cat("\n --- Descriptives of each row-variable by groups of '",yname,"' ---\n", sep="")
   } else
     cat("\n --- Descriptives of each row-variable ---\n")
   for (i in 1:length(x)) {
     cat("\n")
     cat("------------------- \n")
     cat("row-variable:", nn[i], "\n")
     x.i <- as.matrix(x[[i]])
     x.i <- ifelse(is.nan(x.i), ".", signifdec(x.i, digits=digits))
     x.i <- ifelse(x.i=="NA", "", x.i)
     cat("\n")
     print(x.i, na.print="", quote=FALSE)
     if (!is.null(or<-attr(x[[i]],"OR"))){
       cat("\n")
       or <- ifelse(is.nan(or), ".", signifdec(or, digits=digits))
       or <- ifelse(or=="NA", "", or)       
       print(or, na.print="", quote=FALSE)
     } 
     if (!is.null(hr<-attr(x[[i]],"HR"))){
       cat("\n") 
       hr <- ifelse(is.nan(hr), ".", signifdec(hr, digits=digits))
       hr <- ifelse(hr=="NA", "", hr)             
       print(hr, na.print="", quote=FALSE)           
     }
  }
}

