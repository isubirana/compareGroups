# Table of missingness counts by groups.

This functions returns a table with the non-available frequencies from a
already build bivariate table.

## Usage

``` r
missingTable(obj,...)
```

## Arguments

- obj:

  either a 'compareGroups' or 'createTable' object.

- ...:

  other arguments passed to `createTable`.

## Value

An object of class 'createTable'. For further details, see 'value'
section of `createTable` help file.

## Note

This function returns an object of class 'createTable', and therefore
all methods implemented for 'createTable' objects can be applied, except
the 'update' method.

All arguments of `createTable` can be passed throught '...' argument,
except 'hide.no' argument which is fixed inside the code and cannot be
changed.

This function cannot be applied to stratified tables, i.e.
'rbind.createTable' and 'cbind.createTable'. If stratified missingness
table is desired, apply this function first to each table and then use
`cbind.createTable` or/and `rbind.createTable` functions to combine
exactly in the same way as 'createTable' objects. See 'example' section
below.

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md)

## Examples

``` r

require(compareGroups)

# load regicor data
data(regicor)

# table of descriptives by recruitment year
res <- compareGroups(year ~ age + sex + smoker + sbp + histhtn + 
         chol + txchol + bmi + phyact + pcs + death, regicor)
restab <- createTable(res, hide.no = "no")

# missingness table
missingTable(restab,type=1)
#> Warning: the standard deviation is zero
#> Warning: the standard deviation is zero
#> 
#> 
#> -------- Summary of results by groups of 'year'---------
#> 
#> 
#>    var     N    p.value  method      selection
#> 1  age     2294 .        categorical ALL      
#> 2  sex     2294 .        categorical ALL      
#> 3  smoker  2294 0.010**  categorical ALL      
#> 4  sbp     2294 <0.001** categorical ALL      
#> 5  histhtn 2294 0.015**  categorical ALL      
#> 6  chol    2294 <0.001** categorical ALL      
#> 7  txchol  2294 <0.001** categorical ALL      
#> 8  bmi     2294 0.318    categorical ALL      
#> 9  phyact  2294 <0.001** categorical ALL      
#> 10 pcs     2294 <0.001** categorical ALL      
#> 11 death   2294 0.001**  categorical ALL      
#> -----
#> Signif. codes:  0 '**' 0.05 '*' 0.1 ' ' 1 
#> 
#> 
#> --------Missingness table by 'year'---------
#> 
#> ____________________________________ 
#>         1995  2000   2005  p.overall 
#>         N=431 N=786 N=1077           
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
#> age     0.00% 0.00% 0.00%      .     
#> sex     0.00% 0.00% 0.00%      .     
#> smoker  3.71% 3.56% 1.58%    0.010   
#> sbp     0.70% 1.40% 0.00%   <0.001   
#> histhtn 0.00% 0.00% 0.74%    0.015   
#> chol    6.50% 9.03% 0.19%   <0.001   
#> txchol  0.00% 1.65% 3.90%   <0.001   
#> bmi     1.86% 1.91% 1.11%    0.318   
#> phyact  14.8% 2.80% 0.19%   <0.001   
#> pcs     7.89% 15.6% 7.71%   <0.001   
#> death   10.2% 6.11% 5.01%    0.001   
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 


if (FALSE) { # \dontrun{

# also create the missing table from a compareGroups object
miss <- missingTable(res)
miss

# some methods that works for createTable objects also works for objects 
#   computed by missTable function.
miss[1:4]
varinfo(miss)
plot(miss)

#... but update methods cannot be applied (this returns an error).
update(miss,type=2) 

} # }

```
