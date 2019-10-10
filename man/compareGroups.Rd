\name{compareGroups}
\alias{compareGroups}
\alias{print.compareGroups}
\alias{plot.compareGroups}
\alias{update.compareGroups}
\alias{summary.compareGroups}
\alias{print.summary.compareGroups}

\title{
Descriptives by groups
}


\description{
This function performs descriptives by groups for several variables. Depending on the nature of these variables, different descriptive statistics are calculated (mean, median, frequencies or K-M probabilities) and different tests are computed as appropriate (t-test, ANOVA, Kruskall-Wallis, Fisher, log-rank, ...).
}

\usage{
compareGroups(formula, data, subset, na.action = NULL, y = NULL, Xext = NULL, 
  selec = NA, method = 1, timemax = NA, alpha = 0.05, min.dis = 5, max.ylev = 5, 
  max.xlev = 10, include.label = TRUE, Q1 = 0.25, Q3 = 0.75, simplify = TRUE, 
  ref = 1, ref.no = NA, fact.ratio = 1, ref.y = 1, p.corrected = TRUE, 
  compute.ratio = TRUE, include.miss = FALSE, oddsratio.method = "midp", 
  chisq.test.perm = FALSE, byrow = FALSE, chisq.test.B = 2000, chisq.test.seed = NULL, 
  Date.format = "d-mon-Y", var.equal = TRUE, conf.level = 0.95, surv=FALSE,
  riskratio = FALSE, riskratio.method = "wald")
\method{plot}{compareGroups}(x, file, type = "pdf", bivar = FALSE, z=1.5, 
  n.breaks = "Sturges", perc = FALSE, ...)
}

\arguments{

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
  
  \item{byrow}{logical or NA. Percentage of categorical variables must be reported by rows (TRUE), by columns (FALSE) or by columns and rows to sum up 1 (NA). Default value is FALSE, which means that percentages are reported by columns (withing groups).}  
  
  \item{chisq.test.perm}{logical. It applies a permutation chi squared test (\code{\link[stats]{chisq.test}}) instead of an exact Fisher test (\code{\link[stats]{fisher.test}}). It only applies when expected count in some cells are lower than 5.}
  
  \item{chisq.test.B}{integer. Number of permutation when computing permuted chi squared test for categorical variables. Default value is 2000.}
   
  \item{chisq.test.seed}{integer or NULL. Seed when performing permuted chi squared test for categorical variables. Default value is NULL which sets no seed. It is important to introduce some number different from NULL in order to reproduce the results when permuted chi-squared test is performed.} 
  
  \item{Date.format}{character indicating how the dates are shown. Default is "d-mon-Y". See \code{\link[chron]{chron}} for more details.} 
  
  \item{var.equal}{logical, indicating whether to consider equal variances when comparing means on normal distributed variables on more than two groups. If TRUE \code{\link{anova}} function is applied and \code{\link{oneway.test}} otherwise. Default value is TRUE.}   

  \item{conf.level}{double. Conficende level of confidence interval for means, medians, proportions or incidence. Default value is 0.95.}
  
  \item{surv}{logical. Compute survival (TRUE) or incidence (FALSE) for time-to-event row-variables. Default value is FALSE.} 
  \item{riskratio}{logical. Whether to compute Odds Ratio (FALSE) or Risk Ratio (TRUE). Default value is FALSE.}  
  
  \item{riskratio.method}{Which method to compute the Odds Ratio. See 'method' argument from \code{\link[epitools]{riskratio}}. Default value is "wald".}     

  
Arguments passed to \code{plot} method.  
  
  \item{x}{an object of class 'compareGroups'.}  

  \item{file}{a character string giving the name of the file. A bmp, jpg, png or tif file is saved with an appendix added to 'file' corresponding to the row-variable name. If 'onefile' argument is set to TRUE throught '...' argument of plot method function, a unique PDF file is saved named as [file].pdf. If it is missing, multiple devices are opened, one for each row-variable of 'x' object.}  

  \item{type}{a character string indicating the file format where the plots are stored. Possibles foramts are 'bmp', 'jpg', 'png', 'tif' and 'pdf'.Default value is 'pdf'.}  

  \item{bivar}{logical. If bivar=TRUE, it plots a boxplot or a barplot (for a continuous or categorical row-variable, respectively) stratified by groups. If bivar=FALSE, it plots a normality plot (for continuous row-variables) or a barplot (for categorical row-variables). Default value is FALSE.}

  \item{z}{double. Indicates threshold limits to be placed in the deviation from normality plot. It is considered that too many points beyond this threshold indicates that current variable is far to be normal-distributed. Default value is 1.5.}

  \item{n.breaks}{same as argument 'breaks' of \code{\link[graphics]{hist}}.} 

  \item{perc}{logical. Relative frequencies (in percentatges) instead of absolute frequencies are displayed in barplots for categorical variable.}  

  \item{\dots}{For 'plot' method, '...' arguments are passed to \code{\link[grDevices]{pdf}}, \code{\link[grDevices]{bmp}}, \code{\link[grDevices]{jpeg}}, \code{\link[grDevices]{png}} or \code{\link[grDevices]{tiff}} if 'type' argument equals to 'pdf', 'bmp', 'jpg', 'png' or 'tif', respectively.}

}

\details{

Depending whether the row-variable is considered as continuous normal-distributed (1), continuous non-normal distributed (2) or categorical (3), the following descriptives and tests are performed: \cr
  1- mean, standard deviation and t-test or ANOVA \cr
  2- median, 1st and 3rd quartiles (by default), and Kruskall-Wallis test \cr
  3- or absolute and relative frequencies and chi-squared or exact Fisher test when the expected frequencies is less than 5 in some cell\cr
Also, a row-variable can be of class 'Surv'. Then the probability of 'event' at a fixed time (set up with 'timemax' argument) is computed and a logrank test is performed.\cr 

When there are more than 2 groups, it also performs pairwise comparisons adjusting for multiple testing (Tukey when row-variable is normal-distributed and Benjamini & Hochberg method otherwise), and computes p-value for trend. 
The p-value for trend is computed from the Pearson test when row-variable is normal and from the Spearman test when it is continuous non normal. If row-variable is of class 'Surv', the score test is computed from a Cox model where the grouping variable is introduced as an integer variable predictor. If the row-variable is categorical, the p-value for trend is computed as \cr
\code{1-pchisq(cor(as.integer(x),as.integer(y))^2*(length(x)-1),1)} \cr
where 'x' is the row-variable and 'y' is the grouping variable.   \cr

If there are two groups, the Odds Ratio or Risk Ratio is computed for each row-variable. While, if the response is of class 'Surv' (i.e. time to event) Hazard Ratios are computed. 
When x-variable is a factor, the Odds Ratio and Risk Ratio are computed using \code{\link[epitools]{oddsratio}} and \code{\link[epitools]{riskratio}}, respectively. While when x-variable is a continuous variable, the Odds Ratio and Risk Ratio are computed under a logistic regression with a canonical link and the log link, respectively. \cr

The p-values for Hazard Ratios are computed using the logrank or Wald test under a Cox proportional hazard regression when row-variable is categorical or continuous, respectively. \cr

See the vignette for more detailed examples illustrating the use of this function and the methods used.

}


\value{

 An object of class 'compareGroups'.  \cr

  'print' returns a table sample size, overall p-values, type of variable ('categorical', 'normal', 'non-normal' or 'Surv') and the subset of individuals selected.  \cr

  'summary' returns a much more detailed list. Every component of the list is the result for each row-variable, showing frequencies, mean, standard deviations, quartiles or K-M probabilities as appropriate. Also, it shows overall p-values as well as p-trends and pairwise p-values among the groups. \cr
 
  'plot' displays, for all the analyzed variables, normality plots (with the Shapiro-Wilks test), barplots or Kaplan-Meier plots depending on whether the row-variable is continuous, categorical or time-to-response, respectevily. Also, bivariate plots can be displayed with stratified by groups boxplots or barplots, setting 'bivar' argument to TRUE.  \cr
  
  An update method for 'compareGroups' objects has been implemented and works as usual to change all the arguments of previous analysis. \cr

  A subset, '[', method has been implemented for 'compareGroups' objects. The subsetting indexes can be either integers (as usual), row-variables names or row-variable labels.       \cr
  
  Combine by rows,'rbind', method has been implemented for 'compareGroups' objects. It is useful to distinguish row-variable groups. \cr 

See examples for further illustration about all previous issues. 

}
               

\note{

By default, the labels of the variables (row-variables and grouping variable) are displayed in the resulting tables. These labels are taken from the "label" attribute of each variable. And if this attribute is NULL, then the name of the variable is displayed, instead. 
To label non-labeled variables, or to change their labels, specify its "label" atribute directly.\cr

There may be no equivalence between the intervals of the OR / HR and p-values. For example, when the response variable is binary and the row-variable is continuous, p-value is based on Mann-Whitney U test or t-test depending on whether row-variable is normal distributed or not, respectively, while the confidence interval is build using the Wald method (log(OR) -/+ 1.96*se). Or when the answer is of class 'Surv', p-value is computed with the logrank test, while confidence intervals are based on the Wald method (log(HR) -/+ 1.96*se). 
Finally, when the response is binary and the row variable is categorical, the p-value is based on the chi-squared or Fisher test when appropriate, while confidence intervals are constructed from the median-unbiased estimation method (see \code{\link[epitools]{oddsratio}}). \cr

Subjects selection criteria specified in 'selec' and 'subset' arguments are combined using '&' to be applied to every row-variable.\cr

Through '...' argument of 'plot' method, some parameters such as figure size, multiple figures in a unique file (only for 'pdf' files), resolution, etc. are controlled. For more information about which arguments can be passed depending on the format type, see \code{\link[grDevices]{pdf}}, \code{\link[grDevices]{bmp}}, \code{\link[grDevices]{jpeg}}, \code{\link[grDevices]{png}} or \code{\link[grDevices]{tiff}}.\cr

Since version 4.0, date variables are supported. For this kind of variables only method==2 is applied, i.e. non-parametric tests for continuous variables are applied. However, the descriptive statistics (medians and quantiles) are displayed in date format instead of numeric format.

}

\references{
  Isaac Subirana, Hector Sanz, Joan Vila (2014). Building Bivariate Tables: The compareGroups Package for R. Journal of Statistical Software, 57(12), 1-16. URL \url{http://www.jstatsoft.org/v57/i12/}.
}

\seealso{
\code{\link{createTable}}
}

\examples{

require(compareGroups)

# load REGICOR data
data(regicor)

# compute a time-to-cardiovascular event variable
regicor$tcv <- with(regicor, Surv(tocv, as.integer(cv=='Yes')))
attr(regicor$tcv,"label")<-"Cardiovascular"

# compute a time-to-overall death variable
regicor$tdeath <- with(regicor, Surv(todeath, as.integer(death=='Yes')))
attr(regicor$tdeath,"label") <- "Mortality"

# descriptives by sex
res <- compareGroups(sex ~ .-id-tocv-cv-todeath-death, data = regicor)
res

# summary of each variable
summary(res)

# univariate plots of all row-variables
\dontrun{
plot(res)
}

# plot of all row-variables by sex
\dontrun{
plot(res, bivar = TRUE)
}

# update changing the response: time-to-cardiovascular event.
# note that time-to-death must be removed since it is not possible 
# not compute descriptives of a 'Surv' class object by another 'Surv' class object.

\dontrun{
update(res, tcv ~ . + sex - tdeath - tcv)
}

}

\keyword{misc}
