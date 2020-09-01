server <- function(input, output, session) {

  # output$sidebarAspect <- renderUI({
  #   tags$style(HTML(paste0(".main-sidebar{width: ", input$sidebarwidth,"%;}")))
  # })
  
  output$xxx <- renderPrint({
    # cat("summary(rv$dataset)\n")
    # print(summary(rv$dataset))
    # cat("-----------------\n")
    # cat("summary(rv$datasetorig)\n")
    # print(summary(rv$datasetorig))    
    # cat("-----------------\n")
    # cat("summary(rv$datasetorigfiltered)\n")
    # print(summary(rv$datasetorigfiltered)) 
    print(input$sepSNPs)
  })
  
  output$github <- renderUser({
    div(style="margin-top:5px;border:1px solid #3C8DBC;", 
      HTML(
        '<a title="github" href="https://github.com/isubirana/compareGroups" target="_blank" class="btn btn-social-icon">
        <i style="background-color:#3C8DBC; color:white;" class="fab fa-github"></i>
        </a>'
      )        
    )
  })
  
  # observeEvent(input$showci,{
  #   if (!is.null(input$showci) && input$showci)
  #     hide("formatAccordion")
  #   else
  #     show("formatAccordion")
  # })
  
  observe({
    type <- if(is.null(input$type)) 1 else as.character(input$type)
    showci <- if(is.null(input$showci)) FALSE else input$showci
    conflevel <- if(is.null(input$conflevel)) 0.95 else input$conflevel
    if (!showci)
      vv <- switch(type,"1"="%","2"="N (%)","3"="N")
    else
      vv <- paste0("% [",conflevel,"%CI]")
    updateTextInput(session,"extralabelperc",value=vv)
  })
  
  observe({
    sdtype <- if(is.null(input$sdtype)) 1 else as.character(input$sdtype)
    showci <- if(is.null(input$showci)) FALSE else input$showci
    conflevel <- if(is.null(input$conflevel)) 0.95 else input$conflevel
    if (!showci)
      vv <- switch(sdtype,"1"="Mean (SD)","2"="Mean\u00B1SD")
    else
      vv <- paste0("Mean [",conflevel,"%CI]")
    updateTextInput(session,"extralabelmean",value=vv)
  })
  
  observe({
    qtype1 <- if(is.null(input$qtype1)) "1" else as.character(input$qtype1)
    qtype2 <- if(is.null(input$qtype2)) "1" else as.character(input$qtype2)
    Q1 <- if(is.null(input$Q1)) 25 else input$Q1
    Q3 <- if(is.null(input$Q3)) 25 else input$Q3
    showci <- if(is.null(input$showci)) FALSE else input$showci
    conflevel <- if(is.null(input$conflevel)) 0.95 else input$conflevel
    if (!showci)
      vv <- paste0("Median ",switch(qtype1,"1"="[","2"="("),Q1,switch(qtype2,"1"=";","2"=",","3"="-"),Q3,switch(qtype1,"1"="]","2"=")"))
    else
      vv <- paste0("Median [",conflevel,"%CI]")
    updateTextInput(session,"extralabelmedian",value=vv)
  })    
  
  observe({
    timemax <- if(is.null(input$timemax)) NA else input$timemax
    showci <- if(is.null(input$showci)) FALSE else input$showci
    conflevel <- if(is.null(input$conflevel)) 0.95 else input$conflevel
    if (!showci)
      vv <- paste("Incidence")
    else
      vv <- paste0("Incidence [",conflevel,"%CI]")
    if (!is.na(timemax)) vv <- paste0(vv," at time=",round(timemax,1))
    updateTextInput(session,"extralabelsurv",value=vv)
  })  
  
  observeEvent(input$varinfotabbtn, {
    showModal(modalDialog(
      easyClose = TRUE,
      title = "Variable names / labels",
      tableOutput("varinfotab")
    ))
  })
  
  observe_helpers(withMathJax = TRUE) # needed to use shinyhelper package
  
  observeEvent(input$changeselevarsok,{
    if (!is.null(rv$selevars) & length(rv$selevars)>0)
      shinyjs::show("dropdownDescriptives")
    else
      shinyjs::hide("dropdownDescriptives")
  })


  output$leftPanelAspect <- renderUI({
    HTML(paste0("<style type='text/css'> #leftPanel{color:white;background-color:rgba(60,141,188,1);width:",input$leftPanelWidth,"%</style>"))
  })

  output$rightPanelAspect <- renderUI({
    leftPanelWidth <- input$leftPanelWidth
    if (leftPanelWidth>70)
      rightPanelWidth <- 100
    else
      rightPanelWidth <- 100 - leftPanelWidth
    if (input$leftmenu=='Home'){
      rightPanelWidth <- 100
    }
    HTML(paste0("<style type='text/css'> #rightPanel{padding-left:3%;width:",rightPanelWidth,"%;height:50%</style>"))
  })

  observeEvent(input$leftPanelWidth, {
    if (input$leftPanelWidth<5)
      shinyjs::hide("leftPanel")
    else
      shinyjs::show("leftPanel")
  })

  observeEvent(input$leftmenu,{
    updateSliderInput(session, "leftPanelWidth", value=30)
  })


  ## when data is loaded show the rest of menuItems
  observeEvent(rv$datasetorig, {
    if (NROW(rv$datasetorig)==0){
      shinyjs::hide(selector = "ul li:eq(22)") # filter data
      shinyjs::hide(selector = "ul li:eq(23)") # recode variables
      shinyjs::hide(selector = "ul li:eq(24)") # table: variables
      shinyjs::hide(selector = "ul li:eq(28)") # settings
      shinyjs::hide(selector = "ul li:eq(33)") # display
      shinyjs::hide(selector = "ul li:eq(38)") # plots: variables
      shinyjs::hide(selector = "ul li:eq(39)") # plots: groups
      shinyjs::hide(selector = "ul li:eq(40)") # snps: variables
      shinyjs::hide(selector = "ul li:eq(41)") # snps: groups
      shinyjs::hide(selector = "ul li:eq(42)") # snps: options
      shinyjs::hide("TableHeader")
      shinyjs::hide("PlotHeader")
      shinyjs::hide("SNPsHeader")
      shinyjs::hide("dropdownData")
      # updateTabItems(session, "leftmenu", selected = "LoadData")
    }else{
      shinyjs::show(selector = "ul li:eq(22)") # filter data
      shinyjs::show(selector = "ul li:eq(23)") # recode variables
      shinyjs::show(selector = "ul li:eq(24)") # table: variables
      shinyjs::show(selector = "ul li:eq(28)") # settings
      shinyjs::show(selector = "ul li:eq(33)") # display
      shinyjs::show(selector = "ul li:eq(38)") # plots: variables
      shinyjs::show(selector = "ul li:eq(39)") # plots: groups
      shinyjs::show(selector = "ul li:eq(40)") # snps: variables
      shinyjs::show(selector = "ul li:eq(41)") # snps: groups
      shinyjs::show(selector = "ul li:eq(42)") # snps: options
      shinyjs::show("TableHeader")
      shinyjs::show("PlotHeader")
      shinyjs::show("SNPsHeader")
      shinyjs::show("dropdownData")
      # updateTabItems(session, "leftmenu", selected = "DescribedVariables")
    }
  })
  
  observe({
    if (!is.null(input$resptype) && input$resptype=='None'){
      shinyjs::hide(selector = "ul li:eq(32)")  
    } else {
      if (is.null(input$computeratio) && is.null(input$resptype)){
        shinyjs::hide(selector = "ul li:eq(32)")  
      } else {
        if (input$computeratio || input$resptype=='Survival')
          shinyjs::show(selector = "ul li:eq(32)")
        else
          shinyjs::hide(selector = "ul li:eq(32)")
      }
    }
  })
  
  observe({
    if (input$leftmenu=="Home"){
      rv$DataHeaderColor <- "white"
      rv$TableHeaderColor <- "white"
      rv$PlotHeaderColor <- "white"
      rv$SNPsHeaderColor <- "white"
      hide("showDataPanel"); hide("dropdownData")
      hide("descrTableBox"); hide("dropdownDescriptives")
      hide("showPlotPanel"); hide("dropdownPlot")
      hide("showSNPsPanel"); hide("dropdownSNPs")
      show("homePanel")      
    }
    if (input$leftmenu%in%c("LoadData","FilterData","RecodeVars")){
      rv$DataHeaderColor <- "#357CA5"
      rv$TableHeaderColor <- "white"
      rv$PlotHeaderColor <- "white"
      rv$SNPsHeaderColor <- "white"
      hide("homePanel")
      hide("descrTableBox"); hide("dropdownDescriptives")
      hide("showPlotPanel"); hide("dropdownPlot")
      hide("showSNPsPanel"); hide("dropdownSNPs")
      show("showDataPanel")
      if (NROW(rv$datasetorig)>0)
        {show("dropdownData")}
      else
        {hide("dropdownData")}      
    }
    if (input$leftmenu%in%c("Variables","DescribedVariables","ResponseVariable","StrataVariable",
                            "Type","Hide","Subset","ORHR",
                            "Show","Format","Decimals","Labels")){
      rv$DataHeaderColor <- "white"
      rv$TableHeaderColor <- "#357CA5"
      rv$PlotHeaderColor <- "white"
      rv$SNPsHeaderColor <- "white"
      hide("homePanel")
      hide("showDataPanel"); hide("dropdownData")
      hide("showPlotPanel"); hide("dropdownPlot")
      hide("showSNPsPanel"); hide("dropdownSNPs")
      show("descrTableBox")
      if (inherits(create(),"createTable"))
        {show("dropdownDescriptives")}
      else 
        {hide("dropdownDescriptives")}      
    }
    if (input$leftmenu%in%c("PlotVariables","PlotGroups")){
      rv$DataHeaderColor <- "white"
      rv$TableHeaderColor <- "white"
      rv$PlotHeaderColor <- "#357CA5"
      rv$SNPsHeaderColor <- "white"
      hide("homePanel")
      hide("showDataPanel"); hide("dropdownData")
      hide("descrTableBox"); hide("dropdownDescriptives")
      hide("showSNPsPanel"); hide("dropdownSNPs")
      show("showPlotPanel");
      if (rv$plotcreated)
        {show("dropdownPlot")}
      else 
        {hide("dropdownPlot")}
    }
    if (input$leftmenu%in%c("SNPsVariables","SNPsGroups","SNPsOptions")){
      rv$DataHeaderColor <- "white"
      rv$TableHeaderColor <- "white"
      rv$PlotHeaderColor <- "white"
      rv$SNPsHeaderColor <- "#357CA5"
      hide("homePanel")
      hide("showDataPanel"); hide("dropdownData")
      hide("descrTableBox"); hide("dropdownDescriptives")
      hide("showPlotPanel"); hide("dropdownPlot")
      show("showSNPsPanel")
      if (inherits(createSNPs(),"compareSNPs"))
        {show("dropdownSNPs")}
      else 
        {hide("dropdownSNPs")}
    }
  })

  onclick("DataHeader",{
    rv$DataHeaderColor <- "#357CA5"
    rv$TableHeaderColor <- "white"
    rv$PlotHeaderColor <- "white"
    rv$SNPsHeaderColor <- "white"
    hide("leftPanel")
    hide("homePanel")
    hide("descrTableBox"); hide("dropdownDescriptives")
    hide("showPlotPanel"); hide("dropdownPlot")
    hide("showSNPsPanel"); hide("dropdownSNPs")
    show("showDataPanel")
    if (NROW(rv$datasetorig)>0)
      {show("dropdownData")}
    else
      {hide("dropdownData")}    
  })

  onclick("TableHeader",{
    rv$DataHeaderColor <- "white"
    rv$TableHeaderColor <- "#357CA5"
    rv$PlotHeaderColor <- "white"
    rv$SNPsHeaderColor <- "white"
    hide("leftPanel")
    hide("homePanel")
    hide("showDataPanel"); hide("dropdownData")
    hide("showPlotPanel"); hide("dropdownPlot")
    hide("showSNPsPanel"); hide("dropdownSNPs")
    show("descrTableBox")
    if (inherits(create(),"createTable"))
      {show("dropdownDescriptives")}      
    else
      {hide("dropdownDescriptives")}    
  })

  onclick("PlotHeader",{
    rv$DataHeaderColor <- "white"
    rv$TableHeaderColor <- "white"
    rv$PlotHeaderColor <- "#357CA5"
    rv$SNPsHeaderColor <- "white"
    hide("leftPanel")
    hide("homePanel")
    hide("showDataPanel"); hide("dropdownData")
    hide("descrTableBox"); hide("dropdownDescriptives")
    hide("showSNPsPanel"); hide("dropdownSNPs")
    show("showPlotPanel")
    if (rv$plotcreated)
      {show("dropdownPlot")}
    else 
      {hide("dropdownPlot")}
  })

  onclick("SNPsHeader",{
    rv$DataHeaderColor <- "white"
    rv$TableHeaderColor <- "white"
    rv$PlotHeaderColor <- "white"
    rv$SNPsHeaderColor <- "#357CA5"
    hide("leftPanel")
    hide("homePanel")
    hide("showDataPanel"); hide("dropdownData")
    hide("descrTableBox"); hide("dropdownDescriptives")
    hide("showPlotPanel"); hide("dropdownPlot")
    show("showSNPsPanel")
    if (inherits(createSNPs(),"compareSNPs"))
      {show("dropdownSNPs")}
    else 
      {hide("dropdownSNPs")}
  })

  output$DataHeaderText <- renderUI({
    cc <- rv$DataHeaderColor
    HTML(paste0("<i style='margin-left:10px; color:",cc,"' class='fa fa-database'></i><format style='color:",cc,"; font-weight:bold; padding-left:10px; font-size:20px'>Data</format>"))
  })
  
  output$TableHeaderText <- renderUI({
    cc <- rv$TableHeaderColor
    HTML(paste0("<i style='margin-left:10px; color:",cc,"' class='fa fa-table'></i><format style='color:",cc,"; font-weight:bold; padding-left:10px; font-size:20px'>Descriptive Table</format>"))
  })  
  
  output$PlotHeaderText <- renderUI({
    cc <- rv$PlotHeaderColor
    HTML(paste0("<i style='margin-left:10px; color:",cc,"' class='fa fa-chart-bar'></i><format style='color:",cc,"; font-weight:bold; padding-left:10px; font-size:20px'>Plots</format>"))
  }) 
  
  output$SNPsHeaderText <- renderUI({
    cc <- rv$SNPsHeaderColor
    HTML(paste0("<i style='margin-left:10px; color:",cc,"' class='fa fa-dna'></i><format style='color:",cc,"; font-weight:bold; padding-left:10px; font-size:20px'>SNPs</format>"))
  })   
  
  
  observeEvent(input$toggleLeftPanel,{
    shinyjs::hide("leftPanel",anim=FALSE)
    updateSliderInput(session, "leftPanelWidth", value=0)  
  })
  
  # observe({
  #   if (is.null(input$dimension) || is.null(input$toggleLeftPanel)) return(NULL)
  #   if (input$toggleLeftPanel%%2==0){
  #     shinyjs::show("leftPanel",anim=FALSE)
  #     widthLeftPanel <- 30
  #     if (input$leftmenu=='Home')
  #       widthLeftPanel <- 0
  #     else {
  #       if (input$dimension[1]<900) widthLeftPanel <- 100
  #       # if (input$dimension[1]>=600 & input$dimension[1]<900) widthLeftPanel <- 50
  #       # if (input$dimension[1]>=900) widthLeftPanel <- 30
  #     }
  #     updateSliderInput(session, "leftPanelWidth", value=widthLeftPanel)
  #   } else {
  #     shinyjs::hide("leftPanel",anim=FALSE)
  #     updateSliderInput(session, "leftPanelWidth", value=0)
  #   }
  # })

  observeEvent(input$leftmenu,{
    if (input$leftmenu=='Home'){
      shinyjs::hide("leftPanel")
      # updateCheckboxInput(session, "toggleLeftPanel", value=FALSE)
    }else{
      shinyjs::show("leftPanel")
      # updateCheckboxInput(session, "toggleLeftPanel", value=TRUE)
    }
  })


  ##### hide show load data options #####

  observe({
    if (input$exampledata!='Own data'){
      shinyjs::hide("ownPanel")
      shinyjs::hide("files")
      shinyjs::show("loadok")
    } else {
      shinyjs::show("files")
      if (is.null(input$files)){
        shinyjs::hide("ownPanel")
        shinyjs::hide("loadok")
      }else{
        shinyjs::show("ownPanel")
        shinyjs::show("loadok")
      }
    }
  })

  observe({
    if (input$datatype!='*.xls') return(NULL)
    tablenames <- try(readxl::excel_sheets(input$files$datapath), silent=TRUE)
    if (inherits(tablenames, "try-error")) return(NULL)
    names(tablenames)<-tablenames
    updateSelectInput(session, "tablenames", choices=tablenames)
  })

  output$previewtxtdown <- downloadHandler(
    filename = function() input$files$name,
    content = function(ff){
      file.copy(input$files$datapath, ff)
    }
  )


  ## init some input values when pressing loadok button


  ## reactive Values

  rv<-reactiveValues()

  rv$dataset <- rv$datasetorig <- rv$datasetorigfiltered <- data.frame()
  rv$recodedvars <- character()

  rv$changemethodcount<-0
  observeEvent(input$changemethod,{
    rv$changemethodcount<-rv$changemethodcount+1
  })

  rv$changestratacount<-0
  observeEvent(input$changestrata,{
    rv$changestratacount<-rv$changestratacount+1
  })

  rv$changevarsubsetcount<-0
  observeEvent(input$changevarsubset,{
    rv$changevarsubsetcount<-rv$changevarsubsetcount+1
  })

  rv$changedescdigitscount<-0
  observeEvent(input$changedescdigits,{
    rv$changedescdigitscount<-rv$changedescdigitscount+1
  })

  rv$changeratiodigitscount<-0
  observeEvent(input$changeratiodigits,{
    rv$changeratiodigitscount<-rv$changeratiodigitscount+1
  })

  rv$changeshowcount<-0
  observeEvent(input$changeshow,{
    rv$changeshowcount<-rv$changeshowcount+1
  })

  rv$changeformatcount<-0
  observeEvent(input$changeformat,{
    rv$changeformatcount<-rv$changeformatcount+1
  })

  rv$changehidecount<-0
  observeEvent(input$changehide,{
    rv$changehidecount<-rv$changehidecount+1
  })

  rv$changepvalsdigitscount<-0
  observeEvent(input$changepvalsdigits,{
    rv$changepvalsdigitscount<-rv$changepvalsdigitscount+1
  })

  rv$changerespcount<-0
  observeEvent(input$changeresp,{
    rv$changerespcount<-rv$changerespcount+1
  })

  rv$changeselevarsokcount<-0
  observeEvent(input$changeselevarsok,{
    rv$changeselevarsokcount<-rv$changeselevarsokcount+1
  })

  rv$changeglobalsubsetcount<-0
  observeEvent(input$changeglobalsubset,{
    rv$changeglobalsubsetcount<-rv$changeglobalsubsetcount+1
  })

  rv$changeratiocatcount<-0
  observeEvent(input$changeratiocat,{
    rv$changeratiocatcount<-rv$changeratiocatcount+1
  })

  rv$changefactratiocount<-0
  observeEvent(input$changefactratio,{
    rv$changefactratiocount<-rv$changefactratiocount+1
  })

  rv$initial<-FALSE
  observeEvent(rv$dataset,{
    # if (!is.null(dataset())) rv$initial<<-TRUE
    if (nrow(rv$dataset)>0) rv$initial<-TRUE else rv$initial<-FALSE
  })
  
  rv$plotcreated <- FALSE
  
  rv$DataHeaderColor <- rv$TableHeaderColor <- rv$PlotHeaderColor <- rv$SNPsHeaderColor <- "white"
  

  ## udpate dataset when selecting rows on-line from DT
  observeEvent(input$valuesext_rows_all,{
    ll <- lapply(rv$dataset, attr, which="label", exact=TRUE)
    ll <- unlist(ifelse(sapply(ll, is.null), names(rv$dataset), ll))
    rv$dataset <- rv$datasetorig[input$valuesext_rows_all,,drop=FALSE]
    for (j in 1:ncol(rv$dataset)) attr(rv$dataset[,j],"label") <- ll[j]
  })

  ## recode variables
  observeEvent(input$newvarok,{
    if (input$newvarlabel=='') 
      updateTextInput(session, "newvarlabel", value=input$newvarname)
    if (input$newvarname==''){
      shinyjs::alert("Enter the variable name")
      return(NULL)
    }
    if (input$newvarexpr==''){
      shinyjs::alert("Write an R code to compute the variable")
      return(NULL)
    }
    expr <- input$newvarexpr
    dataset <- rv$datasetorig
    var <- try(eval(parse(text=paste("with(dataset,{", expr,"})"))), silent=TRUE)
    if (inherits(var, "try-error")){
      shinyjs::alert("Error in evaluating the R code")
      return(NULL)
    }
    # attr(var, "label") <- input$newvarlabel
    rv$datasetorig[,input$newvarname] <- var
    attr(rv$datasetorig[,input$newvarname], "label") <- input$newvarlabel
    rv$datasetorigfiltered <- rv$datasetorig
    rv$dataset <- rv$datasetorig
    rv$recodedvars <- c(rv$recodedvars, input$newvarname)
  })

  observeEvent(input$removenewvarok,{
    updateTextInput(session, "newvarname", value="")
    updateTextInput(session, "newvarlabel", value="")
    updateTextAreaInput(session, "newvarexpr",  value="")
  })

  # observeEvent(input$changeselevarsok,{
  observe({
    input$selevars
    input$selevarsAll
    input$selevarsNone
    rv$selevars <- input$selevars
  })

  observeEvent(input$changemethod,{
    if (!is.null(rv$method)){
      if (!is.null(input$varselemethodALL) && input$varselemethodALL)
        rv$method[1:length(rv$method)]<<-ifelse(input$method=='Normal',1,
                                                ifelse(input$method=='Non-normal',2,
                                                       ifelse(input$method=='Categorical',3,NA)))
      else
        if (length(input$varselemethod)>0)
          rv$method[input$varselemethod]<<-ifelse(input$method=='Normal',1,
                                                  ifelse(input$method=='Non-normal',2,
                                                         ifelse(input$method=='Categorical',3,NA)))
    }
  })

  observeEvent(input$changedescdigits,{
    if (!is.null(rv$descdigits)){
      if (!is.null(input$varseledescdigitsALL) && input$varseledescdigitsALL)
        rv$descdigits[1:length(rv$descdigits)]<-ifelse(input$descdigits==-1,NA,input$descdigits)
      else
        if (length(input$varseledescdigits)>0)
          rv$descdigits[input$varseledescdigits]<-ifelse(input$descdigits==-1,NA,input$descdigits)
    }
  })

  observeEvent(input$changeratiodigits,{
    if (!is.null(rv$ratiodigits)){
      if (!is.null(input$varseleratiodigitsALL) && input$varseleratiodigitsALL)
        rv$ratiodigits[1:length(rv$ratiodigits)]<-ifelse(input$ratiodigits==-1,NA,input$ratiodigits)
      else
        if (length(input$varseleratiodigits)>0)
          rv$ratiodigits[input$varseleratiodigits]<-ifelse(input$ratiodigits==-1,NA,input$ratiodigits)
    }
  })

  observeEvent(input$changeratiocat,{
    if (length(input$varselerefratio)>0 && !is.null(input$refratiocat)){
      catval<-as.numeric(strsplit(input$refratiocat,":")[[1]][1])
      rv$refratiocat[input$varselerefratio]<-catval
      #rv$refratiocat<-refratiocat
    }
  })

  observeEvent(input$changefactratio,{
    if (!is.null(rv$factratio)){
      if (!is.null(input$varselefactratioALL) && input$varselefactratioALL)
        rv$factratio[1:length(rv$factratio)]<-input$factratio
      else
        if (length(input$varselefactratio)>0)
          rv$factratio[input$varselefactratio]<-input$factratio
    }
  })

  observeEvent(input$changehide,{
    if (length(input$varselehide)>0 && !is.null(input$hidecat) && !is.null(rv$xhide)){
      catval<-as.numeric(strsplit(input$hidecat,":")[[1]][1])
      rv$xhide[input$varselehide]<-catval
    }
  })

  observeEvent(input$changevarsubset,{
    if (is.null(rv$varsubset)) return(NULL)
    if (length(input$varselevarsubset)>0) rv$varsubset[input$varselevarsubset]<-input$varsubset
    rv$varsubset<-ifelse(rv$varsubset=='',NA,rv$varsubset)
  })


  ## help modal
  rv$count <- 1
  observeEvent(input$dec,{
    rv$count<-rv$count-1
  })
  observeEvent(input$inc,{
    rv$count<-rv$count+1
  })
  
  observeEvent(input$helpcg,{
    shinyjs::toggle("mycarouselPanel")
  })

  ## toggles
  # iniciate the table
  observeEvent(input$collapseInput,{
    if (rv$changeselevarsokcount==0)
      shinyjs::click("changeselevarsok")
  })


  ###############
  ## read data ##
  ###############

  # guess format by extension
  observeEvent(input$files, {
    extension <- tools::file_ext(input$files$name)
    if (extension=="sav")
      {updateSelectInput(session, "datatype", selected='*.sav'); return(NULL)}
    if (extension%in%c("xlsx","xls"))
      {updateSelectInput(session, "datatype", selected='*.xls'); return(NULL)}
    if (extension%in%c("rda","rds","RData"))
      {updateSelectInput(session, "datatype", selected='*.rda'); return(NULL)}
    if (extension%in%c("dta"))
      {updateSelectInput(session, "datatype", selected='*.dta'); return(NULL)}
    updateSelectInput(session, "datatype", selected='*.txt')
  })

  observeEvent(input$resetbtn,{
    on.exit({shinyjs::hide("resetbtnPanel")})
    # reset all inputs!!!
    # shinyjs::reset("leftPanel")
    rv$selevars<-rv$method<-rv$descdigits<-rv$ratiodigits<-rv$refratiocat<-rv$factratio<-rv$xhide<-rv$varsubset<-NULL
    rv$initial<-FALSE
    rv$datasetorig <- rv$dataset <- rv$datasetorigfiltered <- data.frame()
    shinyjs::reset("LoadDataPanel")
    shinyjs::reset("ResponseVariablePanel")
    shinyjs::reset("StrataVariablePanel")
    shinyjs::reset("TypePanel")
    shinyjs::reset("HidePanel")
    shinyjs::reset("SubsetPanel")
    shinyjs::reset("RatioPanel")
    shinyjs::reset("ShowPanel")
    shinyjs::reset("FormatPanel")
    shinyjs::reset("DecimalsPanel")
    shinyjs::reset("LabelsPanel")
    shinyjs::reset("SavePanel")
    shinyjs::reset("PlotGroupsPanel")
    shinyjs::reset("PlotVariablesPanel")
    shinyjs::reset("SNPsGroupsPanel")
    shinyjs::reset("SNPsVariablesPanel")
    shinyjs::show("LoadDataPanel")
  })

  # read data
  observeEvent(input$loadok,{
    # remove all elements
    rm(list=ls(),envir=.cGroupsWUIEnv)
    ## begin to read!
    progress <- shiny::Progress$new(session, min=1, max=3)
    progress$set(message = "Reading data",value=1)
    on.exit(progress$close())
    rv$selevars<<-rv$method<<-rv$descdigits<<-rv$ratiodigits<<-rv$refratiocat<<-rv$factratio<<-rv$xhide<<-rv$varsubset<<-NULL
    rv$initial<<-FALSE
    if (input$exampledata!='Own data'){ # read examples...
      datasetname<-input$exampledata
      if (input$exampledata=='REGICOR'){
        data(regicor)
        dataset <- regicor
      }
      if (input$exampledata=='PREDIMED'){
        data(predimed)
        dataset <- predimed
      }
      if (input$exampledata=='SNPS'){
        # data(SNPs,package="SNPassoc")
        data(SNPs)
        dataset <- SNPs
      }
    } else { # read own data
      inFile<-input$files
      if (is.null(inFile)){
        return(invisible(NULL))
      }
      # read TXT
      if (input$datatype=='*.txt'){
        if (is.null(input$quote))
          quote<-'"'
        else{
          if (input$quote==1)
            quote<-""
          if (input$quote==2)
            quote<-'"'
          if (input$quote==3)
            quote<-"'"
        }
        if (input$sep=='o')
          sepchar<-input$sepother
        else
          sepchar<-input$sep
        if (input$encoding=='default')
          dataset<- try(read.table(inFile$datapath,header=input$header,sep=sepchar,quote=quote,dec=input$dechar,na.strings=input$missvalue,skip=input$skip),silent=TRUE)
        else
          dataset<- try(read.table(inFile$datapath,header=input$header,sep=sepchar,quote=quote,dec=input$dechar,na.strings=input$missvalue,skip=input$skip,encoding=input$encoding),silent=TRUE)
        if (inherits(dataset,"try-error")){
          alert("Error in reading data")
          return(invisible(NULL))
        }
        if (!is.data.frame(dataset)){
          alert("Data is not a data frame")
          return(invisible(NULL))
        }
      }
      # read SPSS
      if (input$datatype=='*.sav'){
        dataset <- try(read_sav(inFile$datapath), silent=TRUE)
        if (inherits(dataset,"try-error")){
          alert("Error in reading data")
          return(invisible(NULL))
        }
        if (!inherits(dataset, "data.frame")){
          alert("Data is not a data frame")
          return(invisible(NULL))
        }
        # fix data
        dataset <- as_factor(dataset)
        dataset <- as.data.frame(dataset)
        # vl<-attr(dataset,"variable.labels")
        for (i in 1:ncol(dataset)){
          vari.label <- if (is.null(attr(dataset[,i],"label",exact=TRUE))) "" else attr(dataset[,i],"label",exact=TRUE)
          # if (inherits(dataset[,i], "labelled")){
          #   value.labels <- attr(dataset[,i],"labels",exact=TRUE)
          #   dataset[,i] <- factor(dataset[,i], levels=value.labels, labels=names(value.labels))
          #   class(dataset[,i]) <- class(dataset[,i])[class(dataset[,i])!='labelled']
          # }
          attr(dataset[,i],"label") <- vari.label
        }
      }
      # read STATA
      if (input$datatype=='*.dta'){
        dataset <- try(read_stata(inFile$datapath), silent=TRUE)
        if (inherits(dataset,"try-error")){
          alert("Error in reading data")
          return(invisible(NULL))
        }
        if (!inherits(dataset, "data.frame")){
          alert("Data is not a data frame")
          return(invisible(NULL))
        }
        # fix data
        dataset <- as.data.frame(dataset)
        # vl<-attr(dataset,"variable.labels")
        for (i in 1:ncol(dataset)){
          vari.label <- if (is.null(attr(dataset[,i],"label",exact=TRUE))) "" else attr(dataset[,i],"label",exact=TRUE)
          if (inherits(dataset[,i], "labelled")){
            value.labels <- attr(dataset[,i],"labels",exact=TRUE)
            dataset[,i] <- factor(dataset[,i], levels=value.labels, labels=names(value.labels))
            class(dataset[,i]) <- class(dataset[,i])[class(dataset[,i])!='labelled']
          }
          attr(dataset[,i],"label") <- vari.label
        }
      }
      # read R
      if (input$datatype=='*.rda'){
        datasetname <- try(load(inFile$datapath),silent=TRUE)
        if (inherits(datasetname,"try-error")){
          alert("Error in reading data")
          return(invisible(NULL))
        }
        dataset <- get(datasetname)
        if (!is.data.frame(dataset)){
          alert("Data is not a data frame")
          return(invisible(NULL))
        }
      }
      # read EXCEL
      if (input$datatype=='*.xls'){
        if (is.null(input$tablenames))
          return(invisible(NULL))
        dataset<-try(readxl::read_excel(path=inFile$datapath, sheet=input$tablenames, skip=input$skipexcel, col_names=input$headerexcel, na=input$missvalueexcel), silent=TRUE)
        if (inherits(dataset,"try-error")){
          alert("Data set could not be loaded.\nCheck if the file belongs to Excel format.")
          return(invisible(NULL))
        }
        dataset <- as.data.frame(dataset) # to remove tibble class.
        if (input$stringToFactorexcel) # convert to factor
          for (i in seq_along(dataset))
            if (is.character(dataset[,i])){
              lab.i <- attr(dataset[,i], "label", exact=TRUE)
              dataset[,i] <- factor(dataset[,i])
              attr(dataset[,i],"label") <- lab.i
            }
      }
    }
    if (!inherits(dataset, "data.frame") || nrow(dataset)==0){
      alert("Dataset could not be loaded.\nCheck the file format and/or the options.")
      return(invisible(NULL))
    }

    # iniciate selevars
    rv$selevars<-names(dataset)

    # iniciate method
    res<-try(compareGroups(~.,dataset,max.xlev=Inf,max.ylev=Inf,method=NA),silent=TRUE)
    if (inherits(res, "try-error")){
      rv$methods <- structure(rep(1,ncol(dataset)), names=names(dataset))
    } else {
      method<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
      method<-ifelse(method=="continuous normal",1,
                   ifelse(method=="continuous non-normal",2,3))
      names(method)<-attr(res,"varnames.orig")
      rv$method<<-method
    }

    # iniciate descdigits
    rv$descdigits <- structure(rep(NA,ncol(dataset)), names=names(dataset))

    # iniciate ratiodigits
    rv$ratiodigits <- structure(rep(NA,ncol(dataset)), names=names(dataset))

    # iniciate reference category for OR/HR of categorical row-variables
    rv$refratiocat <- structure(rep(1,ncol(dataset)), names=names(dataset))

    # iniciate factor to be multiplied for continuous variables in computing OR/HR
    rv$factratio <- structure(rep(1,ncol(dataset)), names=names(dataset))

    # iniciate hide
    rv$xhide <- structure(rep(NA,ncol(dataset)), names=names(dataset))

    # iniciate variable subset
    rv$varsubset <- structure(rep(NA,ncol(dataset)), names=names(dataset))

    # iniciate recoded vars names
    rv$recodedvars <- character()

    # iniciate selected variables (by default all)
    updateSelectInput(session, "selevars", selected=names(dataset), choices=names(dataset))
    updateSelectInput(session, "plotselevars", selected=names(dataset), choices=names(dataset))
    updateSelectInput(session, "snpsselevars", selected=names(dataset), choices=names(dataset))

    # return data
    rv$datasetorig <- dataset
    rv$dataset <- dataset
    rv$datasetorigfiltered <- dataset

    # when data is loaded, hide the LoadDataPanel
    shinyjs::hide("LoadDataPanel")
    shinyjs::show("resetbtnPanel")

  })

  # if datasetorig is changed (means that new variable is created or data is reload) then dataset it must be reset too!!!
  observeEvent(rv$datasetorig,{
    rv$dataset <- rv$datasetorig
  })

  # when filter is applied dataset must be updated
  observeEvent(rv$datasetorigfiltered,{
    rv$dataset <- rv$datasetorigfiltered
  })




  ###############################
  ###### Filter data ############
  ###############################

  observeEvent(input$filterdataok,{
    filterexpr <- input$filterexpr
    if (compareGroups:::trim(filterexpr)==""){  # no filter (recover original dataset)
      rv$datasetorigfiltered <- rv$datasetorig
    }
    if (nrow(rv$datasetorig)==0) return(NULL)
    filterexpr <- paste0("subset(rv$datasetorig,",filterexpr,")")
    ans <- try(eval(parse(text=filterexpr)), silent=TRUE)
    if (inherits(ans, "try-error")){
      alert("Expression could not be evaluated. Check the variable names or the syntax.")
      return(NULL)
    }
    rv$datasetorigfiltered <- ans
  })

  observeEvent(input$removefilterdataok,{
    updateTextAreaInput(session, "filterexpr", value="")
  })




  ###############################
  #### LOAD OPTIONS #############
  ###############################

  output$loadoptions<-renderUI({
    inFile<-input$files
    if (is.null(input$datatype))
      return(invisible(NULL))
    if (input$datatype!='*.xls' && input$datatype!='*.txt'){
      return(invisible(NULL))
    } else {
      # EXCELL
      if (input$datatype=='*.xls'){
        if (is.null(inFile))
          return(invisible(NULL))
        tablenames <- try(readxl::excel_sheets(inFile$datapath), silent=TRUE)
        if (inherits(tablenames,"try-error") || length(tablenames)==0)
          return(invisible(NULL))
        names(tablenames)<-tablenames
        return(
          div(
            selectInput("tablenames", "Choose the table to read:", choices = tablenames, selectize=FALSE),
            checkboxInput('headerexcel', 'Has column headers', TRUE),
            numericInput("skipexcel", "Number of rows to skip", value=0),
            textInput("missvalueexcel", HTML("Missing Data String (e.g. <i>NA</i>)"), ""),
            checkboxInput("stringToFactorexcel", "Convert string variables to factor", value=TRUE)
          )
        )
      } else {
        # TXT
        if (input$datatype=='*.txt'){
          return(
            wellPanel(
              HTML('<p style="font-style:Bold; font-size:18px">TEXT Options</p>'),
              checkboxInput('header', 'Has column headers', TRUE),
              numericInput("skip", "Number of rows to skip", value=0),
              textInput("missvalue", HTML("Missing Data String (e.g. <i>NA</i>)"), ""),
              selectInput('sep', 'Column Separator', c(Comma=',', Semicolon=';', Tab='\t', Other='o'), ','),
              conditionalPanel(
                condition = "input.sep == 'o'",
                textInput("sepother", "Specify separator character","")
              ),
              selectInput('dechar', 'Decimal point character', c('Comma'=',', 'Dot'='.'), '.'),
              selectInput('quote', 'Values in Quotes?', c("None"=1, "Double"=2, "Single"=3), 2),
              radioButtons("encoding", "Encoding", c('default'='default','latin1'='latin1','utf8'='utf8'),'default',inline=TRUE)
            )
          )
        }
      }
    }
  })


  ###################
  ### create table ##
  ###################

  create<-reactive({

    # if (is.null(input$loadok)) return(NULL)
    rv$changeglobalsubsetcount
    # rv$changeselevarsokcount
    input$changeselevarsok
    rv$changerespcount
    rv$changepvalsdigitscount
    rv$changehidecount
    rv$changefactratiocount
    rv$changeformatcount
    rv$changeshowcount
    rv$changeratiocatcount
    rv$changemethodcount
    rv$changestratacount
    rv$changevarsubsetcount
    rv$changedescdigitscount
    rv$changeratiodigitscount

    input$udpateSelection

    progress <- shiny::Progress$new(session, min=0, max=4)
    progress$set(message = "Creating bivariate table",value=1)
    on.exit(progress$close())


    isolate({

      dd<-rv$dataset

      validate(need(dd, "Data not loaded"))

      validate(need(!is.null(rv$selevars) && length(rv$selevars)>0,"No variables selected"))

      # form
      if (is.null(input$resptype) || input$resptype=='None'){
        form<-as.formula(paste("~",paste(paste0("`",rv$selevars,"`"),collapse="+"),sep=""))
      } else {
        if (input$resptype=='Survival'){
          # statusval<-as.numeric(strsplit(input$statuscat,":")[[1]][1])
          # cens<-as.integer(dd[,input$varselestatus])==statusval
          statusval <- paste(input$statuscat, collapse=";")
          cens <- as.integer(dd[,input$varselestatus]%in%input$statuscat)
          validate(need(length(input$statuscat)>=1, "you must select at least one category"))
          times<-dd[,input$varseletime]
          dd$"respsurv"<-Surv(times,cens)
          # attr(dd$"respsurv","label")<-paste("[ ",input$varseletime,"; ",input$varselestatus,"=", levels(as.factor(dd[,input$varselestatus]))[statusval],"]")
          attr(dd$"respsurv","label")<-paste("[ ",input$varseletime,"; ",input$varselestatus,"=", statusval,"]")
          form<-as.formula(paste("respsurv~",paste(paste0("`",rv$selevars,"`"),collapse="+"),sep=""))
        } else {
          form<-as.formula(paste(input$gvar,"~",paste(paste0("`",rv$selevars,"`"),collapse="+"),sep=""))
        }
      }
      computeratio<-if (is.null(input$computeratio) || input$resptype=='Survival') TRUE else input$computeratio
      pvaldigits<-if (is.null(input$pvaldigits)) 3 else input$pvaldigits

      # variables subset
      varsubset <- rv$varsubset
      if (is.null(rv$varsubset))
        selec.list <- "NA"
      else {
        varsubset <- varsubset[!is.na(varsubset)]
        if (length(varsubset)==0)
          selec.list <- "NA"
        else
          selec.list <- paste0("list(", paste(paste(names(varsubset),"=",varsubset), collapse=", "),")")
      }

      # hide.no
      if (length(input$hideno)==0 || input$hideno=='')
        hideno<-NA
      else
        hideno<-unlist(strsplit(input$hideno,","))

      # ref
      refno<-hideno
      refy<-if (is.null(input$gvarcat)) 1 else as.numeric(input$gvarcat)
      res<-compareGroups(form,dd,max.xlev=Inf,max.ylev=Inf,method=rv$method,compute.ratio=FALSE)
      refratiocat<-as.vector(rv$refratiocat[attr(res,"varnames.orig")])
      factratio<-as.vector(rv$factratio[attr(res,"varnames.orig")])

      # method
      method<-as.vector(rv$method[attr(res,"varnames.orig")])
      xhide<-as.vector(rv$xhide[attr(res,"varnames.orig")])
      descdigits<-as.vector(rv$descdigits[attr(res,"varnames.orig")])
      ratiodigits<-as.vector(rv$ratiodigits[attr(res,"varnames.orig")])
      alpha<-if (is.null(input$alpha)) 0.05 else input$alpha
      mindis<-if (is.null(input$mindis)) 0.05 else input$mindis

      # quartiles, sd, ...
      Q1<-if (is.null(input$Q1)) 25 else input$Q1
      Q3<-if (is.null(input$Q3)) 75 else input$Q3

      qtype1<-if (is.null(input$qtype1)) 1 else input$qtype1
      qtype2<-if (is.null(input$qtype2)) 1 else input$qtype2
      type<-if (is.null(input$type)) NA else input$type
      sdtype<-if (is.null(input$sdtype)) 1 else input$sdtype

      showpoverall<-if (is.null(input$showpoverall)) TRUE else input$showpoverall
      showptrend<-if (is.null(input$showptrend)) FALSE else input$showptrend
      showratio<-if (is.null(input$showratio)) FALSE else input$showratio
      showpratio<-if (is.null(input$showpratio)) showratio else input$showpratio
      showall<-if (is.null(input$showall)) TRUE else input$showall
      shown<-if (is.null(input$shown)) FALSE else input$shown
      showdesc<-if (is.null(input$showdesc)) TRUE else input$showdesc
      showpmul<-if (is.null(input$showpmul)) FALSE else input$showpmul
      pcorrected<-if (is.null(input$pcorrected)) 0.05 else input$pcorrected
      includemiss<-if (is.null(input$includemiss)) FALSE else input$includemiss
      simplify<-if (is.null(input$simplify)) TRUE else input$simplify
      Dateformat<-if (is.null(input$Dateformat)) "d-mon-Y" else input$Dateformat
      byrow <- if (is.null(input$byrow)) FALSE else switch(input$byrow, rows=TRUE, columns=FALSE, total=NA)
      conflevel <- if (is.null(input$conflevel)) 0.95 else input$conflevel/100
      showci <- if (is.null(input$showci)) FALSE else input$showci
      riskratio <- if (is.null(input$riskratio)) FALSE else input$riskratio=="RR"
      oddsratiomethod <- if (is.null(input$oddsratiomethod)) "midp" else input$oddsratiomethod
      riskratiomethod <- if (is.null(input$riskratiomethod)) "wald" else input$riskratiomethod
      timemax <- if (is.null(input$timemax)) NA else input$timemax
      if(is.null(input$extralabels) || !input$extralabels){
        extra.labels <- NA
      } else {
        extra.labels <- c(input$extralabelmean,input$extralabelmedian,input$extralabelperc,input$extralabelsurv)  
      }

      # compareGroups
      cmd.res <- paste0("compareGroups(form,dd,max.xlev=Inf,max.ylev=Inf,method=method,timemax=timemax,include.miss=includemiss,ref.no='no',
                           ref=refratiocat,Q1=Q1/100,Q3=Q3/100,simplify=simplify,compute.ratio=computeratio,
                           fact.ratio=factratio,ref.y=refy,min.dis=mindis,alpha=alpha,p.corrected=pcorrected,
                           Date.format=Dateformat,byrow=byrow,conf.level=conflevel,riskratio = riskratio,
                           riskratio.method=riskratiomethod,oddsratio.method=oddsratiomethod,
                           selec=",selec.list,")")

      res <- eval(parse(text=cmd.res))

      # createTable
      restab<-createTable(res,show.p.overall=showpoverall,show.p.trend=showptrend,show.ratio=showratio,
                          show.p.ratio=showpratio,show.all=showall,show.n=shown,show.desc=showdesc,
                          hide.no=hideno,hide=xhide,type=type,sd.type=sdtype,q.type=c(qtype1,qtype2),
                          digits=descdigits,digits.ratio=ratiodigits,digits.p=pvaldigits,
                          show.p.mul=showpmul,show.ci=showci,extra.labels=extra.labels)
      # strataTable
      if (!is.null(input$stratatype) && input$stratatype!="None"){
        cg <- attr(restab, "x", exact = TRUE)[[1]]
        Xext <- attr(cg, "Xext", exact = TRUE)
        strata <- input$svar
        strata.var <- factor(Xext[,strata])
        global.subset <- attr(cg, "subset")
        if (!is.null(global.subset))
          global.subset <- paste0(" & (",global.subset,")")
        else
          global.subset <- ""
        x.list <- lapply(levels(strata.var), function(i){
            subset.i <- paste0("as.factor(",strata,")=='",i,"'",global.subset)
            cg.i <- eval(parse(text=paste0("update(cg, subset=",subset.i,", simplify=FALSE)")))
            x.i <- update(restab, x=cg.i)
            x.i
        })
        strata.names <- levels(strata.var)
        restab <- do.call(cbind, structure(x.list, names=strata.names))
      }
    })

    # return
    return(restab)
  })

  #########################
  ### create compareSNPs ##
  #########################

  createSNPs<-reactive({
    if (input$snpsvarchange==0 & input$snpsgroupschange==0 & input$snpsoptionschange==0) return(invisible(NULL))
    isolate({
      withProgress(message = 'Creating SNPs table', value = 1, {
        dd<-rv$dataset
        validate(need(dd, "Data not loaded"))
        validate(need(length(input$snpsselevars)>0, "No variables selected"))
        if (is.null(input$snpsresptype) || input$snpsresptype=='None')
          form<-as.formula(paste("~",paste(paste0("`",input$snpsselevars,"`"),collapse="+"),sep=""))
        else
          form<-as.formula(paste(input$snpsgvar,"~",paste(paste0("`",input$snpsselevars,"`"),collapse="+"),sep=""))
        restabSNPs<-try(compareSNPs(form, dd, sep = input$sepSNPs), silent=TRUE)
        incProgress(1, detail = "")
        validate(need(restabSNPs, "Error: Some variables could not be converted to SNPs. Check the selected variables and the allele separator."))
        return(restabSNPs)
      })
    })
  })

  ####################
  ### values table ###
  ####################

  ## values summary
  output$valuestable <- renderText({
    dd<-rv$dataset
    validate(need(dd, "Data not loaded"))
    input$changemethod
    input$changeselevarsok
    input$maxvalues
    input$htmlsizeinfotab
    isolate({
      validate(need(!is.null(rv$selevars) && length(rv$selevars)>0, "no variables selected"))
      dd<-dd[,rv$selevars,drop=FALSE]
      method<-rv$method[rv$selevars]
      method<-ifelse(method==1,'Normal',ifelse(method==2,'Non-normal','Categorical'))
      values<-n<-NULL
      varnames.orig<-names(dd)
      for (i in 1:ncol(dd)){
        x.i<-dd[,i]
        if (is.character(x.i)){
          vari.label <- attr(x.i, "label", exact=TRUE)
          x.i <- factor(x.i)
          attr(x.i, "label") <- vari.label
        }
        n<-c(n,sum(!is.na(x.i)))
        if (is.factor(x.i)){
          if (nlevels(x.i)>input$maxvalues){
            vv<-paste("'",levels(x.i),"'",sep="")
            cc<-1:nlevels(x.i)
            vv<-c(paste("-",vv[1:(input$maxvalues-1)],sep=""),"...",paste("-",vv[length(vv)],sep=""))
            cc<-c(cc[1:(input$maxvalues-1)],"",cc[length(cc)])
            values<-c(values,paste(paste(cc,vv,sep=""),collapse="<br/> "))
          }else
            values<-c(values,paste(paste(1:nlevels(x.i),paste("'",levels(x.i),"'",sep=""),sep="-"),collapse="<br/> "))
        } else{
          if (all(is.na(x.i)))
            values<-c(values,"-")
          else
            values<-c(values,paste(compareGroups:::format2(range(x.i,na.rm=TRUE)),collapse="; "))
        }
      }
      vari.labels <- sapply(dd,function(dd.i) if (is.null(attr(dd.i, "label", exact=TRUE))) "" else attr(dd.i, "label", exact=TRUE))
      ans<-data.frame("Name"=varnames.orig,"Label"=vari.labels,"Method"=sub("continuous ","",method),"N"=n,"Values"=values)
      nrows <- nrow(ans)
      ans <- kable(ans, format="html", row.names=FALSE, escape=FALSE)
      ans <- kableExtra::kable_styling(ans,position="left",font_size=input$htmlsizeinfotab, bootstrap_options = c("condensed","striped","bordered"),full_width = FALSE)
      ans <- kableExtra::row_spec(ans, 0, background=grey(0.3),color="white")
      # ans <- kableExtra::row_spec(ans, 1:nrows,extra_css = "border-bottom:1px solid black;border-top:1px solid black")
      ans <- kableExtra::row_spec(ans, which((1:nrows)%%2==0), background=grey(0.85))
    })
    return(ans)
  })

  ## values extended
  output$valuesext <- DT::renderDataTable({
    # dd <- rv$datasetorigfiltered
    dd <- rv$datasetorig
    if (NROW(dd)==0) return(invisible(NULL))
    validate(need(dd, "Data not loaded"))
    withProgress(message="Displaying data table", min=0, max=1, {
      which.Surv <- sapply(dd, is.Surv)
      if (any(which.Surv)){
        dataAlertContent <- paste("Variables",paste(names(dd)[which.Surv], collapse=","),"not shown since they are of class survival")
        closeAlert(session, "dataAlertMessage")
        createAlert(session, "dataAlert", "dataAlertMessage", title="", content=dataAlertContent, append = FALSE, style="warning")      
        dd <- dd[!which.Surv]
      }
      nn <- names(dd)
      ll <- sapply(seq_along(nn), function(i){
        if (!is.null(attr(dd[,i],"label", exact=TRUE)))
          return(attr(dd[,i],"label", exact=TRUE))
        else
          return(nn[i])
      })
      nn <- names(dd)
      if (length(rv$recodedvars)>0 && any(rv$recodedvars%in%nn))
        nn[nn%in%rv$recodedvars] <- paste0("<format style='color:red'>",nn[nn%in%rv$recodedvars],"</format>")
  
      if (!is.null(input$showlabels) && input$showlabels){
        if (!identical(ll,names(dd))) nn <- paste0(nn,"<format style='color:grey;font-size:75%'><br><i>",ll,"</i></format>")
      }
  
      ans <- DT::datatable(dd,
                      escape=FALSE,
                      filter = "top",
                      rownames= FALSE,
                      colnames=nn,
                      extensions = list("ColReorder" = NULL,
                                        "Buttons" = NULL,
                                        "FixedColumns" = list(leftColumns=1)),
                      options = list(
                          initComplete = JS(
                            "function(settings, json) {",
                            paste0("$(this.api().table().header()).css({'font-size': '",input$valueextsize,"%'});"),
                            "}"),
                          # language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Catalan.json'),
                          scrollX = TRUE,
                          dom = 'BRrltpi',
                          autoWidth=TRUE,
                          lengthMenu = list(c(10, 50, -1), c('10', '50', 'All')),
                          ColReorder = TRUE,
                          buttons =
                            list(
                              # 'copy',
                              # 'print',
                              list(
                                extend = 'collection',
                                buttons = c('csv', 'excel', 'pdf'),
                                text = 'Download'
                              ),
                              I('colvis')
                            )
                      ))
      ans <- formatStyle(ans,columns=0:ncol(dd),`font-size`=paste0(input$valueextsize,"%"))
      incProgress(amount=1)
      ans
    })
  })
  
  output$valuesextui <- renderUI({
    valueextwidth <- if (is.null(input$valueextwidth)) "100%" else paste0(input$valueextwidth,"%")
    DT::dataTableOutput("valuesext", width=valueextwidth)
  })

  output$typeout <- renderUI({
    if (!rv$initial) return(invisible(NULL))
    return(
      div(
        uiOutput("selemethod"),
        uiOutput("selemethodNA")
      )
    )
  })

  ############################
  ##### html createTable #####
  ############################

  output$htmltab <- renderText({
    restab<-create()
    if (is.null(restab))
      return(invisible(NULL))
    input$changeLabels
    isolate({
      captionlabel<-input$captionlabel
      if (!is.null(captionlabel) && captionlabel=='NULL')
        captionlabel<-NULL
      header.labels<-c('all'=input$alllabel,'p.overall'=input$poveralllabel,'p.trend'=input$ptrendlabel,'p.ratio'=input$pratiolabel,'N'=input$Nlabel)
    })
    position <- if (is.null(input$position)) "center" else input$position
    withProgress(message = 'Visualizing the table', value=0, {
      ans <- export2md(restab,header.labels=header.labels,caption=captionlabel, format="html",
                     width=paste0(input$htmlwidthrestab,"cm"),header.color=input$header.color,header.background=input$header.background,
                     size=input$htmlsizerestab,background=input$strip.color,strip=input$strip,first.strip=TRUE,position=position)
      incProgress(1, detail="")
      ans
    })
  })


  ############################
  ##### print compareSNPs ####
  ############################

  output$restabSNPs <- renderPrint({
    createSNPs()
  })

  ##############################
  ##### summary createTable ####
  ##############################

  output$sumtab <- renderText({

    progress <- shiny::Progress$new(session, min=1, max=3)
    progress$set(message = "Creating info table",value=0)
    on.exit(progress$close())

    restab<-create()
    if (is.null(restab))
      return(invisible(NULL))

    export2md(restab, format="html", which.table="avail",width=paste0(input$htmlwidthrestab,"cm"),header.color=input$header.color,
              header.background=input$header.background,size=input$htmlsizerestab)

  })

  ##############################
  ##### varinfo             ####
  ##############################

  output$varinfotab <- renderTable({

    progress <- shiny::Progress$new(session, min=1, max=3)
    progress$set(message = "Creating var info table",value=0)
    on.exit(progress$close())

    restab<-create()
    if (is.null(restab))
      return(invisible(NULL))
    if (inherits(restab, "cbind.createTable"))  # stratified table
      ans <- varinfo(restab[[1]])[[1]]
    else
      ans <- varinfo(restab)[[1]]
    colnames(ans) <- c("Name", "Label")
    ans
  })



  ##########################################
  ##### select variables to be analyzed ####
  ##########################################

  # when data is loaded update selevars to all variables
  observe({
    if (NROW(rv$dataset)==0)
      return(NULL)
    dd<-rv$dataset
    nn<-names(dd)
    updateSelectInput(session, "selevars", choices=nn, selected=input$selevars)
    updateSelectInput(session, "plotselevars", choices=nn, selected=input$plotselevars)
    updateSelectInput(session, "snpsselevars", choices=nn, selected=input$snpsselevars)
  })

  observeEvent(input$selevarsAll,{
    dd<-rv$dataset
    nn<-names(dd)
    updateSelectInput(session, "selevars", selected=nn)
  })

  observeEvent(input$selevarsNone,{
    updateSelectInput(session, "selevars", selected=".xxx")
  })


  observeEvent(input$snpsselevarsAll,{
    dd<-rv$dataset
    nn<-names(dd)
    updateSelectInput(session, "snpsselevars", selected=nn)
  })

  observeEvent(input$snpsselevarsNone,{
    updateSelectInput(session, "snpsselevars", selected=".xxx")
  })


  ################################
  ##### select strata variable ###
  ################################


  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    ww <- sapply(dd, function(x) length(unique(na.omit(x)))<=input$maxstrata)
    vlist <- names(ww)[ww]
    updateSelectInput(session, "svar", choices=vlist, selected=input$svar)
  })



  ################################
  ##### select group variable ####
  ################################

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    ww <- sapply(dd, function(x) length(unique(na.omit(x)))<=input$maxgroups)
    vlist <- names(ww)[ww]
    updateSelectInput(session, "gvar", choices=vlist, selected=input$gvar)
  })

  observeEvent(input$gvar, {
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    var <- dd[,input$gvar]
    if (length(unique(na.omit(var)))==2){
      shinyjs::show("computeratio")
      shinyjs::show("ResponseVariableORPanelBtn")
      shinyjs::show("ResponseVariableORPanel")
      updateCheckboxInput(session, "computeratio", value=TRUE)
    } else {
      shinyjs::hide("computeratio")
      shinyjs::hide("ResponseVariableORPanelBtn")
      shinyjs::hide("ResponseVariableORPanel")
      updateCheckboxInput(session, "computeratio", value=FALSE)
    }
  })

  # select category for OR reference (only when two categories).
  output$vargroupcat <- renderUI({
    dd<-rv$dataset
    if (is.null(dd)){
      return(invisible(NULL))
    }
    if (is.null(input$gvar))
      return(invisible(NULL))
    vv<-dd[,input$gvar]
    if (nlevels(vv)!=2)
      return(NULL)
    vlist<-paste(1:nlevels(vv),levels(vv),sep=":")
    names(vlist)<-vlist
    conditionalPanel(
      condition = "input.computeratio == true",
      selectInput("gvarcat", "OR ref. cat:", choices = vlist, selectize=FALSE)
    )
  })

  observe({
    dd<-rv$dataset
    if (NROW(dd)==0){
      return(invisible(NULL))
    }
    if (length(input$gvar)==0 || input$gvar=='')
      return(invisible(NULL))
    vv<-as.factor(dd[,input$gvar])
    if (nlevels(vv)!=2)
      return(NULL)
    vlist<-1:nlevels(vv)
    names(vlist) <- levels(vv)
    updateSelectInput(session, "gvarcat", choices=vlist)
  })

  observeEvent(input$ResponseVariableORPanelBtn,{
    shinyjs::toggle("ResponseVariableORPanel", anim=TRUE)
  })


  ########################
  ##### select method ####
  ########################

  observeEvent(rv$selevars,{
    updatePickerInput(session, "varselemethod", choices=rv$selevars, selected = input$varselemethod)
  })

  # when table is not created (no variables selected or whatever, hide some panels)
  observe({
    if (is.null(create())){
      shinyjs::hide("TypePanel")
      shinyjs::hide("HidePanel")
      shinyjs::hide("SubsetPanel")
      shinyjs::hide("ShowPanel")
      shinyjs::hide("RatioPanel")
      shinyjs::hide("FormatPanel")
      shinyjs::hide("DecimalsPanel")
    }else{
      shinyjs::show("TypePanel")
      shinyjs::show("HidePanel")
      shinyjs::show("SubsetPanel")
      shinyjs::show("ShowPanel")
      shinyjs::show("RatioPanel")
      shinyjs::show("FormatPanel")
      shinyjs::show("DecimalsPanel")
    }
  })



  ####################################
  ##### select descriptive digits ####
  ####################################

  observe({
    updatePickerInput(session, "varseledescdigits", choices=rv$selevars, selected=input$varseledescdigits)
  })


  ##############################
  ##### select ratio digits ####
  ##############################

  observe({
    updatePickerInput(session, "varseleratiodigits", choices=rv$selevars, selected=input$varseleratiodigits)
  })


  ##########################
  ##### variable subset ####
  ##########################

  observe({
    updatePickerInput(session, "varselevarsubset", choices=rv$selevars, selected=input$varselevarsubset)
  })

  observeEvent(input$removechangevarsubset,{
    updateTextAreaInput(session,"varsubset",value="")
  })


  ###############################################################
  ##### select reference category in OR/HR for row-variables ####
  ###############################################################

  observe({
    dd<-rv$dataset
    if (NROW(dd)==0) return(NULL)
    if (is.null(rv$selevars) || length(rv$selevars)==0) return(NULL)
    input$changemethod
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal", 1, ifelse(method.temp=="continuous non-normal", 2, 3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp==3]
    names(vlist)<-vlist
    vlist<-intersect(vlist,rv$selevars)
    if (length(vlist)==0) return(invisible(NULL))
    updateSelectInput(session, "varselerefratio", choices = vlist, selected=input$varselerefratio)
  })

  observe({
    dd<-rv$dataset
    if (NROW(dd)==0) return(invisible(NULL))
    if (is.null(rv$selevars) || length(rv$selevars)==0) return(invisible(NULL))
    if (is.null(input$varselerefratio) || input$varselerefratio=="No categorical variables") return(invisible(NULL))
    vv<-as.factor(dd[,input$varselerefratio])
    vlist<-1:nlevels(vv)
    names(vlist)<-paste(vlist,levels(vv),sep=":")
    updateSelectInput(session, "refratiocat", choices=vlist, selected=input$refratiocat)
  })


  #########################################
  ##### select factor to compute OR/HR ####
  #########################################

  observe({
    updatePickerInput(session, "varselefactratio", choices=rv$selevars, selected=input$varselefactratio)
  })


  #################################
  ##### select hide category ######
  #################################

  observe({
    dd<-rv$dataset
    if (NROW(dd)==0) return(invisible(NULL))
    input$changemethod
    if (is.null(rv$selevars) || length(rv$selevars)==0) return(NULL)
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal",1, ifelse(method.temp=="continuous non-normal", 2, 3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp==3]
    names(vlist)<-vlist
    vlist<-intersect(vlist,rv$selevars)
    if (length(vlist)==0) return(invisible(NULL))
    updateSelectInput(session, "varselehide", choices = vlist, selected=input$varselehide)
  })

  observe({
    dd<-rv$dataset
    if (NROW(dd)==0) return(invisible(NULL))
    if (is.null(rv$selevars) || length(rv$selevars)==0) return(invisible(NULL))
    if (is.null(input$varselehide)) return(invisible(NULL))
    vv<-as.factor(dd[,input$varselehide])
    vlist<-c(NA,1:nlevels(vv))
    names(vlist)<-paste(vlist,c("<<None>>",levels(vv)),sep=":")
    updateSelectInput(session, "hidecat", choices=vlist, selected=input$hidecat)
  })


  #################################
  ##### select time variable ######
  #################################

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    ww <- sapply(dd, is.numeric)
    if (!any(ww)) return(NULL)
    vlist <- names(dd)[ww]
    updateSelectInput(session, "varseletime", choices=vlist, selected=input$varseletime)
  })

  #################################
  ##### select status variable ####
  #################################

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    ww1 <- sapply(dd, function(x) is.numeric(x) && length(unique(na.omit(x)))<=10) # maxim 10 valors diferents
    ww2 <- sapply(dd, function(x) is.factor(x) || is.character(x))
    ww <- ww1 | ww2
    if (!any(ww)) return(NULL)
    vlist <- names(dd)[ww]
    updateSelectInput(session, "varselestatus", choices=vlist, selected=input$varselestatus)   #vlist[1])
  })
  

  ######################################
  ##### select death category/ies ######
  ######################################

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    if (is.na(input$varselestatus) || length(input$varselestatus)==0 || input$varselestatus=="") return(NULL)
    if (!input$varselestatus%in%names(dd)) return(NULL)
    var <- dd[,input$varselestatus]
    if (!is.factor(var)) var <- factor(var)
    vlist <- levels(var)
    updateSelectInput(session, "statuscat", choices=vlist, selected=input$statuscat)
  })


  ######################################
  ####### show #########################
  ######################################

  # if show.ratio compute OR
  observeEvent(input$showratio,{
    if (input$showratio){
      updateCheckboxInput(session, "computeratio", value=TRUE)
    }
  })


  ########################
  ##### labels ###########
  ########################

  observeEvent(input$refreshLabels,{
    updateTextInput(session, "alllabel", value="[ALL]")
    updateTextInput(session, "poveralllabel", value="p.overall")
    updateTextInput(session, "ptrendlabel", value="p.trend")
    updateTextInput(session, "pratiolabel", value="p.ratio")
    updateTextInput(session, "Nlabel", value="N")
    updateTextInput(session, "captionlabel", value="NULL")
  })

  
  ########################
  ####### values #########
  ########################

  output$values <- renderUI({
    validate(need(rv$initial, "Data not loaded"))
    div(
      dropdownButton(inputId="valuessumoptionsaction",label="View options",circle=FALSE,status="info",
        div(id="valuessumoptions",
          fluidRow(
            column(4,numericInput("maxvalues", "Maximum number of categories to display:", min=3, max=100, value=10, step=1)),
            column(8,sliderInput("htmlsizeinfotab", "Resize", min=4, max=30, value=16))
          )
        )
      ),
      br(),
      htmlOutput('valuestable')
    )
  })


  ########################
  ####### table ##########
  ########################

  output$table <- renderUI({
    validate(need(rv$initial, "Data not loaded"))
    htmlOutput('htmltab')
  })

  ########################
  ###### plot ############
  ########################

  ##### select response #############

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    ww <- sapply(dd, function(x) length(unique(na.omit(x)))<=input$plotmaxgroups)
    vlist <- names(ww)[ww]
    updateSelectInput(session, "plotgvar", choices=vlist)
  })

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    ww <- sapply(dd, is.numeric)
    if (!any(ww)) return(NULL)
    vlist <- names(dd)[ww]
    updateSelectInput(session, "plotvarseletime", choices=vlist)
  })

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    ww1 <- sapply(dd, function(x) is.numeric(x) && length(unique(na.omit(x)))<=10)
    ww2 <- sapply(dd, function(x) is.factor(x) || is.character(x))
    ww <- ww1 | ww2
    if (!any(ww)) return(NULL)
    vlist <- names(dd)[ww]
    updateSelectInput(session, "plotvarselestatus", choices=vlist, selected=vlist[1])
  })

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    if (is.na(input$plotvarselestatus) || length(input$plotvarselestatus)==0 || input$plotvarselestatus=="") return(NULL)
    if (!input$plotvarselestatus%in%names(dd)) return(NULL)
    var <- dd[,input$plotvarselestatus]
    if (!is.factor(var)) var <- factor(var)
    vlist <- levels(var)
    updateSelectInput(session, "plotstatuscat", choices=vlist)
  })

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    vlist <- names(dd)
    updateSelectInput(session, "plotselevars", choices=vlist)
  })


  ########################
  ######## snps ##########
  ########################

  observe({
    dd <- rv$dataset
    if (NROW(dd)==0) return(NULL)
    ww <- sapply(dd, function(x) length(unique(na.omit(x)))<=input$snpsmaxgroups)
    vlist <- names(ww)[ww]
    updateSelectInput(session, "snpsgvar", choices=vlist, selected=input$snpsgvar)
  })


  ########################
  ##### plot #############
  ########################

  observe({
    if (!is.null(input$collapseInput) && input$collapseInput=="collapseResponse"){
      if (!is.null(input$ResponseTabsetPanel) && input$ResponseTabsetPanel=="Response"){
        if (rv$changerespcount==0) return(NULL)
        isolate({
          if (!is.null(input$resptype) && input$resptype != 'None')
            shinyjs::show("bivar")
          else
            shinyjs::hide("bivar")
        })
      }
    }

  })

  observe({
    ct <- create()
    if (is.null(input$varPlot)) return(NULL)
    if (is.null(ct)) return(NULL)
    cg <- attr(ct,"x")[[1]]
    mm <- lapply(cg, attr, which="method")
    orig.names <- attr(cg, "varnames.orig")
    categ <- sapply(mm, function(mm.i) "categorical"%in%mm.i)
    categ.vars <- orig.names[categ]
    if (input$varPlot%in%categ.vars)
      shinyjs::show("perc")
    else
      shinyjs::hide("perc")
  })


  output$plot <- renderPlot({
    rv$plotcreated <- FALSE
    if (input$plotvarchange==0 & input$plotgroupschange==0) return(invisible(NULL))
    input$udpateSelection
    input$perc
    isolate({
      dd <- rv$dataset
      validate(need(dd, "Data not loaded yet"))
      validate(need(input$plotselevars, "Select one variable"))
      perc<-if (is.null(input$perc)) FALSE else input$perc
      if (!inherits(dd[,input$plotselevars],"factor"))
        hide("perc") 
      else 
        show("perc")
      if (!inherits(dd[,input$plotselevars],"Surv"))
        updateRadioGroupButtons(session, "plotresptype", choices=c("None","Group","Survival")) 
      else 
        updateRadioGroupButtons(session, "plotresptype", choices=c("None","Group"))      
      withProgress(message = 'Making plot', value = 0, {
        if (is.null(input$plotresptype) || input$plotresptype=='None')
          form <- paste0("~",input$plotselevars)
        if (!is.null(input$plotresptype) && input$plotresptype=='Group')
          form <- paste0(input$plotgvar,"~",input$plotselevars)
        if (!is.null(input$plotresptype) && input$plotresptype=='Survival'){
          times<-dd[,input$plotvarseletime]
          validate(need(length(input$plotstatuscat)>=1, "you must select at least one category"))
          cens <- as.integer(dd[,input$plotvarselestatus]%in%input$plotstatuscat)
          dd$"respsurv"<-Surv(times,cens)
          form <- paste0("respsurv ~ ",input$plotselevars)
        }
        cg <- compareGroups(as.formula(form), dd)
        plot(cg,bivar=TRUE,perc=perc)
        # shinyjs::show("downPlotOptionsPanel")
        incProgress(1,detail="")
      })
      rv$plotcreated <- TRUE
    })
  })



  ####################################
  ############  HELP  ################
  ####################################

  # output$helpload<-renderUI(HTML(hlp['LOAD']))
  # output$helpselect<-renderUI(HTML(hlp['SELECT']))
  # output$helptype<-renderUI(HTML(hlp['Type']))
  # output$helpresponse<-renderUI(HTML(hlp['Response']))
  # output$helpstratas<-renderUI(HTML(hlp['Stratas']))
  # output$helphide<-renderUI(HTML(hlp['Hide']))
  # output$helpsubset<-renderUI(HTML(hlp['Subset']))
  # output$helpratio<-renderUI(HTML(hlp['OR/HR']))
  # output$helpshow<-renderUI(HTML(hlp['Show']))
  # output$helpformat<-renderUI(HTML(hlp['Format']))
  # output$helpdecimals<-renderUI(HTML(hlp['Decimals']))
  # output$helplabel<-renderUI(HTML(hlp['Label']))
  # output$helpsave<-renderUI(HTML(hlp['SAVE']))

  # output$helpabout<-renderUI(HTML(hlp['HELPCG']))
  # output$helpwui<-renderUI(HTML(hlp['HELPWUI']))
  # output$helpsecurity<-renderUI(HTML(hlp['DATASECURITY']))
  # output$helpsummary<-renderUI(HTML(hlp['SUMMARY']))
  # output$helpvalues<-renderUI(HTML(hlp['VALUES']))
  # output$helptable<-renderUI(HTML(hlp['TABLE']))
  # output$helpplot<-renderUI(HTML(hlp['PLOT']))
  # output$helpsnps<-renderUI(HTML(hlp['SNPs']))


  ####################################
  ##### DOWNLOAD RESULTS #############
  ####################################

  ####### table #########
  output$actiondownloadtable <- downloadHandler(
    filename = function(){
      extension <- ifelse(input$downloadtabletype=="Word","docx",tolower(input$downloadtabletype))
      extension <- ifelse(input$downloadtabletype=="Excel","xlsx",extension)
      paste("tableOuput",extension,sep=".")
    },
    content = function(ff) {
      input$changeLabels
      isolate({
        header.labels<-c("all"=input$alllabel,"p.overall"=input$poveralllabel,"p.trend"=input$ptrendlabel,"p.ratio"=input$pratiolabel,"N"=input$Nlabel)
        captionlabel<-input$captionlabel
        if (!is.null(captionlabel) && captionlabel=='NULL')
          captionlabel<-NULL
      })
      withProgress(message = 'Downloading descriptive table', value = 0, {
        restab<-create()
        if (is.null(restab)) return(invisible(NULL))
        if (input$downloadtabletype=='CSV'){
          if (inherits(restab,"cbind.createTable")) return(NULL)
          export2csv(restab,file=ff,sep=input$sepcsv,header.labels=header.labels)
        }
        if (input$downloadtabletype=='PDF'){
          sizepdf <- switch(input$sizepdf,
                            "tiny" = 6,
                            "scriptsize" = 8,
                            "footnotesize" = 10,
                            "small" = 10.95,
                            "normalsize" = 12,
                            "large" = 14.4,
                            "Large" = 17.28,
                            "LARGE" = 20.74,
                            "huge" = 24.88,
                            "Huge" = 24.88)
          export2pdf(restab,file=ff, size=sizepdf, landscape=input$landscape, header.labels=header.labels, caption=captionlabel,
                     width=paste0(input$htmlwidthrestab,'cm'), strip=input$strip, first.strip=TRUE, background=input$strip.color)
                     # ,
                     # header.color=input$header.color,header.background=input$header.background)
        }
        if (input$downloadtabletype=='HTML'){
          ans <- export2md(restab,format='html',header.labels=header.labels,caption=captionlabel,
                      width=paste0(input$htmlwidthrestab,'cm'),header.color=input$header.color,header.background=input$header.background,
                      size=input$htmlsizerestab,background=input$strip.color,strip=input$strip,first.strip=TRUE)
          write(ans, file=ff)
        }
        if (input$downloadtabletype=='TXT'){
          sink(ff)
          print(restab,header.labels=header.labels)
          sink()
        }
        if (input$downloadtabletype=='Word'){
          export2word(restab, file=ff, header.labels=header.labels,caption=captionlabel,
                      header.color=input$header.color,header.background=input$header.background,
                      size=input$htmlsizerestab,background=input$strip.color,strip=input$strip,first.strip=TRUE)
        }
        if (input$downloadtabletype=='Excel'){
          if (inherits(restab,"cbind.createTable")) return(NULL)
          export2xls(restab, file=ff,header.labels=header.labels)
        }
        incProgress(1, detail = "")
      })
    }
  )

  observe({
    if (is.null(input$downloadtabletype)) return(NULL)
    rv$changestratacount
    isolate({
      if (!is.null(input$stratatype) && input$stratatype!='None' && input$downloadtabletype%in%c('Excel','CSV')){
        createAlert(session, "downloadtablealert", "downloadtablealertMessage", title = "Warning:",
            content = "Stratified tables cannot be downloaded under the specified format", append = FALSE, style = "warning")
        shinyjs::disable("actiondownloadtable")
      } else {
        closeAlert(session, "downloadtablealertMessage")
        shinyjs::enable("actiondownloadtable")
      }
    })
  })


  ####### SNPs table #########
  output$actiondownloadSNPtable <- downloadHandler(
    filename = function() "tableSNPOuput.txt",
    content = function(ff) {
      restabSNPs<-createSNPs()
      if (is.null(restabSNPs))
        return(invisible(NULL))
      sink(ff)
      print(restabSNPs)
      sink()
    }
  )

  output$actiondownloadplot <- downloadHandler(
    filename = function() paste("figure",tolower(input$downloadplottype),sep="."),
    content = function(ff) {
      ext<-input$downloadplottype
      dd <- rv$dataset
      validate(need(dd, "Data not loaded yet"))
      validate(need(input$plotselevars, "Select one variable"))
      perc<-if (is.null(input$perc)) FALSE else input$perc
      withProgress(message = 'Making plot', value = 0, {
        if (is.null(input$plotresptype) || input$plotresptype=='None')
          form <- paste0("~",input$plotselevars)
        if (!is.null(input$plotresptype) && input$plotresptype=='Group')
          form <- paste0(input$plotgvar,"~",input$plotselevars)
        if (!is.null(input$plotresptype) && input$plotresptype=='Survival'){
          times<-dd[,input$plotvarseletime]
          validate(need(length(input$plotstatuscat)>=1, "you must select at least one category"))
          cens <- as.integer(dd[,input$plotvarselestatus]%in%input$plotstatuscat)
          dd$"respsurv"<-Surv(times,cens)
          form <- paste0("respsurv ~ ",input$plotselevars)
        }
        cg <- compareGroups(form, dd)
        plot(cg,type=ext,file="./www/figure_",bivar=TRUE,perc=perc)
        file.rename(paste0("./www/figure_",input$plotselevars,".",ext),ff)
        incProgress(1,detail="")
      })
    }
  )
}


# setwd(wd)


####### TO DO ##########

# Refresh app when changing dataset !!!! (gvar....)
