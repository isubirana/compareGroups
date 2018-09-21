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
    X.eval <- eval(X)
    
    if (inherits(X.eval, "formula")){
      if (length(X.eval)<3)
        formul <- paste("~ ", paste(vars.orig, collapse=" + "))
      else
        formul <- paste(all.vars(X.eval)[1],"~",paste(vars.orig, collapse=" + "))
      cmd <- paste0("update(x,formula=",formul,")")
    } else {
      formul <- paste("~ ", paste(vars.orig, collapse="+"))
      data.name <- attr(x,"call")$call$formula
      cmd <- paste0("update(x,formula=",formul,", data=",data.name,")")
    }
    
    y <- eval(parse(text=cmd))
    
    y

}