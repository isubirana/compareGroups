Cox.plot <-
function(x, y, file, var.label.x, var.label.y, ...)   
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
  
  plot(y[,1],x,type="n",xlab="time",ylab=var.label.x)
  points(y[y[,2]==0,1],x[y[,2]==0],pch=21,cex=1,bg="black",col="black")
  points(y[y[,2]==1,1],x[y[,2]==1],pch=21,cex=1,bg="red",col="red")
  title(main = paste("Time plot of '",var.label.y,"' by '",var.label.x,"'", sep=""))
  legend("topright",c("censored","observed"),pch=19,col=c("black","red"),pt.bg=c("black","red"))
  
  if (!is.null(file) && (length(grep("pdf$",file))==0 || !onefile))
    dev.off()
     
}


