bar2.plot<-function(x, y, file, var.label.x, var.label.y, ...)     
{

  kk<-!is.na(x) & !is.na(y)
  x<-x[kk]
  y<-y[kk]
  
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
    
  tt <- table(x, y)
  barplot(tt, beside=TRUE, main = paste("Barplot of '",var.label.x,"' by '",var.label.y,"'", sep=""),ylim=c(0,max(tt)*1.3),ylab="Freq",col=rainbow(nlevels(x))) 
  legend("topleft",levels(x),fill=rainbow(nlevels(x)),bty="n")

  if (!is.null(file) && (length(grep("pdf$",file))==0 || !onefile))
    dev.off()

}
