\name{export2md}
\alias{export2md}

\title{
Exporting descriptives table to Markdown format
}
\description{
This function takes the result of \code{createTable} and exports the tables to markdown format. It may be useful when inserting R code chunks in a Markdown file (.Rmd).
}
\usage{
export2md(x, which.table="descr", nmax = TRUE, header.labels = c(), 
          caption = NULL, ...)
}

\arguments{

  \item{x}{an object of class 'createTable'.}

  \item{which.table}{character indicating which table is printed. Possible values are 'descr' or 'avail'(partial matching allowed), exporting descriptives by groups table or availability data table, respectively. Default value is 'descr'.}

  \item{nmax}{logical, indicating whether to show the number of subjects with at least one valid value across all row-variables. Default value is TRUE.}
  
  \item{header.labels}{see the 'header.labels' argument from \code{\link{createTable}}.}   

 \item{caption}{character specifying the table caption for descriptives and available data table. If which.table='both' the first element of 'caption' will be assigned to descriptives table and the second to available data table. If it is set to "", no caption is inserted. Default value is NULL, which writes 'Summary descriptives table by groups of 'y'' for descriptives table and 'Available data by groups of 'y'' for the available data table. }

  \item{\ldots}{arguments passed to \code{\link[knitr]{kable}}.}
  
}

\value{

It does not return anything, but the Markdown code to generate the descriptive or available table is printed.

}

\note{

The way to compute the 'N' shown in the bivariate table header, controlled by 'nmax' argument, has been changed from previous versions (<1.3). In the older versions 'N' was computed as the maximum across the cells withing each column (group) from the 'available data' table ('avail').

}


\seealso{
  \code{\link{createTable}}, \code{\link{export2latex}}, \code{\link{export2pdf}}, \code{\link{export2csv}}, \code{\link{export2html}}, \code{\link{export2word}}
} 


\examples{

\dontrun{
require(compareGroups)
data(regicor)
res <- compareGroups(sex ~. -id-todeath-death-tocv-cv, regicor)
export2md(createTable(res, hide.no = 'no'))
}

}

\keyword{utilities}
