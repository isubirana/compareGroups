summ.i <-
function(x){
  ny<-dim(x$descriptive)[1]-1
  if (attr(x,"method")[1]%in%c("no-data","continuous","Surv")){
    if (ny<=2){
      out <- cbind(x$sam, x$descriptive,c(NA,x$p.overall,rep(NA,ny-1)))
      colnames(out)[ncol(out)] <- "p.overall"
    } else {
      pvalues <- c(x$p.overall, x$p.trend, x$p.mul)
      pvalues <- rbind(rep(NA, length(pvalues)), pvalues, matrix(NA, ncol = length(pvalues), nrow = ny-1))
      colnames(pvalues)[1:2] <- c("p.overall","p.trend")
      out <- cbind(x$sam, x$descriptive, pvalues)
    }
    colnames(out)[1]<-"N"
  } else {
    nn<-x$descriptive
    pp<-x$prop
    colnames(pp)<-paste(colnames(nn)," (row%)",sep="")
    if (ny<=2){
      out <- cbind(nn, pp, c(NA,x$p.overall,rep(NA,ny-1)))
      colnames(out)[ncol(out)] <- "p.overall"
    } else {
      pvalues <- c(x$p.overall, x$p.trend, x$p.mul)
      pvalues <- rbind(rep(NA, length(pvalues)), pvalues, matrix(NA, ncol = length(pvalues), nrow = ny-1))
      colnames(pvalues)[1:2] <- c("p.overall","p.trend")
      out <- cbind(nn, pp, pvalues)
    }
  }
  if (!attr(x,"groups")){
    out<-out[-2,,drop=FALSE]
    out<-out[,-ncol(out),drop=FALSE]
  }
  if (!is.null(attr(x,"OR")))     
    attr(out,"OR")<-attr(x,"OR")    
  if (!is.null(attr(x,"HR")))
    attr(out,"HR")<-attr(x,"HR")    
  out
}

