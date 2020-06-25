\name{report}
\alias{report}

\title{
Report of descriptive tables and plots.
}

\description{
This function creates automatically a PDF with the descriptive table as well as availability data and all plots. This file is structured and indexed in the way that the user can navigate through all tables and figures along the document.
}

\usage{
report(x, file, fig.folder, compile = TRUE, openfile = FALSE, title = "Report", 
       author, date, perc=FALSE, ...)
}

\arguments{

  \item{x}{an object of class 'createTable'.}

  \item{file}{character specifying the PDF file resulting after compiling the LaTeX code of report. LaTeX code is also stored in the same folder with the same name but .tex extension. When 'compile' argument is FALSE, only .tex file is saved.}

  \item{fig.folder}{character specifying the folder where the plots corresponding to all row-variables of the table are placed. If it is left missing, a folder with the name file_figures is created in the same folder of 'file'.}

  \item{compile}{logical indicating whether tex file is compiled using \code{\link[tools:texi2dvi]{texi2pdf}} function. Default value is TRUE.}
  
  \item{openfile}{logical indicating whether to open the compiled pdf file or not. Currently deprectated. Deafult value is FALSE.}
  
  \item{title}{character specifying the title of the report on the cover page. Default value is 'Report'.}

  \item{author}{character specifying the author/s name/s of the report on the cover page. When missing, no authors appear.}

  \item{date}{character specifying the date of the report on the cover page. When missing, the present date appears.}
  
  \item{perc}{logical. Plot relative frequencies (in percentatges) instead of absolute frequencies are displayed in barplots for categorical variable.}
             
  \item{\ldots}{Arguments passed to \code{\link{export2latex}}.}
  
}


\note{

  This functions does not work with stratified tables ('cbind.createTable' class objects). To report this class of tables you can report each of its component (see second example from 'examples' section).

  In order to compile the tex file the following packages must be available:\cr
  - babel \cr
  - longtable  \cr
  - hyperref   \cr
  - multirow    \cr
  - lscape     \cr
  - geometry \cr
  - float      \cr
  - inputenc \cr
  - epsfig \cr

}


\seealso{
  \code{\link{createTable}}, \code{\link{export2latex}}, \code{\link{export2csv}}, \code{\link{export2html}}, \code{\link{radiograph}}
} 


\examples{

\dontrun{

require(compareGroups)
data(regicor)

 # example on an ordinary table
res <- createTable(compareGroups(year ~ . -id, regicor), hide = c(sex=1), hide.no = 'no')
report(res, "report.pdf" ,size="small", title="\\Huge \\textbf{REGICOR study}", 
       author="Isaac Subirana \\\\ IMIM-Parc de Salut Mar")

 # example on an stratified table by sex
res.men <- createTable(compareGroups(year ~ . -id-sex, regicor, subset=sex=='Male'), 
                       hide.no = 'no')
res.wom <- createTable(compareGroups(year ~ . -id-sex, regicor, subset=sex=='Female'), 
                       hide.no = 'no')
res <- cbind("Men"=res.men, "Wom"=res.wom)
report(res[[1]], "reportmen.pdf", size="small", 
        title="\\Huge \\textbf{REGICOR study \\\\ Men}", date="") # report for men / no date
report(res[[2]], "reportwom.pdf", size="small", 
        title="\\Huge \\textbf{REGICOR study \\\\ Women}", date="") # report for wom / no date

}

}

\keyword{utilities}
