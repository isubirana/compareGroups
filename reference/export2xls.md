# Exporting descriptives table to Exel format (.xlsx or .xls)

This function takes the result of `createTable` and exports the tables
to Excel format (.xlsx or .xls).

## Usage

``` r
export2xls(x, file, which.table="descr", nmax=TRUE, nmax.method=1, header.labels=c())
```

## Arguments

- x:

  an object of class 'createTable'.

- file:

  file where table in Excel format will be written.

- which.table:

  character indicating which table is printed. Possible values are
  'descr', 'avail' or 'both' (partial matching allowed), exporting
  descriptives by groups table, availability data table or both tables,
  respectively. In the latter case ('both'), two sheets are built, one
  for each table. Default value is 'descr'.

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

## Note

The way to compute the 'N' shown in the bivariate table header,
controlled by 'nmax' argument, has been changed from previous versions
(\<1.3). In the older versions 'N' was computed as the maximum across
the cells withing each column (group) from the 'available data' table
('avail').

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md),
[`export2latex`](https://isubirana.github.io/compareGroups/index.html/reference/export2latex.md),
[`export2pdf`](https://isubirana.github.io/compareGroups/index.html/reference/export2pdf.md),
[`export2csv`](https://isubirana.github.io/compareGroups/index.html/reference/export2csv.md),
[`export2md`](https://isubirana.github.io/compareGroups/index.html/reference/export2md.md),
[`export2word`](https://isubirana.github.io/compareGroups/index.html/reference/export2word.md)

## Examples

``` r
if (FALSE) { # \dontrun{
require(compareGroups)
data(regicor)
res <- compareGroups(sex ~. -id-todeath-death-tocv-cv, regicor)
export2xls(createTable(res, hide.no = 'n'), file=tempfile(fileext=".xlsx"))
} # }
```
