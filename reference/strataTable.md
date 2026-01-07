# Stratify descriptive table in stratas.

This functions re-build a descriptive table in stratas defined by a
variable.

## Usage

``` r
strataTable(x, strata, strata.names = NULL, max.nlevels = 5)
```

## Arguments

- x:

  an object of class 'createTable'

- strata:

  character specifying the name of the variable whose values or levels
  defines strata.

- strata.names:

  character vector with as many components as stratas, or NULL (default
  value). If NULL, it takes the names of levels of strata variable.

- max.nlevels:

  an integer indicating the maximum number of unique values or levels of
  strata variable. Default value is 5.

## Value

An object of class 'cbind.createTable'.

## References

Isaac Subirana, Hector Sanz, Joan Vila (2014). Building Bivariate
Tables: The compareGroups Package for R. Journal of Statistical
Software, 57(12), 1-16. URL <https://www.jstatsoft.org/v57/i12/>.

## See also

[`compareGroups`](https://isubirana.github.io/compareGroups/index.html/reference/compareGroups.md),
[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md),
[`descrTable`](https://isubirana.github.io/compareGroups/index.html/reference/descrTable.md)

## Examples

``` r
require(compareGroups)

# load REGICOR data
data(regicor)

# compute the descriptive tables (by year)
restab <- descrTable(year ~ . - id - sex, regicor, hide.no="no")

# re-build the table stratifying by gender
strataTable(restab, "sex")
#> 
#> --------Summary descriptives table ---------
#> 
#> _____________________________________________________________________________________________________________________________________________
#>                                                                      Male                                          Female                    
#>                                                  _____________________________________________  _____________________________________________
#>                                                     1995        2000        2005     p.overall     1995        2000        2005     p.overall 
#>                                                     N=206       N=390       N=505                  N=225       N=396       N=572              
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
#> Age                                              54.1 (11.8) 54.3 (11.2) 55.4 (10.7)   0.211    54.1 (11.7) 54.4 (11.2) 55.2 (10.6)   0.355   
#> Smoking status:                                                                       <0.001                                         <0.001   
#>     Never smoker                                 52 (26.5%)  112 (29.7%) 137 (27.5%)            182 (83.1%) 302 (79.3%) 416 (74.0%)           
#>     Current or former < 1y                       77 (39.3%)  199 (52.8%) 134 (26.9%)            32 (14.6%)  68 (17.8%)  83 (14.8%)            
#>     Former >= 1y                                 67 (34.2%)  66 (17.5%)  227 (45.6%)             5 (2.28%)  11 (2.89%)  63 (11.2%)            
#> Systolic blood pressure                          134 (18.4)  137 (19.3)  132 (18.7)    0.003    132 (19.8)  129 (22.6)  127 (20.5)    0.006   
#> Diastolic blood pressure                         79.0 (9.27) 83.0 (9.54) 81.7 (10.8)  <0.001    75.2 (11.3) 78.6 (10.6) 78.3 (10.0)   0.001   
#> History of hypertension                          50 (24.3%)  110 (28.2%) 181 (36.2%)   0.002    61 (27.1%)  123 (31.1%) 198 (34.8%)   0.097   
#> Hypertension treatment                           31 (15.0%)  48 (12.3%)  110 (22.8%)  <0.001    40 (17.8%)  79 (19.9%)  120 (21.7%)   0.446   
#> Total cholesterol                                224 (43.9)  224 (43.9)  210 (40.3)   <0.001    226 (42.4)  224 (44.9)  216 (50.3)    0.004   
#> HDL cholesterol                                  46.5 (13.1) 47.3 (12.6) 48.1 (12.4)   0.300    56.9 (13.9) 57.4 (16.7) 57.8 (14.2)   0.758   
#> Triglycerides                                    131 (91.5)  128 (81.1)  132 (90.3)    0.806    97.8 (47.9) 99.7 (55.1) 104 (57.6)    0.260   
#> LDL cholesterol                                  153 (39.6)  152 (39.1)  137 (36.0)   <0.001    150 (37.3)  146 (38.0)  136 (42.6)   <0.001   
#> History of hyperchol.                            48 (23.3%)  138 (35.8%) 167 (33.2%)   0.007    49 (21.8%)  118 (30.6%) 189 (33.3%)   0.006   
#> Cholesterol treatment                            17 (8.25%)  38 (9.84%)  59 (12.2%)    0.256    11 (4.89%)  30 (7.75%)  73 (13.2%)   <0.001   
#> Height (cm)                                      170 (7.34)  168 (7.17)  170 (7.43)    0.020    158 (6.31)  156 (6.50)  158 (6.24)   <0.001   
#> Weight (Kg)                                      77.6 (11.7) 80.1 (12.3) 80.2 (11.6)   0.021    67.3 (11.3) 67.6 (12.6) 67.7 (13.0)   0.910   
#> Body mass index                                  26.9 (3.64) 28.2 (3.89) 27.9 (3.58)  <0.001    27.2 (4.57) 28.0 (5.25) 27.3 (5.39)   0.079   
#> Physical activity (Kcal/week)                     422 (418)   356 (362)   439 (467)    0.009     553 (412)   486 (382)   273 (253)   <0.001   
#> Physical component                               50.1 (6.71) 50.9 (8.58) 51.5 (8.07)   0.068    48.6 (9.16) 47.1 (10.2) 48.9 (9.45)   0.034   
#> Mental component                                 52.1 (9.67) 50.9 (10.2) 49.2 (9.67)   0.001    46.5 (12.2) 46.9 (11.3) 44.7 (11.2)   0.016   
#> Cardiovascular event                              6 (3.06%)  21 (5.74%)  19 (3.96%)    0.272     4 (1.98%)  14 (3.73%)  28 (5.15%)    0.139   
#> Days to cardiovascular event or end of follow-up 1718 (1127) 1646 (1076) 1830 (1064)   0.044    1848 (1075) 1724 (1083) 1761 (1079)   0.421   
#> Overall death                                    12 (6.45%)  46 (12.5%)  29 (6.08%)    0.002     6 (2.99%)  35 (9.43%)  45 (8.24%)    0.018   
#> Days to overall death or end of follow-up        1690 (1031) 1664 (1034) 1682 (1027)   0.953    1735 (1055) 1684 (1067) 1825 (1075)   0.141   
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
```
