export2word <- function(x, file, which.table="descr", nmax = TRUE, header.labels = c(), ...){
  if (!inherits(x, "createTable")) 
    stop("x must be of class 'createTable'")
  if (inherits(x, "cbind.createTable")) 
    stop("x cannot be of class 'cbind.createTable'")
  if (is.null(caption)) caption<-"NULL"
  if (length(header.labels)==0) header.labels<-"c()"
  #tempfile<-file.path(tempdir(),"temp.Rmd")
  tempfile <- sub("docx$","Rmd",file)
  tempfile <- sub("doc$","Rmd",file)  
  instr<-paste(
"
---
  output: word_document
---
\n\n\n
",paste(export2md(x, which.table, nmax , header.labels, format="markdown", ...), collapse="\n"),
"
\n"
,sep=""
)
  write(instr,tempfile)
  rmarkdown::render(tempfile, rmarkdown::word_document(), file, quiet=TRUE)
}






