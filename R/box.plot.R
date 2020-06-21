box.plot <-
function(x, y, file, var.label.x, var.label.y, ...) 
{

  kk<-!is.na(x) & !is.na(y)
  x<-x[kk]
  y<-y[kk]
  
  dots.args <- eval(substitute(alist(...))) 
  onefile <- FALSE
  if (!is.null(dots.args$onefile))
    onefile<- dots.args$onefile  

  if (length(unique(x))<5){
    return(NULL)
    warning(paste("too few valid different values for variable",var.label.x))
  }

  if (is.null(file))
    {} #dev.new()
  else {
    if (length(grep("bmp$",file)))
      bmp(file,...) 
    if (length(grep("png$",file)))
      png(file,...)  
    if (length(grep("tif$",file)))
      tiff(file,...)  
    if (length(grep("jpg$",file)))
      jpeg(file,...)  
    if (length(grep("pdf$",file)))
      if (!onefile)
        pdf(file,...)                             
  }
    
  boxplot(x ~ y, main = paste("Boxplot of '",var.label.x,"' by '",var.label.y,"'", sep=""),col="red",ylab=var.label.x, xlab=var.label.y)

  if (!is.null(file) && (length(grep("pdf$",file))==0 || !onefile))
    dev.off()

}
