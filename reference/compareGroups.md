# Descriptives by groups

This function performs descriptives by groups for several variables.
Depending on the nature of these variables, different descriptive
statistics are calculated (mean, median, frequencies or K-M
probabilities) and different tests are computed as appropriate (t-test,
ANOVA, Kruskall-Wallis, Fisher, log-rank, ...).

## Usage

``` r
compareGroups(formula, data, subset, na.action = NULL, y = NULL, Xext = NULL, 
  selec = NA, method = 1, timemax = NA, alpha = 0.05, min.dis = 5, max.ylev = 5, 
  max.xlev = 10, include.label = TRUE, Q1 = 0.25, Q3 = 0.75, simplify = TRUE, 
  ref = 1, ref.no = NA, fact.ratio = 1, ref.y = 1, p.corrected = TRUE, 
  compute.ratio = TRUE, include.miss = FALSE, oddsratio.method = "midp", 
  chisq.test.perm = FALSE, byrow = FALSE, chisq.test.B = 2000, chisq.test.seed = NULL, 
  Date.format = "d-mon-Y", var.equal = FALSE, conf.level = 0.95, surv=FALSE,
  riskratio = FALSE, riskratio.method = "wald", compute.prop = FALSE, 
  lab.missing = "'Missing'", p.trend.method = "spearman")
# S3 method for class 'compareGroups'
plot(x, file, type = "pdf", bivar = FALSE, z=1.5, 
  n.breaks = "Sturges", perc = FALSE, ...)
```

## Arguments

- formula:

  an object of class "formula" (or one that can be coerced to that
  class). Right side of ~ must have the terms in an additive way, and
  left side of ~ must contain the name of the grouping variable or can
  be left in blank (in this latter case descriptives for whole sample
  are calculated and no test is performed).

- data:

  an optional data frame, list or environment (or object coercible by
  'as.data.frame' to a data frame) containing the variables in the
  model. If they are not found in 'data', the variables are taken from
  'environment(formula)'.

- subset:

  an optional vector specifying a subset of individuals to be used in
  the computation process. It is applied to all row-variables. 'subset'
  and 'selec' are added in the sense of '&' to be applied in every
  row-variable.

- na.action:

  a function which indicates what should happen when the data contain
  NAs. The default is NULL, and that is equivalent to
  [`na.pass`](https://rdrr.io/r/stats/na.fail.html), which means no
  action. Value [`na.exclude`](https://rdrr.io/r/stats/na.fail.html) can
  be useful if it is desired to removed all individuals with some NA in
  any variable.

- y:

  a vector variable that distinguishes the groups. It must be either a
  numeric, character, factor or NULL. Default value is NULL which means
  that descriptives for whole sample are calculated and no test is
  performed.

- Xext:

  a data.frame or a matrix with the same rows / individuals contained in
  `X`, and maybe with different variables / columns than `X`. This
  argument is used by `compareGroups.default` in the sense that the
  variables specified in the argument `selec` are searched in `Xext`
  and/or in the [`.GlobalEnv`](https://rdrr.io/r/base/environment.html).
  If `Xext` is `NULL`, then Xext is created from variables of `X` plus
  `y`. Default value is `NULL`.

- selec:

  a list with as many components as row-variables. If list length is 1
  it is recycled for all row-variables. Every component of 'selec' is an
  expression that will be evaluated to select the individuals to be
  analyzed for every row-variable. Otherwise, a named list specifying
  'selec' row-variables is applied. '.else' is a reserved name that
  defines the selection for the rest of the variables; if no '.else'
  variable is defined, default value is applied for the rest of the
  variables. Default value is NA; all individuals are analyzed (no
  subsetting).

- method:

  integer vector with as many components as row-variables. If its length
  is 1 it is recycled for all row-variables. It only applies for
  continuous row-variables (for factor row-variables it is ignored).
  Possible values are: 1 - forces analysis as "normal-distributed"; 2 -
  forces analysis as "continuous non-normal"; 3 - forces analysis as
  "categorical"; and 4 - NA, which performs a Shapiro-Wilks test to
  decide between normal or non-normal. Otherwise, a named vector
  specifying 'method' row-variables is applied. '.else' is a reserved
  name that defines the method for the rest of the variables; if no
  '.else' variable is defined, default value is applied. Default value
  is 1.

- timemax:

  double vector with as many components as row-variables. If its length
  is 1 it is recycled for all row-variables. It only applies for 'Surv'
  class row-variables (for all other row-variables it is ignored). This
  value indicates at which time the K-M probability is to be computed.
  Otherwise, a named vector specifying 'timemax' row-variables is
  applied. '.else' is a reserved name that defines the 'timemax' for the
  rest of the variables; if no '.else' variable is defined, default
  value is applied. Default value is NA; K-M probability is then
  computed at the median of observed times.

- alpha:

  double between 0 and 1. Significance threshold for the
  [`shapiro.test`](https://rdrr.io/r/stats/shapiro.test.html) normality
  test for continuous row-variables. Default value is 0.05.

- min.dis:

  an integer. If a non-factor row-variable contains less than 'min.dis'
  different values and 'method' argument is set to NA, then it will be
  converted to a factor. Default value is 5.

- max.ylev:

  an integer indicating the maximum number of levels of grouping
  variable ('y'). If 'y' contains more than 'max.ylev' levels, then the
  function 'compareGroups' produces an error. Default value is 5.

- max.xlev:

  an integer indicating the maximum number of levels when the
  row-variable is a factor. If the row-variable is a factor (or
  converted to a factor if it is a character, for example) and contains
  more than 'max.xlev' levels, then it is removed from the analysis and
  a warning is printed. Default value is 10.

- include.label:

  logical, indicating whether or not variable labels have to be shown in
  the results. Default value is TRUE

- Q1:

  double between 0 and 1, indicating the quantile to be displayed as the
  first number inside the square brackets in the bivariate table. To
  compute the minimum just type 0. Default value is 0.25 which means the
  first quartile.

- Q3:

  double between 0 and 1, indicating the quantile to be displayed as the
  second number inside the square brackets in the bivariate table. To
  compute the maximum just type 1. Default value is 0.75 which means the
  third quartile.

- simplify:

  logical, indicating whether levels with no values must be removed for
  grouping variable and for row-variables. Default value is TRUE.

- ref:

  an integer vector with as many components as row-variables. If its
  length is 1 it is recycled for all row-variables. It only applies for
  categorical row-variables. Or a named vector specifying which
  row-variables 'ref' is applied (a reserved name is '.else' which
  defines the reference category for the rest of the variables); if no
  '.else' variable is defined, default value is applied for the rest of
  the variables. Default value is 1.

- ref.no:

  character specifying the name of the level to be the reference for
  Odds Ratio or Hazard Ratio. It is not case-sensitive. This is
  especially useful for yes/no variables. Default value is NA which
  means that category specified in 'ref' is the one selected to be the
  reference.

- fact.ratio:

  a double vector with as many components as row-variables indicating
  the units for the HR / OR (note that it does not affect the
  descriptives). If its length is 1 it is recycled for all
  row-variables. Otherwise, a named vector specifying 'fact.ratio'
  row-variables is applied. '.else' is a reserved name that defines the
  reference category for the rest of the variables; if no '.else'
  variable is defined, default value is applied. Default value is 1.

- ref.y:

  an integer indicating the reference category of y variable for
  computing the OR, when y is a binary factor. Default value is 1.

- p.corrected:

  logical, indicating whether p-values for pairwise comparisons must be
  corrected. It only applies when there is a grouping variable with more
  than 2 categories. Default value is TRUE.

- compute.ratio:

  logical, indicating whether Odds Ratio (for a binary response) or
  Hazard Ratio (for a time-to-event response) must be computed. Default
  value is TRUE.

- include.miss:

  logical, indicating whether to treat missing values as a new category
  for categorical variables. Default value is FALSE.

- oddsratio.method:

  Which method to compute the Odds Ratio. See 'method' argument from
  `oddsratio` (`epitools` package). Default value is "midp".

- byrow:

  logical or NA. Percentage of categorical variables must be reported by
  rows (TRUE), by columns (FALSE) or by columns and rows to sum up 1
  (NA). Default value is FALSE, which means that percentages are
  reported by columns (withing groups).

- chisq.test.perm:

  logical. It applies a permutation chi squared test
  ([`chisq.test`](https://rdrr.io/r/stats/chisq.test.html)) instead of
  an exact Fisher test
  ([`fisher.test`](https://rdrr.io/r/stats/fisher.test.html)). It only
  applies when expected count in some cells are lower than 5.

- chisq.test.B:

  integer. Number of permutation when computing permuted chi squared
  test for categorical variables. Default value is 2000.

- chisq.test.seed:

  integer or NULL. Seed when performing permuted chi squared test for
  categorical variables. Default value is NULL which sets no seed. It is
  important to introduce some number different from NULL in order to
  reproduce the results when permuted chi-squared test is performed.

- Date.format:

  character indicating how the dates are shown. Default is "d-mon-Y".
  See [`chron`](https://rdrr.io/pkg/chron/man/chron.html) for more
  details.

- var.equal:

  logical, indicating whether to consider equal variances when comparing
  means on normal distributed variables. Default value is FALSE. See
  details section for more information.

- conf.level:

  double. Conficende level of confidence interval for means, medians,
  proportions or incidence, and hazard, odds and risk ratios. Default
  value is 0.95.

- surv:

  logical. Compute survival (TRUE) or incidence (FALSE) for
  time-to-event row-variables. Default value is FALSE.

- riskratio:

  logical. Whether to compute Odds Ratio (FALSE) or Risk Ratio (TRUE).
  Default value is FALSE.

- riskratio.method:

  Which method to compute the Odds Ratio. See 'method' argument from
  `riskratio` (`epitools` package). Default value is "wald".

- compute.prop:

  logical. Compute proportions (TRUE) or percentages (FALSE) for
  cathegorical row-variables. Default value is FALSE.

- lab.missing:

  character. Label for missing cathegory. Only applied when
  `include.missing = TRUE`. Default value is 'Missing'.

- p.trend.method:

  Character indicating the name of test to use for p-value for trend. It
  only applies for numerical non-normal variables. Possible values are
  "spearman", "kendall" or "cuzick". Default value is "spearman". See
  section details for more info.

Arguments passed to `plot` method.

- x:

  an object of class 'compareGroups'.

- file:

  a character string giving the name of the file. A bmp, jpg, png or tif
  file is saved with an appendix added to 'file' corresponding to the
  row-variable name. If 'onefile' argument is set to TRUE throught '...'
  argument of plot method function, a unique PDF file is saved named as
  \[file\].pdf. If it is missing, multiple devices are opened, one for
  each row-variable of 'x' object.

- type:

  a character string indicating the file format where the plots are
  stored. Possibles foramts are 'bmp', 'jpg', 'png', 'tif' and
  'pdf'.Default value is 'pdf'.

- bivar:

  logical. If bivar=TRUE, it plots a boxplot or a barplot (for a
  continuous or categorical row-variable, respectively) stratified by
  groups. If bivar=FALSE, it plots a normality plot (for continuous
  row-variables) or a barplot (for categorical row-variables). Default
  value is FALSE.

- z:

  double. Indicates threshold limits to be placed in the deviation from
  normality plot. It is considered that too many points beyond this
  threshold indicates that current variable is far to be
  normal-distributed. Default value is 1.5.

- n.breaks:

  same as argument 'breaks' of
  [`hist`](https://rdrr.io/r/graphics/hist.html).

- perc:

  logical. Relative frequencies (in percentatges) instead of absolute
  frequencies are displayed in barplots for categorical variable.

- ...:

  For 'plot' method, '...' arguments are passed to
  [`pdf`](https://rdrr.io/r/grDevices/pdf.html),
  [`bmp`](https://rdrr.io/r/grDevices/png.html),
  [`jpeg`](https://rdrr.io/r/grDevices/png.html),
  [`png`](https://rdrr.io/r/grDevices/png.html) or
  [`tiff`](https://rdrr.io/r/grDevices/png.html) if 'type' argument
  equals to 'pdf', 'bmp', 'jpg', 'png' or 'tif', respectively.

## Details

Depending whether the row-variable is considered as continuous
normal-distributed (1), continuous non-normal distributed (2) or
categorical (3), the following descriptives and tests are performed:  
1- mean, standard deviation and t-test or ANOVA  
2- median, 1st and 3rd quartiles (by default), and Kruskall-Wallis
test  
3- or absolute and relative frequencies and chi-squared or exact Fisher
test when the expected frequencies is less than 5 in some cell  
Also, a row-variable can be of class 'Surv'. Then the probability of
'event' at a fixed time (set up with 'timemax' argument) is computed and
a logrank test is performed.  

When there are more than two groups, it also performs pairwise
comparisons adjusting for multiple testing (Tukey or Games-Howell test
when row-variable is normal-distributed and Benjamini & Hochberg method
otherwise), and computes p-value for trend.

When variances are assumed different for normal distributed
row-variables, Welch correccion is applied and Games Howell test
([`games_howell_test`](https://rpkgs.datanovia.com/rstatix/reference/games_howell_test.html))
for pairwise comparison p-values is performed.

The p-value for trend is computed from the Pearson test when
row-variable is normal and from the Spearman test when it is continuous
non normal. Also, for continuous non normal distributed variables, it is
possible to compute the p-value for trend using the Kendall's test
(`method='kendall'` from
[`cor.test`](https://rdrr.io/r/stats/cor.test.html)) or Cuzick's test
([`cuzickTest`](https://rdrr.io/pkg/PMCMRplus/man/cuzickTest.html)). If
row-variable is of class 'Surv', the score test is computed from a Cox
model where the grouping variable is introduced as an integer variable
predictor. If the row-variable is categorical, the p-value for trend is
computed from Mantel-Haenszel test of trend.

If there are two groups, the Odds Ratio or Risk Ratio is computed for
each row-variable. While, if the response is of class 'Surv' (i.e. time
to event) Hazard Ratios are computed. When x-variable is a factor, the
Odds Ratio and Risk Ratio are computed using `oddsratio` and
`riskratio`, respectively, from `epitools` package. While when
x-variable is a continuous variable, the Odds Ratio and Risk Ratio are
computed under a logistic regression with a canonical link and the log
link, respectively.  

The p-values for Hazard Ratios are computed using the logrank or Wald
test under a Cox proportional hazard regression when row-variable is
categorical or continuous, respectively.  

See the vignette for more detailed examples illustrating the use of this
function and the methods used.

## Value

An object of class 'compareGroups'.  

'print' returns a table sample size, overall p-values, type of variable
('categorical', 'normal', 'non-normal' or 'Surv') and the subset of
individuals selected.  

'summary' returns a much more detailed list. Every component of the list
is the result for each row-variable, showing frequencies, mean, standard
deviations, quartiles or K-M probabilities as appropriate. Also, it
shows overall p-values as well as p-trends and pairwise p-values among
the groups.  

'plot' displays, for all the analyzed variables, normality plots (with
the Shapiro-Wilks test), barplots or Kaplan-Meier plots depending on
whether the row-variable is continuous, categorical or time-to-response,
respectevily. Also, bivariate plots can be displayed with stratified by
groups boxplots or barplots, setting 'bivar' argument to TRUE.  

An update method for 'compareGroups' objects has been implemented and
works as usual to change all the arguments of previous analysis.  

A subset, '\[', method has been implemented for 'compareGroups' objects.
The subsetting indexes can be either integers (as usual), row-variables
names or row-variable labels.  

Combine by rows,'rbind', method has been implemented for 'compareGroups'
objects. It is useful to distinguish row-variable groups.  

See examples for further illustration about all previous issues.

## Note

By default, the labels of the variables (row-variables and grouping
variable) are displayed in the resulting tables. These labels are taken
from the "label" attribute of each variable. And if this attribute is
NULL, then the name of the variable is displayed, instead. To label
non-labeled variables, or to change their labels, specify its "label"
atribute directly.  

There may be no equivalence between the intervals of the OR / HR and
p-values. For example, when the response variable is binary and the
row-variable is continuous, p-value is based on Mann-Whitney U test or
t-test depending on whether row-variable is normal distributed or not,
respectively, while the confidence interval is build using the Wald
method (log(OR) -/+ 1.96\*se). Or when the answer is of class 'Surv',
p-value is computed with the logrank test, while confidence intervals
are based on the Wald method (log(HR) -/+ 1.96\*se). Finally, when the
response is binary and the row variable is categorical, the p-value is
based on the chi-squared or Fisher test when appropriate, while
confidence intervals are constructed from the median-unbiased estimation
method (see `oddsratio` function from `epitools` package).  

Subjects selection criteria specified in 'selec' and 'subset' arguments
are combined using '&' to be applied to every row-variable.  

Through '...' argument of 'plot' method, some parameters such as figure
size, multiple figures in a unique file (only for 'pdf' files),
resolution, etc. are controlled. For more information about which
arguments can be passed depending on the format type, see
[`pdf`](https://rdrr.io/r/grDevices/pdf.html),
[`bmp`](https://rdrr.io/r/grDevices/png.html),
[`jpeg`](https://rdrr.io/r/grDevices/png.html),
[`png`](https://rdrr.io/r/grDevices/png.html) or
[`tiff`](https://rdrr.io/r/grDevices/png.html).  

Since version 4.0, date variables are supported. For this kind of
variables only method==2 is applied, i.e. non-parametric tests for
continuous variables are applied. However, the descriptive statistics
(medians and quantiles) are displayed in date format instead of numeric
format.

Since version 4.10, \`var.equal\` default value has been changed to
FALSE and does not apply only when comparing three or more groups but
also when comparing two groups. Therefore, p-values may change when
comparing more than two groups for normal distributed row-variables with
respecto to previous versions.

## References

Isaac Subirana, Hector Sanz, Joan Vila (2014). Building Bivariate
Tables: The compareGroups Package for R. Journal of Statistical
Software, 57(12), 1-16. URL <https://www.jstatsoft.org/v57/i12/>.

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md)

## Examples

``` r
require(compareGroups)
require(survival)
#> Loading required package: survival

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
#> 
#> 
#> -------- Summary of results by groups of 'Sex'---------
#> 
#> 
#>    var                           N    p.value  method            selection
#> 1  Recruitment year              2294 0.506    categorical       ALL      
#> 2  Age                           2294 0.840    continuous normal ALL      
#> 3  Smoking status                2233 <0.001** categorical       ALL      
#> 4  Systolic blood pressure       2280 <0.001** continuous normal ALL      
#> 5  Diastolic blood pressure      2280 <0.001** continuous normal ALL      
#> 6  History of hypertension       2286 0.644    categorical       ALL      
#> 7  Hypertension treatment        2251 0.096*   categorical       ALL      
#> 8  Total cholesterol             2193 0.140    continuous normal ALL      
#> 9  HDL cholesterol               2225 <0.001** continuous normal ALL      
#> 10 Triglycerides                 2231 <0.001** continuous normal ALL      
#> 11 LDL cholesterol               2126 0.092*   continuous normal ALL      
#> 12 History of hyperchol.         2273 0.308    categorical       ALL      
#> 13 Cholesterol treatment         2239 0.583    categorical       ALL      
#> 14 Height (cm)                   2259 <0.001** continuous normal ALL      
#> 15 Weight (Kg)                   2259 <0.001** continuous normal ALL      
#> 16 Body mass index               2259 0.083*   continuous normal ALL      
#> 17 Physical activity (Kcal/week) 2206 0.368    continuous normal ALL      
#> 18 Physical component            2054 <0.001** continuous normal ALL      
#> 19 Mental component              2054 <0.001** continuous normal ALL      
#> 20 Cardiovascular                2163 0.696    Surv [Tmax=1718]  ALL      
#> 21 Mortality                     2148 0.349    Surv [Tmax=1668]  ALL      
#> -----
#> Signif. codes:  0 '**' 0.05 '*' 0.1 ' ' 1 
#> 

# summary of each variable
summary(res)
#> 
#>  --- Descriptives of each row-variable by groups of 'Sex' ---
#> 
#> ------------------- 
#> row-variable: Recruitment year 
#> 
#>        1995 2000 2005 1995%    2000%    2005%    p.overall
#> [ALL]  431  786  1077 18.78814 34.2633  46.94856          
#> Male   206  390  505  18.71026 35.42234 45.86739 0.505601 
#> Female 225  396  572  18.86002 33.19363 47.94635          
#> 
#>      OR       OR.lower OR.upper
#> 1995 1                         
#> 2000 0.929738 0.734647 1.176216
#> 2005 1.037038 0.828871 1.29712 
#> 
#> ------------------- 
#> row-variable: Age 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2294 54.73627 11.04926 54.28388 55.18866          
#> Male   1101 54.78474 11.08709 54.12912 55.44036 0.840122 
#> Female 1193 54.69153 11.01869 54.06564 55.31743          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 0.999236 0.991855 1.006673
#> 
#> ------------------- 
#> row-variable: Smoking status 
#> 
#>        Never smoker Current or former < 1y Former >= 1y Never smoker%
#> [ALL]  1201         593                    439          53.78415     
#> Male   301          410                    360          28.10458     
#> Female 900          183                    79           77.45267     
#>        Current or former < 1y% Former >= 1y% p.overall
#> [ALL]  26.5562                 19.65965               
#> Male   38.28198                33.61345      0        
#> Female 15.74871                6.798623               
#> 
#>                        OR       OR.lower OR.upper
#> Never smoker           1                         
#> Current or former < 1y 0.149541 0.120045 0.185606
#> Former >= 1y           0.073638 0.055542 0.096605
#> 
#> ------------------- 
#> row-variable: Systolic blood pressure 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2280 131.1741 20.30658 130.3402 132.0081          
#> Male   1098 134.0373 18.94442 132.9156 135.1591 0        
#> Female 1182 128.5144 21.15815 127.307  129.7218          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 0.986453 0.982358 0.990566
#> 
#> ------------------- 
#> row-variable: Diastolic blood pressure 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2280 79.65877 10.54792 79.22558 80.09196          
#> Male   1098 81.65665 10.19543 81.05293 82.26036 0        
#> Female 1182 77.80288 10.53501 77.20168 78.40408          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 0.964698 0.956793 0.972668
#> 
#> ------------------- 
#> row-variable: History of hypertension 
#> 
#>        Yes No   Yes%     No%      p.overall
#> [ALL]  723 1563 31.6273  68.3727           
#> Male   341 755  31.11314 68.88686 0.643853 
#> Female 382 808  32.10084 67.89916          
#> 
#>     OR       OR.lower OR.upper
#> Yes 1                         
#> No  0.955384 0.800588 1.139835
#> 
#> ------------------- 
#> row-variable: Hypertension treatment 
#> 
#>        No   Yes No%      Yes%     p.overall
#> [ALL]  1823 428 80.98623 19.01377          
#> Male   889  189 82.46753 17.53247 0.096278 
#> Female 934  239 79.62489 20.37511          
#> 
#>     OR       OR.lower OR.upper
#> No  1                         
#> Yes 1.203346 0.974043 1.488276
#> 
#> ------------------- 
#> row-variable: Total cholesterol 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2193 218.7577 45.24609 216.8629 220.6524          
#> Male   1054 217.2795 42.74327 214.6961 219.8629 0.139545 
#> Female 1139 220.1255 47.42239 217.3686 222.8825          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 1.001395 0.999537 1.003256
#> 
#> ------------------- 
#> row-variable: HDL cholesterol 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2225 52.6891  14.74849 52.07594 53.30225          
#> Male   1075 47.54918 12.59985 46.79513 48.30323 0        
#> Female 1150 57.4938  14.9937  56.62631 58.36129          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 1.054034 1.04681  1.061308
#> 
#> ------------------- 
#> row-variable: Triglycerides 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2231 115.5843 73.94222 112.5143 118.6542          
#> Male   1075 130.7312 87.37705 125.502  135.9603 0        
#> Female 1156 101.4987 55.17943 98.31448 104.6829          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 0.993127 0.991614 0.994642
#> 
#> ------------------- 
#> row-variable: LDL cholesterol 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2126 143.2467 39.69013 141.5586 144.9348          
#> Male   1010 144.768  38.54902 142.3878 147.1482 0.091849 
#> Female 1116 141.8699 40.66348 139.4816 144.2582          
#> 
#>      OR      OR.lower OR.upper
#> [1,] 0.99816 0.996017 1.000307
#> 
#> ------------------- 
#> row-variable: History of hyperchol. 
#> 
#>        Yes No   Yes%     No%      p.overall
#> [ALL]  709 1564 31.19226 68.80774          
#> Male   353 741  32.26691 67.73309 0.307725 
#> Female 356 823  30.19508 69.80492          
#> 
#>     OR       OR.lower OR.upper
#> Yes 1                         
#> No  1.101251 0.922011 1.31537 
#> 
#> ------------------- 
#> row-variable: Cholesterol treatment 
#> 
#>        No   Yes No%      Yes%     p.overall
#> [ALL]  2011 228 89.81688 10.18312          
#> Male   962  114 89.4052  10.5948  0.582577 
#> Female 1049 114 90.19776 9.802236          
#> 
#>     OR       OR.lower OR.upper
#> No  1                         
#> Yes 0.917111 0.696915 1.206891
#> 
#> ------------------- 
#> row-variable: Height (cm) 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2259 162.9156 9.216404 162.5354 163.2959          
#> Male   1090 169.2727 7.340116 168.8364 169.7089 0        
#> Female 1169 156.9882 6.410992 156.6203 157.3561          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 0.769245 0.753099 0.785738
#> 
#> ------------------- 
#> row-variable: Weight (Kg) 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2259 73.43586 13.67845 72.87149 74.00022          
#> Male   1090 79.71587 11.91404 79.0078  80.42394 0        
#> Female 1169 67.58024 12.57931 66.85839 68.30209          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 0.922374 0.91478  0.93003 
#> 
#> ------------------- 
#> row-variable: Body mass index 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2259 27.64126 4.5557   27.4533  27.82923          
#> Male   1090 27.81147 3.730815 27.58974 28.0332  0.082918 
#> Female 1169 27.48256 5.205095 27.18387 27.78125          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 0.984257 0.966554 1.002284
#> 
#> ------------------- 
#> row-variable: Physical activity (Kcal/week) 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2206 398.8314 388.1642 382.6245 415.0383          
#> Male   1060 406.6184 424.8869 381.011  432.2258 0.368498 
#> Female 1146 391.6288 350.8277 371.2954 411.9621          
#> 
#>      OR     OR.lower OR.upper
#> [1,] 0.9999 0.999685 1.000116
#> 
#> ------------------- 
#> row-variable: Physical component 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2054 49.61986 9.009636 49.23    50.00972          
#> Male   1002 51.04962 8.010419 50.55304 51.54621 0        
#> Female 1052 48.25805 9.676943 47.67262 48.84349          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 0.964926 0.955204 0.974747
#> 
#> ------------------- 
#> row-variable: Mental component 
#> 
#>        N    mean     sd       lower    upper    p.overall
#> [ALL]  2054 47.98318 10.98306 47.50793 48.45844          
#> Male   1002 50.3502  9.906833 49.73605 50.96435 0        
#> Female 1052 45.72867 11.4772  45.03432 46.42301          
#> 
#>      OR       OR.lower OR.upper
#> [1,] 0.960136 0.951932 0.968411
#> 
#> ------------------- 
#> row-variable: Cardiovascular 
#> 
#>        N    inc      lower    upper    p.overall
#> [ALL]  2163 4.491335 3.509831 5.462855          
#> Male   1042 4.462992 3.051264 5.854162 0.696334 
#> Female 1121 4.523978 3.150404 5.878071          
#> 
#>      OR OR.lower OR.upper
#> [1,] .  .        .       
#> 
#> ------------------- 
#> row-variable: Mortality 
#> 
#>        N    inc      lower    upper    p.overall
#> [ALL]  2148 7.599346 6.269    8.910809          
#> Male   1030 8.377363 6.328564 10.38135 0.348953 
#> Female 1118 6.901506 5.161763 8.609335          
#> 
#>      OR OR.lower OR.upper
#> [1,] .  .        .       

# univariate plots of all row-variables
if (FALSE) { # \dontrun{
plot(res)
} # }

# plot of all row-variables by sex
if (FALSE) { # \dontrun{
plot(res, bivar = TRUE)
} # }

# update changing the response: time-to-cardiovascular event.
# note that time-to-death must be removed since it is not possible 
# not compute descriptives of a 'Surv' class object by another 'Surv' class object.

if (FALSE) { # \dontrun{
update(res, tcv ~ . + sex - tdeath - tcv)
} # }
```
