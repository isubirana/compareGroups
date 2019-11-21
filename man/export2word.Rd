\name{export2word}
\alias{export2word}

\title{
Exports tables to Word files.
}

\description{
This function creates automatically a Word file with the table.
}

\usage{
export2word(x, file, which.table="descr", nmax=TRUE, header.labels=c(), 
            caption=NULL, strip=FALSE, first.strip=FALSE, background="#D2D2D2", 
            size=NULL, header.background=NULL, header.color=NULL)
}

\arguments{

  \item{x}{an object of class 'createTable' or that inherits it.}

  \item{file}{character specifying the word file (.doc or .docx) resulting after compiling the Markdown code corresponding to the table specified in the 'x' argument.}
  
  \item{x}{an object of class 'createTable'.}

  \item{which.table}{character indicating which table is printed. Possible values are 'descr' or 'avail'(partial matching allowed), exporting descriptives by groups table or availability data table, respectively. Default value is 'descr'.}

  \item{nmax}{logical, indicating whether to show the number of subjects with at least one valid value across all row-variables. Default value is TRUE.}
  
  \item{header.labels}{see the 'header.labels' argument from \code{\link{createTable}}.}   

 \item{caption}{character specifying the table caption for descriptives and available data table. If which.table='both' the first element of 'caption' will be assigned to descriptives table and the second to available data table. If it is set to "", no caption is inserted. Default value is NULL, which writes 'Summary descriptives table by groups of 'y'' for descriptives table and 'Available data by groups of 'y'' for the available data table. }

 \item{format}{character with three options: 'html', 'latex' or 'markdown'. If missing, it tries to guess the default options of Rmarkdown file in which the table in inserted, or html if it is not in a Rmarkdown file or format not specified.}
 
 \item{strip}{logical. It shadows table lines corresponding to each variable.}
 
 \item{first.strip}{logical. It determines whether to shadow the first variable (TRUE) or the second (FALSE). It only applies when \code{strip} argument is true.}
 
 \item{background}{color code in HEX format for shadowed lines. You can use \code{rgb} function to convert red, green and blue to HEX code. Default color is '#D2D2D2'.}
 
 \item{size}{numeric. Size of descriptive table. Default value is NULL which creates the table in default size.}
 
 \item{header.background}{color character for table header or 'NULL'. Default value is 'NULL'.}
 
 \item{header.color}{color character for table header text. Default color is 'NULL'.}
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
