# Update p values according multiple comparisons

Given a compareGroups object, returns their p-values adjusted using one
of several methods (stats::p.adjust)

## Usage

``` r
padjustCompareGroups(object_compare, p = "p.overall", method = "BH")
```

## Author

Jordi Real \<jordireal\<at\>gmail.com\>

## Arguments

- object_compare:

  object of class `compareGroups`

- p:

  character string. Specify which p-value must be corrected. Possible
  values are 'p.overall' and 'p.trend' (default: 'p.overall')

- method:

  Correction method, a character string. Can be abbreviated (see
  [`p.adjust`](https://rdrr.io/r/stats/p.adjust.html)).

## Value

compareGroups class with corrected p-values

## Examples

``` r
# Define simulated data 
set.seed(123)
N_obs<-100
N_vars<-50 
data<-matrix(rnorm(N_obs*N_vars), N_obs, N_vars) 

sim_data<-data.frame(data,Y=rbinom(N_obs,1,0.5))

# Execute compareGroups
res<-compareGroups(Y~.,data=sim_data)
res
#> 
#> 
#> -------- Summary of results by groups of 'Y'---------
#> 
#> 
#>    var N   p.value method            selection
#> 1  X1  100 0.859   continuous normal ALL      
#> 2  X2  100 0.729   continuous normal ALL      
#> 3  X3  100 0.882   continuous normal ALL      
#> 4  X4  100 0.322   continuous normal ALL      
#> 5  X5  100 0.115   continuous normal ALL      
#> 6  X6  100 0.878   continuous normal ALL      
#> 7  X7  100 0.663   continuous normal ALL      
#> 8  X8  100 0.064*  continuous normal ALL      
#> 9  X9  100 0.971   continuous normal ALL      
#> 10 X10 100 0.828   continuous normal ALL      
#> 11 X11 100 0.494   continuous normal ALL      
#> 12 X12 100 0.521   continuous normal ALL      
#> 13 X13 100 0.404   continuous normal ALL      
#> 14 X14 100 0.539   continuous normal ALL      
#> 15 X15 100 0.723   continuous normal ALL      
#> 16 X16 100 0.828   continuous normal ALL      
#> 17 X17 100 0.133   continuous normal ALL      
#> 18 X18 100 0.442   continuous normal ALL      
#> 19 X19 100 0.869   continuous normal ALL      
#> 20 X20 100 0.332   continuous normal ALL      
#> 21 X21 100 0.497   continuous normal ALL      
#> 22 X22 100 0.132   continuous normal ALL      
#> 23 X23 100 0.091*  continuous normal ALL      
#> 24 X24 100 0.005** continuous normal ALL      
#> 25 X25 100 0.369   continuous normal ALL      
#> 26 X26 100 0.134   continuous normal ALL      
#> 27 X27 100 0.063*  continuous normal ALL      
#> 28 X28 100 0.791   continuous normal ALL      
#> 29 X29 100 0.235   continuous normal ALL      
#> 30 X30 100 0.928   continuous normal ALL      
#> 31 X31 100 0.923   continuous normal ALL      
#> 32 X32 100 0.436   continuous normal ALL      
#> 33 X33 100 0.827   continuous normal ALL      
#> 34 X34 100 0.234   continuous normal ALL      
#> 35 X35 100 0.433   continuous normal ALL      
#> 36 X36 100 0.121   continuous normal ALL      
#> 37 X37 100 0.555   continuous normal ALL      
#> 38 X38 100 0.415   continuous normal ALL      
#> 39 X39 100 0.905   continuous normal ALL      
#> 40 X40 100 0.897   continuous normal ALL      
#> 41 X41 100 0.095*  continuous normal ALL      
#> 42 X42 100 0.601   continuous normal ALL      
#> 43 X43 100 0.003** continuous normal ALL      
#> 44 X44 100 0.224   continuous normal ALL      
#> 45 X45 100 0.303   continuous normal ALL      
#> 46 X46 100 0.324   continuous normal ALL      
#> 47 X47 100 0.720   continuous normal ALL      
#> 48 X48 100 0.017** continuous normal ALL      
#> 49 X49 100 0.233   continuous normal ALL      
#> 50 X50 100 0.852   continuous normal ALL      
#> -----
#> Signif. codes:  0 '**' 0.05 '*' 0.1 ' ' 1 
#> 

# update p values
res_adjusted<-padjustCompareGroups(res)
res_adjusted
#> 
#> 
#> -------- Summary of results by groups of 'Y'---------
#> 
#> 
#>    var N   p.value method            selection
#> 1  X1  100 0.947   continuous normal ALL      
#> 2  X2  100 0.947   continuous normal ALL      
#> 3  X3  100 0.947   continuous normal ALL      
#> 4  X4  100 0.831   continuous normal ALL      
#> 5  X5  100 0.557   continuous normal ALL      
#> 6  X6  100 0.947   continuous normal ALL      
#> 7  X7  100 0.947   continuous normal ALL      
#> 8  X8  100 0.557   continuous normal ALL      
#> 9  X9  100 0.971   continuous normal ALL      
#> 10 X10 100 0.947   continuous normal ALL      
#> 11 X11 100 0.887   continuous normal ALL      
#> 12 X12 100 0.896   continuous normal ALL      
#> 13 X13 100 0.850   continuous normal ALL      
#> 14 X14 100 0.896   continuous normal ALL      
#> 15 X15 100 0.947   continuous normal ALL      
#> 16 X16 100 0.947   continuous normal ALL      
#> 17 X17 100 0.557   continuous normal ALL      
#> 18 X18 100 0.850   continuous normal ALL      
#> 19 X19 100 0.947   continuous normal ALL      
#> 20 X20 100 0.831   continuous normal ALL      
#> 21 X21 100 0.887   continuous normal ALL      
#> 22 X22 100 0.557   continuous normal ALL      
#> 23 X23 100 0.557   continuous normal ALL      
#> 24 X24 100 0.135   continuous normal ALL      
#> 25 X25 100 0.850   continuous normal ALL      
#> 26 X26 100 0.557   continuous normal ALL      
#> 27 X27 100 0.557   continuous normal ALL      
#> 28 X28 100 0.947   continuous normal ALL      
#> 29 X29 100 0.733   continuous normal ALL      
#> 30 X30 100 0.947   continuous normal ALL      
#> 31 X31 100 0.947   continuous normal ALL      
#> 32 X32 100 0.850   continuous normal ALL      
#> 33 X33 100 0.947   continuous normal ALL      
#> 34 X34 100 0.733   continuous normal ALL      
#> 35 X35 100 0.850   continuous normal ALL      
#> 36 X36 100 0.557   continuous normal ALL      
#> 37 X37 100 0.896   continuous normal ALL      
#> 38 X38 100 0.850   continuous normal ALL      
#> 39 X39 100 0.947   continuous normal ALL      
#> 40 X40 100 0.947   continuous normal ALL      
#> 41 X41 100 0.557   continuous normal ALL      
#> 42 X42 100 0.939   continuous normal ALL      
#> 43 X43 100 0.135   continuous normal ALL      
#> 44 X44 100 0.733   continuous normal ALL      
#> 45 X45 100 0.831   continuous normal ALL      
#> 46 X46 100 0.831   continuous normal ALL      
#> 47 X47 100 0.947   continuous normal ALL      
#> 48 X48 100 0.288   continuous normal ALL      
#> 49 X49 100 0.733   continuous normal ALL      
#> 50 X50 100 0.947   continuous normal ALL      
#> -----
#> Signif. codes:  0 '**' 0.05 '*' 0.1 ' ' 1 
#> 

# update p values using FDR method
res_adjusted<-padjustCompareGroups(res, method ="fdr")
res_adjusted
#> 
#> 
#> -------- Summary of results by groups of 'Y'---------
#> 
#> 
#>    var N   p.value method            selection
#> 1  X1  100 0.947   continuous normal ALL      
#> 2  X2  100 0.947   continuous normal ALL      
#> 3  X3  100 0.947   continuous normal ALL      
#> 4  X4  100 0.831   continuous normal ALL      
#> 5  X5  100 0.557   continuous normal ALL      
#> 6  X6  100 0.947   continuous normal ALL      
#> 7  X7  100 0.947   continuous normal ALL      
#> 8  X8  100 0.557   continuous normal ALL      
#> 9  X9  100 0.971   continuous normal ALL      
#> 10 X10 100 0.947   continuous normal ALL      
#> 11 X11 100 0.887   continuous normal ALL      
#> 12 X12 100 0.896   continuous normal ALL      
#> 13 X13 100 0.850   continuous normal ALL      
#> 14 X14 100 0.896   continuous normal ALL      
#> 15 X15 100 0.947   continuous normal ALL      
#> 16 X16 100 0.947   continuous normal ALL      
#> 17 X17 100 0.557   continuous normal ALL      
#> 18 X18 100 0.850   continuous normal ALL      
#> 19 X19 100 0.947   continuous normal ALL      
#> 20 X20 100 0.831   continuous normal ALL      
#> 21 X21 100 0.887   continuous normal ALL      
#> 22 X22 100 0.557   continuous normal ALL      
#> 23 X23 100 0.557   continuous normal ALL      
#> 24 X24 100 0.135   continuous normal ALL      
#> 25 X25 100 0.850   continuous normal ALL      
#> 26 X26 100 0.557   continuous normal ALL      
#> 27 X27 100 0.557   continuous normal ALL      
#> 28 X28 100 0.947   continuous normal ALL      
#> 29 X29 100 0.733   continuous normal ALL      
#> 30 X30 100 0.947   continuous normal ALL      
#> 31 X31 100 0.947   continuous normal ALL      
#> 32 X32 100 0.850   continuous normal ALL      
#> 33 X33 100 0.947   continuous normal ALL      
#> 34 X34 100 0.733   continuous normal ALL      
#> 35 X35 100 0.850   continuous normal ALL      
#> 36 X36 100 0.557   continuous normal ALL      
#> 37 X37 100 0.896   continuous normal ALL      
#> 38 X38 100 0.850   continuous normal ALL      
#> 39 X39 100 0.947   continuous normal ALL      
#> 40 X40 100 0.947   continuous normal ALL      
#> 41 X41 100 0.557   continuous normal ALL      
#> 42 X42 100 0.939   continuous normal ALL      
#> 43 X43 100 0.135   continuous normal ALL      
#> 44 X44 100 0.733   continuous normal ALL      
#> 45 X45 100 0.831   continuous normal ALL      
#> 46 X46 100 0.831   continuous normal ALL      
#> 47 X47 100 0.947   continuous normal ALL      
#> 48 X48 100 0.288   continuous normal ALL      
#> 49 X49 100 0.733   continuous normal ALL      
#> 50 X50 100 0.947   continuous normal ALL      
#> -----
#> Signif. codes:  0 '**' 0.05 '*' 0.1 ' ' 1 
#> 
```
