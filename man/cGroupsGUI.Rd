\name{cGroupsGUI}
\alias{cGroupsGUI}

\title{
Graphical user interface based on tcltk tools
}

\description{
This function allows the user to build tables in an easy and intuitive way and to modify several options, using a graphical interface.
}

\usage{
cGroupsGUI(X)
}

\arguments{
  \item{X}{a matrix or a data.frame. 'X' must exist in \code{.GlobalEnv}.}
}

\details{
See the vignette for more detailed examples illustrating the use of this function.
}


\note{

If a data.frame or a matrix is passed through 'X' argument or is loaded by the 'Load data' GUI menu, this object is placed in the \code{.GlobalEnv}. Manipulating this data.frame or matrix while GUI is opened may produce an error in executing the GUI operations. 

}


\seealso{
  \code{\link{cGroupsWUI}}, \code{\link{compareGroups}}, \code{\link{createTable}}
}

\examples{
\dontrun{
data(regicor)
cGroupsGUI(regicor)
}
}

\keyword{utilities}

