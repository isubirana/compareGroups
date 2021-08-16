missingTable <- function(obj,...)
{

  if (!inherits(obj,"createTable") && !inherits(obj,"compareGroups"))
    stop(" obj must be of class 'createTable' or 'compareGroups'")
  if (inherits(obj,"cbind.createTable"))
    stop(" not implemented for 'cbind.createTable' objects")
  if (inherits(obj,"rbind.createTable"))
    stop(" not implemented for 'rbind.createTable' objects")

  if (inherits(obj, "createTable"))
    cg <- attr(obj, "x")[[1]]
  else 
    cg <- obj
  
  varnames.orig <- attr(cg, "varnames.orig")
  Xext <- attr(cg, "Xext")
  temp <- Xext[varnames.orig]
  temp <- lapply(temp, function(var){
    out <- as.integer(is.na(var))
    out <- factor(out,0:1,c('Avail','Non Avail'))
    attr(out,"label") <- attr(var,"label")
    out
  })
  temp <- as.data.frame(temp)
  Xext[varnames.orig] <- temp

  X<-attr(cg,"call")$call$formula
  X.eval <- eval(X)
  
  if (inherits(X.eval, "formula"))
    cg.update <- update(cg, data = Xext, simplify = FALSE,include.miss=FALSE)
  else
    cg.update <- update(cg, formula = Xext, simplify = FALSE,include.miss=FALSE)    

  print(cg.update)
  if (inherits(obj, "descrTable")){
    ans <- createTable(cg.update, hide.no = 'Avail',...)
    # if (inherits(X.eval, "formula"))
    #   ans <- update(obj, data=Xext, hide.no = 'Avail', simplify = FALSE, include.miss=FALSE,...)
    # else
    #   ans <- update(obj, formula=Xext, hide.no = 'Avail', simplify = FALSE, include.miss=FALSE,...)  
  }else {
    
    if (inherits(obj, "createTable")){
      ans <- update(obj, x = cg.update, hide.no = 'Avail',...)  
    } else{
      ans <- createTable(x = cg.update, hide.no = 'Avail',...)  
    }
  }
    

  class(ans)<-c("missingTable",class(ans))
  ans
  

}







