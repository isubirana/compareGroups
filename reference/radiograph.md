# Lists the values in the data set.

This function creates a report of raw data in your data set. For each
variable an ordered list of the unique entries (read as strings), useful
for checking for input errors.

## Usage

``` r
radiograph(file, header = TRUE, save=FALSE, out.file="", ...)
```

## Arguments

- file:

  character specifying the file where the data set is located.

- header:

  see [`read.table`](https://rdrr.io/r/utils/read.table.html).

- save:

  logical indicating whether output should be stored in a file (TRUE) or
  printed on the console (FALSE). Default is FALSE.

- out.file:

  character specifying the file where the results are to be output. It
  only applies when 'save' argument is set to TRUE.

- ...:

  Arguments passed to
  [`read.table`](https://rdrr.io/r/utils/read.table.html).

## Author

Gavin Lucas (gavin.lucas\<at\>cleargenetics.com)  

Isaac Subirana (isubirana\<at\>imim.es)

## See also

[`report`](https://isubirana.github.io/compareGroups/index.html/reference/report.md)

## Examples

``` r
if (FALSE) { # \dontrun{

require(compareGroups)

# read example data of regicor in plain text format with variables separated by '\t'.
datafile <- system.file("exdata/regicor.txt", package="compareGroups")
radiograph(datafile)

} # }
```
