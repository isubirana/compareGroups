plot.compareGroups<-function(x, file, type = "pdf", bivar = FALSE, z = 1.5, n.breaks = "Sturges", perc = FALSE, ...){

  if (!inherits(x,"compareGroups"))
    stop("x must be of class 'compareGroups'")

  if (!attr(x,"groups") & bivar){
    warning("Univariate plots are performed since no grouping variable specified")
    bivar<-FALSE
  }
  
  if (missing(file))
    file<-NULL

  dots.args <- eval(substitute(alist(...))) 
  onefile <- FALSE
  if (!is.null(dots.args$onefile))
    onefile<- dots.args$onefile

  var.labels<-names(x)
  namesx<-attr(x,"varnames.orig")  
  for (i in 1:length(x)){
    if (bivar)
      y<-attr(x[[i]],"y")
    else
      y<-NULL
    x.var<-attr(x[[i]],"x")
    if (is.null(file))
      file.i<-NULL
    else {
      if (type=='pdf' & onefile){
        file.i<-paste(file,".",type,sep="")
        if (i==1)
          pdf(file.i,...)
      } else
        file.i<-paste(file,namesx[i],".",type,sep="")      
    }
    if (is.null(y)){
      if (!is.factor(x.var) & !inherits(x.var,"Surv"))
        norm.plot(x=x.var, file=file.i, var.label.x=var.labels[i], z=z, n.breaks=n.breaks,...)  
      if (is.factor(x.var))
        bar.plot(x=x.var, file=file.i, var.label.x=var.labels[i], perc=perc, ...)
      if (inherits(x.var,"Surv"))
        KM.plot(x=x.var, file=file.i, var.label.x=var.labels[i],...)    
    } else {
      if (inherits(y,"Surv")){
        if (!is.factor(x.var) & !inherits(x.var,"Surv"))
          Cox.plot(x=x.var, y=y, file=file.i, var.label.x=var.labels[i], var.label.y=attr(x,"yname"),...)          
        if (is.factor(x.var))
          KMg.plot(x=x.var, y=y, file=file.i, var.label.x=var.labels[i], var.label.y=attr(x,"yname"),...)          
        if (inherits(x.var,"Surv"))
          Cox.plot(x=x.var, y=y, file=file.i, var.label.x=var.labels[i], var.label.y=attr(x,"yname"),...)  
      } else {
        if (!is.factor(x.var) & !inherits(x.var,"Surv"))
          box.plot(x=x.var, y=y, file=file.i, var.label.x=var.labels[i], var.label.y=attr(x,"yname"),...)    
        if (is.factor(x.var))
          bar2.plot(x=x.var, y=y, file=file.i, var.label.x=var.labels[i], var.label.y=attr(x,"yname"), perc=perc, byrow=attr(x,"byrow"), ...)          
        if (inherits(x.var,"Surv"))
          KMg.plot(x=y, y=x.var, file=file.i, var.label.x=attr(x,"yname"), var.label.y=var.labels[i],...)          
      }
    }   
    if (i==length(x) && !is.null(file) && type=='pdf' && onefile)
      dev.off()
  }

}     
