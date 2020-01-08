\name{export2pdf}
\alias{export2pdf}

\title{
Exports tables to PDF files.
}

\description{
This function creates automatically a PDF with the table. Also, the LaTeX code is stored in the specified file.
}

\usage{
export2pdf(x, file, which.table="descr", nmax=TRUE, header.labels=c(), caption=NULL,   
  width=Inf, strip=FALSE, first.strip=FALSE, background="#D2D2D2", size=NULL,  
  landscape=FALSE, numcompiled=2)
}

\arguments{

  \item{x}{an object of class 'createTable' or that inherits it.}

  \item{file}{character specifying the PDF file resulting after compiling the LaTeX code corresponding to the table specified in the 'x' argument. LaTeX code is also stored in the same folder with the same name but .tex extension. When 'compile' argument is FALSE, only .tex file is saved.}
  
  \item{which.table}{character indicating which table is printed. Possible values are 'descr', 'avail' or 'both' (partial matching allowed), printing descriptives by groups table, availability data table or both tables, respectively. Default value is 'descr'.}
  
  \item{nmax}{logical, indicating whether to show the number of subjects with at least one valid value across all row-variables. Default value is TRUE.}
  
  \item{header.labels}{a character named vector with 'all', 'p.overall', 'p.trend', 'ratio', 'p.ratio' and 'N' components indicating the label for '[ALL]', 'p.overall', 'p.trend', 'ratio', 'p.ratio' and 'N' (available data), respectively. Default is a zero length vector which makes no changes, i.e. '[ALL]', 'p.overall', 'p.trend', 'ratio', 'p.ratio' and 'N' labels appear for descriptives of entire cohort, global p-value, p-value for trend, HR/OR and p-value of each HR/OR and available data, respectively.}  
  
  \item{caption}{character specifying the table caption for descriptives and available data table. If which.table='both' the first element of 'caption' will be assigned to descriptives table and the second to available data table. If it is set to "", no caption is inserted. Default value is NULL, which writes 'Summary descriptives table by groups of 'y'' for descriptives table and 'Available data by groups of 'y'' for the available data table. }

   \item{width}{character string to specify the width of first column of descriptive table. Default value is \code{Inf} which makes the first column to autoadjust to variable names. Other examples are '10cm', '3in' or '30em'.}

 \item{strip}{logical. It shadows table lines corresponding to each variable.}
 
 \item{first.strip}{logical. It determines whether to shadow the first variable (TRUE) or the second (FALSE). It only applies when \code{strip} argument is true.}
 
 \item{background}{color code in HEX format for shadowed lines. You can use \code{rgb} function to convert red, green and blue to HEX code. Default color is '#D2D2D2'.}
 
 \item{size}{numeric. Size of descriptive table. Default value is NULL which creates the table in default size.}
 
 \item{landscape}{logical. It determines whether to place the table in landscape (horizontal) format. It only applies when format is 'latex'. Default value is FALSE.}
 
 \item{numcompiled}{integer. Number of times LaTeX code is compiled. When creating the table it may be necessary to execute the code several times in order to fit the columns widths. By default it is compiled twice.}

  
}


\note{

  To make the .tex file be compiled, some LaTeX compiler such as Miktex must be installed. Also, the tex file must include the following LaTeX packages:
  \itemize{
  \item longtable\cr
  \item multirow\cr
  \item multicol\cr
  \item booktabs\cr
  \item xcolor\cr
  \item colortbl\cr
  \item lscape\cr
  }
}


\seealso{
  \code{\link{createTable}}, \code{\link{export2latex}}, \code{\link{export2csv}}, \code{\link{export2html}}, \code{\link{export2md}}, \code{\link{export2word}}
} 


\examples{

\dontrun{

require(compareGroups)
data(regicor)

 # example on an ordinary table
res <- createTable(compareGroups(year ~ . -id, regicor), hide = c(sex=1), hide.no = 'no')
export2pdf(res, file=tempfile(fileext=".pdf"), size="small")

}

}

\keyword{utilities}
