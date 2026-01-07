# Web User Interface based on Shiny tools.

This function opens a web browser with a graphical interface based on
shiny package.

## Usage

``` r
cGroupsWUI(port = 8102L)
```

## Arguments

- port:

  integer. Same as 'port' argument of
  [`runApp`](https://rdrr.io/pkg/shiny/man/runApp.html). Default value
  is 8102L.

## See also

[`cGroupsGUI`](https://isubirana.github.io/compareGroups/index.html/reference/cGroupsGUI.md),
[`compareGroups`](https://isubirana.github.io/compareGroups/index.html/reference/compareGroups.md),
[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md)

## Note

If an error occurs when launching the web browser, it may be solved by
changing the port number.

## Examples

``` r
if (FALSE) { # \dontrun{

require(compareGroups)

cGroupsWUI()

} # }
```
