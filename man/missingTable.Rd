\name{missingTable}
\alias{missingTable}

\title{
Table of missingness counts by groups.
}


\description{
This functions returns a table with the non-available frequencies from a already build bivariate table.
}


\usage{
missingTable(obj,...)
}

\arguments{

  \item{obj}{either a 'compareGroups' or 'createTable' object.}

  \item{...}{other arguments passed to \code{createTable}.}
  
}


\value{

An object of class 'createTable'. For further details, see 'value' section of \code{createTable} help file.
  
}


\note{

  This function returns an object of class 'createTable', and therefore all methods implemented for 'createTable' objects can be applied, except the 'update' method.  

  All arguments of \code{createTable} can be passed throught '...' argument, except 'hide.no' argument which is fixed inside the code and cannot be changed.
  
  This function cannot be applied to stratified tables, i.e. 'rbind.createTable' and 'cbind.createTable'. If stratified missingness table is desired, apply this function first to each table and then use \code{cbind.createTable} or/and \code{rbind.createTable} functions to combine exactly in the same way as 'createTable' objects. See 'example' section below.

}


\seealso{
  \code{\link{createTable}}
}
\examples{


require(compareGroups)

# load regicor data
data(regicor)

# table of descriptives by recruitment year
res <- compareGroups(year ~ age + sex + smoker + sbp + histhtn + 
         chol + txchol + bmi + phyact + pcs + death, regicor)
restab <- createTable(res, hide.no = "no")

# missingness table
missingTable(restab,type=1)


\dontrun{

# also create the missing table from a compareGroups object
miss <- missingTable(res)
miss

# some methods that works for createTable objects also works for objects 
#   computed by missTable function.
miss[1:4]
varinfo(miss)
plot(miss)

#... but update methods cannot be applied (this returns an error).
update(miss,type=2) 

}


}

\keyword{utilities}




