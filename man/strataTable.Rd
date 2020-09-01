\name{strataTable}
\alias{strataTable}

\title{
Stratify descriptive table in stratas.
}
\description{
This functions re-build a descriptive table in stratas defined by a variable.
}
\usage{
strataTable(x, strata, strata.names = NULL, max.nlevels = 5)
}

\arguments{

  \item{x}{an object of class 'createTable'}

  \item{strata}{character specifying the name of the variable whose values or levels defines strata.}
  
  \item{strata.names}{character vector with as many components as stratas, or NULL (default value). If NULL, it takes the names of levels of strata variable.}

  \item{max.nlevels}{an integer indicating the maximum number of unique values or levels of strata variable. Default value is 5.}

  
}


\value{

An object of class 'cbind.createTable'.
  
}


\references{
  Isaac Subirana, Hector Sanz, Joan Vila (2014). Building Bivariate Tables: The compareGroups Package for R. Journal of Statistical Software, 57(12), 1-16. URL \url{https://www.jstatsoft.org/v57/i12/}.
}

\seealso{
  \code{\link{compareGroups}}, \code{\link{createTable}}, \code{\link{descrTable}}
}
\examples{

require(compareGroups)

# load REGICOR data
data(regicor)

# compute the descriptive tables (by year)
restab <- descrTable(year ~ . - id - sex, regicor, hide.no="no")

# re-build the table stratifying by gender
strataTable(restab, "sex")

}

\keyword{misc}

