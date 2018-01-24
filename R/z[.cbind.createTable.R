"[.cbind.createTable"<-function(x,i,...){
  y<-x
  for (kk in 1:length(y))
    y[[kk]]<-y[[kk]][i]
  attributes(y)<-attributes(x)
  y  
}