# **compareGroups** <img src="man/figures/logo.png" align="right" width="120px"/>

***package to create descriptive tables***

[![CRAN
version](https://www.r-pkg.org/badges/version/compareGroups)](https://cran.r-project.org/package=compareGroups)
![image not
found](https://cranlogs.r-pkg.org/badges/grand-total/compareGroups)
![image not
found](https://cranlogs.r-pkg.org/badges/last-month/compareGroups)

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
[vignette](./articles/compareGroups_vignette.html).<br>

Also, **compareGroups** package has been published in Journal of
Statistical Software \[Subirana et al, 2014\]
(<https://www.jstatsoft.org/v57/i12/>).

------------------------------------------------------------------------

## Who we are

<img style="float:right; padding:10px" width="25%" src="./man/figures/prbb.jpg" alt="image not found"/>

**`compareGroups`** is developed and maintained by Isaac Subirana,
Hector Sanz, Joan Vila and collaborators at the cardiovascular
epidemiology research unit (URLEC), located at [Barcelona Biomedical
Research Park (PRBB)](http://www.prbb.org/) .

<br><br><br><br><br>

<img style="float:left; padding:10px" width="20%" src="./man/figures/logo_regicor.jpg" alt="image not found"/>

As the driving force behind the [REGICOR
study](https://www.regicor.org), URLEC has extensive experience in
statistical epidemiology, and is a national reference centre for
research into cardiovascular diseases and their risk factors.

<br><br>

------------------------------------------------------------------------

## Gets started

Install the package from CRAN

    install.packages("compareGroups")

or the lattest version from Github

    library(devtools)
    devtools::install_github("isubirana/compareGroups")

### Building the descriptive table

    library(compareGroups)

    data(regicor)

    tab <- descrTable(year ~ . -id , regicor, hide.no = "no", 
                      method=c(triglyc=2, tocv=2, todeath=2), sd.type = 3)

    export2md(tab, header.background = "black", header.color = "white", 
              caption = "Summary by intervention group")

<table class="table table-striped table-condensed" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>
Summary by intervention group
</caption>
<thead>
<tr>
<th style="text-align:left;color: white !important;background-color: black !important;">
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
1995
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
2000
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
2005
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
N=431
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=786
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=1077
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
</tr>
<tr>
<td style="text-align:left;">
Age
</td>
<td style="text-align:center;">
54.1±11.7
</td>
<td style="text-align:center;">
54.3±11.2
</td>
<td style="text-align:center;">
55.3±10.6
</td>
<td style="text-align:center;">
0.079
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
0.506
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Male
</td>
<td style="text-align:center;">
206 (47.8%)
</td>
<td style="text-align:center;">
390 (49.6%)
</td>
<td style="text-align:center;">
505 (46.9%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Female
</td>
<td style="text-align:center;">
225 (52.2%)
</td>
<td style="text-align:center;">
396 (50.4%)
</td>
<td style="text-align:center;">
572 (53.1%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Smoking status:
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Never smoker
</td>
<td style="text-align:center;">
234 (56.4%)
</td>
<td style="text-align:center;">
414 (54.6%)
</td>
<td style="text-align:center;">
553 (52.2%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Current or former &lt; 1y
</td>
<td style="text-align:center;">
109 (26.3%)
</td>
<td style="text-align:center;">
267 (35.2%)
</td>
<td style="text-align:center;">
217 (20.5%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Former &gt;= 1y
</td>
<td style="text-align:center;">
72 (17.3%)
</td>
<td style="text-align:center;">
77 (10.2%)
</td>
<td style="text-align:center;">
290 (27.4%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Systolic blood pressure
</td>
<td style="text-align:center;">
133±19.2
</td>
<td style="text-align:center;">
133±21.3
</td>
<td style="text-align:center;">
129±19.8
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Diastolic blood pressure
</td>
<td style="text-align:center;">
77.0±10.5
</td>
<td style="text-align:center;">
80.8±10.3
</td>
<td style="text-align:center;">
79.9±10.6
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
History of hypertension
</td>
<td style="text-align:center;">
111 (25.8%)
</td>
<td style="text-align:center;">
233 (29.6%)
</td>
<td style="text-align:center;">
379 (35.5%)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Hypertension treatment
</td>
<td style="text-align:center;">
71 (16.5%)
</td>
<td style="text-align:center;">
127 (16.2%)
</td>
<td style="text-align:center;">
230 (22.2%)
</td>
<td style="text-align:center;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;">
Total cholesterol
</td>
<td style="text-align:center;">
225±43.1
</td>
<td style="text-align:center;">
224±44.4
</td>
<td style="text-align:center;">
213±45.9
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
HDL cholesterol
</td>
<td style="text-align:center;">
51.9±14.5
</td>
<td style="text-align:center;">
52.3±15.6
</td>
<td style="text-align:center;">
53.2±14.2
</td>
<td style="text-align:center;">
0.198
</td>
</tr>
<tr>
<td style="text-align:left;">
Triglycerides
</td>
<td style="text-align:center;">
94.0 \[71.0;136\]
</td>
<td style="text-align:center;">
98.0 \[72.0;133\]
</td>
<td style="text-align:center;">
98.0 \[72.0;139\]
</td>
<td style="text-align:center;">
0.762
</td>
</tr>
<tr>
<td style="text-align:left;">
LDL cholesterol
</td>
<td style="text-align:center;">
152±38.4
</td>
<td style="text-align:center;">
149±38.6
</td>
<td style="text-align:center;">
136±39.7
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
History of hyperchol.
</td>
<td style="text-align:center;">
97 (22.5%)
</td>
<td style="text-align:center;">
256 (33.2%)
</td>
<td style="text-align:center;">
356 (33.2%)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Cholesterol treatment
</td>
<td style="text-align:center;">
28 (6.50%)
</td>
<td style="text-align:center;">
68 (8.80%)
</td>
<td style="text-align:center;">
132 (12.8%)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Height (cm)
</td>
<td style="text-align:center;">
163±9.21
</td>
<td style="text-align:center;">
162±9.39
</td>
<td style="text-align:center;">
163±9.05
</td>
<td style="text-align:center;">
0.004
</td>
</tr>
<tr>
<td style="text-align:left;">
Weight (Kg)
</td>
<td style="text-align:center;">
72.3±12.6
</td>
<td style="text-align:center;">
73.8±14.0
</td>
<td style="text-align:center;">
73.6±13.9
</td>
<td style="text-align:center;">
0.120
</td>
</tr>
<tr>
<td style="text-align:left;">
Body mass index
</td>
<td style="text-align:center;">
27.0±4.15
</td>
<td style="text-align:center;">
28.1±4.62
</td>
<td style="text-align:center;">
27.6±4.63
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Physical activity (Kcal/week)
</td>
<td style="text-align:center;">
491±419
</td>
<td style="text-align:center;">
422±377
</td>
<td style="text-align:center;">
351±378
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Physical component
</td>
<td style="text-align:center;">
49.3±8.08
</td>
<td style="text-align:center;">
49.0±9.63
</td>
<td style="text-align:center;">
50.1±8.91
</td>
<td style="text-align:center;">
0.037
</td>
</tr>
<tr>
<td style="text-align:left;">
Mental component
</td>
<td style="text-align:center;">
49.2±11.3
</td>
<td style="text-align:center;">
48.9±11.0
</td>
<td style="text-align:center;">
46.9±10.8
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Cardiovascular event
</td>
<td style="text-align:center;">
10 (2.51%)
</td>
<td style="text-align:center;">
35 (4.72%)
</td>
<td style="text-align:center;">
47 (4.59%)
</td>
<td style="text-align:center;">
0.161
</td>
</tr>
<tr>
<td style="text-align:left;">
Days to cardiovascular event or end of follow-up
</td>
<td style="text-align:center;">
1728 \[746;2767\]
</td>
<td style="text-align:center;">
1617 \[723;2596\]
</td>
<td style="text-align:center;">
1775 \[835;2723\]
</td>
<td style="text-align:center;">
0.096
</td>
</tr>
<tr>
<td style="text-align:left;">
Overall death
</td>
<td style="text-align:center;">
18 (4.65%)
</td>
<td style="text-align:center;">
81 (11.0%)
</td>
<td style="text-align:center;">
74 (7.23%)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Days to overall death or end of follow-up
</td>
<td style="text-align:center;">
1557 \[812;2689\]
</td>
<td style="text-align:center;">
1609 \[734;2549\]
</td>
<td style="text-align:center;">
1734 \[817;2713\]
</td>
<td style="text-align:center;">
0.249
</td>
</tr>
</tbody>
</table>

### Stratified table

    tabstrat <- strataTable(update(tab, . ~ . -sex), "sex")

    export2md(tabstrat, header.background = "black", header.color = "white", size=9)

<table class="table table-striped table-condensed" style="font-size: 9px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
Summary descriptive tables
</caption>
<thead>
<tr>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; color: white !important;padding-right: 4px; padding-left: 4px; background-color: black !important;" colspan="1">

<br>

</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; color: white !important;padding-right: 4px; padding-left: 4px; background-color: black !important;" colspan="4">

Male

</th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; color: white !important;padding-right: 4px; padding-left: 4px; background-color: black !important;" colspan="4">

Female

</th>
</tr>
<tr>
<th style="text-align:left;color: white !important;background-color: black !important;">
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
1995
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
2000
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
2005
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
p.overall
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
1995
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
2000
</th>
<th style="text-align:center;color: white !important;background-color: black !important;">
2005
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
N=206
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=390
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=505
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=225
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=396
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=572
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
</tr>
<tr>
<td style="text-align:left;">
Age
</td>
<td style="text-align:center;">
54.1±11.8
</td>
<td style="text-align:center;">
54.3±11.2
</td>
<td style="text-align:center;">
55.4±10.7
</td>
<td style="text-align:center;">
0.211
</td>
<td style="text-align:center;">
54.1±11.7
</td>
<td style="text-align:center;">
54.4±11.2
</td>
<td style="text-align:center;">
55.2±10.6
</td>
<td style="text-align:center;">
0.355
</td>
</tr>
<tr>
<td style="text-align:left;">
Smoking status:
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Never smoker
</td>
<td style="text-align:center;">
52 (26.5%)
</td>
<td style="text-align:center;">
112 (29.7%)
</td>
<td style="text-align:center;">
137 (27.5%)
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
182 (83.1%)
</td>
<td style="text-align:center;">
302 (79.3%)
</td>
<td style="text-align:center;">
416 (74.0%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Current or former &lt; 1y
</td>
<td style="text-align:center;">
77 (39.3%)
</td>
<td style="text-align:center;">
199 (52.8%)
</td>
<td style="text-align:center;">
134 (26.9%)
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
32 (14.6%)
</td>
<td style="text-align:center;">
68 (17.8%)
</td>
<td style="text-align:center;">
83 (14.8%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Former &gt;= 1y
</td>
<td style="text-align:center;">
67 (34.2%)
</td>
<td style="text-align:center;">
66 (17.5%)
</td>
<td style="text-align:center;">
227 (45.6%)
</td>
<td style="text-align:center;">
</td>
<td style="text-align:center;">
5 (2.28%)
</td>
<td style="text-align:center;">
11 (2.89%)
</td>
<td style="text-align:center;">
63 (11.2%)
</td>
<td style="text-align:center;">
</td>
</tr>
<tr>
<td style="text-align:left;">
Systolic blood pressure
</td>
<td style="text-align:center;">
134±18.4
</td>
<td style="text-align:center;">
137±19.3
</td>
<td style="text-align:center;">
132±18.7
</td>
<td style="text-align:center;">
0.003
</td>
<td style="text-align:center;">
132±19.8
</td>
<td style="text-align:center;">
129±22.6
</td>
<td style="text-align:center;">
127±20.5
</td>
<td style="text-align:center;">
0.006
</td>
</tr>
<tr>
<td style="text-align:left;">
Diastolic blood pressure
</td>
<td style="text-align:center;">
79.0±9.27
</td>
<td style="text-align:center;">
83.0±9.54
</td>
<td style="text-align:center;">
81.7±10.8
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
75.2±11.3
</td>
<td style="text-align:center;">
78.6±10.6
</td>
<td style="text-align:center;">
78.3±10.0
</td>
<td style="text-align:center;">
0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
History of hypertension
</td>
<td style="text-align:center;">
50 (24.3%)
</td>
<td style="text-align:center;">
110 (28.2%)
</td>
<td style="text-align:center;">
181 (36.2%)
</td>
<td style="text-align:center;">
0.002
</td>
<td style="text-align:center;">
61 (27.1%)
</td>
<td style="text-align:center;">
123 (31.1%)
</td>
<td style="text-align:center;">
198 (34.8%)
</td>
<td style="text-align:center;">
0.097
</td>
</tr>
<tr>
<td style="text-align:left;">
Hypertension treatment
</td>
<td style="text-align:center;">
31 (15.0%)
</td>
<td style="text-align:center;">
48 (12.3%)
</td>
<td style="text-align:center;">
110 (22.8%)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
40 (17.8%)
</td>
<td style="text-align:center;">
79 (19.9%)
</td>
<td style="text-align:center;">
120 (21.7%)
</td>
<td style="text-align:center;">
0.446
</td>
</tr>
<tr>
<td style="text-align:left;">
Total cholesterol
</td>
<td style="text-align:center;">
224±43.9
</td>
<td style="text-align:center;">
224±43.9
</td>
<td style="text-align:center;">
210±40.3
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
226±42.4
</td>
<td style="text-align:center;">
224±44.9
</td>
<td style="text-align:center;">
216±50.3
</td>
<td style="text-align:center;">
0.004
</td>
</tr>
<tr>
<td style="text-align:left;">
HDL cholesterol
</td>
<td style="text-align:center;">
46.5±13.1
</td>
<td style="text-align:center;">
47.3±12.6
</td>
<td style="text-align:center;">
48.1±12.4
</td>
<td style="text-align:center;">
0.300
</td>
<td style="text-align:center;">
56.9±13.9
</td>
<td style="text-align:center;">
57.4±16.7
</td>
<td style="text-align:center;">
57.8±14.2
</td>
<td style="text-align:center;">
0.758
</td>
</tr>
<tr>
<td style="text-align:left;">
Triglycerides
</td>
<td style="text-align:center;">
110 \[79.0;149\]
</td>
<td style="text-align:center;">
113 \[84.0;145\]
</td>
<td style="text-align:center;">
108 \[79.0;149\]
</td>
<td style="text-align:center;">
0.825
</td>
<td style="text-align:center;">
86.0 \[66.0;113\]
</td>
<td style="text-align:center;">
87.0 \[66.0;118\]
</td>
<td style="text-align:center;">
90.0 \[66.0;128\]
</td>
<td style="text-align:center;">
0.496
</td>
</tr>
<tr>
<td style="text-align:left;">
LDL cholesterol
</td>
<td style="text-align:center;">
153±39.6
</td>
<td style="text-align:center;">
152±39.1
</td>
<td style="text-align:center;">
137±36.0
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
150±37.3
</td>
<td style="text-align:center;">
146±38.0
</td>
<td style="text-align:center;">
136±42.6
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
History of hyperchol.
</td>
<td style="text-align:center;">
48 (23.3%)
</td>
<td style="text-align:center;">
138 (35.8%)
</td>
<td style="text-align:center;">
167 (33.2%)
</td>
<td style="text-align:center;">
0.007
</td>
<td style="text-align:center;">
49 (21.8%)
</td>
<td style="text-align:center;">
118 (30.6%)
</td>
<td style="text-align:center;">
189 (33.3%)
</td>
<td style="text-align:center;">
0.006
</td>
</tr>
<tr>
<td style="text-align:left;">
Cholesterol treatment
</td>
<td style="text-align:center;">
17 (8.25%)
</td>
<td style="text-align:center;">
38 (9.84%)
</td>
<td style="text-align:center;">
59 (12.2%)
</td>
<td style="text-align:center;">
0.256
</td>
<td style="text-align:center;">
11 (4.89%)
</td>
<td style="text-align:center;">
30 (7.75%)
</td>
<td style="text-align:center;">
73 (13.2%)
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Height (cm)
</td>
<td style="text-align:center;">
170±7.34
</td>
<td style="text-align:center;">
168±7.17
</td>
<td style="text-align:center;">
170±7.43
</td>
<td style="text-align:center;">
0.020
</td>
<td style="text-align:center;">
158±6.31
</td>
<td style="text-align:center;">
156±6.50
</td>
<td style="text-align:center;">
158±6.24
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Weight (Kg)
</td>
<td style="text-align:center;">
77.6±11.7
</td>
<td style="text-align:center;">
80.1±12.3
</td>
<td style="text-align:center;">
80.2±11.6
</td>
<td style="text-align:center;">
0.021
</td>
<td style="text-align:center;">
67.3±11.3
</td>
<td style="text-align:center;">
67.6±12.6
</td>
<td style="text-align:center;">
67.7±13.0
</td>
<td style="text-align:center;">
0.910
</td>
</tr>
<tr>
<td style="text-align:left;">
Body mass index
</td>
<td style="text-align:center;">
26.9±3.64
</td>
<td style="text-align:center;">
28.2±3.89
</td>
<td style="text-align:center;">
27.9±3.58
</td>
<td style="text-align:center;">
&lt;0.001
</td>
<td style="text-align:center;">
27.2±4.57
</td>
<td style="text-align:center;">
28.0±5.25
</td>
<td style="text-align:center;">
27.3±5.39
</td>
<td style="text-align:center;">
0.079
</td>
</tr>
<tr>
<td style="text-align:left;">
Physical activity (Kcal/week)
</td>
<td style="text-align:center;">
422±418
</td>
<td style="text-align:center;">
356±362
</td>
<td style="text-align:center;">
439±467
</td>
<td style="text-align:center;">
0.009
</td>
<td style="text-align:center;">
553±412
</td>
<td style="text-align:center;">
486±382
</td>
<td style="text-align:center;">
273±253
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Physical component
</td>
<td style="text-align:center;">
50.1±6.71
</td>
<td style="text-align:center;">
50.9±8.58
</td>
<td style="text-align:center;">
51.5±8.07
</td>
<td style="text-align:center;">
0.068
</td>
<td style="text-align:center;">
48.6±9.16
</td>
<td style="text-align:center;">
47.1±10.2
</td>
<td style="text-align:center;">
48.9±9.45
</td>
<td style="text-align:center;">
0.034
</td>
</tr>
<tr>
<td style="text-align:left;">
Mental component
</td>
<td style="text-align:center;">
52.1±9.67
</td>
<td style="text-align:center;">
50.9±10.2
</td>
<td style="text-align:center;">
49.2±9.67
</td>
<td style="text-align:center;">
0.001
</td>
<td style="text-align:center;">
46.5±12.2
</td>
<td style="text-align:center;">
46.9±11.3
</td>
<td style="text-align:center;">
44.7±11.2
</td>
<td style="text-align:center;">
0.016
</td>
</tr>
<tr>
<td style="text-align:left;">
Cardiovascular event
</td>
<td style="text-align:center;">
6 (3.06%)
</td>
<td style="text-align:center;">
21 (5.74%)
</td>
<td style="text-align:center;">
19 (3.96%)
</td>
<td style="text-align:center;">
0.272
</td>
<td style="text-align:center;">
4 (1.98%)
</td>
<td style="text-align:center;">
14 (3.73%)
</td>
<td style="text-align:center;">
28 (5.15%)
</td>
<td style="text-align:center;">
0.139
</td>
</tr>
<tr>
<td style="text-align:left;">
Days to cardiovascular event or end of follow-up
</td>
<td style="text-align:center;">
1619 \[719;2715\]
</td>
<td style="text-align:center;">
1613 \[667;2509\]
</td>
<td style="text-align:center;">
1822 \[897;2794\]
</td>
<td style="text-align:center;">
0.043
</td>
<td style="text-align:center;">
1828 \[853;2779\]
</td>
<td style="text-align:center;">
1617 \[772;2679\]
</td>
<td style="text-align:center;">
1750 \[746;2692\]
</td>
<td style="text-align:center;">
0.427
</td>
</tr>
<tr>
<td style="text-align:left;">
Overall death
</td>
<td style="text-align:center;">
12 (6.45%)
</td>
<td style="text-align:center;">
46 (12.5%)
</td>
<td style="text-align:center;">
29 (6.08%)
</td>
<td style="text-align:center;">
0.002
</td>
<td style="text-align:center;">
6 (2.99%)
</td>
<td style="text-align:center;">
35 (9.43%)
</td>
<td style="text-align:center;">
45 (8.24%)
</td>
<td style="text-align:center;">
0.018
</td>
</tr>
<tr>
<td style="text-align:left;">
Days to overall death or end of follow-up
</td>
<td style="text-align:center;">
1557 \[836;2680\]
</td>
<td style="text-align:center;">
1606 \[751;2490\]
</td>
<td style="text-align:center;">
1688 \[785;2516\]
</td>
<td style="text-align:center;">
0.947
</td>
<td style="text-align:center;">
1587 \[786;2717\]
</td>
<td style="text-align:center;">
1620 \[730;2583\]
</td>
<td style="text-align:center;">
1809 \[867;2804\]
</td>
<td style="text-align:center;">
0.141
</td>
</tr>
</tbody>
</table>

### Visual exploration

<table>
<colgroup>
<col style="width: 46%" />
<col style="width: 53%" />
</colgroup>
<tbody>
<tr>
<td style="text-align: center;"><code>plot(tab["sex"])</code></td>
<td style="text-align: center;"><code>plot(tab["age"])</code></td>
</tr>
<tr>
<td style="text-align: center;"><img src="./man/figures/var1sex.png"
alt="image not found" /></td>
<td style="text-align: center;"><img src="./man/figures/var1age.png"
alt="image not found" /></td>
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
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
    regicor$tcv <- Surv(regicor$tocv, regicor$cv=="Yes")

    tabhr <- descrTable(tcv ~ .-id-cv-tocv, regicor, 
               method=c(triglyc=2, tocv=2, todeath=2),
               hide.no="no", ref.no="no",
               show.ratio=TRUE, show.p.overall=FALSE)


    export2md(tabhr[1:10], header.label=c("p.ratio"="p-value"),
              caption="Descriptives by cardiovascular event")  

<table class="table table-striped table-condensed" style="width: auto !important; margin-left: auto; margin-right: auto;">
<caption>
Descriptives by cardiovascular event
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
p-value
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=2071
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
N=92
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
<td style="text-align:center;font-style: italic;border-bottom: 1px solid grey">
</td>
</tr>
<tr>
<td style="text-align:left;">
Recruitment year:
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
1995
</td>
<td style="text-align:center;">
388 (18.7%)
</td>
<td style="text-align:center;">
10 (10.9%)
</td>
<td style="text-align:center;">
Ref.
</td>
<td style="text-align:center;">
Ref.
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
2000
</td>
<td style="text-align:center;">
706 (34.1%)
</td>
<td style="text-align:center;">
35 (38.0%)
</td>
<td style="text-align:center;">
1.95 \[0.96;3.93\]
</td>
<td style="text-align:center;">
0.063
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
2005
</td>
<td style="text-align:center;">
977 (47.2%)
</td>
<td style="text-align:center;">
47 (51.1%)
</td>
<td style="text-align:center;">
1.82 \[0.92;3.59\]
</td>
<td style="text-align:center;">
0.087
</td>
</tr>
<tr>
<td style="text-align:left;">
Age
</td>
<td style="text-align:center;">
54.6 (11.1)
</td>
<td style="text-align:center;">
57.5 (11.0)
</td>
<td style="text-align:center;">
1.02 \[1.00;1.04\]
</td>
<td style="text-align:center;">
0.021
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Male
</td>
<td style="text-align:center;">
996 (48.1%)
</td>
<td style="text-align:center;">
46 (50.0%)
</td>
<td style="text-align:center;">
Ref.
</td>
<td style="text-align:center;">
Ref.
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Female
</td>
<td style="text-align:center;">
1075 (51.9%)
</td>
<td style="text-align:center;">
46 (50.0%)
</td>
<td style="text-align:center;">
0.92 \[0.61;1.39\]
</td>
<td style="text-align:center;">
0.696
</td>
</tr>
<tr>
<td style="text-align:left;">
Smoking status:
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
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Never smoker
</td>
<td style="text-align:center;">
1099 (54.3%)
</td>
<td style="text-align:center;">
37 (40.2%)
</td>
<td style="text-align:center;">
Ref.
</td>
<td style="text-align:center;">
Ref.
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Current or former &lt; 1y
</td>
<td style="text-align:center;">
506 (25.0%)
</td>
<td style="text-align:center;">
47 (51.1%)
</td>
<td style="text-align:center;">
2.67 \[1.74;4.11\]
</td>
<td style="text-align:center;">
&lt;0.001
</td>
</tr>
<tr>
<td style="text-align:left;padding-left: 2em;" indentlevel="1">
Former &gt;= 1y
</td>
<td style="text-align:center;">
419 (20.7%)
</td>
<td style="text-align:center;">
8 (8.70%)
</td>
<td style="text-align:center;">
0.55 \[0.26;1.18\]
</td>
<td style="text-align:center;">
0.123
</td>
</tr>
<tr>
<td style="text-align:left;">
Systolic blood pressure
</td>
<td style="text-align:center;">
131 (20.3)
</td>
<td style="text-align:center;">
138 (21.5)
</td>
<td style="text-align:center;">
1.02 \[1.01;1.02\]
</td>
<td style="text-align:center;">
0.001
</td>
</tr>
<tr>
<td style="text-align:left;">
Diastolic blood pressure
</td>
<td style="text-align:center;">
79.5 (10.4)
</td>
<td style="text-align:center;">
82.9 (12.3)
</td>
<td style="text-align:center;">
1.03 \[1.01;1.05\]
</td>
<td style="text-align:center;">
0.002
</td>
</tr>
<tr>
<td style="text-align:left;">
History of hypertension
</td>
<td style="text-align:center;">
647 (31.3%)
</td>
<td style="text-align:center;">
38 (41.3%)
</td>
<td style="text-align:center;">
1.52 \[1.01;2.31\]
</td>
<td style="text-align:center;">
0.047
</td>
</tr>
<tr>
<td style="text-align:left;">
Hypertension treatment
</td>
<td style="text-align:center;">
382 (18.7%)
</td>
<td style="text-align:center;">
22 (23.9%)
</td>
<td style="text-align:center;">
1.37 \[0.85;2.22\]
</td>
<td style="text-align:center;">
0.195
</td>
</tr>
<tr>
<td style="text-align:left;">
Total cholesterol
</td>
<td style="text-align:center;">
218 (44.5)
</td>
<td style="text-align:center;">
224 (50.4)
</td>
<td style="text-align:center;">
1.00 \[1.00;1.01\]
</td>
<td style="text-align:center;">
0.207
</td>
</tr>
<tr>
<td style="text-align:left;">
HDL cholesterol
</td>
<td style="text-align:center;">
52.8 (14.8)
</td>
<td style="text-align:center;">
50.4 (13.3)
</td>
<td style="text-align:center;">
0.99 \[0.97;1.00\]
</td>
<td style="text-align:center;">
0.114
</td>
</tr>
</tbody>
</table>

### Web-based User Interface

For those not familiar to R syntax, a Web User Interface (**WUI**) has
been implemented using [Shiny](https://shiny.rstudio.com/) tools, which
can be used off line by typing `cGroupsWUI()` after having
`compareGroups` package installed and loaded, or remotely just accessing
the application hosted in a [shinyapp.io
server](https://isubirana.shinyapps.io/compareGroups/).

<img src="./man/figures/WUI.png" alt="image not found"/>
