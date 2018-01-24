table.i <-
function(x, hide.i, digits, digits.ratio, type, varname, hide.i.no, digits.p, sd.type, q.type){

  os<-sessionInfo()$platform
  locale<-sessionInfo()$locale
  locale<-strsplit(locale,";")[[1]] 
  locale<-locale[grep("^LC_CTYPE",locale)]        
  locale<-sub("LC_CTYPE=","",locale)
  spchar<-if (length(grep("linux",os))==0 || length(grep("UTF-8",locale))>0) TRUE else FALSE

  method<-attr(x,"method")

  if (is.na(digits))
    digits<-NULL

  if (is.na(digits.ratio))
    digits.ratio<-NULL

  if (is.na(type))
    type<-2

  pvals<-c(x$p.overall,x$p.trend,x$p.mul)
  names(pvals)[1:2]<-c("p.overall","p.trend")
  pvals<-format2(pvals,digits.p)
  pvals<-ifelse(is.na(pvals) | is.nan(pvals),".",pvals)
  N<-x$sam[1]
  or<-attr(x,"OR")
  hr<-attr(x,"HR")

  ci <- if(!is.null(or)) or else hr
  p.ratio <- attr(x,"p.ratio")

  if (!is.null(ci)){
    rr <- apply(is.na(ci) & !is.nan(ci),1,any)
    ci <- ifelse(is.nan(ci),".",format2(ci,digits.ratio))
    ci <- t(ci)
    ci <- apply(ci,2,function(vv) paste(vv[1]," [",vv[2],";",vv[3],"]",sep="")) 
    ci[rr]<-"Ref."
  } else  
    ci <- NA
  if (!is.null(p.ratio)){
    rr <- is.na(p.ratio) & !is.nan(p.ratio)
    p.ratio <- ifelse(is.nan(p.ratio),".",format2(p.ratio,digits.p))
    p.ratio[rr]<-"Ref."
  }else 
    p.ratio <- NA
  
  if (method[1]=="no-data"){
    nn<-x$descriptive
    nn<-ifelse(is.nan(nn),".",nn)
    rn<-rownames(nn)
    ci<-"."
    ans<-c(nn,ci,p.ratio,pvals,N)
    ans<-cbind(ans)
    rownames(ans)[1:length(rn)]<-rn
    rownames(ans)[length(rn)+1]<-"OR"
    rownames(ans)[nrow(ans)]<-"N"
    colnames(ans)<-varname   
  }
  if (method[1]=="categorical"){
    simp.hide<-FALSE
    ll<-levels(attr(x,"x"))  
    nn<-x$descriptive
    nn<-ifelse(is.na(nn),".",nn)
    pp<-format2(x$prop,digits)
    pp<-ifelse(is.na(pp),".",pp)
    ans<-pp
    if (type==1)
      ans<-matrix(paste(pp,"%",sep=""),nrow=nrow(ans),ncol=ncol(ans))    
    if (type==2)
      ans<-matrix(paste(nn," (",pp,"%)",sep=""),nrow=nrow(ans),ncol=ncol(ans))
    if (type==3)
      ans<-matrix(nn,nrow=nrow(ans),ncol=ncol(ans))
    colnames(ans)<-paste(varname,colnames(nn),sep=": ")
    rownames(ans)<-rownames(nn)
    ansp<-matrix(NA,nrow=length(pvals),ncol=ncol(ans))
    ansp[,1]<-pvals
    rownames(ansp)<-names(pvals)
    if (!is.na(hide.i)){
      if (hide.i==Inf)
        hide.i<-ncol(ans)
      if (is.character(hide.i)){
        hide.i.char<-hide.i
        hide.i<-which(hide.i==ll)
        if (length(hide.i)==0){
          warning(paste("in argument 'hide', category '",hide.i.char,"' not found in row-variable '",varname,"'",sep=""))
          hide.i<-NA
        }
      }
    } else {
      if (!is.na(hide.i.no[1])){
        simp.hide<-TRUE
        hide.i<-which(tolower(ll)%in%tolower(hide.i.no))
        if (length(hide.i)>1 | length(hide.i)==0 | ncol(ans)!=2){
          hide.i<-NA
          simp.hide<-FALSE
        }
      }    
    }
    if (!is.na(hide.i) & ncol(ans)>1){
      if (hide.i==1)
        ansp[,2]<-pvals
      ans<-ans[,-hide.i,drop=FALSE]
      ansp<-ansp[,-hide.i,drop=FALSE]
      if (length(ci)>1 || (length(ci)==1 && !is.na(ci)))
        ci <- ci[-hide.i]
      if (length(p.ratio)>1 || (length(p.ratio)==1 && !is.na(p.ratio)))
        p.ratio <- p.ratio[-hide.i]        
    }                                
    if (attr(x,"groups")){
      if (inherits(attr(x,"y"),"Surv"))
        ans<-rbind(ans,HR=ci,p.ratio=p.ratio,ansp)
      else
        ans<-rbind(ans,OR=ci,p.ratio=p.ratio,ansp)    
    }else
      ans<-rbind(ans,OR=ci,p.ratio=p.ratio,ansp)
    ans<-rbind(ans,rep(NA,ncol(ans)))
    ans[nrow(ans),1]<-N
    rownames(ans)[nrow(ans)]<-"N"
    if (simp.hide)
      colnames(ans)<-varname
  } 
  if (method[1]=="Surv"){
    nn<-x$descriptive
    nn<-format2(x$descriptive,digits)
    nn<-ifelse(is.na(nn) | is.nan(nn),".",nn)
    ans<-nn
    rn<-rownames(nn)
    ans<-cbind(c(paste(as.vector(ans),"%",sep=""),OR=ci,p.ratio=p.ratio,pvals,N))
    rownames(ans)[1:length(rn)]<-rn
    rownames(ans)[nrow(ans)]<-"N"
    colnames(ans)<-varname 
  }
  if (method[1]=="continuous"){
    nn<-x$descriptive
    nn<-format2(x$descriptive,digits)
    nn<-ifelse(is.na(nn),".",nn)
    if (method[2]=="normal"){
      if (sd.type==1)
        ans<-cbind(apply(nn,1,function(y) paste(y[1]," (",y[2],")",sep="")))
      else
        if (spchar)
          ans<-cbind(apply(nn,1,function(y) paste(y[1],intToUtf8(0xB1L),y[2],sep="")))        
        else
          ans<-cbind(apply(nn,1,function(y) paste(y[1],"+/-",y[2],sep="")))                
    } else {
      if (q.type[1]==1){
        if (q.type[2]==1)
          ans<-cbind(apply(nn,1,function(y) paste(y[1]," [",y[2],";",y[3],"]",sep="")))
        else 
          if (q.type[2]==2)
            ans<-cbind(apply(nn,1,function(y) paste(y[1]," [",y[2],",",y[3],"]",sep="")))
          else
            ans<-cbind(apply(nn,1,function(y) paste(y[1]," [",y[2],"-",y[3],"]",sep="")))      
      } else {
        if (q.type[2]==1)
          ans<-cbind(apply(nn,1,function(y) paste(y[1]," (",y[2],";",y[3],")",sep="")))
        else 
          if (q.type[2]==2)
            ans<-cbind(apply(nn,1,function(y) paste(y[1]," (",y[2],",",y[3],")",sep="")))
          else
            ans<-cbind(apply(nn,1,function(y) paste(y[1]," (",y[2],"-",y[3],")",sep="")))      
      }      
    }  
    rn<-rownames(nn)
    if (attr(x,"groups")){
      if (inherits(attr(x,"y"),"Surv"))
        ans<-cbind(c(ans,HR=ci,p.ratio=p.ratio,pvals,N))
      else
        ans<-cbind(c(ans,OR=ci,p.ratio=p.ratio,pvals,N))
    }else
      ans<-cbind(c(ans,OR=ci,p.ratio=p.ratio,pvals,N))  
    rownames(ans)[1:length(rn)]<-rn
    rownames(ans)[nrow(ans)]<-"N"
    colnames(ans)<-varname
  }
 
  ans

}

