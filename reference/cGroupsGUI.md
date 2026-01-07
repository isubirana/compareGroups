# Graphical user interface based on tcltk tools

This function allows the user to build tables in an easy and intuitive
way and to modify several options, using a graphical interface.

## Usage

``` r
cGroupsGUI(X)
```

## Arguments

- X:

  a matrix or a data.frame. 'X' must exist in `.GlobalEnv`.

## Details

See the vignette for more detailed examples illustrating the use of this
function.

## Note

If a data.frame or a matrix is passed through 'X' argument or is loaded
by the 'Load data' GUI menu, this object is placed in the `.GlobalEnv`.
Manipulating this data.frame or matrix while GUI is opened may produce
an error in executing the GUI operations.

## See also

[`cGroupsWUI`](https://isubirana.github.io/compareGroups/index.html/reference/cGroupsWUI.md),
[`compareGroups`](https://isubirana.github.io/compareGroups/index.html/reference/compareGroups.md),
[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md)

## Examples

``` r
if (FALSE) { # \dontrun{
data(regicor)
cGroupsGUI(regicor)
} # }
```
