"[.compareGroups"<-function(x,i,...){

    nn <- names(x)           
    nn.orig <- attr(x, "varnames.orig")

    if (is.integer(i))
      i <- i
    if (is.character(i)){
      if (all(i%in%nn))
        i <- which(nn%in%i)
      else{
        if (all(i%in%nn.orig))
          i <- which(nn.orig%in%i)
        else
          stop("some specified variables in subsetting don't exist")
      }
    }
    
    vars.orig <- attr(x, "varnames.orig")[i]
    X<-attr(x,"call")$call$formula
    Xext<-attr(x,"Xext")
    # X.eval <- eval(X)

    dd<-data.frame(attr(x[[1]],"x.orig"))
    for (ii in 2:length(x))
      dd[[ii]]<-attr(x[[ii]],"x.orig")
    dd<-dd[i]
    names(dd)<-vars.orig
    if (!is.null(Xext)){
      ww<-which(!names(Xext)%in%names(dd))
      if (length(ww)>0)  
        dd<-cbind(dd,Xext[,ww])
    }
    if (attr(x,"groups")){
      resp.value<-attr(x[[1]],"y.orig")
      X.eval <- eval(X)
      if (inherits(X.eval, "data.frame") || (inherits(X.eval,"formula") & length(X.eval)<3))
        resp <- "resp.name"
      else
        resp<-all.vars(X)[1]
      dd[[ncol(dd)+1]]<-resp.value
      names(dd)[ncol(dd)]<-as.character(resp)
    }else{
      resp<-resp.value<-NULL
    }
    pred<-paste(vars.orig,collapse="+")
    formul<-as.formula(paste(resp,pred,sep="~"))
    y<-update(x,formula=formul,data=dd,y=NULL)

    class(y) <- "compareGroups"
    y

}
     