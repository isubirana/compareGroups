# compareGroups <img src="man/figures/logo.png" align="right" style="margin-top:30px" width="80px"/>

***package to create descriptive tables***

[![CRAN
version](http://www.r-pkg.org/badges/version/compareGroups)](http://cran.r-project.org/package=compareGroups)
![](http://cranlogs.r-pkg.org/badges/grand-total/compareGroups)
![](http://cranlogs.r-pkg.org/badges/last-month/compareGroups)

-   [Overview](#overview)
-   [News](#news)
-   [Package installation](#package-installation)
-   [Costumizing the table](#costumizing-the-table)
-   [Visual exploration](#visual-exploration)
-   [Exporting the table](#exporting-the-table)
-   [Stratified tables](#stratified-tables)
-   [Odds Ratios and Hazard Ratios](#odds-ratios-and-hazard-ratios)
-   [Web-based User Interface](#web-based-user-interface)
-   [Citation](#citation)

## Overview

**compareGroups** is an R package available on CRAN which performs
descriptive tables displaying means, standard deviation, quantiles or
frequencies of several variables. Also, p-value to test equality between
groups is computed using the appropiate test. <br>

With a very simple code, nice, compact and ready-to-publish descriptives
table are displayed on R console. They can also be exported to different
formats, such as Word, Excel, PDF or inserted in a R-Sweave or
R-markdown document.<br>

You will find an extensive manual describing all **compareGropus**
capabilities with real examples in the
[vignette](http://htmlpreview.github.io/?https://github.com/isubirana/compareGroups/blob/master/compareGroups_vignette.html).<br>

Also, **compareGroups** package has been published in Journal of
Statistical Software \[Subirana et al, 2014
[http://www.jstatsoft.org/v57/i12/.](https://www.jstatsoft.org/v57/i12/.)\].

## News

***Version 4.1***

-   Compute confidence intervals of means, medians, proporcions or
    incidences

-   Proportions can be computed by rows as well as by columns, or by
    combinations of rows and columns (i.e. to sum up 100%).

-   New argument “position” to place tables justified to the left,
    centered or to the right using Rmarkdown.

-   When exporting tables to Excel, `export2xls` no longer uses `xlsx`
    package and uses `write_xlsx` function from writexl pacakge,
    instead.

-   The web-based user interface , `cGroupsWUI()`, has been improved and
    updated.

***Version 4.0***

-   New argument `var.equal` to consider unequal variances when
    performing ANOVA tests.

-   Date variables are supported.

-   New **`strataTable`** function: to create stratified tables without
    having to use cbind.

-   package vignette improved.

-   New **`descrTable`** function that builds a descriptive table in one
    step.

-   New options added in `export2md`, to export tables in nicer format.

-   New options added in `compareGroups` to control permutated
    chisquared test.

## Package installation

Install the **`compareGroups`** package from CRAN and then load it by
typing:

    install.packages("compareGroups")

or from github to get the latest version

    library(devtools)
    devtools::install_github(repo = "isubirana/compareGroups")

## Costumizing the table

In the following table, some variables from the REGICOR (“Registre
Gironí del Cor”) project ([www.regicor.cat](https://www.regicor.cat))
data set available in the package are analysed. We illustrate the syntax
of **`compareGroups`** functions to display tables containing
descriptives or possible tests to compare groups.

Following, to describe all the variables of the data set just type:

    library(compareGroups) # load compareGroups package
    data(regicor) # load example data
    descrTable(regicor)


    --------Summary descriptives table ---------

    _____________________________________________________________________________ 
                                                              [ALL]           N   
                                                             N=2294               
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
    Individual id                                    1215817624 (1339538686) 2294 
    Recruitment year:                                                        2294 
        1995                                               431 (18.8%)            
        2000                                               786 (34.3%)            
        2005                                              1077 (46.9%)            
    Age                                                    54.7 (11.0)       2294 
    Sex:                                                                     2294 
        Male                                              1101 (48.0%)            
        Female                                            1193 (52.0%)            
    Smoking status:                                                          2233 
        Never smoker                                      1201 (53.8%)            
        Current or former < 1y                             593 (26.6%)            
        Former >= 1y                                       439 (19.7%)            
    Systolic blood pressure                                131 (20.3)        2280 
    Diastolic blood pressure                               79.7 (10.5)       2280 
    History of hypertension:                                                 2286 
        Yes                                                723 (31.6%)            
        No                                                1563 (68.4%)            
    Hypertension treatment:                                                  2251 
        No                                                1823 (81.0%)            
        Yes                                                428 (19.0%)            
    Total cholesterol                                      219 (45.2)        2193 
    HDL cholesterol                                        52.7 (14.7)       2225 
    Triglycerides                                          116 (73.9)        2231 
    LDL cholesterol                                        143 (39.7)        2126 
    History of hyperchol.:                                                   2273 
        Yes                                                709 (31.2%)            
        No                                                1564 (68.8%)            
    Cholesterol treatment:                                                   2239 
        No                                                2011 (89.8%)            
        Yes                                                228 (10.2%)            
    Height (cm)                                            163 (9.22)        2259 
    Weight (Kg)                                            73.4 (13.7)       2259 
    Body mass index                                        27.6 (4.56)       2259 
    Physical activity (Kcal/week)                           399 (388)        2206 
    Physical component                                     49.6 (9.01)       2054 
    Mental component                                       48.0 (11.0)       2054 
    Cardiovascular event:                                                    2163 
        No                                                2071 (95.7%)            
        Yes                                                92 (4.25%)             
    Days to cardiovascular event or end of follow-up       1755 (1081)       2163 
    Overall death:                                                           2148 
        No                                                1975 (91.9%)            
        Yes                                                173 (8.05%)            
    Days to overall death or end of follow-up              1721 (1051)       2148 
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 

**Example**

In the following table, variables are described by year of recruitment.
Some variables such as tryglicerides (`triglyc`), physical activity
(`phyact`), days to cardiovascular event (`tocv`) or days to death
(`todeath`) have been treated as non-normal distributed, and medians and
quantiles within square brackets instead of means and standard
deviations within round brackets are displayed. Also, individuals older
than 55 years old are selected. Appropiate tests to compare means,
medians or proportions are performed. For those binary variables of type
“yes/no”, you may desire to show only the proportion of “yes” category
without showing “yes” but only the variable name or label. For example,
for “Cholesterol treatment” you may want to see simply “Cholesterol
treatment” instead of “Cholesterol treatment: yes”. This is possible by
`hide.no` argument. Finally, patient id (`id`) has been removed using
`-` from the formula environment.

Note the simplicity of the syntax. Also, note the use of `formula` to
select the variables, and the use of `subset` to filter some individuals
as usual in many other R funcions.

    tab <- descrTable(year ~ . - id, regicor, hide.no="no", method=c(triglyc=2, tocv=2, todeath=2), 
                      subset=age>55)
    tab


    --------Summary descriptives table by 'year'---------

    __________________________________________________________________________________________________________ 
                                                          1995            2000            2005       p.overall 
                                                          N=203           N=365           N=540                
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
    Age                                                65.0 (5.41)     64.7 (5.48)     64.3 (5.57)     0.235   
    Sex:                                                                                               0.613   
        Male                                           94 (46.3%)      181 (49.6%)     251 (46.5%)             
        Female                                         109 (53.7%)     184 (50.4%)     289 (53.5%)             
    Smoking status:                                                                                   <0.001   
        Never smoker                                   127 (64.1%)     220 (63.2%)     326 (61.6%)             
        Current or former < 1y                         29 (14.6%)      84 (24.1%)      71 (13.4%)              
        Former >= 1y                                   42 (21.2%)      44 (12.6%)      132 (25.0%)             
    Systolic blood pressure                            142 (18.3)      144 (20.0)      137 (20.0)     <0.001   
    Diastolic blood pressure                           79.5 (9.88)     83.5 (9.93)     81.2 (10.6)    <0.001   
    History of hypertension                            80 (39.4%)      151 (41.4%)     274 (51.0%)     0.002   
    Hypertension treatment                             57 (28.1%)      101 (27.7%)     198 (38.1%)     0.002   
    Total cholesterol                                  229 (41.8)      228 (44.4)      217 (44.3)     <0.001   
    HDL cholesterol                                    52.4 (14.5)     52.2 (15.3)     53.5 (14.2)     0.403   
    Triglycerides                                    99.0 [77.0;137] 107 [82.0;136]  104 [77.0;142]    0.491   
    LDL cholesterol                                    154 (37.5)      153 (38.3)      139 (39.6)     <0.001   
    History of hyperchol.                              52 (25.6%)      150 (42.3%)     219 (40.7%)    <0.001   
    Cholesterol treatment                              22 (10.8%)      55 (15.4%)      111 (21.3%)     0.002   
    Height (cm)                                        162 (8.72)      160 (8.98)      161 (8.54)      0.002   
    Weight (Kg)                                        73.1 (11.8)     75.2 (12.9)     74.1 (12.4)     0.157   
    Body mass index                                    28.0 (4.40)     29.5 (4.21)     28.4 (4.39)    <0.001   
    Physical activity (Kcal/week)                       491 (380)       429 (317)       373 (370)     <0.001   
    Physical component                                 46.9 (8.95)     45.7 (10.8)     47.6 (9.70)     0.031   
    Mental component                                   49.2 (11.6)     49.8 (11.0)     47.6 (10.9)     0.016   
    Cardiovascular event                                6 (3.23%)      21 (6.10%)      28 (5.44%)      0.356   
    Days to cardiovascular event or end of follow-up 1710 [804;2769] 1577 [640;2564] 1752 [824;2739]   0.137   
    Overall death                                      13 (7.03%)      61 (17.9%)      46 (8.91%)     <0.001   
    Days to overall death or end of follow-up        1620 [808;2631] 1483 [732;2323] 1751 [782;2640]   0.106   
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 

Also, number of decimals and much more options can be changed to
costumize the table as desired (see the [package
manual](https://CRAN.R-project.org/package=compareGroups))

## Visual exploration

With **`compareGroups`** it is also possible to visualize the
distribution of analysed variables. This can be done by the `plot`
function applied on the table:

    plot(tab["sex"]) # barplot
    plot(tab["age"]) # histogram and normality plot

<table>
<colgroup>
<col style="width: 49%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: center;"><img
src="./man/figures/var1sex.png" /></td>
<td style="text-align: center;"><img
src="./man/figures/var1age.png" /></td>
</tr>
</tbody>
</table>

## Exporting the table

Once the table is created, it can be printed on the R console in a nice
and compact format, or it can be exported to different formats, such as
PDF, Excel, Word or LaTex code.

    export2pdf(tab, file = "example.pdf")
    export2xls(tab, file = "example.xlsx")
    export2word(tab, file = "example.docx")
    export2latex(tab, file = "example.tex")

This is how the table looks like in PDF:

![](./man/figures/examplePDF.png)

Also, by using `export2md` function a descriptive table can be inserted
in a Rmarkdown chunk to be compiled in HTML, PDF or Word report. Here
there is an example of a Rmarkdown compiled to HTML.

    export2md(tab, strip = TRUE, first = TRUE, 
              header.background = "blue", header.color = "white", 
              caption = "Description of variables by recruitment year",
              size=10)

<table class="table table-condensed" style="font-size: 10px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
Description of variables by recruitment year
</caption>
<thead>
<tr>
<th style="text-align:left;color: white !important;background-color: blue !important;">
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
1995
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
2000
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
2005
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
p.overall
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=203
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=365
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=540
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Age
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
65.0 (5.41)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
64.7 (5.48)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
64.3 (5.57)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.235
</td>
</tr>
<tr>
<td style="text-align:left;">
Sex:
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
0.613
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Male
</td>
<td style="text-align:center;">
94 (46.3%)
</td>
<td style="text-align:center;">
181 (49.6%)
</td>
<td style="text-align:center;">
251 (46.5%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Female
</td>
<td style="text-align:center;">
109 (53.7%)
</td>
<td style="text-align:center;">
184 (50.4%)
</td>
<td style="text-align:center;">
289 (53.5%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Smoking status:
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;background-color: #D2D2D2 !important;" indentlevel="1">
Never smoker
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
127 (64.1%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
220 (63.2%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
326 (61.6%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;background-color: #D2D2D2 !important;" indentlevel="1">
Current or former &lt; 1y
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
29 (14.6%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
84 (24.1%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
71 (13.4%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;background-color: #D2D2D2 !important;" indentlevel="1">
Former &gt;= 1y
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
42 (21.2%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
44 (12.6%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
132 (25.0%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Systolic blood pressure
</td>
<td style="text-align:center;">
142 (18.3)
</td>
<td style="text-align:center;">
144 (20.0)
</td>
<td style="text-align:center;">
137 (20.0)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Diastolic blood pressure
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
79.5 (9.88)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
83.5 (9.93)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
81.2 (10.6)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
History of hypertension
</td>
<td style="text-align:center;">
80 (39.4%)
</td>
<td style="text-align:center;">
151 (41.4%)
</td>
<td style="text-align:center;">
274 (51.0%)
</td>
<td style="text-align:center;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Hypertension treatment
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
57 (28.1%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
101 (27.7%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
198 (38.1%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;">
Total cholesterol
</td>
<td style="text-align:center;">
229 (41.8)
</td>
<td style="text-align:center;">
228 (44.4)
</td>
<td style="text-align:center;">
217 (44.3)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
HDL cholesterol
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
52.4 (14.5)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
52.2 (15.3)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
53.5 (14.2)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.403
</td>
</tr>
<tr>
<td style="text-align:left;">
Triglycerides
</td>
<td style="text-align:center;">
99.0 \[77.0;137\]
</td>
<td style="text-align:center;">
107 \[82.0;136\]
</td>
<td style="text-align:center;">
104 \[77.0;142\]
</td>
<td style="text-align:center;">
0.491
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
LDL cholesterol
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
154 (37.5)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
153 (38.3)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
139 (39.6)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
History of hyperchol.
</td>
<td style="text-align:center;">
52 (25.6%)
</td>
<td style="text-align:center;">
150 (42.3%)
</td>
<td style="text-align:center;">
219 (40.7%)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Cholesterol treatment
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
22 (10.8%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
55 (15.4%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
111 (21.3%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;">
Height (cm)
</td>
<td style="text-align:center;">
162 (8.72)
</td>
<td style="text-align:center;">
160 (8.98)
</td>
<td style="text-align:center;">
161 (8.54)
</td>
<td style="text-align:center;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Weight (Kg)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
73.1 (11.8)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
75.2 (12.9)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
74.1 (12.4)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.157
</td>
</tr>
<tr>
<td style="text-align:left;">
Body mass index
</td>
<td style="text-align:center;">
28.0 (4.40)
</td>
<td style="text-align:center;">
29.5 (4.21)
</td>
<td style="text-align:center;">
28.4 (4.39)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Physical activity (Kcal/week)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
491 (380)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
429 (317)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
373 (370)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Physical component
</td>
<td style="text-align:center;">
46.9 (8.95)
</td>
<td style="text-align:center;">
45.7 (10.8)
</td>
<td style="text-align:center;">
47.6 (9.70)
</td>
<td style="text-align:center;">
0.031
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Mental component
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
49.2 (11.6)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
49.8 (11.0)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
47.6 (10.9)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.016
</td>
</tr>
<tr>
<td style="text-align:left;">
Cardiovascular event
</td>
<td style="text-align:center;">
6 (3.23%)
</td>
<td style="text-align:center;">
21 (6.10%)
</td>
<td style="text-align:center;">
28 (5.44%)
</td>
<td style="text-align:center;">
0.356
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Days to cardiovascular event or end of follow-up
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1710 \[804;2769\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1577 \[640;2564\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1752 \[824;2739\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.137
</td>
</tr>
<tr>
<td style="text-align:left;">
Overall death
</td>
<td style="text-align:center;">
13 (7.03%)
</td>
<td style="text-align:center;">
61 (17.9%)
</td>
<td style="text-align:center;">
46 (8.91%)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Days to overall death or end of follow-up
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1620 \[808;2631\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1483 \[732;2323\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1751 \[782;2640\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.106
</td>
</tr>
</tbody>
</table>

## Stratified tables

After creating a table you may want to repeat the descriptives within
stratas. For example, you may want to compare the groups for men and for
women. This is very easy using the `strataTable` function:

    # stratify by sex
    tabestr <- strataTable(tab, strata="sex")

    # remove sex variable from the table
    tabestr[-2]


    --------Summary descriptives table ---------

    ______________________________________________________________________________________________________________________________________________________________________
                                                                                Male                                                      Female                          
                                                     __________________________________________________________  _________________________________________________________
                                                           1995            2000            2005       p.overall       1995            2000            2005       p.overall 
                                                           N=94            N=181           N=251                      N=109           N=184           N=289                
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    Age                                                65.4 (5.36)      64.7 (5.39)     64.6 (5.62)     0.453      64.7 (5.47)     64.6 (5.58)     64.1 (5.53)     0.403   
    Smoking status:                                                                                    <0.001                                                      0.007   
        Never smoker                                    23 (25.6%)      50 (28.9%)      70 (28.6%)                 104 (96.3%)     170 (97.1%)     256 (90.1%)             
        Current or former < 1y                          25 (27.8%)      80 (46.2%)      57 (23.3%)                  4 (3.70%)       4 (2.29%)      14 (4.93%)              
        Former >= 1y                                    42 (46.7%)      43 (24.9%)      118 (48.2%)                 0 (0.00%)       1 (0.57%)      14 (4.93%)              
    Systolic blood pressure                             141 (18.0)      145 (18.8)      139 (19.3)      0.003      143 (18.6)      143 (21.1)      136 (20.4)     <0.001   
    Diastolic blood pressure                           79.8 (8.79)      84.8 (9.50)     82.5 (10.8)    <0.001      79.3 (10.8)     82.2 (10.2)     80.0 (10.2)     0.028   
    History of hypertension                             34 (36.2%)      67 (37.0%)      126 (50.6%)     0.006      46 (42.2%)      84 (45.7%)      148 (51.4%)     0.202   
    Hypertension treatment                              25 (26.6%)      39 (21.5%)      96 (39.8%)     <0.001      32 (29.4%)      62 (33.7%)      102 (36.6%)     0.398   
    Total cholesterol                                   221 (42.3)      222 (44.3)      207 (37.9)     <0.001      236 (40.3)      234 (43.8)      225 (47.8)      0.035   
    HDL cholesterol                                    47.6 (14.3)      46.9 (11.9)     49.1 (12.7)     0.225      56.8 (13.4)     57.6 (16.5)     57.4 (14.4)     0.913   
    Triglycerides                                     110 [79.5;139]  112 [87.0;137]  109 [77.0;142]    0.670    95.5 [75.0;127] 104 [77.0;134]  102 [77.0;142]    0.577   
    LDL cholesterol                                     151 (38.8)      152 (39.8)      134 (34.2)     <0.001      157 (36.4)      154 (36.9)      144 (43.2)      0.006   
    History of hyperchol.                               24 (25.5%)      72 (40.4%)      90 (36.0%)      0.050      28 (25.7%)      78 (44.1%)      129 (44.8%)     0.002   
    Cholesterol treatment                               12 (12.8%)      30 (16.9%)      44 (18.1%)      0.498      10 (9.17%)      25 (14.0%)      67 (24.2%)      0.001   
    Height (cm)                                         168 (6.78)      166 (6.36)      167 (6.92)      0.040      156 (6.27)      153 (6.27)      156 (6.36)     <0.001   
    Weight (Kg)                                        76.6 (12.6)      81.1 (11.8)     78.8 (10.2)     0.005      70.1 (10.4)     69.2 (11.1)     69.9 (12.6)     0.773   
    Body mass index                                    27.1 (3.97)      29.4 (3.59)     28.2 (3.25)    <0.001      28.8 (4.62)     29.6 (4.76)     28.6 (5.19)     0.141   
    Physical activity (Kcal/week)                       499 (462)        399 (342)       492 (449)      0.054       483 (299)       458 (289)       269 (240)     <0.001   
    Physical component                                 48.3 (7.03)      48.0 (10.2)     49.0 (9.03)     0.558      45.6 (10.3)     43.5 (11.0)     46.4 (10.1)     0.024   
    Mental component                                   52.6 (10.3)      52.5 (9.49)     50.1 (9.94)     0.033      46.1 (11.9)     47.2 (11.8)     45.3 (11.2)     0.263   
    Cardiovascular event                                3 (3.33%)       14 (8.19%)      13 (5.44%)      0.257       3 (3.12%)       7 (4.05%)      15 (5.43%)      0.706   
    Days to cardiovascular event or end of follow-up 1606 [793;2735]  1608 [537;2492] 1882 [920;2827]   0.105    1739 [834;2768] 1573 [686;2655] 1723 [701;2673]   0.512   
    Overall death                                       9 (10.3%)       34 (20.0%)      16 (6.72%)     <0.001       4 (4.08%)      27 (15.8%)      30 (10.8%)      0.013   
    Days to overall death or end of follow-up        1625 [1015;2655] 1442 [769;2247] 1684 [715;2518]   0.290    1501 [725;2515] 1507 [679;2408] 1811 [890;2721]   0.174   
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

or when is complied in HTML

    export2md(tabestr, strip = TRUE, first = TRUE, 
              header.background = "blue", header.color = "white", size=8)

<table class="table table-condensed" style="font-size: 8px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
Summary descriptive tables
</caption>
<thead>
<tr>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="1">

<br>

</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="4">

Male

</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="4">

Female

</th>
</tr>
<tr>
<th style="text-align:left;color: white !important;background-color: blue !important;">
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
1995
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
2000
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
2005
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
p.overall
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
1995
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
2000
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
2005
</th>
<th style="text-align:center;color: white !important;background-color: blue !important;">
p.overall
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=94
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=181
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=251
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=109
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=184
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=289
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Age
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
65.4 (5.36)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
64.7 (5.39)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
64.6 (5.62)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.453
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
64.7 (5.47)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
64.6 (5.58)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
64.1 (5.53)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.403
</td>
</tr>
<tr>
<td style="text-align:left;">
Sex:
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
.
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
.
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Male
</td>
<td style="text-align:center;">
94 (100%)
</td>
<td style="text-align:center;">
181 (100%)
</td>
<td style="text-align:center;">
251 (100%)
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
0 (0.00%)
</td>
<td style="text-align:center;">
0 (0.00%)
</td>
<td style="text-align:center;">
0 (0.00%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Female
</td>
<td style="text-align:center;">
0 (0.00%)
</td>
<td style="text-align:center;">
0 (0.00%)
</td>
<td style="text-align:center;">
0 (0.00%)
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
109 (100%)
</td>
<td style="text-align:center;">
184 (100%)
</td>
<td style="text-align:center;">
289 (100%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Smoking status:
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
&lt;0.001
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.007
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;background-color: #D2D2D2 !important;" indentlevel="1">
Never smoker
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
23 (25.6%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
50 (28.9%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
70 (28.6%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
104 (96.3%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
170 (97.1%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
256 (90.1%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;background-color: #D2D2D2 !important;" indentlevel="1">
Current or former &lt; 1y
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
25 (27.8%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
80 (46.2%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
57 (23.3%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
4 (3.70%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
4 (2.29%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
14 (4.93%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;background-color: #D2D2D2 !important;" indentlevel="1">
Former &gt;= 1y
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
42 (46.7%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
43 (24.9%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
118 (48.2%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0 (0.00%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1 (0.57%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
14 (4.93%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Systolic blood pressure
</td>
<td style="text-align:center;">
141 (18.0)
</td>
<td style="text-align:center;">
145 (18.8)
</td>
<td style="text-align:center;">
139 (19.3)
</td>
<td style="text-align:center;">
0.003
</td>
<td style="text-align:center;">
143 (18.6)
</td>
<td style="text-align:center;">
143 (21.1)
</td>
<td style="text-align:center;">
136 (20.4)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Diastolic blood pressure
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
79.8 (8.79)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
84.8 (9.50)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
82.5 (10.8)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
&lt;0.001
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
79.3 (10.8)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
82.2 (10.2)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
80.0 (10.2)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.028
</td>
</tr>
<tr>
<td style="text-align:left;">
History of hypertension
</td>
<td style="text-align:center;">
34 (36.2%)
</td>
<td style="text-align:center;">
67 (37.0%)
</td>
<td style="text-align:center;">
126 (50.6%)
</td>
<td style="text-align:center;">
0.006
</td>
<td style="text-align:center;">
46 (42.2%)
</td>
<td style="text-align:center;">
84 (45.7%)
</td>
<td style="text-align:center;">
148 (51.4%)
</td>
<td style="text-align:center;">
0.202
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Hypertension treatment
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
25 (26.6%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
39 (21.5%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
96 (39.8%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
&lt;0.001
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
32 (29.4%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
62 (33.7%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
102 (36.6%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.398
</td>
</tr>
<tr>
<td style="text-align:left;">
Total cholesterol
</td>
<td style="text-align:center;">
221 (42.3)
</td>
<td style="text-align:center;">
222 (44.3)
</td>
<td style="text-align:center;">
207 (37.9)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
236 (40.3)
</td>
<td style="text-align:center;">
234 (43.8)
</td>
<td style="text-align:center;">
225 (47.8)
</td>
<td style="text-align:center;">
0.035
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
HDL cholesterol
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
47.6 (14.3)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
46.9 (11.9)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
49.1 (12.7)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.225
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
56.8 (13.4)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
57.6 (16.5)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
57.4 (14.4)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.913
</td>
</tr>
<tr>
<td style="text-align:left;">
Triglycerides
</td>
<td style="text-align:center;">
110 \[79.5;139\]
</td>
<td style="text-align:center;">
112 \[87.0;137\]
</td>
<td style="text-align:center;">
109 \[77.0;142\]
</td>
<td style="text-align:center;">
0.670
</td>
<td style="text-align:center;">
95.5 \[75.0;127\]
</td>
<td style="text-align:center;">
104 \[77.0;134\]
</td>
<td style="text-align:center;">
102 \[77.0;142\]
</td>
<td style="text-align:center;">
0.577
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
LDL cholesterol
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
151 (38.8)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
152 (39.8)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
134 (34.2)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
&lt;0.001
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
157 (36.4)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
154 (36.9)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
144 (43.2)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.006
</td>
</tr>
<tr>
<td style="text-align:left;">
History of hyperchol.
</td>
<td style="text-align:center;">
24 (25.5%)
</td>
<td style="text-align:center;">
72 (40.4%)
</td>
<td style="text-align:center;">
90 (36.0%)
</td>
<td style="text-align:center;">
0.050
</td>
<td style="text-align:center;">
28 (25.7%)
</td>
<td style="text-align:center;">
78 (44.1%)
</td>
<td style="text-align:center;">
129 (44.8%)
</td>
<td style="text-align:center;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Cholesterol treatment
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
12 (12.8%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
30 (16.9%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
44 (18.1%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.498
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
10 (9.17%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
25 (14.0%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
67 (24.2%)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Height (cm)
</td>
<td style="text-align:center;">
168 (6.78)
</td>
<td style="text-align:center;">
166 (6.36)
</td>
<td style="text-align:center;">
167 (6.92)
</td>
<td style="text-align:center;">
0.040
</td>
<td style="text-align:center;">
156 (6.27)
</td>
<td style="text-align:center;">
153 (6.27)
</td>
<td style="text-align:center;">
156 (6.36)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Weight (Kg)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
76.6 (12.6)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
81.1 (11.8)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
78.8 (10.2)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.005
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
70.1 (10.4)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
69.2 (11.1)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
69.9 (12.6)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.773
</td>
</tr>
<tr>
<td style="text-align:left;">
Body mass index
</td>
<td style="text-align:center;">
27.1 (3.97)
</td>
<td style="text-align:center;">
29.4 (3.59)
</td>
<td style="text-align:center;">
28.2 (3.25)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
28.8 (4.62)
</td>
<td style="text-align:center;">
29.6 (4.76)
</td>
<td style="text-align:center;">
28.6 (5.19)
</td>
<td style="text-align:center;">
0.141
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Physical activity (Kcal/week)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
499 (462)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
399 (342)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
492 (449)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.054
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
483 (299)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
458 (289)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
269 (240)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Physical component
</td>
<td style="text-align:center;">
48.3 (7.03)
</td>
<td style="text-align:center;">
48.0 (10.2)
</td>
<td style="text-align:center;">
49.0 (9.03)
</td>
<td style="text-align:center;">
0.558
</td>
<td style="text-align:center;">
45.6 (10.3)
</td>
<td style="text-align:center;">
43.5 (11.0)
</td>
<td style="text-align:center;">
46.4 (10.1)
</td>
<td style="text-align:center;">
0.024
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Mental component
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
52.6 (10.3)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
52.5 (9.49)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
50.1 (9.94)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.033
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
46.1 (11.9)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
47.2 (11.8)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
45.3 (11.2)
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.263
</td>
</tr>
<tr>
<td style="text-align:left;">
Cardiovascular event
</td>
<td style="text-align:center;">
3 (3.33%)
</td>
<td style="text-align:center;">
14 (8.19%)
</td>
<td style="text-align:center;">
13 (5.44%)
</td>
<td style="text-align:center;">
0.257
</td>
<td style="text-align:center;">
3 (3.12%)
</td>
<td style="text-align:center;">
7 (4.05%)
</td>
<td style="text-align:center;">
15 (5.43%)
</td>
<td style="text-align:center;">
0.706
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Days to cardiovascular event or end of follow-up
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1606 \[793;2735\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1608 \[537;2492\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1882 \[920;2827\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.105
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1739 \[834;2768\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1573 \[686;2655\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1723 \[701;2673\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.512
</td>
</tr>
<tr>
<td style="text-align:left;">
Overall death
</td>
<td style="text-align:center;">
9 (10.3%)
</td>
<td style="text-align:center;">
34 (20.0%)
</td>
<td style="text-align:center;">
16 (6.72%)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
4 (4.08%)
</td>
<td style="text-align:center;">
27 (15.8%)
</td>
<td style="text-align:center;">
30 (10.8%)
</td>
<td style="text-align:center;">
0.013
</td>
</tr>
<tr>
<td style="text-align:left;background-color: #D2D2D2 !important;">
Days to overall death or end of follow-up
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1625 \[1015;2655\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1442 \[769;2247\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1684 \[715;2518\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.290
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1501 \[725;2515\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1507 \[679;2408\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
1811 \[890;2721\]
</td>
<td style="text-align:center;background-color: #D2D2D2 !important;">
0.174
</td>
</tr>
</tbody>
</table>

## Odds Ratios and Hazard Ratios

Using **`compareGroups`** package you can compute Odds Ratios for
transversal or case-control studies, or Hazard Ratios for cohort studies

-   **Example of case-control study: Odds Ratios**

<!-- -->

    data(SNPs)
    descrTable(casco ~ .-id, SNPs, show.ratio=TRUE, show.p.overall=FALSE)[1:4]


    --------Summary descriptives table by 'casco'---------

    _______________________________________________________________ 
                     0             1              OR        p.ratio 
                   N=47          N=110                              
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
    sex:                                                            
        Male    21 (44.7%)    54 (49.1%)         Ref.        Ref.   
        Female  26 (55.3%)    56 (50.9%)   0.84 [0.42;1.67]  0.619  
    blood.pre   13.1 (0.88)   12.9 (1.03)  0.78 [0.55;1.11]  0.174  
    protein    39938 (19770) 44371 (24897) 1.00 [1.00;1.00]  0.280  
    snp10001:                                                       
        CC       2 (4.26%)    10 (9.09%)         Ref.        Ref.   
        CT      21 (44.7%)    32 (29.1%)   0.33 [0.04;1.43]  0.147  
        TT      24 (51.1%)    68 (61.8%)   0.60 [0.08;2.55]  0.521  
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 

-   **Example of cohort study: Hazard Ratios**

<!-- -->

    # create a Surv response:
    library(survival)
    regicor$tcv <- Surv(regicor$tocv, regicor$cv=="Yes")

    # perform descriptive table placing the Surv object as the response (left side of ~):
    tab <- descrTable(tcv ~ .-id-cv-tocv, regicor, 
               method=c(triglyc=2, tocv=2, todeath=2),
               hide.no="no", ref.no="no",
               show.ratio=TRUE, show.p.overall=FALSE)

    # print table on R console
    print(tab, header.label=c("p.ratio"="p-value"))           


    --------Summary descriptives table by 'tcv'---------

    __________________________________________________________________________________________________ 
                                                 No event          Event             HR        p-value 
                                                  N=2071           N=92                                
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
    Recruitment year:                                                                                  
        1995                                    388 (18.7%)     10 (10.9%)          Ref.        Ref.   
        2000                                    706 (34.1%)     35 (38.0%)    1.95 [0.96;3.93]  0.063  
        2005                                    977 (47.2%)     47 (51.1%)    1.82 [0.92;3.59]  0.087  
    Age                                         54.6 (11.1)     57.5 (11.0)   1.02 [1.00;1.04]  0.021  
    Sex:                                                                                               
        Male                                    996 (48.1%)     46 (50.0%)          Ref.        Ref.   
        Female                                 1075 (51.9%)     46 (50.0%)    0.92 [0.61;1.39]  0.696  
    Smoking status:                                                                                    
        Never smoker                           1099 (54.3%)     37 (40.2%)          Ref.        Ref.   
        Current or former < 1y                  506 (25.0%)     47 (51.1%)    2.67 [1.74;4.11] <0.001  
        Former >= 1y                            419 (20.7%)      8 (8.70%)    0.55 [0.26;1.18]  0.123  
    Systolic blood pressure                     131 (20.3)      138 (21.5)    1.02 [1.01;1.02]  0.001  
    Diastolic blood pressure                    79.5 (10.4)     82.9 (12.3)   1.03 [1.01;1.05]  0.002  
    History of hypertension                     647 (31.3%)     38 (41.3%)    1.52 [1.01;2.31]  0.047  
    Hypertension treatment                      382 (18.7%)     22 (23.9%)    1.37 [0.85;2.22]  0.195  
    Total cholesterol                           218 (44.5)      224 (50.4)    1.00 [1.00;1.01]  0.207  
    HDL cholesterol                             52.8 (14.8)     50.4 (13.3)   0.99 [0.97;1.00]  0.114  
    Triglycerides                             96.0 [71.0;135] 110 [87.5;161]  1.00 [1.00;1.00]  0.190  
    LDL cholesterol                             143 (39.6)      149 (45.6)    1.00 [1.00;1.01]  0.148  
    History of hyperchol.                       639 (31.1%)     25 (27.2%)    0.82 [0.52;1.30]  0.406  
    Cholesterol treatment                       213 (10.5%)      6 (6.52%)    0.61 [0.27;1.39]  0.239  
    Height (cm)                                 163 (9.21)      163 (9.34)    1.00 [0.98;1.03]  0.692  
    Weight (Kg)                                 73.4 (13.7)     74.9 (12.8)   1.01 [0.99;1.02]  0.294  
    Body mass index                             27.6 (4.56)     28.1 (4.48)   1.02 [0.98;1.07]  0.299  
    Physical activity (Kcal/week)                405 (397)       338 (238)    1.00 [1.00;1.00]  0.089  
    Physical component                          49.7 (8.95)     47.4 (9.03)   0.98 [0.96;1.00]  0.023  
    Mental component                            48.1 (10.9)     46.3 (12.2)   0.99 [0.97;1.00]  0.122  
    Overall death                               156 (7.98%)     15 (16.9%)    2.35 [1.35;4.09]  0.003  
    Days to overall death or end of follow-up 1684 [789;2663] 1468 [510;2453] 1.00 [1.00;1.00]  0.298  
    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 

# Web-based User Interface

For those not familiar to R syntax, a Web User Interface (**WUI**) has
been implemented using [Shiny](https://shiny.rstudio.com/) tools, which
can be used remotely just accessing the [**compareGroups project
website**](http://www.comparegroups.eu)

![](./man/figures/WUI.png)

Try the WUI compareGroups [here](http://www.comparegroups.eu/wui)

<br>

# Citation

    citation("compareGroups")


    To cite compareGroups in publications use:

      Isaac Subirana, Hector Sanz, Joan Vila (2014). Building Bivariate
      Tables: The compareGroups Package for R. Journal of Statistical
      Software, 57(12), 1-16. URL https://www.jstatsoft.org/v57/i12/.

    A BibTeX entry for LaTeX users is

      @Article{,
        title = {Building Bivariate Tables: The {compareGroups} Package for {R}},
        author = {Isaac Subirana and H\'ector Sanz and Joan Vila},
        journal = {Journal of Statistical Software},
        year = {2014},
        volume = {57},
        number = {12},
        pages = {1--16},
        url = {https://www.jstatsoft.org/v57/i12/},
      }

# References

<p>
Subirana, Isaac, Héctor Sanz, and Joan Vila. 2014. “Building Bivariate
Tables: The compareGroups Package for R.” <em>Journal of Statistical
Software</em> 57 (12): 1–16.
<a href="https://www.jstatsoft.org/v57/i12/" class="uri">https://www.jstatsoft.org/v57/i12/</a>.
</p>
