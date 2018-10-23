\name{export2word}
\alias{export2word}

\title{
Exports tables to Word files.
}

\description{
This function creates automatically a Word file with the table.
}

\usage{
export2word(x, file, which.table="descr", nmax = TRUE, header.labels = c(), ...)
}

\arguments{

  \item{x}{an object of class 'createTable' or that inherits it.}

  \item{file}{character specifying the word file (.doc or .docx) resulting after compiling the Markdown code corresponding to the table specified in the 'x' argument.}

  \item{which.table}{see \code{\link{export2md}}}
  
  \item{nmax}{see \code{\link{print.createTable}}}
  
  \item{header.labels}{see \code{\link{print.createTable}}}
  
  \item{...}{further arguments passed to \code{\link{export2md}}}
  
}


\note{

Word file is created after compiling Markdown code created by \code{\link{export2md}}. To compile it it calls \code{\link[rmarkdown]{render}} function which requires pandoc to be installed.

}


\seealso{
  \code{\link{createTable}}, \code{\link{export2latex}}, \code{\link{export2pdf}}, \code{\link{export2csv}}, \code{\link{export2html}}, \code{\link{export2md}}
} 


\examples{

\dontrun{

require(compareGroups)
data(regicor)

 # example on an ordinary table
res <- createTable(compareGroups(year ~ . -id, regicor), hide = c(sex=1), hide.no = 'no')
export2word(res, file = tempfile(fileext=".docx"))

}

}

\keyword{utilities}
