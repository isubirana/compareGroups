export2pdf <- function(x, file, which.table="descr", nmax=TRUE, header.labels=c(), caption=NULL, 
                       width=Inf, strip=FALSE, first.strip=FALSE, background="#D2D2D2", size=NULL,  
                       landscape=FALSE, numcompiled=2, header.background=NULL, header.color=NULL){

  
  if (!inherits(x, "createTable"))
    stop("x must be of class 'createTable'")

  if (length(header.labels)==0) header.labels<-"c()"

  tempfile <- NULL
  tempfile <- sub("pdf$","Rmd",file)

  instr<-paste(
"---
header-includes:
   - \\usepackage{longtable}
   - \\usepackage{multirow}
   - \\usepackage{multicol}
   - \\usepackage{booktabs}
   - \\usepackage{xcolor}
   - \\usepackage{colortbl}
   - \\usepackage{lscape}
output: pdf_document
---
\n\n\n


```{r, echo=FALSE}\n
export2md(x, which.table=which.table, nmax=nmax, header.labels=header.labels, 
caption=caption, width=width,format='latex', strip=strip, 
first.strip=first.strip, background=background, size=size, landscape=landscape,
header.color=header.color, header.background=header.background)\n
```\n
\n"
,sep=""
)

  write(instr, file=tempfile)

  for (i in numcompiled){# need to compile twice because of longtable format
    rmarkdown::render(tempfile, rmarkdown::pdf_document(), file, quiet=TRUE)
  }

}






