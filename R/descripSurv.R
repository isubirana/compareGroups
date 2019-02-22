descripSurv <-
function(x, y, timemax)
{

  tt<-table(y)
  ll<-names(tt)[tt>0]

  nn<-by(!is.na(x[,1]),y,sum)
  nn[is.na(nn)]<-0
  oo<-by(x[,2]==1,y,sum,na.rm=TRUE)
  
  ss<-try(summary(survfit(x~y),times=timemax,extend=TRUE),silent=TRUE)

  Pmax.i<-Pmax.lower.i<-Pmax.upper.i<-rep(NaN,nlevels(y))
  names(Pmax.i)<-names(Pmax.lower.i)<-names(Pmax.upper.i)<-levels(y)
  if (!inherits(ss,"try-error")){
    # incid
    temp<-1-ss$surv
    names(temp)<-ll
    Pmax.i[ll]<-temp
    #lower
    temp<-1-ss$upper
    names(temp)<-ll
    Pmax.lower.i[ll]<-temp
    #upper
    temp<-1-ss$lower
    names(temp)<-ll
    Pmax.upper.i[ll]<-temp    
  }  

  nn.all<-sum(nn,na.rm=TRUE)

  ss.all<-try(summary(survfit(x~1),times=timemax,extend=TRUE),silent=TRUE)

  if (inherits(ss.all,"try-error")){
    Pmax.all<-Pmax.lower.all<-Pmax.upper.all<-NaN
  } else {
    Pmax.all<-1-ss.all$surv
    Pmax.lower.all<-1-ss.all$upper
    Pmax.upper.all<-1-ss.all$lower
  }
  ans<-cbind(c(nn.all,nn),c(Pmax.all,Pmax.i)*100,c(Pmax.lower.all,Pmax.lower.i)*100,c(Pmax.upper.all,Pmax.upper.i)*100)
  colnames(ans) <- c("n", "inc","lower","upper")
  rownames(ans) <- c("[ALL]",levels(y))  
  ans
  
}