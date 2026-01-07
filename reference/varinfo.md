# Variable names and labels extraction

This functions builds and prints a table with the variable names and
their labels.

## Usage

``` r
varinfo(x, ...)
# S3 method for class 'compareGroups'
varinfo(x, ...)
# S3 method for class 'createTable'
varinfo(x, ...)
```

## Arguments

- x:

  an object of class 'compareGroups' or 'createTable'

- ...:

  other arguments currently ignored

## Details

By default, a compareGroup descriptives table lists variables by label
(if one exists) rather than by name. If researchers have assigned
detailed labels to their variables, this function is very useful to
quickly locate the original variable name if some modification is
required. This function simply lists all "Analyzed variable names" by
"Orig varname" (i.e. variable name in the data.frame) and "Shown
varname" (i.e., label).

## Value

A 'matrix' with two columns

- Orig varname:

  actual variable name in the 'data.frame' or in the 'parent
  environment'.

- Shown varname:

  names of the variable shown in the resulting tables.

## Note

If a variable has no "label" attribute, then the 'original varname' is
the same as the 'shown varname'. The first variable in the table
corresponds to the grouping variable. To label non-labeled variables or
to change the label, specify its "label" attribute..

## See also

[`compareGroups`](https://isubirana.github.io/compareGroups/index.html/reference/compareGroups.md),
[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md)

## Examples

``` r
require(compareGroups)
data(regicor)
res<-compareGroups(sex ~ . ,regicor)
#createTable(res, hide.no = 'no')  
varinfo(res)
#> 
#> --- Analyzed variable names ----
#> 
#>    Orig varname Shown varname                                   
#> 1  sex          Sex                                             
#> 2  id           Individual id                                   
#> 3  year         Recruitment year                                
#> 4  age          Age                                             
#> 5  smoker       Smoking status                                  
#> 6  sbp          Systolic blood pressure                         
#> 7  dbp          Diastolic blood pressure                        
#> 8  histhtn      History of hypertension                         
#> 9  txhtn        Hypertension treatment                          
#> 10 chol         Total cholesterol                               
#> 11 hdl          HDL cholesterol                                 
#> 12 triglyc      Triglycerides                                   
#> 13 ldl          LDL cholesterol                                 
#> 14 histchol     History of hyperchol.                           
#> 15 txchol       Cholesterol treatment                           
#> 16 height       Height (cm)                                     
#> 17 weight       Weight (Kg)                                     
#> 18 bmi          Body mass index                                 
#> 19 phyact       Physical activity (Kcal/week)                   
#> 20 pcs          Physical component                              
#> 21 mcs          Mental component                                
#> 22 cv           Cardiovascular event                            
#> 23 tocv         Days to cardiovascular event or end of follow-up
#> 24 death        Overall death                                   
#> 25 todeath      Days to overall death or end of follow-up       
```
