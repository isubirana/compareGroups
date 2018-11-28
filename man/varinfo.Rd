\name{varinfo}
\alias{varinfo}
\alias{varinfo.compareGroups}
\alias{varinfo.createTable}

\title{
Variable names and labels extraction
}

\description{
This functions builds and prints a table with the variable names and their labels.
}

\usage{
varinfo(x, ...)
\method{varinfo}{compareGroups}(x, ...)
\method{varinfo}{createTable}(x, ...)
}

\arguments{
  \item{x}{an object of class 'compareGroups' or 'createTable'}
  \item{\dots}{other arguments currently ignored}
}

\details{
By default, a compareGroup descriptives table lists variables by label (if one exists) rather than by name.  If researchers have assigned detailed labels to their variables, this function is very useful to quickly locate the original variable name if some modification is required. This function simply lists all "Analyzed variable names" by "Orig varname" (i.e. variable name in the data.frame) and "Shown varname" (i.e., label).
}

\value{
A 'matrix' with two columns
\item{Orig varname}{actual variable name in the 'data.frame' or in the 'parent environment'.}
\item{Shown varname}{names of the variable shown in the resulting tables.}
}

\note{
If a variable has no "label" attribute, then the 'original varname' is the same as the 'shown varname'. The first variable in the table corresponds to the grouping variable. To label non-labeled variables or to change the label, specify its "label" attribute..
}

\seealso{
\code{\link{compareGroups}}, \code{\link{createTable}}
}

\examples{
require(compareGroups)
data(regicor)
res<-compareGroups(sex ~ . ,regicor)
#createTable(res, hide.no = 'no')  
varinfo(res)
}

\keyword{utilities}

