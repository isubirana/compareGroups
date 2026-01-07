# Exporting descriptives table to Markdown format

This function takes the result of `createTable` and exports the tables
to markdown format. It may be useful when inserting R code chunks in a
Markdown file (.Rmd).

## Usage

``` r
export2md(x, which.table = "descr", nmax = TRUE, nmax.method = 1, header.labels = c(),
          caption = NULL, format = "html", width = Inf, strip = FALSE, 
          first.strip = FALSE, background = "#D2D2D2", size = NULL, landscape=FALSE, 
          header.background=NULL, header.color=NULL, position="center", ...)
```

## Arguments

- x:

  an object of class 'createTable'.

- which.table:

  character indicating which table is printed. Possible values are
  'descr' or 'avail'(partial matching allowed), exporting descriptives
  by groups table or availability data table, respectively. Default
  value is 'descr'.

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

- format:

  character with three options: 'html', 'latex' or 'markdown'. If
  missing, it tries to guess the default options of Rmarkdown file in
  which the table in inserted, or html if it is not in a Rmarkdown file
  or format not specified.

- width:

  character string to specify the width of first column of descriptive
  table. It is ignored when exporting to Word. Default value is `Inf`
  which makes the first column to autoadjust to variable names. Other
  examples are '10cm', '3in' or '30em'.

- strip:

  logical. It shadows table lines corresponding to each variable.

- first.strip:

  logical. It determines whether to shadow the first variable (TRUE) or
  the second (FALSE). It only applies when `strip` argument is true.

- background:

  color code in HEX format for shadowed lines. You can use `rgb`
  function to convert red, green and blue to HEX code. Default color is
  '#D2D2D2'.

- size:

  numeric. Size of descriptive table. Default value is NULL which
  creates the table in default size.

- landscape:

  logical. It determines whether to place the table in landscape
  (horizontal) format. It only applies when format is 'latex'. Default
  value is FALSE.

- header.background:

  color character for table header or 'NULL'. Default value is 'NULL'.

- header.color:

  color character for table header text. Default color is 'NULL'.

- position:

  character specifying the table location. Possible values are 'left',
  'center', 'right', 'float_left' and 'float_right'. It only applies
  when compiling to HTML or PDF. Default value is 'center'. See
  [`kable_styling`](https://rdrr.io/pkg/kableExtra/man/kable_styling.html)
  position argument for more info.

- ...:

  arguments passed to
  [`kable`](https://rdrr.io/pkg/knitr/man/kable.html).

## Value

It does not return anything, but the Markdown code to generate the
descriptive or available table is printed.

## Note

The way to compute the 'N' shown in the bivariate table header,
controlled by 'nmax' argument, has been changed from previous versions
(\<1.3). In the older versions 'N' was computed as the maximum across
the cells withing each column (group) from the 'available data' table
('avail').

Stratified tables, i.e. `cbind.createTable` class, are not supported
when creating a Word document.

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md),
[`export2latex`](https://isubirana.github.io/compareGroups/index.html/reference/export2latex.md),
[`export2pdf`](https://isubirana.github.io/compareGroups/index.html/reference/export2pdf.md),
[`export2csv`](https://isubirana.github.io/compareGroups/index.html/reference/export2csv.md),
[`export2html`](https://isubirana.github.io/compareGroups/index.html/reference/export2html.md),
[`export2word`](https://isubirana.github.io/compareGroups/index.html/reference/export2word.md)

## Examples
