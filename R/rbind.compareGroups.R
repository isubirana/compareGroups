rbind.compareGroups<-function(..., caption)
{
  list.names <- function(...) {
      deparse.level<-1
      l <- as.list(substitute(list(...)))[-1L]
      nm <- names(l)
      fixup <- if (is.null(nm)) 
          seq_along(l)
      else nm == ""
      dep <- sapply(l[fixup], function(x) switch(deparse.level + 1, "", if (is.symbol(x)) as.character(x) else "", 
          deparse(x, nlines = 1)[1L]))
      if (is.null(nm)) 
          dep
      else {
          nm[fixup] <- dep
          nm
      }
  } 

  args<-list(...)

  if (missing(caption))
    caption<-list.names(...)
  else{
    if (!is.null(caption))
      if (length(caption)!=length(args))
        stop("length of caption must be the number of 'compareGroups' objects to be combined")
  }
  
  cc<-unlist(lapply(args, function(x) !inherits(x,"compareGroups")))
  if (any(cc))
    stop("arguments must be of class 'compareGroups'")
  
  out<-list()
  nn<-varnames.orig<-character(0)
  k<-1
  for (i in 1:length(args)){    
    args.i<-args[[i]]
    if (!is.null(caption) && !is.null(attr(args.i,"caption")))
      warning(paste("Captions for",caption[i],"table will be removed"))        
    for (j in 1:length(args.i)){
      out[[k]]<-args.i[[j]]
      k<-k+1
    }
    nn<-c(nn,names(args.i))
    varnames.orig<-c(varnames.orig,attr(args.i,"varnames.orig"))
  }
  
  Xlong <- as.data.frame(lapply(args, function(args.i) attr(args.i,"Xlong")))

  names(out)<-nn
  attr(out,"yname")<-attr(args[[1]],"yname")
  attr(out,"yname.orig")<-attr(args[[1]],"yname.orig")
  attr(out,"ny")<-attr(args[[1]],"ny")
  attr(out,"groups")<-attr(args[[1]],"groups")
  attr(out,"varnames.orig")<-varnames.orig
  attr(out,"Xlong")<-Xlong
  attr(out,"ylong")<-attr(args.i,"ylong")
  
  if (!is.null(caption)){
    lc<-cumsum(unlist(lapply(args,length)))
    cc<-rep("",sum(unlist(lapply(args,length))))    
    lc<-c(0,lc[-length(lc)])+1
    cc[lc]<-caption
    attr(out,"caption")<-cc
  }
  
  class(out)<-c("rbind.compareGroups","compareGroups")
  out
}
