"[.rbind.createTable"<-function(x,i,...){
  
  if (is.character(i)){
    oo<-NULL
    for (kk in 1:length(attr(x,"x")))
      oo<-c(oo,attr(attr(x,"x")[[kk]],"varnames.orig"))
    oo<-structure(1:length(oo),names=oo)
    if (!all(i%in%names(oo)))
      warning("some specified variables in subsetting don't exist.\nBe sure to specify the name of selected variables by the 'original name' and not their label")
    i<-oo[i]
    i<-i[!is.na(i)]
  } 
  
  args<-attr(x,"x")
  dots<-paste(paste("args[[",1:length(args),"]]",sep=""),collapse=",")
  ans<-eval(parse(text=paste("rbind(",dots,")",sep="")))
  
  rbind(args[[1]],args[[2]])
  
  ll.args<-unlist(lapply(args,length))
  nn.args<-as.vector(unlist(sapply(ll.args,function(x) 1:x)))
  ll.args<-rep(1:length(ll.args),ll.args)
  nn.args<-cbind(ll.args,nn.args)[i,,drop=FALSE]
  args.new<-list()
  k<-1
  for (j in unique(nn.args[1,])){
    nn.args.j<-nn.args[nn.args[,1]==j,,drop=FALSE]
    if (nrow(nn.args.j)>0){
      args.new[[k]]<-args[[j]][nn.args.j[,2]]
      k<-k+1
    }
  }
  args<-args.new
  if (length(args)==0)
    stop("No variables selected")
  
  args.ct<-attr(x,"args")
  
  hide<-unlist(lapply(args.ct,attr,which="hide"))
  digits<-unlist(lapply(args.ct,attr,which="digits"))
  type<-attr(args.ct[[1]],"type")
  show.p.overall<-attr(args.ct[[1]],"show.p.overall")
  show.all<-attr(args.ct[[1]],"show.all")
  show.p.trend<-attr(args.ct[[1]],"show.p.trend")
  show.p.mul<-attr(args.ct[[1]],"show.p.mul")
  show.n<-attr(args.ct[[1]],"show.n")
  show.ratio<-attr(args.ct[[1]],"show.ratio")
  show.descr<-attr(args.ct[[1]],"show.descr")
  hide.no<-attr(args.ct[[1]],"hide.no")
  digits.ratio<-unlist(lapply(args.ct,attr,which="digits.ratio"))
  
  caption<- unlist(attr(x, "caption"))
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
  
  names(hide)<-NULL
  names(digits)<-NULL
  names(digits.ratio)<-NULL
  
  y<-createTable(ans[i], hide=hide[i], digits=digits[i], type=type, show.p.overall=show.p.overall, show.all=show.all, show.p.trend=show.p.trend, show.p.mul=show.p.mul, show.n=show.n, show.ratio=show.ratio, show.descr=show.descr, hide.no=hide.no, digits.ratio=digits.ratio[i])
  
  attr(y,"caption") <- caption
  
  class(y)<-class(x)
  
  y
  
}
