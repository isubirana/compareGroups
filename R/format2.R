format2 <-
function(x,digits=NULL,stars=FALSE,...){
  if (!is.null(digits)){             
    res<-format(round(x,digits),trim=TRUE,nsmall=digits,...)
    res<-ifelse(res==paste("0.",paste(rep(0,digits),collapse=""),sep=""),paste("<0.",paste(rep(0,digits-1),collapse=""),"1",sep=""),res)
    res<-ifelse(res==paste("0,",paste(rep(0,digits),collapse=""),sep=""),paste("<0,",paste(rep(0,digits-1),collapse=""),"1",sep=""),res)    
    res<-ifelse(x==0,format(round(x,digits),trim=TRUE,nsmall=digits,...),res)
    res<-ifelse(is.na(x) | is.nan(x) | x==Inf | x==-Inf,".",res)
  } else {
    res <- ifelse(is.na(x) | is.nan(x) | x==Inf | x==-Inf,".",
           ifelse(x<10,format(round(x,2),trim=TRUE,nsmall=2,...),
           ifelse(x<100,format(round(x,1),trim=TRUE,nsmall=1,...),format(round(x,0),trim=TRUE,nsmall=0,...))))
  }
  if (stars){
    res <- ifelse(x<0.05, paste0(res, "** "), 
           ifelse(x<0.1, paste0(res, "*  "), paste0(res,"   ")))
  }
  return(res)
}

