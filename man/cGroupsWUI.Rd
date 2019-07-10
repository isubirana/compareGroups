\name{cGroupsWUI}
\alias{cGroupsWUI}

\title{
Web User Interface based on Shiny tools.
}

\description{
This function opens a web browser with a graphical interface based on \pkg{shiny} package.
}

\usage{
cGroupsWUI(port = 8102L)
}

\arguments{
  \item{port}{integer. Same as 'port' argument of \code{\link[shiny]{runApp}}. Default value is 8102L.}
}

\seealso{
  \code{\link{cGroupsGUI}}, \code{\link{compareGroups}}, \code{\link{createTable}}
}

\note{
  If an error occurs when launching the web browser, it may be solved by changing the port number.
} 


\examples{

\dontrun{

require(compareGroups)

cGroupsWUI()

}

}

\keyword{utilities}
