bar.plot <-
function(x, file, var.label.x, ...)
{
  x<-x[!is.na(x)]
  
  dots.args <- eval(substitute(alist(...))) 
  onefile <- FALSE
  if (!is.null(dots.args$onefile))
    onefile<- dots.args$onefile  
  
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

  barplot(table(x),main=paste("Barplot of '",var.label.x,"'",sep=""),ylab="Freq",col="red")

  if (!is.null(file) && (length(grep("pdf$",file))==0 || !onefile))
    dev.off()

}
