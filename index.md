**compareGroups** <img src="man/figures/logo.png" align="right" width="120px"/>
===============================================================================

***package to create descriptive tables***

[![CRAN
version](http://www.r-pkg.org/badges/version/compareGroups)](http://cran.r-project.org/package=compareGroups)
![](http://cranlogs.r-pkg.org/badges/grand-total/compareGroups)
![](http://cranlogs.r-pkg.org/badges/last-month/compareGroups)

Overview
--------

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
[vignette](./articles/compareGroups_vignette.html).<br>

Also, **compareGroups** package has been published in Journal of
Statistical Software \[Subirana et al, 2014\]
(<a href="https://www.jstatsoft.org/v57/i12/" class="uri">https://www.jstatsoft.org/v57/i12/</a>).

------------------------------------------------------------------------

Who we are
----------

<img style="float:right; padding:10px" width="25%" src="../man/figures/prbb.jpg" />

**`compareGroups`** is developed and maintained by Isaac Subirana,
Hector Sanz, Joan Vila and collaborators at the cardiovascular
epidemiology research unit (URLEC), located at [Barcelona Biomedical
Research Park (PRBB)](http://www.prbb.org/) .

<br><br><br><br><br>

<img style="float:left; padding:10px" width="20%" src="../man/figures/logo_regicor.jpg" />

As the driving force behind the [REGICOR study](www.regicor.org), URLEC
has extensive experience in statistical epidemiology, and is a national
reference centre for research into cardiovascular diseases and their
risk factors.

<br><br>

------------------------------------------------------------------------

Gets started
------------

Install the package from CRAN

    install.packages("compareGroups")

or the lattest version from Github

    library(devtools)
    devtools::install_github("isubirana/compareGroups")

### Building the descriptive table

    library(compareGroups)

    data(predimed)

    tab <- descrTable(group ~ . , predimed, hide.no = "no", method = c(wth = 2, p14 = 2), sd.type = 3)

    export2md(tab, header.background = "black", header.color = "white", caption = "Summary by intervention group")

<table class="table table-striped table-condensed" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>
Summary by intervention group
</caption>
<thead>
<tr>
<th style="text-align:left;color: white !important;background-color: black !important;">
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
Control
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
MedDiet + Nuts
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
MedDiet + VOO
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
p.overall
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=2042
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=2100
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=2182
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
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
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Male
</td>
<td style="text-align:center;">
812 (39.8%)
</td>
<td style="text-align:center;">
968 (46.1%)
</td>
<td style="text-align:center;">
899 (41.2%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Female
</td>
<td style="text-align:center;">
1230 (60.2%)
</td>
<td style="text-align:center;">
1132 (53.9%)
</td>
<td style="text-align:center;">
1283 (58.8%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Age
</td>
<td style="text-align:center;">
67.3±6.28
</td>
<td style="text-align:center;">
66.7±6.02
</td>
<td style="text-align:center;">
67.0±6.21
</td>
<td style="text-align:center;">
0.003
</td>
</tr>
<tr>
<td style="text-align:left;">
Smoking:
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
0.444
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Never
</td>
<td style="text-align:center;">
1282 (62.8%)
</td>
<td style="text-align:center;">
1259 (60.0%)
</td>
<td style="text-align:center;">
1351 (61.9%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Current
</td>
<td style="text-align:center;">
270 (13.2%)
</td>
<td style="text-align:center;">
296 (14.1%)
</td>
<td style="text-align:center;">
292 (13.4%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Former
</td>
<td style="text-align:center;">
490 (24.0%)
</td>
<td style="text-align:center;">
545 (26.0%)
</td>
<td style="text-align:center;">
539 (24.7%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Body mass index
</td>
<td style="text-align:center;">
30.3±3.96
</td>
<td style="text-align:center;">
29.7±3.77
</td>
<td style="text-align:center;">
29.9±3.71
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Waist circumference
</td>
<td style="text-align:center;">
101±10.8
</td>
<td style="text-align:center;">
100±10.6
</td>
<td style="text-align:center;">
100±10.4
</td>
<td style="text-align:center;">
0.045
</td>
</tr>
<tr>
<td style="text-align:left;">
Waist-to-height ratio
</td>
<td style="text-align:center;">
0.63 \[0.59;0.68\]
</td>
<td style="text-align:center;">
0.62 \[0.58;0.66\]
</td>
<td style="text-align:center;">
0.62 \[0.58;0.67\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Hypertension
</td>
<td style="text-align:center;">
1711 (83.8%)
</td>
<td style="text-align:center;">
1738 (82.8%)
</td>
<td style="text-align:center;">
1786 (81.9%)
</td>
<td style="text-align:center;">
0.249
</td>
</tr>
<tr>
<td style="text-align:left;">
Type-2 diabetes
</td>
<td style="text-align:center;">
970 (47.5%)
</td>
<td style="text-align:center;">
950 (45.2%)
</td>
<td style="text-align:center;">
1082 (49.6%)
</td>
<td style="text-align:center;">
0.017
</td>
</tr>
<tr>
<td style="text-align:left;">
Dyslipidemia
</td>
<td style="text-align:center;">
1479 (72.4%)
</td>
<td style="text-align:center;">
1539 (73.3%)
</td>
<td style="text-align:center;">
1560 (71.5%)
</td>
<td style="text-align:center;">
0.423
</td>
</tr>
<tr>
<td style="text-align:left;">
Family history of premature CHD
</td>
<td style="text-align:center;">
462 (22.6%)
</td>
<td style="text-align:center;">
460 (21.9%)
</td>
<td style="text-align:center;">
507 (23.2%)
</td>
<td style="text-align:center;">
0.581
</td>
</tr>
<tr>
<td style="text-align:left;">
Hormone-replacement therapy
</td>
<td style="text-align:center;">
31 (1.68%)
</td>
<td style="text-align:center;">
30 (1.61%)
</td>
<td style="text-align:center;">
36 (1.84%)
</td>
<td style="text-align:center;">
0.850
</td>
</tr>
<tr>
<td style="text-align:left;">
MeDiet Adherence score
</td>
<td style="text-align:center;">
8.00 \[7.00;10.0\]
</td>
<td style="text-align:center;">
9.00 \[8.00;10.0\]
</td>
<td style="text-align:center;">
9.00 \[8.00;10.0\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
follow-up to main event (years)
</td>
<td style="text-align:center;">
4.09±1.74
</td>
<td style="text-align:center;">
4.31±1.70
</td>
<td style="text-align:center;">
4.64±1.60
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
AMI, stroke, or CV Death
</td>
<td style="text-align:center;">
97 (4.75%)
</td>
<td style="text-align:center;">
70 (3.33%)
</td>
<td style="text-align:center;">
85 (3.90%)
</td>
<td style="text-align:center;">
0.064
</td>
</tr>
</tbody>
</table>

### Stratified table

<div class="small">


    tabstrat <- strataTable(update(tab, . ~ . -sex), "sex")

    export2md(tabstrat, header.background = "black", header.color = "white", size=9)

<table class="table table-striped table-condensed" style="font-size: 9px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
Summary descriptive tables
</caption>
<thead>
<tr>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; color:  white ;padding-right: 4px; padding-left: 4px; background-color:  black ;" colspan="1">

<br>

</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; color:  white ;padding-right: 4px; padding-left: 4px; background-color:  black ;" colspan="4">

Male

</th>
<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; color:  white ;padding-right: 4px; padding-left: 4px; background-color:  black ;" colspan="4">

Female

</th>
</tr>
<tr>
<th style="text-align:left;color: white !important;background-color: black !important;">
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
Control
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
MedDiet + Nuts
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
MedDiet + VOO
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
p.overall
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
Control
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
MedDiet + Nuts
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
MedDiet + VOO
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
p.overall
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=812
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=968
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=899
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=1230
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=1132
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=1283
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
</tr>
<tr>
<td style="text-align:left;">
Age
</td>
<td style="text-align:center;">
66.4±6.62
</td>
<td style="text-align:center;">
65.8±6.40
</td>
<td style="text-align:center;">
66.1±6.61
</td>
<td style="text-align:center;">
0.215
</td>
<td style="text-align:center;">
68.0±5.96
</td>
<td style="text-align:center;">
67.4±5.57
</td>
<td style="text-align:center;">
67.7±5.84
</td>
<td style="text-align:center;">
0.056
</td>
</tr>
<tr>
<td style="text-align:left;">
Smoking:
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
0.851
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
0.907
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Never
</td>
<td style="text-align:center;">
205 (25.2%)
</td>
<td style="text-align:center;">
266 (27.5%)
</td>
<td style="text-align:center;">
236 (26.3%)
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
1077 (87.6%)
</td>
<td style="text-align:center;">
993 (87.7%)
</td>
<td style="text-align:center;">
1115 (86.9%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Current
</td>
<td style="text-align:center;">
204 (25.1%)
</td>
<td style="text-align:center;">
242 (25.0%)
</td>
<td style="text-align:center;">
221 (24.6%)
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
66 (5.37%)
</td>
<td style="text-align:center;">
54 (4.77%)
</td>
<td style="text-align:center;">
71 (5.53%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Former
</td>
<td style="text-align:center;">
403 (49.6%)
</td>
<td style="text-align:center;">
460 (47.5%)
</td>
<td style="text-align:center;">
442 (49.2%)
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
87 (7.07%)
</td>
<td style="text-align:center;">
85 (7.51%)
</td>
<td style="text-align:center;">
97 (7.56%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Body mass index
</td>
<td style="text-align:center;">
29.6±3.45
</td>
<td style="text-align:center;">
29.1±3.28
</td>
<td style="text-align:center;">
29.2±3.28
</td>
<td style="text-align:center;">
0.018
</td>
<td style="text-align:center;">
30.8±4.20
</td>
<td style="text-align:center;">
30.2±4.08
</td>
<td style="text-align:center;">
30.4±3.91
</td>
<td style="text-align:center;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;">
Waist circumference
</td>
<td style="text-align:center;">
104±9.82
</td>
<td style="text-align:center;">
103±9.36
</td>
<td style="text-align:center;">
103±9.65
</td>
<td style="text-align:center;">
0.289
</td>
<td style="text-align:center;">
99.0±11.0
</td>
<td style="text-align:center;">
97.8±11.0
</td>
<td style="text-align:center;">
98.0±10.5
</td>
<td style="text-align:center;">
0.016
</td>
</tr>
<tr>
<td style="text-align:left;">
Waist-to-height ratio
</td>
<td style="text-align:center;">
0.62 \[0.58;0.65\]
</td>
<td style="text-align:center;">
0.61 \[0.58;0.65\]
</td>
<td style="text-align:center;">
0.61 \[0.58;0.65\]
</td>
<td style="text-align:center;">
0.256
</td>
<td style="text-align:center;">
0.64 \[0.59;0.69\]
</td>
<td style="text-align:center;">
0.63 \[0.58;0.68\]
</td>
<td style="text-align:center;">
0.63 \[0.59;0.68\]
</td>
<td style="text-align:center;">
0.003
</td>
</tr>
<tr>
<td style="text-align:left;">
Hypertension
</td>
<td style="text-align:center;">
649 (79.9%)
</td>
<td style="text-align:center;">
753 (77.8%)
</td>
<td style="text-align:center;">
682 (75.9%)
</td>
<td style="text-align:center;">
0.130
</td>
<td style="text-align:center;">
1062 (86.3%)
</td>
<td style="text-align:center;">
985 (87.0%)
</td>
<td style="text-align:center;">
1104 (86.0%)
</td>
<td style="text-align:center;">
0.780
</td>
</tr>
<tr>
<td style="text-align:left;">
Type-2 diabetes
</td>
<td style="text-align:center;">
430 (53.0%)
</td>
<td style="text-align:center;">
496 (51.2%)
</td>
<td style="text-align:center;">
486 (54.1%)
</td>
<td style="text-align:center;">
0.468
</td>
<td style="text-align:center;">
540 (43.9%)
</td>
<td style="text-align:center;">
454 (40.1%)
</td>
<td style="text-align:center;">
596 (46.5%)
</td>
<td style="text-align:center;">
0.007
</td>
</tr>
<tr>
<td style="text-align:left;">
Dyslipidemia
</td>
<td style="text-align:center;">
531 (65.4%)
</td>
<td style="text-align:center;">
653 (67.5%)
</td>
<td style="text-align:center;">
589 (65.5%)
</td>
<td style="text-align:center;">
0.575
</td>
<td style="text-align:center;">
948 (77.1%)
</td>
<td style="text-align:center;">
886 (78.3%)
</td>
<td style="text-align:center;">
971 (75.7%)
</td>
<td style="text-align:center;">
0.319
</td>
</tr>
<tr>
<td style="text-align:left;">
Family history of premature CHD
</td>
<td style="text-align:center;">
135 (16.6%)
</td>
<td style="text-align:center;">
171 (17.7%)
</td>
<td style="text-align:center;">
156 (17.4%)
</td>
<td style="text-align:center;">
0.841
</td>
<td style="text-align:center;">
327 (26.6%)
</td>
<td style="text-align:center;">
289 (25.5%)
</td>
<td style="text-align:center;">
351 (27.4%)
</td>
<td style="text-align:center;">
0.596
</td>
</tr>
<tr>
<td style="text-align:left;">
Hormone-replacement therapy
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
.
</td>
<td style="text-align:center;">
31 (2.64%)
</td>
<td style="text-align:center;">
30 (2.81%)
</td>
<td style="text-align:center;">
36 (2.95%)
</td>
<td style="text-align:center;">
0.898
</td>
</tr>
<tr>
<td style="text-align:left;">
MeDiet Adherence score
</td>
<td style="text-align:center;">
9.00 \[7.00;10.0\]
</td>
<td style="text-align:center;">
9.00 \[8.00;10.0\]
</td>
<td style="text-align:center;">
9.00 \[8.00;10.0\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
8.00 \[7.00;10.0\]
</td>
<td style="text-align:center;">
9.00 \[8.00;10.0\]
</td>
<td style="text-align:center;">
9.00 \[7.00;10.0\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
follow-up to main event (years)
</td>
<td style="text-align:center;">
4.05±1.78
</td>
<td style="text-align:center;">
4.38±1.74
</td>
<td style="text-align:center;">
4.53±1.64
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
4.12±1.71
</td>
<td style="text-align:center;">
4.26±1.67
</td>
<td style="text-align:center;">
4.72±1.56
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
AMI, stroke, or CV Death
</td>
<td style="text-align:center;">
58 (7.14%)
</td>
<td style="text-align:center;">
41 (4.24%)
</td>
<td style="text-align:center;">
52 (5.78%)
</td>
<td style="text-align:center;">
0.029
</td>
<td style="text-align:center;">
39 (3.17%)
</td>
<td style="text-align:center;">
29 (2.56%)
</td>
<td style="text-align:center;">
33 (2.57%)
</td>
<td style="text-align:center;">
0.576
</td>
</tr>
</tbody>
</table>
</div>

### Visual exploration

<table>
<tbody>
<tr class="odd">
<td style="text-align: center;"><code>plot(tab["sex"])</code></td>
<td style="text-align: center;"><code>plot(tab["age"])</code></td>
</tr>
<tr class="even">
<td style="text-align: center;"><img src="../man/figures/varsex.png" /></td>
<td style="text-align: center;"><img src="../man/figures/varage.png" /></td>
</tr>
</tbody>
</table>

### Computing Odds Ratios

    data(SNPs)

    tabor <- descrTable(casco ~ .-id, SNPs, show.ratio=TRUE, show.p.overall=FALSE)

    export2md(tabor[1:4])

<table class="table table-striped table-condensed" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>
Summary descriptives table by groups of \`casco’
</caption>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:center;">
0
</th>
<th style="text-align:center;">
1
</th>
<th style="text-align:center;">
OR
</th>
<th style="text-align:center;">
p.ratio
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=47
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=110
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
</tr>
<tr>
<td style="text-align:left;">
sex:
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Male
</td>
<td style="text-align:center;">
21 (44.7%)
</td>
<td style="text-align:center;">
54 (49.1%)
</td>
<td style="text-align:center;">
Ref.
</td>
<td style="text-align:center;">
Ref.
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Female
</td>
<td style="text-align:center;">
26 (55.3%)
</td>
<td style="text-align:center;">
56 (50.9%)
</td>
<td style="text-align:center;">
0.84 \[0.42;1.67\]
</td>
<td style="text-align:center;">
0.619
</td>
</tr>
<tr>
<td style="text-align:left;">
blood.pre
</td>
<td style="text-align:center;">
13.1 (0.88)
</td>
<td style="text-align:center;">
12.9 (1.03)
</td>
<td style="text-align:center;">
0.78 \[0.55;1.11\]
</td>
<td style="text-align:center;">
0.174
</td>
</tr>
<tr>
<td style="text-align:left;">
protein
</td>
<td style="text-align:center;">
39938 (19770)
</td>
<td style="text-align:center;">
44371 (24897)
</td>
<td style="text-align:center;">
1.00 \[1.00;1.00\]
</td>
<td style="text-align:center;">
0.280
</td>
</tr>
<tr>
<td style="text-align:left;">
snp10001:
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
CC
</td>
<td style="text-align:center;">
2 (4.26%)
</td>
<td style="text-align:center;">
10 (9.09%)
</td>
<td style="text-align:center;">
Ref.
</td>
<td style="text-align:center;">
Ref.
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
CT
</td>
<td style="text-align:center;">
21 (44.7%)
</td>
<td style="text-align:center;">
32 (29.1%)
</td>
<td style="text-align:center;">
0.33 \[0.04;1.43\]
</td>
<td style="text-align:center;">
0.147
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
TT
</td>
<td style="text-align:center;">
24 (51.1%)
</td>
<td style="text-align:center;">
68 (61.8%)
</td>
<td style="text-align:center;">
0.60 \[0.08;2.55\]
</td>
<td style="text-align:center;">
0.521
</td>
</tr>
</tbody>
</table>

### Computing Hazard Ratios

    library(survival)
    predimed$tevent <- with(predimed, Surv(toevent, event=='Yes'))

    tabhr <- descrTable(tevent ~ ., predimed, hide.no = "no", method = c(wth = 2, p14 = 2), sd.type = 3,  
                        show.ratio=TRUE, show.p.overall=FALSE)

    export2md(tabhr[1:10])

<table class="table table-striped table-condensed" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>
Summary descriptives table by groups of \`tevent’
</caption>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:center;">
No event
</th>
<th style="text-align:center;">
Event
</th>
<th style="text-align:center;">
HR
</th>
<th style="text-align:center;">
p.ratio
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=6072
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=252
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
</tr>
<tr>
<td style="text-align:left;">
Intervention group:
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Control
</td>
<td style="text-align:center;">
1945 (32.0%)
</td>
<td style="text-align:center;">
97 (38.5%)
</td>
<td style="text-align:center;">
Ref.
</td>
<td style="text-align:center;">
Ref.
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
MedDiet + Nuts
</td>
<td style="text-align:center;">
2030 (33.4%)
</td>
<td style="text-align:center;">
70 (27.8%)
</td>
<td style="text-align:center;">
0.66 \[0.48;0.89\]
</td>
<td style="text-align:center;">
0.008
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
MedDiet + VOO
</td>
<td style="text-align:center;">
2097 (34.5%)
</td>
<td style="text-align:center;">
85 (33.7%)
</td>
<td style="text-align:center;">
0.70 \[0.53;0.94\]
</td>
<td style="text-align:center;">
0.018
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
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Male
</td>
<td style="text-align:center;">
2528 (41.6%)
</td>
<td style="text-align:center;">
151 (59.9%)
</td>
<td style="text-align:center;">
Ref.
</td>
<td style="text-align:center;">
Ref.
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Female
</td>
<td style="text-align:center;">
3544 (58.4%)
</td>
<td style="text-align:center;">
101 (40.1%)
</td>
<td style="text-align:center;">
0.49 \[0.38;0.63\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Age
</td>
<td style="text-align:center;">
66.9±6.14
</td>
<td style="text-align:center;">
69.4±6.65
</td>
<td style="text-align:center;">
1.06 \[1.04;1.09\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Smoking:
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Never
</td>
<td style="text-align:center;">
3778 (62.2%)
</td>
<td style="text-align:center;">
114 (45.2%)
</td>
<td style="text-align:center;">
Ref.
</td>
<td style="text-align:center;">
Ref.
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Current
</td>
<td style="text-align:center;">
809 (13.3%)
</td>
<td style="text-align:center;">
49 (19.4%)
</td>
<td style="text-align:center;">
1.96 \[1.40;2.74\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left; padding-left: 2em;" indentlevel="1">
Former
</td>
<td style="text-align:center;">
1485 (24.5%)
</td>
<td style="text-align:center;">
89 (35.3%)
</td>
<td style="text-align:center;">
2.02 \[1.53;2.67\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Body mass index
</td>
<td style="text-align:center;">
30.0±3.81
</td>
<td style="text-align:center;">
29.8±3.92
</td>
<td style="text-align:center;">
0.99 \[0.96;1.02\]
</td>
<td style="text-align:center;">
0.455
</td>
</tr>
<tr>
<td style="text-align:left;">
Waist circumference
</td>
<td style="text-align:center;">
100±10.6
</td>
<td style="text-align:center;">
102±10.6
</td>
<td style="text-align:center;">
1.02 \[1.01;1.03\]
</td>
<td style="text-align:center;">
0.003
</td>
</tr>
<tr>
<td style="text-align:left;">
Waist-to-height ratio
</td>
<td style="text-align:center;">
0.63 \[0.58;0.67\]
</td>
<td style="text-align:center;">
0.63 \[0.59;0.68\]
</td>
<td style="text-align:center;">
5.27 \[0.83;33.6\]
</td>
<td style="text-align:center;">
0.079
</td>
</tr>
<tr>
<td style="text-align:left;">
Hypertension
</td>
<td style="text-align:center;">
5025 (82.8%)
</td>
<td style="text-align:center;">
210 (83.3%)
</td>
<td style="text-align:center;">
1.10 \[0.79;1.53\]
</td>
<td style="text-align:center;">
0.578
</td>
</tr>
<tr>
<td style="text-align:left;">
Type-2 diabetes
</td>
<td style="text-align:center;">
2841 (46.8%)
</td>
<td style="text-align:center;">
161 (63.9%)
</td>
<td style="text-align:center;">
1.88 \[1.46;2.44\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Dyslipidemia
</td>
<td style="text-align:center;">
4427 (72.9%)
</td>
<td style="text-align:center;">
151 (59.9%)
</td>
<td style="text-align:center;">
0.62 \[0.49;0.80\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
</tbody>
</table>

### Web-based User Interface

For those not familiar to R syntax, a Web User Interface (**WUI**) has
been implemented using [Shiny](https://shiny.rstudio.com/) tools, which
can be used remotely just accessing the [**compareGroups project
website**](http://www.comparegroups.eu)

![](../man/figures/WUI.png)

Try the WUI compareGroups
[here](https://isubirana.shinyapps.io/compareGroups/)
