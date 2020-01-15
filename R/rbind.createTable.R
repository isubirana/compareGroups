rbind.createTable <- function(..., caption)
{

  cl<-match.call()
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
  
  cl.miss<-sapply(args,function(args.i) inherits(args.i,"missingTable"))  
  if (mean(cl.miss)>0 & mean(cl.miss)<1)
    stop("All or none of the tables must be of class 'missingTable'")

  if (missing(caption))
    caption<-list.names(...)
  else{
    if (!is.null(caption))
      if (length(caption)!=length(args))
        stop("length of caption must be the number of 'createTable' objects to be combined")
  }

  cc<-unlist(lapply(args, function(x) !inherits(x,"createTable")))
  if (any(cc))
    stop("arguments must be of class 'createTable'")
    
  out<-list()
  descr<-avail<-nr<-varnames<-NULL
  for (i in 1:length(args)){
    args.i<-args[[i]]
    if (!is.null(caption) && !is.null(attr(args.i,"caption"))){
      warning(paste("Captions for",caption[i],"table will be removed"))     
      attr(args.i,"caption")<-NULL
    }
    descr<-rbind(descr,args.i[[1]])
    avail<-rbind(avail,args.i[[2]])
    nr<-c(nr,attr(args.i,"nr"))
    varnames<-c(varnames,attr(args.i,"varnames"))
  }
  Xlong <- do.call(cbind, lapply(args, function(args.i) attr(args.i, "Xlong", exact=TRUE)))
  
  out$descr<-descr
  out$avail<-avail
  attr(out,"nmax.pos")<-attr(args.i,"nmax.pos")
  attr(out,"yname")<-attr(args.i,"yname")
  attr(out,"ny")<- attr(args.i, "ny")
  attr(out,"show.all")<- attr(args.i, "show.all")
  attr(out,"groups")<-attr(args.i, "groups") 
  attr(out,"dd.pos")<- attr(args.i, "dd.pos")
  attr(out,"ylevels")<- attr(args.i, "ylevels")
  attr(out,"nr")<-nr
  attr(out,"varnames")<-varnames
  attr(out,"x") <- lapply(args,function(aa) attr(aa,"x")[[1]])
  attr(out,"args")<-args  
  attr(out,"Xlong")<-Xlong
  attr(out,"ylong")<-attr(args.i,"ylong")
  attr(out,"all.last")<-attr(args.i,"all.last")
  attr(out,"show.descr")<-attr(args.i,"show.descr")
  
  if (!is.null(caption)){
    nv<-unlist(lapply(args,function(x) length(attr(x,"varnames"))))
    lc<-cumsum(nv)
    cc<-rep("",sum(nv))    
    lc<-c(0,lc[-length(lc)])+1
    cc[lc]<-caption
    attr(out,"caption")<-cc
  }
  
  out$call<-cl
  class(out)<-c("rbind.createTable",class(args[[1]]))
  out

}
