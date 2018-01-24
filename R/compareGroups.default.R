compareGroups.default <-
function(X, y = NULL, Xext = NULL, selec = NA, method = 1, timemax = NA, alpha = 0.05, min.dis = 5, max.ylev = 5, max.xlev = 10, include.label = TRUE, Q1 = 0.25, Q3 = 0.75, simplify = TRUE, ref = 1, ref.no = NA, fact.ratio = 1, ref.y = 1, p.corrected = TRUE, compute.ratio = TRUE, include.miss = FALSE, oddsratio.method = "midp", chisq.test.perm = FALSE, byrow = FALSE, ...) {

   if (!is.null(Xext)){
    if (!is.matrix(Xext) & !is.data.frame(Xext))
      stop("Xext must be a matrix or a data.frame")
    if (is.matrix(Xext))
      Xext<-as.data.frame(X)      
    if (! NROW(Xext) == NROW(Xext))
      stop("Xext and X must have the same number of rows")
   }    

   if (!is.matrix(X) & !is.data.frame(X))
    stop("X must be a matrix or a data.frame")

   if (Q1>1 | Q1<0)
    stop("Q1 must be between 0 and 1")
      
   if (Q3>1 | Q3<0)
    stop("Q3 must be between 0 and 1")

   if (Q3<=Q1)
    stop("Q3 must be greater than Q1")

   cl <- match.call()
   yname <- as.character(cl)[3]
   
   if (is.null(y)){
    y<-rep(1,nrow(X))
    groups<-FALSE
   } else {
    if (all(is.na(y)))
      stop("grouping variable contains no available data")
    groups<-TRUE
   }

   if (is.matrix(X))
    X <- as.data.frame(X) 
   
   nvars<-ncol(X)
   
   if (!inherits(substitute(selec),"logical")){
     selec.temp<-substitute(selec)
     selec<-list()
     for (i in 2:length(selec.temp))
       selec[[i-1]]<-as.character(deparse(substitute(selec.temp)[[i]]))
     names(selec)<-names(selec.temp)[-1]
     selec<-unlist(selec)
   }
   
   if (!is.null(attr(selec,"names"))){
    temp<-rep(NA,ncol(X))
    if (".else"%in%names(selec)){
      temp<-rep(selec[".else"],ncol(X))
      selec<-selec[-which(names(selec)==".else")]
    }    
    names(temp)<-names(X)
    if (!all(names(selec)%in%names(temp)))
      warning(paste("variables",paste(names(selec)[!names(selec)%in%names(temp)],collapse=", "),"specified in 'selec' not found"))
    kkk<-names(selec)[names(selec)%in%names(X)]
    temp[kkk]<-selec[kkk]
    selec<-temp
   } else
     if (length(selec)==1) 
      selec=rep(selec,nvars)

   if (!is.null(attr(method,"names"))){
    temp<-rep(1,ncol(X))
    if (".else"%in%names(method)){
      temp<-rep(method[".else"],ncol(X))
      method<-method[-which(names(method)==".else")]
    }
    names(temp)<-names(X)    
    if (!all(names(method)%in%names(temp)))
      warning(paste("variables",paste(names(method)[!names(method)%in%names(temp)],collapse=", "),"specified in 'method' not found"))
    kkk<-names(method)[names(method)%in%names(X)]
    temp[kkk]<-method[kkk]
    method<-temp
   } else 
     if (length(method)==1) 
       method=rep(method,nvars)
       
   if (!is.null(attr(timemax,"names"))){
    temp<-rep(NA,ncol(X))
    if (".else"%in%names(timemax)){
      temp<-rep(timemax[".else"],ncol(X))
      timemax<-timemax[-which(names(timemax)==".else")]
    }
    names(temp)<-names(X)    
    if (!all(names(timemax)%in%names(temp)))
      warning(paste("variables",paste(names(timemax)[!names(timemax)%in%names(temp)],collapse=", "),"specified in 'timemax' not found"))
    kkk<-names(timemax)[names(timemax)%in%names(X)]
    temp[kkk]<-timemax[kkk]
    timemax<-temp
   } else 
     if (length(timemax)==1) 
       timemax=rep(timemax,nvars)

   if (!is.null(attr(fact.ratio,"names"))){
    temp<-rep(1,ncol(X))
    if (".else"%in%names(fact.ratio)){
      temp<-rep(fact.ratio[".else"],ncol(X))
      fact.ratio<-fact.ratio[-which(names(fact.ratio)==".else")]
    }    
    names(temp)<-names(X)
    if (!all(names(fact.ratio)%in%names(temp)))
      warning(paste("variables",paste(names(fact.ratio)[!names(fact.ratio)%in%names(temp)],collapse=", "),"specified in 'fact.ratio' not found"))
    kkk<-names(fact.ratio)[names(fact.ratio)%in%names(X)]
    temp[kkk]<-fact.ratio[kkk]
    fact.ratio<-temp
   } else
     if (length(fact.ratio)==1) 
      fact.ratio=rep(fact.ratio,nvars)

   ref.ind<-character()
   if (!is.null(attr(ref,"names"))){
    temp<-rep(1,ncol(X))
    ref.ind<-names(ref)
    if (".else"%in%names(ref)){
      temp<-rep(ref[".else"],ncol(X))
      ref<-ref[-which(names(ref)==".else")]
      ref.ind<-names(X)
    }
    names(temp)<-names(X)    
    if (!all(names(ref)%in%names(temp)))
      warning(paste("variables",paste(names(ref)[!names(ref)%in%names(temp)],collapse=", "),"specified in 'ref' not found"))
    kkk<-names(ref)[names(ref)%in%names(X)]
    temp[kkk]<-ref[kkk]
    ref<-temp
   } else {
     if (length(ref)==1){ 
       ref<-rep(ref,nvars)
     } 
   }
       
   ref.no.i<-rep(NA,ncol(X))
   if (length(ref.no)>0){
     for (i in 1:ncol(X)){
       ll<-tolower(levels(X[,i]))
       if (length(ll)>2)
         ref.no.i[i]<-NA
       else{
         temp<-which(ll%in%tolower(ref.no))
         if (length(temp)>1){
           ref.no.i[i]<-NA
           warning(paste("For variable",names(X)[i],"there are more than 2 levels matching with ref"))
         }
         if (length(temp)==1)
           ref.no.i[i]<-temp
       }
     }
     names(ref.no.i)<-names(X)
   }
  
   if (length(ref.ind)>0)      
     ref.no.i[names(ref.no.i)%in%ref.ind]<-NA
   
   if (length(ref.ind)==0) 
     ref[!is.na(ref.no.i)]<-ref.no.i[!is.na(ref.no.i)] 
   else{
     ref.no.i<-ref.no.i[names(ref)]
     ref[!is.na(ref.no.i)]<-ref.no.i[!is.na(ref.no.i)]   
   }
    
   varnames.orig<-names(X)
   yname.orig<-yname

   names.X<-names(X)
   if (!is.null(attr(y,"label")) & include.label)
     yname<-attr(y,"label")
   nX <- lapply(X, function(x){
    nn<-attr(x,"label")  
    if (!is.null(nn) & include.label) 
      nn
    else
      NA
   })
   names.X<-ifelse(is.na(nX),names.X,nX)
   
   if (!inherits(y,"Surv") && is.character(y))
    y <- as.factor(y)
    
   if (!inherits(y,"Surv") && is.numeric(y))
    y <- as.factor(y)    

   if (!inherits(y,"Surv") && !is.factor(y))
    stop("variable 'y' must be a factor or a 'Surv' object")

   if (!inherits(y,"Surv")){
     tt<-table(y)
     if (simplify){
       if (any(tt==0)){ 
        y <- factor(y)
        warning("Some levels of y are removed since no observation in that/those levels")
       }
     }
   } else {
     if (all(y[,2]==0,na.rm=TRUE))
      stop("There are no events")
   }

   if (inherits(y,"Surv"))
     ny<-2
   else
     ny<-length(levels(y))
   
   if (ny>max.ylev)
    stop(paste("number of groups must be less or equal to",max.ylev))

   if (NROW(X)!=NROW(y))
    stop("data doesn't mach")

   ans <- lapply(1:nvars, function(i) try(compare.i(X[,i],y=y, selec.i=selec[i], method.i=method[i], timemax.i=timemax[i], alpha=alpha, min.dis=min.dis, max.xlev=max.xlev, varname=names(X)[i], Q1=Q1, Q3=Q3, groups=groups, simplify=simplify, Xext=Xext, ref=ref[i], fact.ratio=fact.ratio[i], ref.y=ref.y, p.corrected=p.corrected, compute.ratio=compute.ratio, include.miss=include.miss, oddsratio.method=oddsratio.method, chisq.test.perm=chisq.test.perm, byrow=byrow),silent=TRUE))
   
   names(ans)<-names.X    
   
   ww<-ii<-NULL
   for (i in 1:length(ans)){
    if (inherits(ans[[i]],"try-error"))
      ww<-c(ww,i)
    else
      ii<-c(ii,i)
   }
   ans<-ans[ii]
   
   if (length(ans)==0)
    stop("None variable can be computed")
    
   if (length(ww)>0){
    warning(paste("Variables '",paste(names(X)[ww],collapse="', '"),"' have been removed since some errors occurred",sep=""))
    varnames.orig<-varnames.orig[-ww]
   }

   Xlong <- NULL
   for (i in 1:length(ans))
    Xlong <- cbind(Xlong, attr(ans[[i]],"xlong"))
   colnames(Xlong) <- varnames.orig
   ylong <- attr(ans[[1]],"ylong")

   if (groups){
    attr(ans,"yname")<-yname
    attr(ans,"yname.orig")<-yname.orig
   } else {
    attr(ans,"yname")<-NULL
    attr(ans,"yname.orig")<-NULL
   }
   attr(ans,"call")<-list()
   attr(ans,"call")$call<-cl
   attr(ans,"ny")<-ny
   attr(ans,"varnames.orig")<-varnames.orig
   if (any(attr(ans,"names")=='')) 
     attr(ans,"names")[attr(ans,"names")=='']<-attr(ans,"varnames.orig")[attr(ans,"names")=='']
   attr(ans,"groups")<-groups
   attr(ans,"Xext")<-Xext
   attr(ans,"Xlong")<-Xlong
   attr(ans,"ylong")<-ylong
   attr(ans,"method")<-method
   attr(ans,"Q1")<-Q1
   attr(ans,"Q3")<-Q3
   class(ans)<-"compareGroups"
   ans
   
}

