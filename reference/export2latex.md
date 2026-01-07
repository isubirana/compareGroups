# Exporting descriptives table to LaTeX format

This function takes the result of `createTable` and exports the tables
to LaTeX format.

## Usage

``` r
export2latex(x, ...)
# S3 method for class 'createTable'
export2latex(x, file, which.table = 'descr', size = 'same', 
    nmax = TRUE, nmax.method = 1, header.labels = c(), caption = NULL, 
    loc.caption = 'top', label = NULL, landscape = NA, colmax = 10, ...)
# S3 method for class 'cbind.createTable'
export2latex(x, file, which.table = 'descr', size = 'same', 
    nmax = TRUE, nmax.method = 1, header.labels = c(), caption = NULL, 
    loc.caption = 'top', label = NULL, landscape = NA, colmax = 10, ...)
```

## Arguments

- x:

  an object of class 'createTable'.

- file:

  Name of file where the resulting code should be saved. If file is
  missing, output is displayed on screen. Also, another file with the
  extension '\_appendix' is written with the available data table.

- which.table:

  character indicating which table is exported. Possible values are
  'descr', 'avail' or 'both' (partial matching allowed), exporting
  descriptives by groups table, availability data table or both tables,
  respectively. Default value is 'descr'.

- size:

  character indicating the size of the table elements. Possible values
  are: 'tiny', 'scriptsize', 'footnotesize', 'small', 'normalsize',
  'large', 'Large', 'LARGE','huge', 'Huge' or 'same' (partial matching
  allowed). Default value is 'same' which means that font size of the
  table is the same as specified in the main LaTeX document.

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

- caption:

  character specifying the table caption for descriptives and available
  data table. If which.table='both' the first element of 'caption' will
  be assigned to descriptives table and the second to available data
  table. If it is set to "", no caption is inserted. Default value is
  NULL, which writes 'Summary descriptives table by groups of 'y” for
  descriptives table and 'Available data by groups of 'y” for the
  available data table.

- label:

  character specifying the table label for descriptives and available
  data table. This may be useful to cite the tables elsewhere in the
  LaTeX document. If which.table='both' the first element of 'label'
  will be assigned to descriptives table and the second to available
  data table. Default value is NULL, which assigns no label to the
  table/s.

- loc.caption:

  character specifying the table caption location. Possible values are
  'top' or 'bottom' (partial matching allowed). Default value is 'top'.

- landscape:

  logical indicating whether the table must be placed in landscape, or
  NA that places the table in landscape when there are more than
  'colmax' columns. Default value is NA.

- colmax:

  integer indicating the maximum number of columns to make the table not
  to be placed in landscape. This argument is only applied when
  'landscape' argument is NA. Default value is 10.

- ...:

  currently ignored.

## Value

List of two possible components corresponding to the code of 'descr'
table and 'avail' table. Each component of the list is a character
corresponding to the LaTeX code of these tables which can be helpful for
post-processing.

## Note

The table is created in LaTeX language using the longtable environment.
Therefore, it is necessary to type `\includepackage{longtable}` in the
preamble of the LaTeX main document where the table code is inserted.
Also, it it necessary to include the 'multirow' LaTeX package. \\

The way to compute the 'N' shown in the bivariate table header,
controlled by 'nmax' argument, has been changed from previous versions
(\<1.3). In the older versions 'N' was computed as the maximum across
the cells withing each column (group) from the 'available data' table
('avail'). \\

When 'landscape' argument is TRUE or there are more than 'colmax'
columns and 'landscape' is set to NA, LaTeX package 'lscape' must be
loaded in the tex document.

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md),
[`export2csv`](https://isubirana.github.io/compareGroups/index.html/reference/export2csv.md),
[`export2html`](https://isubirana.github.io/compareGroups/index.html/reference/export2html.md),
[`export2pdf`](https://isubirana.github.io/compareGroups/index.html/reference/export2pdf.md),
[`export2md`](https://isubirana.github.io/compareGroups/index.html/reference/export2md.md),
[`export2word`](https://isubirana.github.io/compareGroups/index.html/reference/export2word.md)

## Examples

``` r
if (FALSE) { # \dontrun{
require(compareGroups)
data(regicor)
res <- compareGroups(sex ~. -id-todeath-death-tocv-cv, regicor)
export2latex(createTable(res, hide.no = 'n'), file=tempfile(fileext=".tex"))
} # }
```
