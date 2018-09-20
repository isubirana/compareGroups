\name{export2md}
\alias{export2md}

\title{
Exporting descriptives table to Markdown format
}
\description{
This function takes the result of \code{createTable} and exports the tables to markdown format. It may be useful when inserting R code chunks in a Markdown file (.Rmd).
}
\usage{
export2md(x, which.table = "descr", nmax = TRUE, header.labels = c(), caption = NULL, 
          format = "html", width = Inf, strip = FALSE, first.strip = FALSE, 
          background = "#D2D2D2", size = NULL, landscape=FALSE, ...)

}

\arguments{

  \item{x}{an object of class 'createTable'.}

  \item{which.table}{character indicating which table is printed. Possible values are 'descr' or 'avail'(partial matching allowed), exporting descriptives by groups table or availability data table, respectively. Default value is 'descr'.}

  \item{nmax}{logical, indicating whether to show the number of subjects with at least one valid value across all row-variables. Default value is TRUE.}
  
  \item{header.labels}{see the 'header.labels' argument from \code{\link{createTable}}.}   

 \item{caption}{character specifying the table caption for descriptives and available data table. If which.table='both' the first element of 'caption' will be assigned to descriptives table and the second to available data table. If it is set to "", no caption is inserted. Default value is NULL, which writes 'Summary descriptives table by groups of 'y'' for descriptives table and 'Available data by groups of 'y'' for the available data table. }

 \item{format}{character with three options: 'html', 'latex' or 'markdown'. If missing, it tries to guess the default options of Rmarkdown file in which the table in inserted, or html if it is not in a Rmarkdown file or format not specified.}
 
 \item{width}{character string to specify the width of first column of descriptive table. Default value is \code{Inf} which makes the first column to autoadjust to variable names. Other examples are '10cm', '3in' or '30em'.}

 \item{strip}{logical. It shadows table lines corresponding to each variable.}
 
 \item{first.strip}{logical. It determines whether to shadow the first variable (TRUE) or the second (FALSE). It only applies when \code{strip} argument is true.}
 
 \item{background}{color code in HEX format. You can use \code{rgb} function to convert red, green and blue to HEX code. Default color is '#D2D2D2'.}
 
 \item{size}{numeric. Size of descriptive table. Default value is NULL which creates the table in default size.}
 
 \item{landscape}{logical. It determines whether to place the table in landscape (horizontal) format. It only applies when format is 'latex'. Default value is FALSE.}
 
 \item{\ldots}{arguments passed to \code{\link[knitr]{kable}}.}
  
}

\value{

It does not return anything, but the Markdown code to generate the descriptive or available table is printed.

}


\note{

The way to compute the 'N' shown in the bivariate table header, controlled by 'nmax' argument, has been changed from previous versions (<1.3). In the older versions 'N' was computed as the maximum across the cells withing each column (group) from the 'available data' table ('avail').

Stratified tables, i.e. \code{cbind.createTable} class, are not supported when creating a Word document.

}


\seealso{
  \code{\link{createTable}}, \code{\link{export2latex}}, \code{\link{export2pdf}}, \code{\link{export2csv}}, \code{\link{export2html}}, \code{\link{export2word}}
} 


\examples{

\dontrun{

---
title: "Report"
output:
  html_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE, warning=FALSE, message=FALSE)
```

```{r}
library(compareGroups)
data(predimed)
res <- compareGroups(group~., predimed)
restab <- createTable(res)
```

## Report section

The following table contains descriptives of **PREDIMED** data

```{r}
export2md(restab, strip = TRUE, first.strip = TRUE)
```
}

}

\keyword{utilities}
