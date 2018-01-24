export2csv<-function(x, file, which.table="descr", sep=",", nmax = TRUE, header.labels=c(), ...){

  if (!inherits(x,"createTable"))
    stop("x must be of class 'createTable'")
    
  if (inherits(x,"cbind.createTable"))
    stop("x cannot be of class 'cbind.createTable'")        

  ww <- charmatch(which.table, c("descr","avail","both"))
  if (is.na(ww))
    stop(" argument 'which.table' must be either 'descr', 'avail' or 'both'")    
    
  if (ww%in%c(1,3)){
    pp<-prepare(x,nmax=nmax,header.labels)
    table1<-prepare(x,nmax=nmax,header.labels)[[1]]
    cc<-unlist(attr(pp,"cc"))
    ii<-ifelse(rownames(table1)[2]=='',2,1)
    table1<-cbind(rownames(table1),table1)
    if (!is.null(attr(x,"caption")))
      table1[,1]<-paste("    ",table1[,1])
    aux<-NULL
    for (i in (ii+1):nrow(table1)){
      if (!is.null(cc) && cc[i-ii]!=""){
        aux<-rbind(aux,c(cc[i-ii],rep("",ncol(table1)-1)))
        aux<-rbind(aux,table1[i,])
      }else {
        aux<-rbind(aux,table1[i,])      
      }
    }
    table1<-rbind(table1[1:ii,,drop=FALSE],aux)
    write.table(table1,file=file,na="",sep=sep,row.names=FALSE,col.names=FALSE,...)
  }

  if (ww%in%c(2,3)){  
    table2<-prepare(x,nmax=nmax,c())[[2]]
    table2<-cbind(rownames(table2),table2)
    if (!is.null(attr(x,"caption"))){
      cc<-unlist(attr(x,"caption"))
      table2[,1]<-paste("    ",table2[,1])
    }
    aux<-NULL
    for (i in 2:nrow(table2)){
      if (!is.null(attr(x,"caption")) && !is.null(cc) && cc[i-1]!=""){
        aux<-rbind(aux,c(cc[i-1],rep("",ncol(table2)-1)))
        aux<-rbind(aux,table2[i,])
      }else {
        aux<-rbind(aux,table2[i,])      
      }
    }
    table2<-rbind(table2[1,],aux)
    file.save<-paste(sub("\\.csv$","",file),"_appendix.csv",sep="")
    write.table(table2,file=file.save,na="",sep=sep,row.names=FALSE,col.names=FALSE,...)
  }

}

