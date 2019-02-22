getResults <- function(obj, what = "descr"){

  if (!inherits(obj,"createTable") && !inherits(obj,"compareGroups"))
    stop("'obj' must be of class 'compareGroups' or 'createTable'")

  if (inherits(obj,"createTable")){
    if (inherits(obj,"cbind.createTable"))
      stop("'obj' cannot be of class 'cbind.createTable'")
    if (inherits(obj,"rbind.createTable")){
      temp <- list()
      for (i in 1:length(attr(obj,"x")))
        temp <- c(temp,attr(obj,"x")[[i]])  
      obj<-temp
    } else {
      obj<-attr(obj,"x")[[1]]
    }
  }
  
  if (!what%in%c("descr","p.overall","p.trend","p.mul","ratio"))
    stop("'what' must be 'descr', 'p.overall', 'p.trend', 'p.mul' or 'ratio'")
  
  ### Descriptives ###
  if (what=="descr"){
    nn.tot<-pp.tot<-mean.tot<-sd.tot<-med.tot<-q1.tot<-q3.tot<-inc.tot<-lower.tot<-upper.tot<-rn<-NULL
    for (i in 1:length(obj)){
      obj.i<-obj[[i]]
      mm<-attr(obj.i,"method")
      dd<-obj.i$desc
      if ("categorical"%in%mm){
        nn<-t(obj.i$descriptive)
        pp<-t(obj.i$prop/100)
        nn.tot<-rbind(nn.tot,nn)
        pp.tot<-rbind(pp.tot,pp)
        lowers <- t(obj.i$lower/100)
        uppers <- t(obj.i$upper/100)
        inc.tot<-rbind(inc.tot,matrix(NA,nrow=nrow(pp),ncol=ncol(pp)))
        mean.tot<-rbind(mean.tot,matrix(NA,nrow=nrow(pp),ncol=ncol(pp)))
        sd.tot<-rbind(sd.tot,matrix(NA,nrow=nrow(pp),ncol=ncol(pp)))
        med.tot<-rbind(med.tot,matrix(NA,nrow=nrow(pp),ncol=ncol(pp)))
        q1.tot<-rbind(q1.tot,matrix(NA,nrow=nrow(pp),ncol=ncol(pp)))
        q3.tot<-rbind(q3.tot,matrix(NA,nrow=nrow(pp),ncol=ncol(pp)))
        lower.tot<-rbind(lower.tot,lowers)
        upper.tot<-rbind(upper.tot,uppers)
        rn<-c(rn,paste(names(obj)[i],rownames(nn),sep=": "))
      }
      if ("normal"%in%mm){
        means<-t(dd[,1,drop=FALSE])
        sds<-t(dd[,2,drop=FALSE])
        lowers <- t(dd[,"lower",drop=FALSE])
        uppers <- t(dd[,"upper",drop=FALSE])
        mean.tot<-rbind(mean.tot,means)
        sd.tot<-rbind(sd.tot,sds)
        inc.tot<-rbind(inc.tot,matrix(NA,nrow=1,ncol=ncol(means)))
        nn.tot<-rbind(nn.tot,matrix(NA,nrow=1,ncol=ncol(means)))
        pp.tot<-rbind(pp.tot,matrix(NA,nrow=1,ncol=ncol(means)))
        med.tot<-rbind(med.tot,matrix(NA,nrow=1,ncol=ncol(means)))
        q1.tot<-rbind(q1.tot,matrix(NA,nrow=1,ncol=ncol(means)))
        q3.tot<-rbind(q3.tot,matrix(NA,nrow=1,ncol=ncol(means)))
        lower.tot<-rbind(lower.tot,lowers)
        upper.tot<-rbind(upper.tot,uppers)
        rn<-c(rn,names(obj)[i])                                
      }
      if ("non-normal"%in%mm){
        meds<-t(dd[,1,drop=FALSE])
        q1s<-t(dd[,2,drop=FALSE])
        q3s<-t(dd[,3,drop=FALSE])
        lowers <- t(dd[,"lower",drop=FALSE])
        uppers <- t(dd[,"upper",drop=FALSE])
        med.tot<-rbind(med.tot,meds)
        q1.tot<-rbind(q1.tot,q1s)
        q3.tot<-rbind(q3.tot,q3s)
        inc.tot<-rbind(inc.tot,matrix(NA,nrow=1,ncol=ncol(meds)))
        nn.tot<-rbind(nn.tot,matrix(NA,nrow=1,ncol=ncol(meds)))
        pp.tot<-rbind(pp.tot,matrix(NA,nrow=1,ncol=ncol(meds)))
        mean.tot<-rbind(mean.tot,matrix(NA,nrow=1,ncol=ncol(meds)))
        sd.tot<-rbind(sd.tot,matrix(NA,nrow=1,ncol=ncol(meds)))
        lower.tot<-rbind(lower.tot,lowers)
        upper.tot<-rbind(upper.tot,uppers)
        rn<-c(rn,names(obj)[i]) 
      }
      if ("Surv"%in%mm){
        incs<-t(dd[,1,drop=FALSE])
        lowers <- t(dd[,"lower",drop=FALSE])
        uppers <- t(dd[,"upper",drop=FALSE])
        inc.tot<-rbind(inc.tot,incs)
        mean.tot<-rbind(mean.tot,matrix(NA,nrow=1,ncol=ncol(incs)))
        sd.tot<-rbind(sd.tot,matrix(NA,nrow=1,ncol=ncol(incs)))        
        nn.tot<-rbind(nn.tot,matrix(NA,nrow=1,ncol=ncol(incs)))
        pp.tot<-rbind(pp.tot,matrix(NA,nrow=1,ncol=ncol(incs)))
        med.tot<-rbind(med.tot,matrix(NA,nrow=1,ncol=ncol(incs)))
        q1.tot<-rbind(q1.tot,matrix(NA,nrow=1,ncol=ncol(incs)))
        q3.tot<-rbind(q3.tot,matrix(NA,nrow=1,ncol=ncol(incs)))
        lower.tot<-rbind(lower.tot,lowers)
        upper.tot<-rbind(upper.tot,uppers)
        rn<-c(rn,names(obj)[i]) 
      }      
    }
    rownames(mean.tot)<-rownames(sd.tot)<-rownames(med.tot)<-rownames(q1.tot)<-rownames(q3.tot)<-rownames(nn.tot)<-rownames(pp.tot)<-rownames(inc.tot)<-rownames(lower.tot)<-rownames(upper.tot)<-rn
    if (attr(obj,"groups")){ 
      ans<-array(NA,dim=c(nrow(mean.tot),10,ncol(mean.tot)),dimnames=list(rn,c("mean","sd","med","Q1","Q3","n","prop","inc","lower","upper"),c("[ALL]",levels(attr(obj[[1]],"y")))))
      ans[,1,]<-mean.tot
      ans[,2,]<-sd.tot
      ans[,3,]<-med.tot
      ans[,4,]<-q1.tot
      ans[,5,]<-q3.tot        
      ans[,6,]<-nn.tot        
      ans[,7,]<-pp.tot
      ans[,8,]<-inc.tot
      ans[,9,]<-lower.tot
      ans[,10,]<-upper.tot
    } else {
      ans<-array(NA,dim=c(nrow(mean.tot),ncol=10),dimnames=list(rn,c("mean","sd","med","Q1","Q3","n","prop","inc","lower","upper")))
      ans[,1]<-mean.tot[,1]
      ans[,2]<-sd.tot[,1]
      ans[,3]<-med.tot[,1]
      ans[,4]<-q1.tot[,1]
      ans[,5]<-q3.tot[,1]        
      ans[,6]<-nn.tot[,1]        
      ans[,7]<-pp.tot[,1] 
      ans[,8]<-inc.tot[,1]
      ans[,9]<-lower.tot[,1]
      ans[,10]<-upper.tot[,1]
    }
  }

  ### p.overall ###
  if (what=="p.overall"){
    if (!attr(obj,"groups"))
      stop("There are no groups to compute p-value")
    ans<-sapply(1:length(obj),function(i) obj[[i]]$p.overall)
    names(ans)<-names(obj)
  }
  
  ### p.trend ###
  if (what=="p.trend"){
    if (!attr(obj,"groups") || nlevels(attr(obj[[1]],"y"))<3)
      stop("There are less than 3 groups to compute p-trend")  
    ans<-sapply(1:length(obj),function(i) obj[[i]]$p.trend)
    names(ans)<-names(obj)
  }
  
  ### p.mult###
  if (what=="p.mul"){
    if (!attr(obj,"groups") || nlevels(attr(obj[[1]],"y"))<3)
      stop("There are less than 3 groups to compute p-trend")  
    ans<-t(sapply(1:length(obj),function(i) obj[[i]]$p.mul))
    rownames(ans)<-names(obj)
  }  
  
  ### OR / HR ###
  if (what=="ratio"){
    if  (!is.null(attr(obj[[1]],"OR"))){
      ratios <- sapply(1:length(obj),function(i) attr(obj[[i]],"OR"))
      pvals <- sapply(1:length(obj),function(i) attr(obj[[i]],"p.ratio"))
    } else {  
      if  (!is.null(attr(obj[[1]],"HR"))){
        ratios <- lapply(1:length(obj),function(i) attr(obj[[i]],"HR"))
        pvals <- lapply(1:length(obj),function(i) attr(obj[[i]],"p.ratio"))
      } else 
        stop("No OR or HR computed")
    }
    ans<-NULL
    for (i in 1:length(ratios)){
      ratios.i<-ratios[[i]]
      pvals.i<-pvals[[i]]
      kk<-which(is.na(ratios.i[,2]))
      if (length(kk)>0){
        ratios.i<-ratios.i[-kk,,drop=FALSE]
        pvals.i<-pvals.i[-kk]
        rownames(ratios.i)<-paste(names(obj)[i],rownames(ratios.i),sep=": ")
      }else{
        rownames(ratios.i)<-names(obj)[i]
      }
      ans<-rbind(ans,cbind(ratios.i,"pval"=pvals.i))
    }
  }
  
  ### RETURN ###
  ans
}
