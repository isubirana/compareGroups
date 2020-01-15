createTable <- function(x, hide = NA, digits = NA, type = NA, show.p.overall = TRUE, show.all, show.p.trend, show.p.mul = FALSE, show.n, show.ratio = FALSE, show.descr = TRUE, 
                        show.ci = FALSE, hide.no = NA, digits.ratio = NA, show.p.ratio = show.ratio, digits.p = 3, sd.type = 1, q.type = c(1,1), extra.labels = NA, all.last = FALSE)
{
  
  os<-sessionInfo()$platform
  locale<-sessionInfo()$locale
  locale<-strsplit(locale,";")[[1]]
  locale<-locale[grep("^LC_CTYPE",locale)]
  locale<-sub("LC_CTYPE=","",locale)

  spchar<-if (length(grep("linux",os))==0 || length(grep("UTF-8",locale))>0) TRUE else FALSE

  if (any(!is.na(extra.labels))){ 
    method <- sapply(x, function(x.i) paste(attr(x.i, "method"),collapse="-"))
    method <- ifelse(method=="continuous-normal", 1, ifelse(method=="continuous-non-normal", 2, 3))
    Q1 <- attr(x,"Q1")
    Q3 <- attr(x,"Q3")
    if (!is.na(extra.labels[1]) && extra.labels[1]=="")
      extra.labels[1] <- if (sd.type==1) "Mean (SD)" else "Mean\u00B1SD"
    if (!is.na(extra.labels[2]) && extra.labels[2]=="")
      extra.labels[2] <- paste0("Median ",ifelse(q.type[1]==1,"[","("),Q1*100,"th",ifelse(q.type[2]==1,";",ifelse(q.type[2]==2,",","-")),Q3*100,"th",ifelse(q.type[1]==1,"]",")"))
    if (!is.na(extra.labels[3]) && extra.labels[3]==""){
      if (is.na(type) || type==2)
        extra.labels[3] <- "N (%)"
      else {
        if (type==1) extra.labels[3] <- "%"
        if (type==3) extra.labels[3] <- "N"
      }
    }
    names(x) <- paste0(names(x), 
                      ifelse(method==1 & !is.na(extra.labels[1]), paste0(", ", extra.labels[1]),
                      ifelse(method==2 & !is.na(extra.labels[2]), paste0(", ", extra.labels[2]),
                      ifelse(method==3 & !is.na(extra.labels[3]), paste0(", ", extra.labels[3]), ""))))
  }
  


  if (!inherits(x,"compareGroups"))
    stop("x must be of class 'compareGroups'")

  if (!type%in%c(1,2,3,NA))
    stop("type must be 1 '%', 2 'n(%)' or 3 'n'")

  cl<-match.call()
  
  if (!show.ratio)
    show.p.ratio <- FALSE

  if (!is.null(attr(digits,"names"))){
   temp<-rep(NA,length(x))
   if (".else"%in%names(digits)){
     temp<-rep(digits[".else"],length(x))
     digits<-digits[-which(names(digits)==".else")]
   }
   names(temp)<-attr(x,"varnames.orig")     
   if (!all(names(digits)%in%names(temp)))
     warning(paste("variables",paste(names(digits)[!names(digits)%in%names(temp)],collapse=", "),"specified in 'digits' not found"))
   kkk<-names(digits)[names(digits)%in%attr(x,"varnames.orig")]
   temp[kkk]<-digits[kkk]
   digits<-temp
  } else 
    if (length(digits)==1)
      digits<-rep(digits,length(x))
      
  if (!is.null(attr(digits.ratio,"names"))){
   temp<-rep(NA,length(x))
   if (".else"%in%names(digits.ratio)){
     temp<-rep(digits.ratio[".else"],length(x))
     digits.ratio<-digits.ratio[-which(names(digits.ratio)==".else")]
   }
   names(temp)<-attr(x,"varnames.orig")     
   if (!all(names(digits.ratio)%in%names(temp)))
     warning(paste("variables",paste(names(digits.ratio)[!names(digits.ratio)%in%names(temp)],collapse=", "),"specified in 'digits.ratio' not found"))
   kkk<-names(digits.ratio)[names(digits.ratio)%in%attr(x,"varnames.orig")]
   temp[kkk]<-digits.ratio[kkk]
   digits.ratio<-temp
  } else 
    if (length(digits.ratio)==1)
      digits.ratio<-rep(digits.ratio,length(x))      

  hide<-as.list(hide)
  if (!is.null(attr(hide,"names"))){
   temp<-rep(NA,length(x))
   names(temp)<-attr(x,"varnames.orig")
   if (!all(names(hide)%in%names(temp)))
     warning(paste("variables",paste(names(hide)[!names(hide)%in%names(temp)],collapse=", "),"specified in 'hide' not found"))
   kkk<-names(hide)[names(hide)%in%attr(x,"varnames.orig")]
   temp[kkk]<-hide[kkk]
   hide<-temp
  } else 
    if (length(hide)==1)
      hide<-rep(hide,length(x))
  
  if (missing(show.p.trend)){
    show.p.trend<-FALSE
    y<-attr(x[[1]],"y")
    if (nlevels(y)>2 & is.ordered(y))
      show.p.trend<-TRUE
  }

  ans<-list()
  ans$descr<-NULL
  ans$avail<-NULL
  varnames<-names(x)
  nr<-NULL
  k<-1
  for (i in 1:length(x)){
    t.i<-t(table.i(x[[i]],hide.i=hide[[i]],digits=digits[i],digits.ratio=digits.ratio[i],type=type,varname=varnames[i],hide.no,digits.p=digits.p,sd.type=sd.type,q.type=q.type,spchar=spchar,show.ci=show.ci))
    nr<-c(nr,nrow(t.i))
    ans$descr<-rbind(ans$descr,t.i)
    s.i<-attr(x[[i]],"selec")
    s.i<-ifelse(is.na(s.i),"ALL",s.i)
    ans$avail<-rbind(ans$avail,c(x[[i]]$sam,paste(attr(x[[i]],"method"),collapse="-"),s.i,attr(x[[i]],"fact.ratio")))
  }

  rownames(ans$avail)<-varnames
  nc<-ncol(ans$avail)
  colnames(ans$avail)[(nc-2):nc]<-c("method","select","Fact OR/HR")
  ans$avail[-grep("continuous",ans$avail[,"method"]),"Fact OR/HR"]<-"--"
  if (is.null(attr(x[[1]],"OR")) && is.null(attr(x[[1]],"HR")))
    ans$avail<-ans$avail[,-ncol(ans$avail),drop=FALSE]             

  ans$call<-cl

  all.pos<-1
  ny<-attr(x,"ny")
  desc.pos<-2:(1+ny)
  or.pos<-max(desc.pos)+1 
  pratio.pos<-or.pos+1
  poverall.pos<-pratio.pos+1
  ptrend.pos<-poverall.pos+1
  pmult.pos<-(ptrend.pos+1):(ptrend.pos+max(c(1,choose(ny,2))))
  n.pos<-max(pmult.pos)+1

  elim.pos<-NULL
  dd.pos<-NULL

  if (attr(x,"groups")){
    if (missing(show.all))
      show.all<-FALSE
    if (!show.all)
      elim.pos<-c(elim.pos,all.pos)
    if (!show.descr)
      elim.pos<-c(elim.pos,desc.pos)
    if (!show.p.ratio)
      elim.pos<-c(elim.pos,pratio.pos)
    if (all(is.na(ans[[1]][,or.pos])) || !show.ratio){
      elim.pos<-c(elim.pos,or.pos,pratio.pos)
      show.ratio<-FALSE
    }
    if (!show.p.overall)
      elim.pos<-c(elim.pos,poverall.pos)
    if (!show.p.trend)
      elim.pos<-c(elim.pos,ptrend.pos)
    if (!show.p.mul || ny<3)
      elim.pos<-c(elim.pos,pmult.pos)
    if (missing(show.n))
      show.n<-FALSE
    if (!show.n)
      elim.pos<-c(elim.pos,n.pos)
  } else {
    show.descr<-FALSE
    elim.pos<-c(elim.pos,desc.pos,or.pos,pratio.pos,poverall.pos,ptrend.pos,pmult.pos)
    if (missing(show.n))
      show.n<-TRUE
    if (!show.n)
      elim.pos<-c(elim.pos,n.pos)
    if (missing(show.all))
      show.all<-TRUE
    if (!show.all)
      elim.pos<-c(elim.pos,all.pos)
    ans[[2]]<-ans[[2]][,-2,drop=FALSE]    
  }

  if (show.all & show.descr)
    nmax.pos<-list(all.pos,desc.pos)
  if (show.all & !show.descr)
    nmax.pos<-list(1,integer(0))
  if (!show.all & show.descr)
    nmax.pos<-list(integer(0),1:ny)
  if (!show.all & !show.descr)
    nmax.pos<-list(integer(0),integer(0))
  attr(ans,"nmax.pos")<-nmax.pos

  dd.pos<-unlist(nmax.pos)
  if (show.ratio){
    if (length(dd.pos)>0)
      if (show.p.ratio)
        dd.pos<-c(dd.pos,max(dd.pos)+1:2)
      else
        dd.pos<-c(dd.pos,max(dd.pos)+1)  
    else
      if (show.p.ratio)
        dd.pos<-1:2
      else
        dd.pos<-1
  }

  attr(ans,"yname")<-attr(x,"yname")
  attr(ans,"nr")<-nr
  attr(ans,"varnames")<-varnames
  attr(ans,"ny")<-ny
  attr(ans,"show.all")<-show.all
  attr(ans,"groups")<-attr(x,"groups")    
  attr(ans,"dd.pos")<-dd.pos
  attr(ans,"caption")<-attr(x,"caption")
  attr(ans,"hide")<-unlist(hide)
  attr(ans,"digits")<-digits
  attr(ans,"digits.ratio")<-digits.ratio  
  attr(ans,"type")<-type    
  attr(ans,"show.p.overall")<-show.p.overall    
  attr(ans,"show.all")<-show.all    
  attr(ans,"show.p.trend")<-show.p.trend      
  attr(ans,"show.p.mul")<-show.p.mul      
  attr(ans,"show.n")<-show.n      
  attr(ans,"show.ratio")<-show.ratio  
  attr(ans,"show.p.ratio")<-show.p.ratio    
  attr(ans,"show.descr")<-show.descr      
  attr(ans,"hide.no")<-hide.no      
  attr(ans,"x")<-list(x)
  attr(ans,"Xlong")<-attr(x,"Xlong")
  attr(ans,"ylong")<-attr(x,"ylong")  
  
  attr(ans,"all.last")<-all.last
      
  if (!is.null(elim.pos))
    ans[[1]]<-ans[[1]][,-elim.pos,drop=FALSE]

  if (attr(x,"groups"))
    attr(ans,"ylevels")<-levels(attr(x[[1]],"y"))

  class(ans)<-"createTable"

  ans

}

