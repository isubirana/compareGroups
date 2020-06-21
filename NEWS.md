# compareGroups 4.4.3
MAJOR
- WUI (cGroupsWUI) renewed based on shinydashboardPlus layout and more options.
MINOR
- wrong description of file argument from export2xls function fixed.
- bug fixed in getResults(, "ratio") when only one variable is described.
- bug fixed in xlab and ylab in box.plot internal function.
- new component in 'extra.labels' argument from 'createTable' function to append label for surv variables.
- shinydashboardPlus package added to suggested

# compareGroups 4.4.2
- bug fixed when exporting tables to PDF in cGroupsWUI()

# compareGroups 4.4.1
- bug fixed in internal function compare.i when computing binom.test with zero freqs.
- confinterval function to compute confidence interval of means and medians return NA and not error when it cannot compute IC for medians.
- conf.level (confidence level) argument in compareGroups and descrTable function also applies to hazard, odds and risk ratios.
- epitools package removed from importFrom (NAMESPACE)
- functions qnorm, rbinom and uniroot functions from stats package added in importFrom

# compareGroups 4.4.0
- compareGroups, descrTable: new argument 'compute.prop' added (to compute proportions instead of percentages for categorical row-variables).
- createTable, descrTable: new argument 'all.last' added (to place descriptives of the whole sample after descriptives by groups).

# compareGroups 4.3.1
- compareGroups.Rd: p.trend for categorical variables modified.
- export2word: new arguments added (same as export2md).
- export2md: longtable fixed.
- bug fixed in internal table.i function when identifying reference category when NA.
- bug fixed in cGroupsGUI: updated to new updates of compareGroups.fit function.
- export2pdf: new arguments incorportated and makes use of export2md function.

# compareGroups 4.3.0
- export2word supports stratified tables
- Risk Ratios are now computed. See `riskratio` argument from `compareGroups` function.

# compareGroups 4.2.0
- flextable package dependency
- export2md supports tables to export to word in nicer format using flextable
- export2md supports stratified tables when exporting to word (new export2mdwordcbind internal function)
- new argument perc in report function (same as plot)
- export2word bug fixed

# compareGroups 4.1.1
- bug fixed in export2md when exportd in a Rmd notebook.
- norm.plot: par(mfrow=c(1,1)) added at the end, to restore mutiplots device.
- export2md: more understandable warning message when used outside the Rmarkdown chunk.

# compareGroups 4.1.0

- new argument show.ci and conf.level in createTable and compareGroups, respectively, to compute confidence intervals of means, medians, proportions and incidences.
- new argument "position" to export2md function, to place tables justified to the left, centerd or to the right (only when compiling to HTML or PDF)
- no longer Hmisc, xtable, gdata package dependies. Imports write_xlsx from writexl and suggests readxl packages.
- xlsx removed from suggested packages.
- export2xls uses write_xlsx function from writexl pacakge.
- cGroupsWUI improved and updated.
- shinythemes package suggested. This saves a lot of space in app folder.
- shinyWidgets package suggested (for awasome dropdownbuttons and colour picker in the shiny app)
- export2md, export2mdcbind: bug fixed when drawing header line and no Nmax is reported.
- labelled class from "predimed", "regicor" variables removed.
- byrow add a choice to compute proportions by combinations of rows and columns (i.e. to sum up 100%).

**MINOR**
- bug fixed in compareGroups.R when using "select" argument.
- compare.i function: bug fixed when "include.miss".
- bug fixed when variable names contains spaces.
- "..." argument removed from export2word.
- internal function simplify.formula removed.

# compareGroups 4.0.0

- new argument var.equal to compareGroups and descrTable.
- update.compareGroups: changed.
- dates variables supported
- compareGroups.default and compareGroups.formula unified in a single compareGroups function.
- new strataTable function: to create stratified tables without having to use cbind. Also incorporates an update method.
- package vignette improved.
- new descrTable created. This function builds a descriptive table in one step.
- Imports: kableExtra and chron added,  
- Suggested: car removed
- export2md: new arguments added (format, width, strip, first.strip, background, size and landscape)
- compareGroups: new arguments added (chisq.test.B and chisq.test.seed)
- table.i, createTable: checking OS to print +/- sign removed from table.i and passed to createTable. This speeds up the bivariate construction a lot.
- compareGroups.default: '...' argument removed.

# compareGroups 3.4.0

- compareGroups now handles tibble objects

# compareGroups 3.3.4

- bug fixed when checking vignette
v3.3.3
- bug fixed for Hmisc::label in examples and vignette

# compareGroups 3.3.2

- createTable: bug fixed related to hide.no
v3.3.1
- createTable: bug fixed related to extra.labels argument
v3.3
- createTable: new "extra.labels" argument indicating the key to normal, non-normal or categorical variables.
- compareGroups: new "byrow" argument to report percentages by rows or by columns.
v3.2.5
- export2md, export2html: Var removed from descriptive table header.
v3.2.4
- compareGroups.default: new argument chisq.test.perm to perform simulation chisq test instead of fisher test
v3.2.3
- export2word: changed working directory
v3.2.2
- plot do not open new windows when file argument is NULL.
- new argument "verbose" set to FALSE by default in "compareSNPs"
- new component in header.labels argument to modify OR/HR bivariate table column label.
- bug fixed in getResults function when exctracting proportions.  
v3.2.1
- package vignette updated.
- new argument "oddsratio.method" in "compareGroups.default" function to compute odds ratio under different methods.
- XLConnect and shinythemes removed from suggested packages.
v3.2
- cGroupsWUI: improved.
- Internal function descripSurv has been modified fixing a bug when computing K-M probabilities.
- xlsx not imported but suggested. Only required when calling export2xls function.

# compareGroups 3.1

- cGroupsWUI: improved shiny app interface.
- export2word: new function to export tables to Word.
- export2md: new function to export tables to Markdown.
- export2html: file argument can be left missing to return HTML code, similar to export2latex.

# compareGroups 3.0.1

- cGroupsWUI: udpates and improvements in the aspect of the GUI web based application.

# compareGroups 3.0

2015-01-14
- new argument header.labels incorporated to functions to print and export the bivariate table. This offers the possibility to change some 'key' labels such as p.overall or p.trend.
- new function getResults to retrieve results from compareGroups or createTable object as vectors and matrices.
- new argument 'margin' implemented in 'export2pdf' function.

**MAJOR CHANGES:**

- new function cGroupsWUI has been implemented which opens a web browser with a Web User Interface using Shiny functions.
- new vignette compareGroupsWUI_vignette.pdf created to illustrate how WUI works.

**MINOR CHANGES:**

- 'file' argument from export2csv, export2latex, export2html, export2pdf and report functions must specify the extension. This has been changed from previous versions where no extension (.pdf, .tex, .html or .pdf) was required.
- fixed: 'hide' argument from createTable does not produce an error but a warning when a non-existing variable is specified.
- fixed: indentation when exporting a rbind.createTable object to HTML
- SNPs data removed.

# compareGroups 2.0.5

2014-8-25

- Bug fixed regarding number of decimals when applying subsetting '[' method to createTable, rbind.createTable and cbind.createTable class objects.

# compareGroups 2.0.4

2014-05-02

- JSS paper citation included, in compareGroups.Rd and in createTable.Rd help files.

# compareGroups 2.0.3

2014-04-29

- high line and +/- symbol when printint table on R console replaced by standard C-locale if necessary.

# compareGroups 2.0.2

2014-03-26

- fixed: +/- symbol

# compareGroups 2.0.1

2014-03-17

- check package: Sweave.sty removed from vignette folder.
- integerToAscii replaced by intToUtf8 function.
- internal functions 'snp.R', 'SNPHWE.R', 'sortSNPs.R', etc. removed since SNPassoc package has been incorporated in depends list.

# compareGroups 2.0

2013-08-02

- new argument 'type' in 'plot.compareGroups' method to save plots in different formats.
- new argument 'include.miss' in compareGroups function. This treats NA values as a new category for categorical row-variables.
- new function 'radiograph' that reports raw data in the data set.
- new function 'missTable' has been created, to report missingness tables.
- new function 'compareSNPs' has been created, with its own 'print' method.
- new functions 'report' and 'export2pdf' have been created to generate PDF files with tables and/or plots.
- new argumen 'landscape' has been incorporated to 'export2latex' function.
- new package dependencies required: SNPassoc and HardyWeinberg

**MINOR CHANGES:**

- when computing p-values to compare groups for a categorical row-variables, if only one row or one column has some non-zero count, p-value is '.'.
- cGroupsGUI no longer saves objects in .GlobalEnv but uses .compareGroupsEnv environment.
- cGroupsGUI input cannot be left missing.
- bug fixed in cGroupsGUI function when exporting to html format.
- internal function prepare has been modified in order to fit the bivariate table columns to their width.
- internal function descripSurv has been modified to accomodate group codes containing regular expression symbols (such as +, -, etc.).
- bug fixed in export2html function when exporting a table with one row.
- bug fixed in 'ref.no' argument of compareGroups function.	

# compareGroups 1.4

2012-11-06

- an internal bug fixed when specifying selec for a particular row-varible in building Xlong attribute for compareGroups object.
- cGroupsGUI: improved, more compact.

# compareGroups 1.3

2012-07-19

- createTable objects can be plotted and it is also possible to apply varinfo function on them.
- cGroupsGUI: new smaller frame.
- createTable: new argument q.type, to specify how the quartiles (percentiles) are displayed for a non-normal distributed row-variable.
- createTable: new argument sd.type, to allow the user change the format in displaying SD; 1-inside brackets (default), 2- mean +/- SD.
- createTable: new argument digits.p added, to allow the user specify the number of decimals for all p-values displayed on the bivariate table.
- createTable: new argument p.ratio has been added. This computes de p-value corresponding to each OR/HR individually.
- Nmax reported changed: now it represents the number of patients with at least one valid value across all analized variables.
- a bug fixed in compareGroup: when some row-variable could not be performed 'varnames.orig' attribute was bad built. This affected other functions such as createTable.
- a bug fixed in [.createTable: an error ocurred when a literal category specified to be hiden when subsetting a createTable object.
- MINOR CHANGE: 1.95 replaced by 1.96 in 'compareGroups.Rd' file.

# compareGroups 1.2

2012-07-10

- export2html: a bug fixed in N.
- repeated row-variables are kept after applying the generic function 'update'. This was not possible in the previous version 1.1.
- new internal function 'simplify.formula' added.

# compareGroups 1.1 

2012-05-13

- [.compareGroups: a bug fixed when a row-variable present multiple times.
- compareGroups: new argument 'compute.ratio'.
- compareGroups: default value for argument 'simplify' changed to TRUE.
- load tcltk only when cGroupsGUI is called.
- bug fixed in export2latex.cbind.createTable when drawing hlines.
- export2latex: apostrophes have been changed from '' to `' in writing default table caption.

# compareGroups 1.0

2011-11-29

**MAIN CHANGES**

- new method '[' implemented for createTable objects.
- new method rbind implemented for compareGroups and createGroups objects.
- new method cbind implemented for createTable objects.
- new method summary implemented for createTable objects.
- createTable: new value for type (3) displays only absolute frequencies for categorical variables.
- export2latex.createTable, export2latex.cbind.createTable: new argument 'label' implemented to put a label for each table to be cited in the main LaTeX document.
- chisq.test2: computes simulated p-values for the chi-squared test when it is not possible to compute assymptotic nor exact fisher test. 
- compareGroups: new argument 'p.mult.corrected' added that gives the option of computing multiple comparison corrected p-values or non-corrected p-values.
- regicor: some variables names have been changed (gender to sex, histbp to histhtn).
- example data sets: 'myData' example data set has been removed and 'regicor' data set is used in the examples instead.


# compareGroups 0.1-6

2010-03-25

**MAIN CHANGES**

- compareGroups: can deal with Surv objects as response variables in order to compute appropiate p-values for a cohort (time-to-response) studies.
- plot.compareGroups: perform appropiate plots when response is of class 'Surv' (kaplan-meier, etc.)
- export2html: new function created to export tables to HTML format
- plot.compareGroups: new internal functions created to draw proper plots for survival class variables	
- createTable: new argument 'show.p.overall'.
- createTable: change default value for 'show.p.all' argument to FALSE.
- export2csv and export2html: new argument created which is the same as 'which.table' in 'export2latex' function
- plot.compareGroups: bug fixed in performing shapiro-Wilks test on >5000 size sample.
- export2latex: new arguments 'caption' and 'loc.caption' added.
- argument silent set to TRUE in all functions where try have been applied.


# compareGroups 0.1-5

2010-08-20

- print.createTable: lines in header and botoom of the tables are printed, using some characters from integer2ascii function of oce package.
- print.createTable, export2latex, export2csv: new argument 'nmax' added.
- export2latex: environment longtable is used, instead of table.
- compareGroups: new argument 'simplify' added.
- MAIN change: it is possible not to specify any grouping variable, and descriptives for all sample are performed without p-values.
- print.createTable, export2latex, export2csv: bug fixed when row-variables with no data present.
- plot.compareGroups method now plots barplots for categorical variable, as well as bivariate plots (row-variables vs grouping variable).
- [.summary.compareGroups method deleted and new [.compareGroups method created instead.
- export2csv: now writes the N (sample size) for each group in the header line.
- createTable: argument 'hide' changed, now the user can specify either the position of the cateogory to be hidden or the name of this category.
- createTable: new argument 'hide.no' added, that allows the user to specify which category to be hidden for all 2-level row-variables.
- createTable: bug fixed, when only 1 row-variable and show.all=FALSE.
- print.createTable changed: 'which.table' argument added that specifyies which table is printed (descr, avail or both). By default, only 'descr' table is printed.
- export2latex: 'which.table' argument added add an argument that specifyies which table is printed (descr, avail or both). By default, only 'descr' table is printed.
- export2latex: 'file' argument can be missing. In this case, LaTex code is printed in the R console. This function returns the LaTeX code like print.xtable does. 
- export2latex: 'size' argument added.
- compareGroups.formula: bug fixed in removing variables using '-'.
- compare.i: bug fixed in p-value for multiple comparison for a normal row-variable.
- createTable: automatacally detects if grouping variable is an ordered factor to display p-trend.

# compareGroups 0.1-4

2010-07-30

- print.compareGroups: fix a bug, significant p-values codes 0.01 has been replaced by 0.1 
- export2latex: substitute some special character ($, <, >, >=, <=, &, ...) in the grouping variable label, and '&' for row-variables and group levels.
- compareGroups.default: added an option to specify different quantiles from Q1 and Q3  (min and max for example) for non-normal variables.
- [.summary.compareGroups method

# compareGroups 0.1-3

2010-07-27

- fixed a bug in 'print.createTable', 'export2csv' and 'export2latex' functions when there is only one row-variable

# compareGroups 0.1-2

2010-07-27

- MAIN CHANGE: submitted to CRAN.
- package no more available in www.regicor.org

# compareGroups 0.1-1

2010-07-26

- fixed a bug in 'print.createTable', 'export2csv' and 'export2latex' functions when there is only one group
- some words changed in help documentation

# compareGroups 0.1-0

2010-06-22

- 'compareGroups' created and uploaded in www.regicor.org