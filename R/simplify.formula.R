simplify.formula<-function(form)
{
  ii <- if (length(form) > 2) 3 else 2
  right <- trim(deparse(form[[ii]]))
  right <- sub("\\+$", "+ ", right)
  right <- sub("\\-$", "- ", right)
  right <- paste(right, collapse = "")
  right <- gsub("\\(", "", right)
  right <- gsub("\\)", "", right)
  if (substr(right, 1, 1) != '-') right <- paste("+",right)
  right <- gsub("\\+ ", "+", right)
  right <- gsub("\\- ", "-", right)
  terms <- strsplit(right," ")[[1]]
  pos.terms <- grep("^\\+", terms,value = TRUE)
  neg.terms <- grep("^\\-", terms,value = TRUE)
  pos.terms <- sub("^\\+", "", pos.terms)
  neg.terms <- sub("^\\-", "", neg.terms)
  if (length(neg.terms) > 0)
    pos.terms <- pos.terms[!pos.terms %in% neg.terms]
  right <- paste(pos.terms, collapse = " + ")
  if (ii==3)
    ans <- paste(form[[2]], form[[1]], right)
  else
    ans <- paste(form[[1]], right)
  return(as.formula(ans))
}
