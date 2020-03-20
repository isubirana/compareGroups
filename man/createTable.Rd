\name{createTable}
\alias{createTable}
\alias{print.createTable}
\alias{summary.createTable}
\alias{print.summary.createTable}
\alias{plot.createTable}

\title{
Table of descriptives by groups: bivariate table 
}
\description{
This functions builds a "compact" and "nice" table with the descriptives by groups.
}
\usage{
createTable(x, hide = NA, digits = NA, type = NA, show.p.overall = TRUE,
           show.all, show.p.trend, show.p.mul = FALSE, show.n, show.ratio =
           FALSE, show.descr = TRUE, show.ci = FALSE, hide.no = NA, digits.ratio = NA,
           show.p.ratio = show.ratio, digits.p = 3, sd.type = 1, q.type = c(1, 1),
           extra.labels = NA, all.last = FALSE)
\method{print}{createTable}(x, which.table = "descr", nmax = TRUE, header.labels = c(), ...)
\method{plot}{createTable}(x, ...)
}

\arguments{

  \item{x}{an object of class 'compareGroups'}

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
  
  \item{show.ci}{logical indicating whether to show confidence intervals of means, medians, proporcions or incidences are displayed. If so, they are displayed between squared brackets. Default value is FALSE.}  
  
  \item{hide.no}{character specifying the name of the level to be hidden for all categorical variables with 2 categories. It is not case-sensitive. The result is one row for the variable with only the name displayed and not the category. This is especially useful for yes/no variables. It is ignored for the categorical row-variables with 'hide' argument different from NA. Default value is NA which means that no category is hidden.}
  
  \item{digits.ratio}{The same as 'digits' argument but applied for the Hazard Ratio or Odds Ratio.}

  \item{show.p.ratio}{logical indicating whether p-values corresponding to each Hazard Ratio / Odds Ratio are shown.}
  
  \item{digits.p}{integer indicating the number of decimals displayed for all p-values. Default value is 3.}
  
  \item{sd.type}{an integer that indicates how standard deviation is shown: 1 - mean (SD), 2 -  mean ? SD.}
  
  \item{q.type}{a vector with two integer components. The first component refers to the type of brackets to be displayed for non-normal row-variables (1 - rounded and 2 - squared), while the second refers to the percentile separator (1 - ';', 2 - ',' and 3 - '-'. Default value is c(1, 1).}
  
  \item{extra.labels}{character vector of 3 components corresponding to key legend to be appended to normal, non-normal and categorical row-variables labels. Default value is NA which appends no extra key. If it is set to \code{c("","","")}, "Mean (SD)", "Median [25th; 75th]" and "N (\%)" are appended.}
  
  \item{all.last}{logical. Descriptives of the whole sample is placed after the descriptives by groups. Default value is FALSE which places the descriptives of whole cohort at first.}
  
  \item{which.table}{character indicating which table is printed. Possible values are 'descr', 'avail' or 'both' (partial matching allowed), printing descriptives by groups table, availability data table or both tables, respectively. Default value is 'descr'.}
  
  \item{nmax}{logical, indicating whether to show the number of subjects with at least one valid value across all row-variables. Default value is TRUE.}

  \item{header.labels}{a character named vector with 'all', 'p.overall', 'p.trend', 'ratio', 'p.ratio' and 'N' components indicating the label for '[ALL]', 'p.overall', 'p.trend', 'ratio', 'p.ratio' and 'N' (available data), respectively. Default is a zero length vector which makes no changes, i.e. '[ALL]', 'p.overall', 'p.trend', 'ratio', 'p.ratio' and 'N' labels appear for descriptives of entire cohort, global p-value, p-value for trend, HR/OR and p-value of each HR/OR and available data, respectively.}  

  \item{...}{other arguments passed to \code{\link[base]{print.default}}.}
  
}


\value{

An object of class 'createTable', which contains a list of 2 matrix:

  \item{descr}{a character matrix of descriptives for all row-variables by groups and p-values in a 'compact' format}

  \item{avail}{a character matrix indicating the number of available data for each group, the type of variable (categorical, continuous-normal or continuous-non-normal) and the individuals selection made (if non selection 'ALL' is displayed).}

  'print' prints these two tables in a 'nice' format.
  
  'summary' prints the 'available' info table (it is a short form of \code{print(x, which.table = 'avail')}).
  
  'update' modifies previous results from 'createTable'.
  
  'plot' see the method in \code{\link{compareGroups}} function.
  
  subsetting, '[', can also be applied to 'createTable' objects in the same way as 'compareGroups' objects.
  
  combine by rows, 'rbind', method can be applied to 'createTable' objects, but only if all 'createTable' objects have the same columns. It is useful to distinguish row-variable groups. The resulting object is of class 'rbind.createTable' and 'createTable'.
  
  combine by columns, 'cbind', method can be applied to 'createTable' objects, but only if all 'createTable' objects have the same rows. It may be used when combining different tables referring to different subsets of people (for example, men and women). The resulting object is of class 'cbind.createTable' and 'createTable' and has its own 'print' method.
  
  See the vignette for more details.
  
}


\note{

The way to compute the 'N' shown in the bivariate table header, controlled by 'nmax' argument, has been changed from previous versions (<1.3). In the older versions 'N' was computed as the maximum across the cells withing each column (group) from the 'available data' table ('avail').

The p-values corresponding to the OR of a two level row-variable may not me equal to its p.overall p-value. This is because statistical tests are different: the option 'midp.exact' (see \code{oddsratio} from \code{epitools} package for more details) is taken in the first case and Chi-square or Fisher exact test in the second. The same happens when OR for a continuous value is performed: the p-value corresponding to this OR is computed form a logistic regression and therefore may differ from the one computed using a Student-T test or Kruskall Wallis test.
This discordance may also be present when computing the p-value corresponding to a Hazard Ratio for a categorical two level row-variable: a Wald test or a long-rank test are peformed.

}

\references{
  Isaac Subirana, Hector Sanz, Joan Vila (2014). Building Bivariate Tables: The compareGroups Package for R. Journal of Statistical Software, 57(12), 1-16. URL \url{http://www.jstatsoft.org/v57/i12/}.
}

\seealso{
  \code{\link{compareGroups}}, \code{\link{export2latex}}, \code{\link{export2csv}}, \code{\link{export2html}}
}
\examples{

require(compareGroups)

# load REGICOR data
data(regicor)

# compute a time-to-cardiovascular event variable
regicor$tcv <- with(regicor,Surv(tocv, as.integer(cv=='Yes')))
attr(regicor$tcv, "label")<-"Cardiovascular incidence"

# descriptives by time-to-cardiovascular event, taking 'no' category as 
# the reference in computing HRs.
res <- compareGroups(tcv ~ age + sex + smoker + sbp + histhtn + 
         chol + txchol + bmi + phyact + pcs + tcv, regicor, ref.no='no')

# build table showing HR and hiding the 'no' category
restab <- createTable(res, show.ratio = TRUE, hide.no = 'no')
restab

# prints available info table
summary(restab)


# more...

\dontrun{

# Adds the 'available data' column
update(restab, show.n=TRUE)

# Descriptive of the entire cohort
update(restab, x = update(res, ~ . ))

# .. changing the response variable to sex
# Odds Ratios (OR) are displayed instead of Hazard Ratios (HR).
# note that now it is possible to compute descriptives by time-to-death 
# or time-to-cv but not the ORs . 
# We set timemax to 5 years, to report the probability of death and CV at 5 years:
update(restab, x = update(res, sex ~ . - sex + tdeath + tcv, timemax = 5*365.25))


## Combining tables:

# a) By rows: takes the first four variables as a group and the rest as another group:
rbind("First group of variables"=restab[1:4],"Second group of variables"=
  restab[5:length(res)])

# b) By columns: puts stratified tables by sex one beside the other:
res1<-compareGroups(year ~ . - id - sex, regicor)
restab1<-createTable(res1, hide.no = 'no')
restab2<-update(restab1, x = update(res1, subset = sex == 'Male'))
restab3<-update(restab1, x = update(res1, subset = sex == 'Female'))
cbind("ALL" = restab1, "MALES" = restab2, "FEMALES" = restab3)

}

}

\keyword{misc}

