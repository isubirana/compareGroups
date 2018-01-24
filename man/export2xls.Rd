\name{export2xls}
\alias{export2xls}

\title{
Exporting descriptives table to Exel format (.xlsx or .xls)
}
\description{
This function takes the result of \code{createTable} and exports the tables to Excel format (.xlsx or .xls).
}
\usage{
export2xls(x, file, which.table="descr", nmax=TRUE, header.labels=c(), ...)
}

\arguments{

  \item{x}{an object of class 'createTable'.}

  \item{file}{file where table in HTML format will be written. Also, another file with the extension '_appendix' is written with the available data table. If missing, the HTML code is returned.}

  \item{which.table}{character indicating which table is printed. Possible values are 'descr', 'avail' or 'both' (partial matching allowed), exporting descriptives by groups table, availability data table or both tables, respectively. Default value is 'descr'.}

  \item{nmax}{logical, indicating whether to show the number of subjects with at least one valid value across all row-variables. Default value is TRUE.}
  
  \item{header.labels}{see the 'header.labels' argument from \code{\link{createTable}}.}   
             
  \item{\ldots}{arguments passed to \code{\link[xlsx]{write.xlsx}} function.}
  
}


\note{

The way to compute the 'N' shown in the bivariate table header, controlled by 'nmax' argument, has been changed from previous versions (<1.3). In the older versions 'N' was computed as the maximum across the cells withing each column (group) from the 'available data' table ('avail').

To use this function you must have the \pkg{xlsx} package installed, which depends on \pkg{rjava} package.


}


\seealso{
  \code{\link{createTable}}, \code{\link{export2latex}}, \code{\link{export2pdf}}, \code{\link{export2csv}}, \code{\link{export2md}}, \code{\link{export2word}}
} 
\examples{

\dontrun{
require(compareGroups)
data(regicor)
res <- compareGroups(sex ~. -id-todeath-death-tocv-cv, regicor)
export2xls(createTable(res, hide.no = 'n'), file=tempfile(fileext=".xlsx"))
}

}

\keyword{utilities}
