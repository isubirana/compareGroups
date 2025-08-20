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
library(googlesheets4, quietly=TRUE)


# devtools::install_version("shinydashboardPlus","0.7.5")
#devtools::install_version("shinydashboard","0.7.1")
#devtools::install_github("RinteRface/shinydashboardPlus")

library(shinydashboard, quietly=TRUE)
library(shinydashboardPlus, quietly=TRUE)
library(haven, quietly=TRUE)

library(survival, quietly=TRUE)

source("flipBox.R")

# if (!exists("runAppLocal",envir = as.environment("package:compareGroups"))) runAppLocal <- FALSE
# cat("runAppLocal: ",runAppLocal,"\n") 


#if (!runAppLocal){
if (dir.exists(".secrets")){
  # insert entires logs
  sheet_id <- "https://docs.google.com/spreadsheets/d/11nVz8IjpLTwSJUDPK8uG5yG_rfNWc3nK6pE-TKx84BY/"
  gs4_auth(cache = ".secrets", email = "isubirana@datarus.eu", subject = "isubirana@datarus.eu",scope="spreadsheets", use_oob = TRUE)
} else {
  print("Running app from cGroupsWUI()")
}


data(regicor); data(SNPs)


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


# this function has been deprecated from shinyWidgets and code must be sourced
setShadow <- function(id = NULL, class = NULL) {
  
  # shadow css
  cssShadow <- paste0(
    " box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
      transition: 0.3s;
      border-radius: 5px;
   ")
  
  cssShadow <- if (!is.null(id)) {
    if (!is.null(class)) {
      paste0("#", id, " .", class, " {", cssShadow, "}")
    } else {
      paste0("#", id, " {", cssShadow, "}")
    }
  } else {
    if (!is.null(class)) {
      paste0(".", class, " {", cssShadow, "}")
    } else {
      NULL
    }
  }
  
  # hover effect css
  cssHover <- "box-shadow: 0 16px 32px 0 rgba(0,0,0,0.2);"
  
  cssHover <- if (!is.null(id)) {
    if (!is.null(class)) {
      paste0("#", id, ":hover .", class, ":hover {", cssHover, "}")
    } else {
      paste0("#", id, ":hover", " {", cssHover, "}")
    }
  } else {
    if (!is.null(class)) {
      paste0(".", class, ":hover", " {", cssHover, "}")
    } else {
      NULL
    }
  }
  
  css <- paste(cssShadow, cssHover)
  
  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}


# setwd(system.file("app", package = "compareGroups"))


