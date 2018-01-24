descripSurv <-
function(x, y, timemax)
{

  tt<-table(y)
  ll<-names(tt)[tt>0]

  nn<-by(!is.na(x[,1]),y,sum)
  nn[is.na(nn)]<-0
  oo<-by(x[,2]==1,y,sum,na.rm=TRUE)
  
  ss<-try(summary(survfit(x~y),times=timemax,extend=TRUE),silent=TRUE)

  Pmax.i<-rep(NaN,nlevels(y))
  names(Pmax.i)<-levels(y)
  if (!inherits(ss,"try-error")){
    temp<-1-ss$surv
    names(temp)<-ll
    Pmax.i[ll]<-temp
  }  

  nn.all<-sum(nn,na.rm=TRUE)

  ss.all<-try(summary(survfit(x~1),times=timemax,extend=TRUE),silent=TRUE)

  if (inherits(ss.all,"try-error")){
    Pmax.all<-NaN
  } else {
    Pmax.all<-1-ss.all$surv
  }
  ans<-cbind(c(nn.all,nn),c(Pmax.all,Pmax.i)*100)
  colnames(ans) <- c("n", "inc")
  rownames(ans) <- c("[ALL]",levels(y))  
  ans
  
}