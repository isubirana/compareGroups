printTable <- function(obj, row.names = TRUE, justify = 'right')
{
  if (!inherits(obj,"data.frame") && !inherits(obj,"matrix"))
    stop(" 'obj' must be of class 'data.frame' or 'matrix'")
  os<-sessionInfo()$platform
  locale<-sessionInfo()$locale
  locale<-strsplit(locale,";")[[1]] 
  locale<-locale[grep("^LC_CTYPE",locale)]        
  locale<-sub("LC_CTYPE=","",locale)
  spchar<-if (length(grep("linux",os))==0 || length(grep("UTF-8",locale))>0) TRUE else FALSE
  obj <- as.matrix(obj)
  obj <- rbind(colnames(obj), obj)
  if (row.names)
    obj[,1] <- apply(obj[, 1,drop = FALSE], 2, format, justify = "left")
  else
    obj[,1] <- apply(obj[, 1,drop = FALSE], 2, format, justify = justify)    
  obj[,-1] <- apply(obj[, -1, drop=FALSE], 2, format, justify = justify)
  obj <- as.matrix(obj)
  obj <- apply(obj, 1, paste, collapse=" ")
  nch <- max(nchar(obj))
  cat(paste(rep("_", nch), collapse=""), "\n")
  cat(obj[1], "\n")
  cat(paste(rep("=", nch), collapse  =""), "\n")
  for (i in 2:length(obj)) cat(obj[i], "\n")
  if (spchar)
    cat(paste(rep(intToUtf8(0xAFL), nch), collapse = ""), "\n")
  else
    cat(paste(rep("-", nch), collapse = ""), "\n")  
}
