print.createTable <-
function(x, which.table="descr", nmax=TRUE, header.labels=c(), ...){

  if (!inherits(x,"createTable"))
    stop("x must be of class 'createTable'")
    
  varnames<-attr(x,"varnames")
  nr<-attr(x,"nr")
  
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
  
  yname<-attr(x,"yname")   
  
  if (ww%in%c(1,3)){
    pp<-prepare(x,nmax=nmax,c())
    table1<-prepare(x,nmax=nmax,header.labels)[[1]]
    cc<-attr(pp,"cc")
    if (attr(x,"groups"))
      if (inherits(x,"missingTable"))
        cat("\n--------Missingness table by '",yname,"'---------\n\n",sep="")
      else
        cat("\n--------Summary descriptives table by '",yname,"'---------\n\n",sep="")      
    else
      if (inherits(x,"missingTable"))
        cat("\n--------Missingness table ---------\n\n",sep="")
      else
        cat("\n--------Summary descriptives table ---------\n\n",sep="")      
  
    ii<-ifelse(rownames(table1)[2]=='',2,1)
    if (!is.null(attr(x,"caption")))
      rownames(table1)<-paste("   ",rownames(table1))
    table1<-cbind(rownames(table1),table1)
    table1<-as.matrix(table1)
    table1<-ifelse(is.na(table1),"",table1)    
    table1[,1]<-format(table1[,1],justify="left")
    nn<-max(nchar(apply(table1,1,paste,collapse="")))+ncol(table1)-1
    if (spchar)
      hline.over<-paste(rep(intToUtf8(0xAFL),nn),collapse="")
    else
      hline.over<-paste(rep("-",nn),collapse="")    
    hline.under<-paste(rep("_",nn),collapse="")
    cat(hline.under,"\n")
    for (i in 1:ii) 
      cat(table1[i,],"\n")
    cat(hline.over,"\n")
    for (i in (ii+1):nrow(table1)){ 
      if (!is.null(attr(x,"caption")) && cc[i-ii]!=""){
        cat(cc[i-ii],":\n",sep="")
        cat(table1[i,],"\n")
      }else{
        cat(table1[i,],"\n")                  
      }      
    }  
    cat(hline.over,"\n")
  }
  
  if (ww%in%c(2,3)){
    table2<-prepare(x,nmax=nmax,header.labels=c())[[2]]  
    if (!is.null(attr(x,"caption")))
      rownames(table2)<-paste("   ",rownames(table2))
    cat("\n\n\n---Available data----\n\n")
    table2<-cbind(rownames(table2),table2)
    table2<-as.matrix(table2)
    table2<-ifelse(is.na(table2),"",table2)    
    table2[,-1]<-apply(table2[,-1,drop=FALSE],2,format,justify="centre")
    table2[,1]<-format(table2[,1],justify="left")
    nn<-max(nchar(apply(table2,1,paste,collapse="")))+ncol(table2)-1
    if (spchar)
      hline.over<-paste(rep(intToUtf8(0xAFL),nn),collapse="")
    else
      hline.over<-paste(rep("-",nn),collapse="")    
    hline.under<-paste(rep("_",nn),collapse="")
    cat(hline.under,"\n")
    cat(table2[1,],"\n")
    cat(hline.over,"\n")
    for (i in 2:nrow(table2)){
      if (!is.null(attr(x,"caption")) && attr(x,"caption")[[i-1]]!=""){
        cat(attr(x,"caption")[[i-1]],":\n",sep="")
        cat(table2[i,],"\n")
      }else{
        cat(table2[i,],"\n")                  
      }
    }
    cat(hline.over,"\n")
  }

}

