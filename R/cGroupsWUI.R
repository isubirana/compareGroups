cGroupsWUI <- function(port = 8102L){
  shiny::runApp(system.file("app", package="compareGroups"), port)
}