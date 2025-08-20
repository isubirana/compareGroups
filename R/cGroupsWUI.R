cGroupsWUI <- function(port = 8102L){
  #assign("runAppLocal", value=TRUE, envir=as.environment("package:compareGroups"))
  # environment(runAppLocal) <- as.environment("package:compareGroups")
  shiny::runApp(system.file("app", package="compareGroups"), port)
}