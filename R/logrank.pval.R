logrank.pval<-function(x,y){
  ss<-survdiff(y~x)
  1-pchisq(ss$chisq,length(ss$obs)-1)
}