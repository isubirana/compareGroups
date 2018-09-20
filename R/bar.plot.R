bar.plot <-
function(x, file, var.label.x, perc, ...)
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

  pp <- table(x)
  ylab <- "Freq (n)"
  if (perc){
    pp <- prop.table(pp)*100
    ylab <- "Freq (%)"
  }

  barplot(pp,main=paste("Barplot of '",var.label.x,"'",sep=""),ylab=ylab,col="red")

  if (!is.null(file) && (length(grep("pdf$",file))==0 || !onefile))
    dev.off()

}
