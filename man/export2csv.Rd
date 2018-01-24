\name{export2csv}
\alias{export2csv}

\title{
Exporting descriptives table to plain text (CSV) format
}
\description{
This function takes the result of \code{createTable} and exports the tables to plain text (CSV) format.
}
\usage{
export2csv(x, file, which.table="descr", sep=",", nmax = TRUE, header.labels = c(), ...)
}

\arguments{

  \item{x}{an object of class 'createTable'.}

  \item{file}{file where table in CSV format will be written. Also, another file with the extension '_appendix' is written with the available data table.}

  \item{which.table}{character indicating  which table is printed. Possible values are 'descr', 'avail' or 'both' (partial matching allowed), exporting descriptives by groups table, available data table or both tables, respectively. Default value is 'descr'.}

  \item{sep}{character. The variable separator, same as 'sep' argument from \code{\link[utils]{write.table}}. Default value is ','.}
  
  \item{nmax}{logical, indicating whether to show the number of subjects with at least one valid value across all row-variables. Default value is TRUE.}
  
  \item{header.labels}{see the 'header.labels' argument from \code{\link{createTable}}.}  
             
  \item{\ldots}{other arguments passed to \code{\link[utils]{write.table}}.}
  
}


\note{

The way to compute the 'N' shown in the bivariate table header, controlled by 'nmax' argument, has been changed from previous versions (<1.3). In the older versions 'N' was computed as the maximum across the cells withing each column (group) from the 'available data' table ('avail').

}


\seealso{
  \code{\link{createTable}}, \code{\link{export2latex}}, \code{\link{export2pdf}}, \code{\link{export2html}}, \code{\link{export2md}}, \code{\link{export2word}}
} 

                                                                                                                                   
\examples{

\dontrun{
require(compareGroups)
data(regicor)
res <- compareGroups(sex ~. -id-todeath-death-tocv-cv, regicor)
export2csv(createTable(res, hide.no = 'n'), file=tempfile(fileext=".csv"))
}

}

\keyword{utilities}

