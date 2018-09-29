\name{descrTable}
\alias{descrTable}

\title{
Perform descriptives and build the bivariate table.
}
\description{
This functions builds a bivariate table calling compareGroups and createTable function in one step.
}
\usage{
descrTable(formula, data, subset, na.action = NULL, y = NULL, Xext = NULL, 
  selec = NA, method = 1, timemax = NA, alpha = 0.05, min.dis = 5, max.ylev = 5, 
  max.xlev = 10, include.label = TRUE, Q1 = 0.25, Q3 = 0.75, simplify = TRUE, 
  ref = 1, ref.no = NA, fact.ratio = 1, ref.y = 1, p.corrected = TRUE, 
  compute.ratio = TRUE, include.miss = FALSE, oddsratio.method = "midp", 
  chisq.test.perm = FALSE, byrow = FALSE, chisq.test.B = 2000, chisq.test.seed = NULL,
  Date.format = "d-mon-Y", var.equal = TRUE, 
  hide = NA, digits = NA, type = NA, show.p.overall = TRUE,
  show.all, show.p.trend, show.p.mul = FALSE, show.n, show.ratio =
  FALSE, show.descr = TRUE, hide.no = NA, digits.ratio = NA,
  show.p.ratio = show.ratio, digits.p = 3, sd.type = 1, q.type = c(1, 1),
  extra.labels = NA)
}

\arguments{

Arguments from \code{\link{compareGroups}} function:

 \item{formula}{an object of class "formula" (or one that can be coerced to that class). Right side of ~ must have the terms in an additive way, and left side of ~ must contain the name of the grouping variable or can be left in blank (in this latter case descriptives for whole sample are calculated and no test is performed).}

  \item{data}{an optional data frame, list or environment (or object coercible by 'as.data.frame' to a data frame) containing the variables in the model. If they are not found in 'data', the variables are taken from 'environment(formula)'.}
  
  \item{subset}{an optional vector specifying a subset of individuals to be used in the computation process. It is applied to all row-variables. 'subset' and 'selec' are added in the sense of '&' to be applied in every row-variable.}
  
  \item{na.action}{a function which indicates what should happen when the data contain NAs. The default is NULL, and that is equivalent to \code{\link[stats]{na.pass}}, which means no action. Value \code{\link[stats]{na.exclude}} can be useful if it is desired to removed all individuals with some NA in any variable.}    

  \item{y}{a vector variable that distinguishes the groups. It must be either a numeric, character, factor or NULL. Default value is NULL which means that descriptives for whole sample are calculated and no test is performed.}
  
  \item{Xext}{a data.frame or a matrix with the same rows / individuals contained in \code{X}, and maybe with different variables / columns than \code{X}. This argument is used by \code{compareGroups.default} in the sense that the variables specified in the argument \code{selec} are searched in \code{Xext} and/or in the \code{\link[base]{.GlobalEnv}}. If \code{Xext} is \code{NULL}, then Xext is created from variables of \code{X} plus \code{y}. Default value is \code{NULL}.} 
  
  \item{selec}{a list with as many components as row-variables. If list length is 1 it is recycled for all row-variables. Every component of 'selec' is an expression that will be evaluated to select the individuals to be analyzed for every row-variable. Otherwise, a named list specifying 'selec' row-variables is applied. '.else' is a reserved name that defines the selection for the rest of the variables; if no '.else' variable is defined, default value is applied for the rest of the variables. Default value is NA; all individuals are analyzed (no subsetting).}
  
  \item{method}{integer vector with as many components as row-variables. If its length is 1 it is recycled for all row-variables. It only applies for continuous row-variables (for factor row-variables it is ignored). Possible values are: 1 - forces analysis as "normal-distributed"; 2 - forces analysis as "continuous  non-normal"; 3 - forces analysis as "categorical";  and 4 - NA, which performs a Shapiro-Wilks  test to decide between normal or non-normal. Otherwise, a named vector specifying 'method' row-variables is applied. 
'.else' is a reserved name that defines the method for the rest of the variables; if no '.else' variable is defined, default value is applied. Default value is 1.}
  
  \item{timemax}{double vector with as many components as row-variables. If its length is 1 it is recycled for all row-variables. It only applies for 'Surv' class row-variables (for all other row-variables it is ignored).  This value indicates at which time the K-M probability is to be computed. Otherwise, a named vector specifying 'timemax' row-variables is applied. '.else' is a reserved name that defines the 'timemax' for the rest of the variables; if no '.else' variable is defined, default value is applied. Default value is NA; K-M probability is then computed at the median of observed times.}
  
  \item{alpha}{double between 0 and 1. Significance threshold for the \code{\link[stats]{shapiro.test}} normality test for continuous row-variables. Default value is 0.05.}
  
  \item{min.dis}{an integer. If a non-factor row-variable contains less than 'min.dis' different values and 'method' argument is set to NA, then it will be converted to a factor. Default value is 5.}
  
  \item{max.ylev}{an integer indicating the maximum number of levels of grouping variable ('y'). If 'y' contains more than 'max.ylev' levels, then the function 'compareGroups' produces an error. Default value is 5.}

  \item{max.xlev}{an integer indicating the maximum number of levels when the row-variable is a factor. If the row-variable is a factor (or converted to a factor if it is a character, for example) and contains more than 'max.xlev' levels, then it is removed from the analysis and a warning is printed. Default value is 10.}
    
  \item{include.label}{logical, indicating whether or not variable labels have to be shown in the results. Default value is TRUE}

  \item{Q1}{double between 0 and 1, indicating the quantile to be displayed as the first number inside the square brackets in the bivariate table. To compute the minimum just type 0. Default value is 0.25 which means the first quartile.}
  
  \item{Q3}{double between 0 and 1, indicating the quantile to be displayed as the second number inside the square brackets in the bivariate table. To compute the maximum just type 1. Default value is 0.75 which means the third quartile.}

  \item{simplify}{logical, indicating whether levels with no values must be removed for grouping variable and for row-variables. Default value is TRUE.}
  
  \item{ref}{an integer vector with as many components as row-variables. If its length is 1 it is recycled for all row-variables. It only applies for categorical row-variables. Or a named vector specifying which row-variables 'ref' is applied (a reserved name is '.else' which defines the reference category for the rest of the variables); if no '.else' variable is defined, default value is applied for the rest of the variables. Default value is 1.}
  
  \item{ref.no}{character specifying the name of the level to be the reference for Odds Ratio or Hazard Ratio. It is not case-sensitive. This is especially useful for yes/no variables. Default value is NA which means that category specified in 'ref' is the one selected to be the reference.}

  \item{fact.ratio}{a double vector with as many components as row-variables  indicating  the units for the HR / OR (note that it does not affect the descriptives).  If its length is 1 it is recycled for all row-variables. Otherwise, a named vector specifying 'fact.ratio' row-variables is applied. '.else' is a reserved name that defines the reference category for the rest of the variables;  if no '.else' variable is defined, default value is applied. Default value is 1.}
  
  \item{ref.y}{an integer indicating the reference category of y variable for computing the OR, when y is a binary factor. Default value is 1.}
  
  \item{p.corrected}{logical, indicating whether p-values for pairwise comparisons must be corrected. It only applies when there is a grouping variable with more than 2 categories. Default value is TRUE.}  
  
  \item{compute.ratio}{logical, indicating whether Odds Ratio (for a binary response) or Hazard Ratio (for a time-to-event response) must be computed. Default value is TRUE.}  
  
  \item{include.miss}{logical, indicating whether to treat missing values as a new category for categorical variables. Default value is FALSE.}   
  
  \item{oddsratio.method}{Which method to compute the Odds Ratio. See 'method' argument from \code{\link[epitools]{oddsratio}}. Default value is "midp".}    
  
  \item{byrow}{logical. Percentage of categorical variables must be reported by rows. Default value is FALSE, which means that percentages are reported by columns (withing groups).}  
  
  \item{chisq.test.perm}{logical. It applies a permutation chi squared test (\code{\link[stats]{chisq.test}}) instead of an exact Fisher test (\code{\link[stats]{fisher.test}}). It only applies when expected count in some cells are lower than 5.}
  
  \item{chisq.test.B}{integer. Number of permutation when computing permuted chi squared test for categorical variables. Default value is 2000.}
   
  \item{chisq.test.seed}{integer or NULL. Seed when performing permuted chi squared test for categorical variables. Default value is NULL which sets no seed. It is important to introduce some number different from NULL in order to reproduce the results when permuted chi-squared test is performed.} 
  
  \item{Date.format}{character indicating how the dates are shown. Default is "d-mon-Y". See \code{\link[chron]{chron}} for more details.}
  
  \item{var.equal}{logical, indicating whether to consider equal variances when comparing means on normal distributed variables on more than two groups. If TRUE \code{\link{anova}} function is applied and \code{\link{oneway.test}} otherwise. Default value is TRUE.} 

Arguments from \code{\link{createTable}} function:


  \item{hide}{a vector (or a list) with integers or characters with as many components as row-variables. If its length is 1 it is recycled for all row-variables. Each component specifies which category (the literal name of the category if it is a character, or the position if it is an integer) must be hidden and not shown. This argument only applies to categorical row-variables, and for continuous row-variables it is ignored. If NA, all categories are displayed. Or a named vector (or a named list) specifying which row-variables 'hide' is applied, and for the rest of row-variables default value is applied. Default value is NA.}

  \item{digits}{an integer vector with as many components as row-variables. If its length is 1 it is recycled for all row-variables. Each component specifies the number of significant decimals to be displayed. Or a named vector specifying which row-variables 'digits' is applied (a reserved name is '.else' which defines 'digits' for the rest of the variables); if no '.else' variable is defined, default value is applied for the rest of the variables. Default value is NA which puts the 'appropriate' number of decimals (see vignette for further details).}

  \item{type}{an integer that indicates whether absolute and/or relative frequencies are displayed: 1 - only relative frequencies; 2 or NA - absolute and relative frequencies in brackets; 3 - only absolute frequencies.} 

  \item{show.p.overall}{logical indicating whether p-value of overall groups significance ('p.overall' column) is displayed or not. Default value is TRUE.}
  
  \item{show.all}{logical indicating whether the '[ALL]' column (all data without stratifying by groups) is displayed or not. Default value is FALSE if grouping variable is defined, and FALSE if there are no groups.}
  
  \item{show.p.trend}{logical indicating whether p-trend is displayed or not. It is always FALSE when there are less than 3 groups. If this argument is missing, there are more than 2 groups and the grouping variable is an ordered factor, then p-trend is displayed. By default, p-trend is not displayed, and it is displayed when there are more than 2 groups and the grouping variable is of class ordered-factor.}
  
  \item{show.p.mul}{logical indicating whether the pairwise (between groups) comparisons p-values are displayed or not. It is always FALSE when there are less than 3 groups. Default value is FALSE.}
  
  \item{show.n}{logical indicating whether number of individuals analyzed for each row-variable is displayed or not in the 'descr' table. Default value is FALSE and it is TRUE when there are no groups.}
  
  \item{show.ratio}{logical indicating whether OR / HR is displayed or not. Default value is FALSE.}  

  \item{show.descr}{logical indicating whether descriptives (i.e. mean, proportions, ...) are displayed. Default value is TRUE.}
  
  \item{hide.no}{character specifying the name of the level to be hidden for all categorical variables with 2 categories. It is not case-sensitive. The result is one row for the variable with only the name displayed and not the category. This is especially useful for yes/no variables. It is ignored for the categorical row-variables with 'hide' argument different from NA. Default value is NA which means that no category is hidden.}
  
  \item{digits.ratio}{The same as 'digits' argument but applied for the Hazard Ratio or Odds Ratio.}

  \item{show.p.ratio}{logical indicating whether p-values corresponding to each Hazard Ratio / Odds Ratio are shown.}
  
  \item{digits.p}{integer indicating the number of decimals displayed for all p-values. Default value is 3.}
  
  \item{sd.type}{an integer that indicates how standard deviation is shown: 1 - mean (SD), 2 -  mean ? SD.}
  
  \item{q.type}{a vector with two integer components. The first component refers to the type of brackets to be displayed for non-normal row-variables (1 - rounded and 2 - squared), while the second refers to the percentile separator (1 - ';', 2 - ',' and 3 - '-'. Default value is c(1, 1).}
  
  \item{extra.labels}{character vector of 3 components corresponding to key legend to be appended to normal, non-normal and categorical row-variables labels. Default value is NA which appends no extra key. If it is set to \code{c("","","")}, "Mean (SD)", "Median [25th; 75th]" and "N (\%)" are appended.}

}


\value{

An object of class 'createTable' (see \code{\link{createTable}}).

So, all methods implemented for createTable class objects can be applied (such as plot, '[', etc.).

}

\note{

The use of descrTable function makes easier to build the table (it only needs one line), it may be preferable to build the descriptive table in two steps when computing descriptives and p-values takes some time: first use \code{compareGroups} function to store the descriptives and p-values in an object, and then apply \code{createTable} to the this object. The two steps strategy saves time since descriptives and p-values are not recomputed every time it is desired to costumize the descriptive table (number of digits, etc.).

}


\references{
  Isaac Subirana, Hector Sanz, Joan Vila (2014). Building Bivariate Tables: The compareGroups Package for R. Journal of Statistical Software, 57(12), 1-16. URL \url{http://www.jstatsoft.org/v57/i12/}.
}

\seealso{
  \code{\link{createTable}}, \code{\link{compareGroups}}, \code{\link{export2latex}}, \code{\link{export2csv}}, \code{\link{export2html}}
}
\examples{

require(compareGroups)

# load REGICOR data
data(regicor)

# perform descriptives by year and build the table.
# note the use of arguments from compareGroups (formula and data set) and
# arguments from createTable (hide.no and show.p.mul)
descrTable(year ~ ., regicor, hide.no="no", show.p.mul=TRUE)

}

\keyword{misc}

