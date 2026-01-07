# Report of descriptive tables and plots.

This function creates automatically a PDF with the descriptive table as
well as availability data and all plots. This file is structured and
indexed in the way that the user can navigate through all tables and
figures along the document.

## Usage

``` r
report(x, file, fig.folder, compile = TRUE, openfile = FALSE, title = "Report", 
       author, date, perc=FALSE, ...)
```

## Arguments

- x:

  an object of class 'createTable'.

- file:

  character specifying the PDF file resulting after compiling the LaTeX
  code of report. LaTeX code is also stored in the same folder with the
  same name but .tex extension. When 'compile' argument is FALSE, only
  .tex file is saved.

- fig.folder:

  character specifying the folder where the plots corresponding to all
  row-variables of the table are placed. If it is left missing, a folder
  with the name file_figures is created in the same folder of 'file'.

- compile:

  logical indicating whether tex file is compiled using
  [`texi2pdf`](https://rdrr.io/r/tools/texi2dvi.html) function. Default
  value is TRUE.

- openfile:

  logical indicating whether to open the compiled pdf file or not.
  Currently deprectated. Deafult value is FALSE.

- title:

  character specifying the title of the report on the cover page.
  Default value is 'Report'.

- author:

  character specifying the author/s name/s of the report on the cover
  page. When missing, no authors appear.

- date:

  character specifying the date of the report on the cover page. When
  missing, the present date appears.

- perc:

  logical. Plot relative frequencies (in percentatges) instead of
  absolute frequencies are displayed in barplots for categorical
  variable.

- ...:

  Arguments passed to
  [`export2latex`](https://isubirana.github.io/compareGroups/index.html/reference/export2latex.md).

## Note

This functions does not work with stratified tables ('cbind.createTable'
class objects). To report this class of tables you can report each of
its component (see second example from 'examples' section).

In order to compile the tex file the following packages must be
available:  
- babel  
- longtable  
- hyperref  
- multirow  
- lscape  
- geometry  
- float  
- inputenc  
- epsfig  

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md),
[`export2latex`](https://isubirana.github.io/compareGroups/index.html/reference/export2latex.md),
[`export2csv`](https://isubirana.github.io/compareGroups/index.html/reference/export2csv.md),
[`export2html`](https://isubirana.github.io/compareGroups/index.html/reference/export2html.md),
[`radiograph`](https://isubirana.github.io/compareGroups/index.html/reference/radiograph.md)

## Examples
