"[.rbind.compareGroups"<-function(x,i,...)
{
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
    
    y <- unclass(x)[i]
    attr(y,"varnames.orig") <- attr(x, "varnames.orig")[i]
    attr(y,"yname") <- attr(x, "yname")
    attr(y,"yname.orig") <- attr(x, "yname.orig")
    attr(y,"groups") <- attr(x, "groups")
    attr(y,"groups") <- attr(x, "groups")  
    attr(y,"ny") <- attr(x, "ny")
    attr(y,"ylong") <- attr(x, "ylong")
    attr(y,"Xlong") <- attr(x, "Xlong")[,i,drop=FALSE]
    caption<- attr(x, "caption")
    if (length(caption)>1){
      for (k in 2:length(caption))
        if (caption[k]=="")
          caption[k]<-caption[k-1]
    }
    caption<-caption[i]
    if (length(caption)>1){
      for (k in length(caption):2)
        if (caption[k]==caption[k-1])
          caption[k]<-""
    }
    attr(y,"caption") <- caption
    class(y) <- c("rbind.compareGroups","compareGroups")
    y
}
