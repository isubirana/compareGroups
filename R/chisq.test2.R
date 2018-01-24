chisq.test2 <-
function(obj, chisq.test.perm){
  if (any(dim(obj)<2) || is.null(dim(obj)) || sum(rowSums(obj)>0)<2 || sum(colSums(obj)>0)<2)
    return(NaN)
  obj<-obj[,colSums(obj)>0] # erase columns full of zeros.
  expect<-outer(rowSums(obj),colSums(obj))/sum(obj)    
  if (any(expect<5)){
    if (chisq.test.perm)
      test<-try(chisq.test(obj, simulate.p.value=TRUE),silent=TRUE)          
    else 
      test <- try(fisher.test(obj),silent=TRUE)
  } else {
    test <- try(chisq.test(obj),silent=TRUE)
  }
  if (inherits(test,"try-error")){
    test<-try(chisq.test(obj, simulate.p.value=TRUE),silent=TRUE)  
  }
  if (inherits(test,"try-error"))
    return(NaN)
  ans <- test$p.value
  ans
}

