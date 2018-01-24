\name{printTable}
\alias{printTable}

\title{
'Nice' table format.
}


\description{
This functions prints a table on the console in a 'nice' format.
}


\usage{
printTable(obj, row.names = TRUE, justify = 'right')
}

\arguments{

  \item{obj}{an object of class 'data.frame' or 'matrix'. It must be at least two columns, the first columns is considered as the 'row.names' and is left justified (if the 'row.names' argument is set to TRUE), while the rest of the columns are right justified.}
  
  \item{row.names}{logical indicating whether the first column or variable is treated as a 'row.names' column and must be left-justified. Default value is TRUE.}
  
  \item{justify}{character as 'justify' argument from \code{\link[base]{format}} function. It applies to all columns of the data.frame or matrix when 'row.names' argument is FALSE or all columns excluding the first one otherwise. Default value is 'right'.} 
  
}


\value{

No object is returned.
  
}


\note{

  This function may be usefull when printing a table with some results with variables as the first column and a header. It adds 'nice' lines to highlight the header and also the bottom of the table. 
  
  It has been used to print 'compareSNPs' objects.

}


\seealso{
  \code{\link{compareSNPs}}
}


\examples{

require(compareGroups)

data(regicor)

# example of the coefficients table from a linear regression
model <- lm(chol ~ age + sex + bmi, regicor)
results <- coef(summary(model))
results <- cbind(Var = rownames(results), round(results, 4))
printTable(results)

# or visualize the first rows of the iris data frame. 
# In this example, the first column is not treated as a row.names column and it is right justified.
printTable(head(iris), FALSE)

# the same example with columns centered
printTable(head(iris), FALSE, 'centre')


}




\keyword{utilities}

