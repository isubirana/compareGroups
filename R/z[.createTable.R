"[.createTable"<-function(x,i,...){
  show.descr <- attr(x,"show.descr")
  all.last <- attr(x,"all.last")
  if (is.character(i)){
    oo<-attr(attr(x,"x")[[1]],"varnames.orig")
    oo<-structure(1:length(oo),names=oo)
    if (!all(i%in%names(oo)))
      warning("some specified variables in subsetting don't exist.\nBe sure to specify the name of selected variables by the 'original name' and not their label")
    i<-oo[i]
    i<-i[!is.na(i)]
  } 
  class.orig<-class(x)
  if (inherits(x,"rbind.createTable"))
    stop("x cannot be of class rbind.createTable")
  cc<-x$call
  hide<-attr(x,"hide")[i]
  hide<-sapply(hide,function(x) if(is.character(x) && !is.na(x)) paste("'",x,"'",sep="") else x)
  digits<-attr(x,"digits")[i]
  digits.ratio<-attr(x,"digits.ratio")[i]
  hide<-paste("c(",paste(hide,collapse=","),")")
  digits<-paste("c(",paste(digits,collapse=","),")")  
  digits.ratio<-paste("c(",paste(digits.ratio,collapse=","),")")  
  obj.i<-attr(x,"x")[[1]][i]
  if (inherits(x, "descrTable"))
    class(x) <- class(x)[class(x)!="descrTable"]
  ans<-eval(parse(text=paste("update(x,x=obj.i,hide=",hide,",digits=",digits,")",sep="")))
  attr(ans,"show.descr") <- show.descr
  attr(ans,"all.last") <- all.last
  class(ans)<-class.orig
  ans
}