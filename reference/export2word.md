# Exports tables to Word files.

This function creates automatically a Word file with the table.

## Usage

``` r
export2word(x, file, which.table="descr", nmax=TRUE, header.labels=c(), 
            caption=NULL, strip=FALSE, first.strip=FALSE, background="#D2D2D2", 
            size=NULL, header.background=NULL, header.color=NULL)
```

## Arguments

- x:

  an object of class 'createTable' or that inherits it.

- file:

  character specifying the word file (.doc or .docx) resulting after
  compiling the Markdown code corresponding to the table specified in
  the 'x' argument.

- which.table:

  character indicating which table is printed. Possible values are
  'descr' or 'avail'(partial matching allowed), exporting descriptives
  by groups table or availability data table, respectively. Default
  value is 'descr'.

- nmax:

  logical, indicating whether to show the number of subjects with at
  least one valid value across all row-variables. Default value is TRUE.

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

- header.background:

  color character for table header or 'NULL'. Default value is 'NULL'.

- header.color:

  color character for table header text. Default color is 'NULL'.

## Note

Word file is created after compiling Markdown code created by
[`export2md`](https://isubirana.github.io/compareGroups/index.html/reference/export2md.md).
To compile it it calls
[`render`](https://pkgs.rstudio.com/rmarkdown/reference/render.html)
function which requires pandoc to be installed.

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md),
[`export2latex`](https://isubirana.github.io/compareGroups/index.html/reference/export2latex.md),
[`export2pdf`](https://isubirana.github.io/compareGroups/index.html/reference/export2pdf.md),
[`export2csv`](https://isubirana.github.io/compareGroups/index.html/reference/export2csv.md),
[`export2html`](https://isubirana.github.io/compareGroups/index.html/reference/export2html.md),
[`export2md`](https://isubirana.github.io/compareGroups/index.html/reference/export2md.md)

## Examples

``` r
if (FALSE) { # \dontrun{

require(compareGroups)
data(regicor)

 # example on an ordinary table
res <- createTable(compareGroups(year ~ . -id, regicor), hide = c(sex=1), hide.no = 'no')
export2word(res, file = tempfile(fileext=".docx"))

} # }
```
