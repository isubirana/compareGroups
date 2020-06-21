library(compareGroups, quietly = TRUE)
library(shiny, quietly=TRUE)
library(shinyBS, quietly=TRUE)
library(shinyjs, quietly=TRUE)
# remotes::install_github("nik01010/dashboardthemes")
# library(shinythemes, quietly=TRUE)
# library(shinyjqui, quietly=TRUE)
# library(colourpicker, quietly=TRUE)
library(shinyWidgets, quietly=TRUE)
library(DT, quietly=TRUE)
library(shinyhelper, quietly=TRUE)

library(shinydashboard, quietly=TRUE)
library(shinydashboardPlus, quietly=TRUE)
library(haven, quietly=TRUE)


source("flipBox.R")

data(predimed); data(regicor); data(SNPs)


# source("dashboard_theme.R")

# horizontal scroll bar on top datatable
css.topScroolBar <- 
  "#topScroll > .dataTables_wrapper.no-footer > .dataTables_scroll > .dataTables_scrollBody {
  transform:rotateX(180deg);
  }
  #topScroll > .dataTables_wrapper.no-footer > .dataTables_scroll > .dataTables_scrollBody table{
  transform:rotateX(180deg);
  }"


options(shiny.maxRequestSize = 10e6) # ~10 Mb
.cGroupsWUIEnv <- new.env(parent=emptyenv())

# loadhelp <- function(){
#   help <- gsub("\t","",readLines("help.html"))
#   starthelp <- which(help=="<cghelptext>") + 1
#   endhelp <- which(help=="</cghelptext>") - 1
#   helpvar <- help[starthelp - 2]
#   hlp <- sapply(1:length(helpvar), function(a) paste(help[starthelp[a]:endhelp[a]],collapse=""))
#   names(hlp) <- helpvar
#   return(hlp)
# }
# hlp <- loadhelp()


# source("spss_varlist.R")

# wd<-getwd()

# color picker
choices_brewer <- list(
  "Blues" = c("#F7FBFF", "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5", "#08519C", "#08306B"),  #brewer.pal(n = 9, name = "Blues"),
  "Greens" = c("#F7FCF5", "#E5F5E0", "#C7E9C0", "#A1D99B", "#74C476", "#41AB5D", "#238B45", "#006D2C", "#00441B"), #brewer.pal(n = 9, name = "Greens"),
  "Reds" = c("#FFF5F0", "#FEE0D2", "#FCBBA1", "#FC9272", "#FB6A4A", "#EF3B2C", "#CB181D", "#A50F15", "#67000D"), #brewer.pal(n = 9, name = "Reds"),
  "Oranges" = c("#FFF5EB", "#FEE6CE", "#FDD0A2", "#FDAE6B", "#FD8D3C", "#F16913", "#D94801", "#A63603", "#7F2704"), #brewer.pal(n = 9, name = "Oranges"),
  "Yellows" = c("#FFF5EB", "#FEE6CE", "#FDD0A2", "#FDAE6B", "#FD8D3C", "#F16913", "#D94801", "#A63603", "#7F2704"), #brewer.pal(n = 9, name = "Yellows"),
  "Purples" = c("#FCFBFD", "#EFEDF5", "#DADAEB", "#BCBDDC", "#9E9AC8", "#807DBA", "#6A51A3", "#54278F", "#3F007D"), #brewer.pal(n = 9, name = "Purples"),
  "Greys" = c("#FFFFFF", "#F0F0F0", "#D9D9D9", "#BDBDBD", "#969696", "#737373", "#525252", "#252525", "#000000") #brewer.pal(n = 9, name = "Greys")
)




# setwd(system.file("app", package = "compareGroups"))


