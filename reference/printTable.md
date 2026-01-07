# 'Nice' table format.

This functions prints a table on the console in a 'nice' format.

## Usage

``` r
printTable(obj, row.names = TRUE, justify = 'right')
```

## Arguments

- obj:

  an object of class 'data.frame' or 'matrix'. It must be at least two
  columns, the first columns is considered as the 'row.names' and is
  left justified (if the 'row.names' argument is set to TRUE), while the
  rest of the columns are right justified.

- row.names:

  logical indicating whether the first column or variable is treated as
  a 'row.names' column and must be left-justified. Default value is
  TRUE.

- justify:

  character as 'justify' argument from
  [`format`](https://rdrr.io/r/base/format.html) function. It applies to
  all columns of the data.frame or matrix when 'row.names' argument is
  FALSE or all columns excluding the first one otherwise. Default value
  is 'right'.

## Value

No object is returned.

## Note

This function may be usefull when printing a table with some results
with variables as the first column and a header. It adds 'nice' lines to
highlight the header and also the bottom of the table.

It has been used to print 'compareSNPs' objects.

## See also

[`compareSNPs`](https://isubirana.github.io/compareGroups/index.html/reference/compareSNPs.md)

## Examples

``` r
require(compareGroups)

data(regicor)

# example of the coefficients table from a linear regression
model <- lm(chol ~ age + sex + bmi, regicor)
results <- coef(summary(model))
results <- cbind(Var = rownames(results), round(results, 4))
printTable(results)
#> ________________________________________________ 
#> Var         Estimate Std. Error t value Pr(>|t|) 
#> ================================================ 
#> (Intercept) 175.5277      6.969 25.1869        0 
#> age           0.3525     0.0899  3.9233    1e-04 
#> sexFemale     3.3515     1.9302  1.7364   0.0826 
#> bmi           0.8076     0.2184  3.6977    2e-04 
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 

# or visualize the first rows of the iris data frame. 
# In this example, the first column is not treated as a row.names column and it is right justified.
printTable(head(iris), FALSE)
#> _________________________________________________________ 
#> Sepal.Length Sepal.Width Petal.Length Petal.Width Species 
#> ========================================================= 
#>          5.1         3.5          1.4         0.2  setosa 
#>          4.9         3.0          1.4         0.2  setosa 
#>          4.7         3.2          1.3         0.2  setosa 
#>          4.6         3.1          1.5         0.2  setosa 
#>          5.0         3.6          1.4         0.2  setosa 
#>          5.4         3.9          1.7         0.4  setosa 
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 

# the same example with columns centered
printTable(head(iris), FALSE, 'centre')
#> _________________________________________________________ 
#> Sepal.Length Sepal.Width Petal.Length Petal.Width Species 
#> ========================================================= 
#>     5.1          3.5         1.4          0.2     setosa  
#>     4.9          3.0         1.4          0.2     setosa  
#>     4.7          3.2         1.3          0.2     setosa  
#>     4.6          3.1         1.5          0.2     setosa  
#>     5.0          3.6         1.4          0.2     setosa  
#>     5.4          3.9         1.7          0.4     setosa  
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 

```
