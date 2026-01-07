# Exporting descriptives table to plain text (CSV) format

This function takes the result of `createTable` and exports the tables
to plain text (CSV) format.

## Usage

``` r
export2csv(x, file, which.table="descr", sep=",", nmax = TRUE, nmax.method = 1, 
           header.labels = c(), ...)
```

## Arguments

- x:

  an object of class 'createTable'.

- file:

  file where table in CSV format will be written. Also, another file
  with the extension '\_appendix' is written with the available data
  table.

- which.table:

  character indicating which table is printed. Possible values are
  'descr', 'avail' or 'both' (partial matching allowed), exporting
  descriptives by groups table, available data table or both tables,
  respectively. Default value is 'descr'.

- sep:

  character. The variable separator, same as 'sep' argument from
  [`write.table`](https://rdrr.io/r/utils/write.table.html). Default
  value is ','.

- nmax:

  logical, indicating whether to show the number of subjects with at
  least one valid value across all row-variables. Default value is TRUE.

- nmax.method:

  integer with two possible values: 1-number of observation with valid
  values in at least one row-variable; 2-total number of observations or
  rows in the data set or in the group. Default value is 1.

- header.labels:

  see the 'header.labels' argument from
  [`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md).

- ...:

  other arguments passed to
  [`write.table`](https://rdrr.io/r/utils/write.table.html).

## Note

The default way to compute the 'N' shown in the bivariate table header,
controlled by 'nmax' argument, has been changed from previous versions
(\<1.3). In the older versions 'N' was computed as the maximum across
the cells withing each column (group) from the 'available data' table
('avail').

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md),
[`export2latex`](https://isubirana.github.io/compareGroups/index.html/reference/export2latex.md),
[`export2pdf`](https://isubirana.github.io/compareGroups/index.html/reference/export2pdf.md),
[`export2html`](https://isubirana.github.io/compareGroups/index.html/reference/export2html.md),
[`export2md`](https://isubirana.github.io/compareGroups/index.html/reference/export2md.md),
[`export2word`](https://isubirana.github.io/compareGroups/index.html/reference/export2word.md)

## Examples

``` r
if (FALSE) { # \dontrun{
require(compareGroups)
data(regicor)
res <- compareGroups(sex ~. -id-todeath-death-tocv-cv, regicor)
export2csv(createTable(res, hide.no = 'n'), file=tempfile(fileext=".csv"))
} # }
```
