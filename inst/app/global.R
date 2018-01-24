library(shiny, quietly=TRUE)
library(shinyBS, quietly=TRUE)
library(shinyjs, quietly=TRUE)
library(shinythemes, quietly=TRUE)
library(DT, quietly=TRUE)


options(shiny.maxRequestSize = 10e6) # ~10 Mb
.cGroupsWUIEnv <- new.env(parent=emptyenv())

loadhelp <- function(){
  help <- gsub("\t","",readLines("help.html"))
  starthelp <- which(help=="<cghelptext>") + 1
  endhelp <- which(help=="</cghelptext>") - 1
  helpvar <- help[starthelp - 2]
  hlp <- sapply(1:length(helpvar), function(a) paste(help[starthelp[a]:endhelp[a]],collapse=""))
  names(hlp) <- helpvar
  return(hlp)
}
hlp <- loadhelp()

require(compareGroups)
require(foreign)


sapply(list.files("./www/", "\\.css$",full=TRUE), file.remove)

unzip("./www/bootstrap.zip",exdir="./www")

source("spss_varlist.R")

wd<-getwd()

if (length(grep("linux",sessionInfo()$platform))){
  setwd("/srv/shiny-server/comparegroups/")
} else {
  setwd(system.file("app", package = "compareGroups"))
}
