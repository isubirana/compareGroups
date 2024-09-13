print.cbind.createTable <- function(x, which.table="descr", nmax=TRUE, nmax.method=1, header.labels=c(), ...)
{

  if (!inherits(x,"cbind.createTable"))
    stop("'x' must be of class 'cbind.createTable")

  ww <- charmatch(which.table, c("descr","avail","both"))
  if (is.na(ww))
    stop(" argument 'which.table' must be either 'descr', 'avail' or 'both'")
    
  if (inherits(x,"missingTable"))
    if (ww != 1){
      warning(" only 'descr' table can be displayed for 'missingTable' object. Argument 'which.table' set to 'descr'")
      ww <- 1
    } 
    
  os<-sessionInfo()$platform
  locale<-sessionInfo()$locale
  locale<-strsplit(locale,";")[[1]] 
  locale<-locale[grep("^LC_CTYPE",locale)]        
  locale<-sub("LC_CTYPE=","",locale)
  spchar<-if (length(grep("linux",os))==0 || length(grep("UTF-8",locale))>0) TRUE else FALSE           
  
  caption<-attr(x,"caption")
  
  desc<-lapply(x,function(vv) prepare(vv,nmax=nmax,nmax.method=nmax.method,header.labels)[[1]])
  nmax <- any(unlist(lapply(x,function(vv) attr(prepare(vv,nmax=nmax,nmax.method=nmax.method,header.labels),"nmax"))))
  avail<-lapply(x,function(vv) prepare(vv,nmax=nmax,nmax.method=nmax.method,c())[[2]])  
  nc.desc<-lapply(desc,ncol)
  if (all(nc.desc==0))
    stop("Stratified table cannot be printed since no columns are displayed")
  if (any(nc.desc==0)){
    desc<-desc[-which(nc.desc==0)]  
    avail<-avail[-which(nc.desc==0)]  
    warning(paste("tables ",paste(which(nc.desc==0),collapse=", ")," removed since they have no columns to be displayed",sep=""))
    caption<-caption[-which(nc.desc==0)]
  }

  cc<-attr(prepare(x[[1]],nmax=nmax,nmax.method=nmax.method,header.labels),"cc")

  nmax.i<-unlist(lapply(desc,function(vv) rownames(vv)[2]==''))
  if (diff(range(nmax.i))!=0){
    for (i in which(!nmax.i)){
      desc.i<-desc[[i]]
      desc[[i]]<-rbind(desc.i[1,,drop=FALSE],rep("",ncol(desc.i)),desc.i[-1,,drop=FALSE])
    }
  }    
  
  aux.desc<-aux.avail<-NULL
  ll.desc<-ll.avail<-integer(0)
  lcap.desc<-lcap.avail<-character(0)
  for (i in 1:length(desc)){
    if (i>1 && !identical(rownames(aux.desc),rownames(desc[[i]])))
      stop(paste("table",i,"does not have the same row.names"))
    desc.i<-format(c(caption[[i]],apply(desc[[i]],1,paste,collapse=" ")),justify="centre")
    avail.i<-format(c(caption[[i]],apply(avail[[i]],1,paste,collapse=" ")),justify="centre")
    lcap.desc<-c(lcap.desc,desc.i[1])
    lcap.avail<-c(lcap.avail,avail.i[1])
    desc.i<-desc.i[-1]
    avail.i<-avail.i[-1]   
    aux.desc<-cbind(aux.desc,desc.i,rep("",length(desc.i)))
    aux.avail<-cbind(aux.avail,avail.i,rep("",length(avail.i)))
    ll.desc<-c(ll.desc,max(nchar(desc.i)))
    ll.avail<-c(ll.avail,max(nchar(avail.i)))
  }
  
  if (ww %in% c(1,3)){
    if (inherits(x[[1]],"missingTable"))
      cat("\n--------Missingness table ---------\n\n",sep="")  
    else
      cat("\n--------Summary descriptives table ---------\n\n",sep="")      
    desc<-aux.desc[,-ncol(aux.desc),drop=FALSE]
    ii<-ifelse(nmax,2,1)
    if (!is.null(attr(x[[1]],"caption")))
      rownames(desc)<-paste("   ",rownames(desc)) 
    desc<-cbind(rownames(desc),desc)
    desc<-apply(desc,2,format)
    lrn<-max(nchar(desc[,1]))+1
    cat(rep("_",lrn+sum(ll.desc)+2*length(ll.desc)-2),"\n",sep="")
    cat(rep(" ",lrn),paste(lcap.desc,collapse="  "),"\n",sep="")
    cat(rep(" ",lrn),paste(sapply(1:length(ll.desc),function(vv) paste(rep("_",ll.desc[vv]),collapse="")),collapse="  "),"\n",sep="")
    for (i in 1:ii)
      cat(desc[i,],"\n")
    if (spchar)
      cat(rep(intToUtf8(0xAFL),lrn+sum(ll.desc)+2*length(ll.desc)-2),"\n",sep="")
    else
      cat(rep("-",lrn+sum(ll.desc)+2*length(ll.desc)-2),"\n",sep="")          
    for (i in (ii+1):nrow(desc)){ 
      if (!is.null(attr(x[[1]],"caption")) && cc[i-ii]!=""){
        cat(cc[i-ii],":\n",sep="")
        cat(desc[i,],"\n")
      }else{
        cat(desc[i,],"\n")                  
      }      
    }
    if (spchar)  
      cat(rep(intToUtf8(0xAFL),lrn+sum(ll.desc)+2*length(ll.desc)-2),"\n",sep="")
    else
      cat(rep("-",lrn+sum(ll.desc)+2*length(ll.desc)-2),"\n",sep="")    
  }
  
  if (ww %in% c(2,3)){
    cat("\n\n\n---Available data----\n\n")  
    avail<-aux.avail[,-ncol(aux.avail),drop=FALSE]
    if (!is.null(attr(x[[1]],"caption")))
      rownames(avail)<-paste("   ",rownames(avail))    
    avail<-cbind(rownames(avail),avail)
    avail<-apply(avail,2,format)
    lrn<-max(nchar(avail[,1]))+1
    cat(rep("_",lrn+sum(ll.avail)+2*length(ll.avail)-2),"\n",sep="")
    cat(rep(" ",lrn),paste(lcap.avail,collapse="  "),"\n",sep="")
    cat(rep(" ",lrn),sapply(ll.avail,function(vv) paste(paste(rep("_",vv),collapse="")," ",collapse="")),"\n",sep="")
    cat(avail[1,],"\n")
    if (spchar)
      cat(rep(intToUtf8(0xAFL),lrn+sum(ll.avail)+2*length(ll.avail)-2),"\n",sep="")
    else
      cat(rep("-",lrn+sum(ll.avail)+2*length(ll.avail)-2),"\n",sep="")
    for (i in 2:nrow(avail)){
      if (!is.null(attr(x[[1]],"caption")) && attr(x[[1]],"caption")[[i-1]]!=""){
        cat(attr(x[[1]],"caption")[[i-1]],":\n",sep="")
        cat(avail[i,],"\n")
      }else{
        cat(avail[i,],"\n")                  
      }
    }
    if (spchar)
      cat(rep(intToUtf8(0xAFL),lrn+sum(ll.avail)+2*length(ll.avail)-2),"\n",sep="")
    else
      cat(rep("-",lrn+sum(ll.avail)+2*length(ll.avail)-2),"\n",sep="")    
  }
  
}

