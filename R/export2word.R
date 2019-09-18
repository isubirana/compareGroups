export2word <- function(x, file, which.table="descr", nmax = TRUE, header.labels = c()){

  if (!inherits(x, "createTable")) 
    stop("x must be of class 'createTable'")
  if (inherits(x, "cbind.createTable")) 
    stop("x cannot be of class 'cbind.createTable'")
  # if (is.null(caption)) caption<-"NULL"
  if (length(header.labels)==0) header.labels<-"c()"
  #tempfile<-file.path(tempdir(),"temp.Rmd")
  tempfile <- NULL
  if (length(grep("docx$",file))) tempfile <- sub("docx$","Rmd",file)
  if (length(grep("doc$",file))) tempfile <- sub("doc$","Rmd",file) 
  if (is.null(tempfile)) stop("file must be .doc or .docx")
  
  instr<-paste(
"
---
  output: word_document
---
\n\n\n

```{r, echo=FALSE}\n
export2md(x, which.table, nmax , header.labels, format='markdown')\n
```\n
\n"
,sep=""
)
  write(instr,tempfile)
  rmarkdown::render(tempfile, rmarkdown::word_document(), file, quiet=TRUE)

}






