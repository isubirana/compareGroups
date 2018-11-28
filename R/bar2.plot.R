bar2.plot<-function(x, y, file, var.label.x, var.label.y, perc, byrow, ...)     
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
    
  pp <- table(x, y)
  ylab <- "Freq (n)"
  main <- paste("Barplot of '",var.label.x,"' by '",var.label.y,"'", sep="")  

  if (!is.na(byrow) & byrow) {
    main <- paste("Barplot of '",var.label.y,"' by '",var.label.x,"'", sep="")
    pp <- table(y, x)
  }
  if (perc){
    if (!is.na(byrow)) 
      pp <- prop.table(pp, margin=2)*100
    else 
      pp <- prop.table(pp, margin=NULL)*100
    ylab <- "Freq (%)"
  }

  if (!is.na(byrow) & byrow){
    barplot(pp, beside=TRUE, main=main, ylim=c(0,max(pp)*1.3),ylab=ylab,col=rainbow(nlevels(y))) 
    legend("topleft",levels(y),fill=rainbow(nlevels(y)),bty="n")
  }else{
    barplot(pp, beside=TRUE, main=main, ylim=c(0,max(pp)*1.3),ylab=ylab,col=rainbow(nlevels(x))) 
    legend("topleft",levels(x),fill=rainbow(nlevels(x)),bty="n")
  }
  
  if (!is.null(file) && (length(grep("pdf$",file))==0 || !onefile))
    dev.off()

}
