# Perform descriptives and build the bivariate table.

This functions builds a bivariate table calling compareGroups and
createTable function in one step.

## Usage

``` r
descrTable(formula, data, subset, na.action = NULL, y = NULL, Xext = NULL, 
  selec = NA, method = 1, timemax = NA, alpha = 0.05, min.dis = 5, max.ylev = 5, 
  max.xlev = 10, include.label = TRUE, Q1 = 0.25, Q3 = 0.75, simplify = TRUE, 
  ref = 1, ref.no = NA, fact.ratio = 1, ref.y = 1, p.corrected = TRUE, 
  compute.ratio = TRUE, include.miss = FALSE, oddsratio.method = "midp", 
  chisq.test.perm = FALSE, byrow = FALSE, chisq.test.B = 2000, chisq.test.seed = NULL,
  Date.format = "d-mon-Y", var.equal = FALSE, conf.level = 0.95, surv = FALSE,
  riskratio = FALSE, riskratio.method = "wald", compute.prop = FALSE, 
  lab.missing = "'Missing'", p.trend.method = "spearman",
  hide = NA, digits = NA, type = NA, show.p.overall = TRUE,
  show.all, show.p.trend, show.p.mul = FALSE, show.n, show.ratio =
  FALSE, show.descr = TRUE, show.ci = FALSE, hide.no = NA, digits.ratio = NA,
  show.p.ratio = show.ratio, digits.p = 3, sd.type = 1, q.type = c(1, 1),
  extra.labels = NA, all.last = FALSE, lab.ref="Ref.", stars = FALSE)
```

## Arguments

Arguments from
[`compareGroups`](https://isubirana.github.io/compareGroups/index.html/reference/compareGroups.md)
function:

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
  "spearman", "kendall" or "cuzick". Default value is "spearman".

Arguments from
[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md)
function:

- hide:

  a vector (or a list) with integers or characters with as many
  components as row-variables. If its length is 1 it is recycled for all
  row-variables. Each component specifies which category (the literal
  name of the category if it is a character, or the position if it is an
  integer) must be hidden and not shown. This argument only applies to
  categorical row-variables, and for continuous row-variables it is
  ignored. If NA, all categories are displayed. Or a named vector (or a
  named list) specifying which row-variables 'hide' is applied, and for
  the rest of row-variables default value is applied. Default value is
  NA.

- digits:

  an integer vector with as many components as row-variables. If its
  length is 1 it is recycled for all row-variables. Each component
  specifies the number of significant decimals to be displayed. Or a
  named vector specifying which row-variables 'digits' is applied (a
  reserved name is '.else' which defines 'digits' for the rest of the
  variables); if no '.else' variable is defined, default value is
  applied for the rest of the variables. Default value is NA which puts
  the 'appropriate' number of decimals (see vignette for further
  details).

- type:

  an integer that indicates whether absolute and/or relative frequencies
  are displayed: 1 - only relative frequencies; 2 or NA - absolute and
  relative frequencies in brackets; 3 - only absolute frequencies.

- show.p.overall:

  logical indicating whether p-value of overall groups significance
  ('p.overall' column) is displayed or not. Default value is TRUE.

- show.all:

  logical indicating whether the '\[ALL\]' column (all data without
  stratifying by groups) is displayed or not. Default value is FALSE if
  grouping variable is defined, and FALSE if there are no groups.

- show.p.trend:

  logical indicating whether p-trend is displayed or not. It is always
  FALSE when there are less than 3 groups. If this argument is missing,
  there are more than 2 groups and the grouping variable is an ordered
  factor, then p-trend is displayed. By default, p-trend is not
  displayed, and it is displayed when there are more than 2 groups and
  the grouping variable is of class ordered-factor.

- show.p.mul:

  logical indicating whether the pairwise (between groups) comparisons
  p-values are displayed or not. It is always FALSE when there are less
  than 3 groups. Default value is FALSE.

- show.n:

  logical indicating whether number of individuals analyzed for each
  row-variable is displayed or not in the 'descr' table. Default value
  is FALSE and it is TRUE when there are no groups.

- show.ratio:

  logical indicating whether OR / HR is displayed or not. Default value
  is FALSE.

- show.descr:

  logical indicating whether descriptives (i.e. mean, proportions, ...)
  are displayed. Default value is TRUE.

- show.ci:

  logical indicating whether to show confidence intervals of means,
  medians, proporcions or incidences are displayed. If so, they are
  displayed between squared brackets. Default value is FALSE.

- hide.no:

  character specifying the name of the level to be hidden for all
  categorical variables with 2 categories. It is not case-sensitive. The
  result is one row for the variable with only the name displayed and
  not the category. This is especially useful for yes/no variables. It
  is ignored for the categorical row-variables with 'hide' argument
  different from NA. Default value is NA which means that no category is
  hidden.

- digits.ratio:

  The same as 'digits' argument but applied for the Hazard Ratio or Odds
  Ratio.

- show.p.ratio:

  logical indicating whether p-values corresponding to each Hazard Ratio
  / Odds Ratio are shown.

- digits.p:

  integer indicating the number of decimals displayed for all p-values.
  Default value is 3.

- sd.type:

  an integer that indicates how standard deviation is shown: 1 - mean
  (SD), 2 - mean ? SD.

- q.type:

  a vector with two integer components. The first component refers to
  the type of brackets to be displayed for non-normal row-variables (1 -
  squared and 2 - rounded), while the second refers to the percentile
  separator (1 - ';', 2 - ',' and 3 - '-'. Default value is c(1, 1).

- extra.labels:

  character vector of 4 components corresponding to key legend to be
  appended to normal, non-normal, categorical or survival row-variables
  labels. Default value is NA which appends no extra key. If it is set
  to `c("","","","")`, "Mean (SD)", "Median \[25th; 75th\]", "N (%)" and
  "Incidence at time=timemax" are appended (see argument `timemax` from
  `compareGroups` function.

- all.last:

  logical. Descriptives of the whole sample is placed after the
  descriptives by groups. Default value is FALSE which places the
  descriptives of whole cohort at first.

- lab.ref:

  character. String shown for reference category. "Ref." as default
  value.

- stars:

  logical, indicating whether to append stars beside p-values; '\*\*':
  p-value \< 0.05, '\*' 0.05 \<= p-value \< 0.1; ” p-value \>=0.1.
  Default value is FALSE

## Value

An object of class 'createTable' (see
[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md)).

So, all methods implemented for createTable class objects can be applied
(such as plot, '\[', etc.).

## Note

The use of descrTable function makes easier to build the table (it only
needs one line), it may be preferable to build the descriptive table in
two steps when computing descriptives and p-values takes some time:
first use `compareGroups` function to store the descriptives and
p-values in an object, and then apply `createTable` to the this object.
The two steps strategy saves time since descriptives and p-values are
not recomputed every time it is desired to costumize the descriptive
table (number of digits, etc.).

## References

Isaac Subirana, Hector Sanz, Joan Vila (2014). Building Bivariate
Tables: The compareGroups Package for R. Journal of Statistical
Software, 57(12), 1-16. URL <https://www.jstatsoft.org/v57/i12/>.

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md),
[`compareGroups`](https://isubirana.github.io/compareGroups/index.html/reference/compareGroups.md),
[`export2latex`](https://isubirana.github.io/compareGroups/index.html/reference/export2latex.md),
[`export2csv`](https://isubirana.github.io/compareGroups/index.html/reference/export2csv.md),
[`export2html`](https://isubirana.github.io/compareGroups/index.html/reference/export2html.md)

## Examples

``` r
require(compareGroups)

# load REGICOR data
data(regicor)

# perform descriptives by year and build the table.
# note the use of arguments from compareGroups (formula and data set) and
# arguments from createTable (hide.no and show.p.mul)
descrTable(year ~ ., regicor, hide.no="no", show.p.mul=TRUE)
#> 
#> --------Summary descriptives table by 'Recruitment year'---------
#> 
#> _______________________________________________________________________________________________________________________________________________________ 
#>                                                        1995              2000           2005     p.overall p.1995 vs 2000 p.1995 vs 2005 p.2000 vs 2005 
#>                                                        N=431             N=786         N=1077                                                           
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
#> Individual id                                    1000002914 (1242) 3000104610 (2379) 1996 (1161)   0.000       0.000          0.000          0.000      
#> Age                                                 54.1 (11.7)       54.3 (11.2)    55.3 (10.6)   0.079       0.936          0.163          0.158      
#> Sex:                                                                                               0.506       0.794          0.794          0.792      
#>     Male                                            206 (47.8%)       390 (49.6%)    505 (46.9%)                                                        
#>     Female                                          225 (52.2%)       396 (50.4%)    572 (53.1%)                                                        
#> Smoking status:                                                                                   <0.001       <0.001         <0.001         <0.001     
#>     Never smoker                                    234 (56.4%)       414 (54.6%)    553 (52.2%)                                                        
#>     Current or former < 1y                          109 (26.3%)       267 (35.2%)    217 (20.5%)                                                        
#>     Former >= 1y                                    72 (17.3%)        77 (10.2%)     290 (27.4%)                                                        
#> Systolic blood pressure                             133 (19.2)        133 (21.3)     129 (19.8)   <0.001       0.932          0.007          <0.001     
#> Diastolic blood pressure                            77.0 (10.5)       80.8 (10.3)    79.9 (10.6)  <0.001       <0.001         <0.001         0.146      
#> History of hypertension                             111 (25.8%)       233 (29.6%)    379 (35.5%)  <0.001       0.169          0.001          0.015      
#> Hypertension treatment                              71 (16.5%)        127 (16.2%)    230 (22.2%)   0.002       0.951          0.023          0.004      
#> Total cholesterol                                   225 (43.1)        224 (44.4)     213 (45.9)   <0.001       0.816          <0.001         <0.001     
#> HDL cholesterol                                     51.9 (14.5)       52.3 (15.6)    53.2 (14.2)   0.198       0.865          0.236          0.424      
#> Triglycerides                                       114 (74.4)        114 (70.7)     117 (76.0)    0.583       0.999          0.755          0.603      
#> LDL cholesterol                                     152 (38.4)        149 (38.6)     136 (39.7)   <0.001       0.510          0.000          <0.001     
#> History of hyperchol.                               97 (22.5%)        256 (33.2%)    356 (33.2%)  <0.001       <0.001         <0.001         1.000      
#> Cholesterol treatment                               28 (6.50%)        68 (8.80%)     132 (12.8%)  <0.001       0.193          0.002          0.015      
#> Height (cm)                                         163 (9.21)        162 (9.39)     163 (9.05)    0.004       0.022          0.955          0.006      
#> Weight (Kg)                                         72.3 (12.6)       73.8 (14.0)    73.6 (13.9)   0.120       0.124          0.188          0.926      
#> Body mass index                                     27.0 (4.15)       28.1 (4.62)    27.6 (4.63)  <0.001       <0.001         0.080          0.036      
#> Physical activity (Kcal/week)                        491 (419)         422 (377)      351 (378)   <0.001       0.021          <0.001         <0.001     
#> Physical component                                  49.3 (8.08)       49.0 (9.63)    50.1 (8.91)   0.037       0.829          0.226          0.041      
#> Mental component                                    49.2 (11.3)       48.9 (11.0)    46.9 (10.8)  <0.001       0.877          0.001          0.001      
#> Cardiovascular event                                10 (2.51%)        35 (4.72%)     47 (4.59%)    0.161       0.151          0.151          0.986      
#> Days to cardiovascular event or end of follow-up    1784 (1101)       1686 (1080)    1793 (1072)   0.099       0.320          0.987          0.095      
#> Overall death                                       18 (4.65%)        81 (11.0%)     74 (7.23%)   <0.001       0.002          0.103          0.012      
#> Days to overall death or end of follow-up           1713 (1042)       1674 (1050)    1758 (1055)   0.254       0.823          0.752          0.225      
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
```
