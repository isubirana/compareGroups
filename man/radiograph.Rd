\name{radiograph}
\alias{radiograph}

\title{
Lists the values in the data set.
}

\description{
This function creates a report of raw data in your data set. For each variable an ordered list of the unique entries (read as strings), useful for checking for input errors.
}

\usage{
radiograph(file, header = TRUE, save=FALSE, out.file="", ...)
}

\arguments{

  \item{file}{character specifying the file where the data set is located.}

  \item{header}{see \code{\link[utils]{read.table}}.}

  \item{save}{logical indicating whether output should be stored in a file (TRUE) or printed on the console (FALSE). Default is FALSE.}

  \item{out.file}{character specifying the file where the results are to be output. It only applies when 'save' argument is set to TRUE.}

  \item{\ldots}{Arguments passed to \code{\link[utils]{read.table}}.}
  
}

\author{

Gavin Lucas (gavin.lucas<at>cleargenetics.com) \cr

Isaac Subirana (isubirana<at>imim.es)

}


\seealso{
  \code{\link{report}}
} 


\examples{

\dontrun{

require(compareGroups)

# read example data of regicor in plain text format with variables separated by '\t'.
datafile <- system.file("exdata/regicor.txt", package="compareGroups")
radiograph(datafile)

}

}

\keyword{utilities}
