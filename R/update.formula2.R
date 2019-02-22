update.formula2<-function(old, new)
{
  old <- as.formula(old)
  new <- as.formula(new)
  ii.old <- if(length(old)>2) 3 else 2
  ii.new <- if(length(new)>2) 3 else 2
  old.right <- deparse(old[[ii.old]])
  new.right <- deparse(new[[ii.new]])
  old.right <- sub("\\+$", "+ ", old.right)
  old.right <- sub("\\-$", "- ", old.right)
  old.right <- paste(old.right, collapse = "")
  new.right <- sub("\\+$", "+ ", new.right)
  new.right <- sub("\\-$", "- ", new.right)
  new.right <- paste(new.right, collapse = "")
  old.right <- paste(" ", old.right, sep="")
  old.right <- paste(old.right, " ", sep="")
  new.right <- paste(" ", new.right, sep="")
  new.right <- paste(new.right," ", sep="")
  new.right <- sub(" \\. ", old.right, new.right)  
  if (ii.new==2){
    ans <- as.formula(paste("~", new.right))
  }else{
    if (ii.old==2)
      ans <- as.formula(paste(new[[2]], "~", new.right))
    else{ 
        if (deparse(new[[2]]=="."))
          ans <- as.formula(paste(old[[2]], "~", new.right))
        else
          ans <- as.formula(paste(new[[2]], "~", new.right))
    }
  }
  return(ans)
}
