\name{getResults}
\alias{getResults}

\title{
Easily retrieve summary data as R-objects (matrices and vectors).
}

\description{
This functions excratcs specific results (descriptives, p-values, Odds-Ratios / Hazard-Ratios, ...) from a compareGroups object as matrix or vectors.
}

\usage{
getResults(obj, what = "descr")

}

\arguments{
  \item{obj}{an object of class 'compareGroups' or 'createTable'}
  \item{what}{character indicating which results are to be retrieved: decriptives, p-value, p-trend, pairwise p-values, or Odds-Ratios / Hazard-Ratios. Possible values are: "descr", "p.overall", "p.trend", "p.mul" and "ratio". Default value is "descr".}
}

\value{
  \item{what = "descr"}{An array or matrix with as many columns as variables/categories and seven columns indicating all possible descriptive statistics (mean, sd, median, Q1, Q3, absolute and relative frequencies). When different groups are analysed, the 3rd dimension of the array corresponds to the groups. Otherwise, the result will be a matrix with no 3rd dimension.}
  \item{what = "p.overall"}{A vector whose elevements are the p-value for each analysed variable.}
  \item{what = "p.trend"}{A vector whose elevements are the p-trend for each analysed variable.} 
  \item{what = "p.mul"}{A matrix with pairwise p-values where rows correspond to the analysed variables and columns to each pair of groups.}
  \item{what = "ratio"}{A matrix with as many rows as variables/categorieswith and 4 columns corresponding to the OR/HR, confidence interval and p-value.} 
}

\note{
For descriptives, NA is placed for descriptives not appropiate for the variable. For example columns corresponding to frequencies for continuous variables will be NA.
}

\seealso{
\code{\link{compareGroups}}, \code{\link{createTable}}
}

\examples{
require(compareGroups)
data(regicor)
res<-compareGroups(sex ~ . ,regicor,method=c(triglyc=2))
# retrieve descriptives
getResults(res)
# retrieve OR and their corresponding p-values
getResults(res,what="ratio")
}

\keyword{utilities}

