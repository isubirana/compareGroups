shinyServer(function(input, output, session) {
  
  
  write(paste0("enter: ",as.character(Sys.time()),"\n"), file="log", append=TRUE)
  on.exit(write(paste0("exit: ",as.character(Sys.time()),"\n\n"), file="log", append=TRUE)) 

  output$loadpanel<-renderUI({
    if (is.null(input$files)) return(invisible(NULL))
    return(
      div(
        selectInput("datatype", "Data format", c('SPSS'='*.sav', 'TEXT'='*.txt','EXCEL'='*.xls','R'='*.rda'),'*.sav'),                  
        bsButton("encodingaction", "Encoding", size="extra-small", style="info"),
        radioButtons("encoding", "", c('default'='default','latin1'='latin1','utf8'='utf8'),'default',inline=TRUE),
        uiOutput("loadoptions")
      )
    )
  })
  
  output$loadokui<-renderUI({
    if (input$exampledata != 'Own data' || (input$exampledata == 'Own data' && !is.null(input$files))){
      return(
        div(
          br(),
          actionButton("loadok","Read data")          
        )
      )
    } else {
      return(invisible(NULL))
    }
  })
  
  
  
  ## input and output panels width
  
  output$panelwidthout <- renderUI({
    if (is.null(input$panelwidth)) return(invisible(NULL))
    x<-4*3*input$panelwidth/300
    y<-100*(12-4*3*input$panelwidth/100)/8
    div(
      HTML(paste("<style type=\"text/css\"> #inputpanel{width:",input$panelwidth*3,"%} </style>",sep="")),
      HTML(paste("<style type=\"text/css\"> #outpanel {width:",y,"%; float:right} </style>",sep=""))
    )
  })

  
  ## init some input values when pressing loadok button

  
  ## reactive Values
  
  rv<-reactiveValues()
  
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
  observeEvent(input$loadok,{
    if (!is.null(dataset())) rv$initial<<-TRUE
  })

  
  observeEvent(input$changeselevars,{
    if (length(input$discvars)>0){
      rv$selevars<-c(rv$selevars,input$discvars) 
      rv$discvars<-rv$discvars[-which(rv$discvars%in%input$discvars)]       
    }
    if (length(input$selevars)>0){
      rv$discvars<-c(rv$discvars,input$selevars)           
      rv$selevars<-rv$selevars[-which(rv$selevars%in%input$selevars)]
    }
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
    if (!is.null(rv$varsubset)){
      if (!is.null(input$varselevarsubsetALL) && input$varselevarsubsetALL)
        rv$varsubset[1:length(rv$varsubset)]<-input$varsubset 
      else
        if (length(input$varselevarsubset)>0)
          rv$varsubset[input$varselevarsubset]<-input$varsubset
      rv$varsubset<-ifelse(rv$varsubset=='',NA,rv$varsubset)
    }
  })  
  
  ## help modal
  rv$count <- 1
  observeEvent(input$dec,{
    rv$count<-rv$count-1
  })
  observeEvent(input$inc,{
    rv$count<-rv$count+1
  })
  observe({
    updateButton(session,"dec",disabled=rv$count<=1)
    updateButton(session,"inc",disabled=rv$count>=7)
  })
  output$helpModalContents <- renderUI({
    if (rv$count==1) return(div(h4("Descriptive table directly from R-console"),wellPanel(img(src='./examples/example1.png', align = "centre", width="100%"))))
    if (rv$count==2) return(div(h4("Export tables to LaTeX file"),wellPanel(img(src='./examples/example2.png', align = "centre", width="100%"))))
    if (rv$count==3) return(div(h4("Save tables on Word documents"),wellPanel(img(src='./examples/example3.png', align = "centre", width="100%"))))
    if (rv$count==4) return(div(h4("Store the descriptives table on Excel spread sheets"),wellPanel(img(src='./examples/example4.png', align = "centre", width="100%"))))
    if (rv$count==5) return(div(h4("Normality plots"),wellPanel(img(src='./examples/example5.png', align = "centre", width="90%"))))
    if (rv$count==6) return(div(h4("Bivariate plots"),wellPanel(img(src='./examples/example6.png', align = "centre", width="90%"))))
    if (rv$count==7) return(div(h4("Analyses of SNPs"),wellPanel(img(src='./examples/example7.png', align = "centre", width="80%"))))    
  })

  ## toggles
    # table
  observe({
   if (!is.null(input$tableoptionsaction))
     updateButton(session, "tableoptionsaction", label = if(input$tableoptionsaction%%2==1) "View options (Hide)" else "View options (Show)")
  })
   # info
  observe({
   if (!is.null(input$infooptionsaction))
    updateButton(session, "infooptionsaction", label = if(input$infooptionsaction%%2==1) "View options (Hide)" else "View options (Show)")
  })  
  # values summary
  observe({
   if (!is.null(input$valuessumoptionsaction))     
    updateButton(session, "valuessumoptionsaction", label = if(input$valuessumoptionsaction%%2==1) "View options (Hide)" else "View options (Show)")
  })   
   # values extended
  observe({
   if (!is.null(input$valuextoptionsaction))         
    updateButton(session, "valuextoptionsaction", label = if(input$valuextoptionsaction%%2==1) "View options (Hide)" else "View options (Show)")
  }) 
   # varPlot
  observe({
    if (!is.null(input$varPlotoptionsaction))
    updateButton(session, "varPlotoptionsaction", label = if(input$varPlotoptionsaction%%2==1) "View options (Hide)" else "View options (Show)")
  })
   # SNPs
  observe({
   if (!is.null(input$SNPsoptionsaction))       
    updateButton(session, "SNPsoptionsaction", label = if(input$SNPsoptionsaction%%2==1) "View options (Hide)" else "View options (Show)")
  })     
  # encoding
  observeEvent(input$encodingaction,{
   toggle("encoding", TRUE, "fade")
  })
  # open select variables panel when data is loaded
  observe({
    if (!is.null(rv$initial) && rv$initial && !is.null(input$loadok) && input$loadok){
      updateCollapse(session, id="collapseInput", open = "collapseSelect", close = "collapseLoad")
    }
  })  
  # move to TABLE tab once data is loaded
  observe(
    if (!is.null(rv$initial) && rv$initial){
      updateNavbarPage(session, inputId="results", selected = "resultsTable")
    }
  )
  # iniciate the table
  observeEvent(input$collapseInput,{
    if (rv$changeselevarsokcount==0)
      shinyjs::click("changeselevarsok")
  })

  output$tableoptionsout <- renderUI({
    if (!rv$initial) return(invisible(NULL))
    return(div(
      fluidRow(
        column(8,
          dropdownButton(inputId = "tableoptionsaction", circle=FALSE, status="info", label="View (show)",
            div(id="tableoptions",               
              fluidRow(
                column(4,sliderInput("htmlsizerestab", "Resize:", min=7, max=30, value=16, step=1)),
                column(4,sliderInput("htmlwidthrestab", "Variable column width (cm):", min=2, max=20, value=8, step=0.5)),
                column(4, 
                  radioButtons("position", "Table position", c("left","center","right"), inline=TRUE),
                  checkboxInput("strip", "Strip variables", FALSE)
                )
              ),
              fluidRow(
                column(4,
                  colorSelectorInput("header.background","Header background colour:",choices=choices_brewer,selected="#F7FBFF",display_label=TRUE)
                ),
                column(4,
                  colorSelectorInput("header.color","Header colour:",choices=choices_brewer,selected="#000000",display_label=TRUE)
                ),
                column(4,
                  conditionalPanel("input.strip",
                    colorSelectorInput("strip.color","Strip colour:",choices=choices_brewer,selected="#F0F0F0",display_label=TRUE)
                  )
                )
              )
            )
          )
        ),
        column(3,
          bsButton("tableinfo","Display info Table"),
          bsModal("tableinfoModal",title="Info table",trigger="tableinfo",size="large",
            htmlOutput("sumtab")
          )
        )
      )
    ))
  })  
  
  
  ###############
  ## read data ##
  ###############
  dataset<-reactive({
    input$loadok
    isolate({
    # remove all elements 
    rm(list=ls(),envir=.cGroupsWUIEnv)  
    progress <- shiny::Progress$new(session, min=1, max=3)
    progress$set(message = "Reading data",value=1)
    on.exit(progress$close())    
    rv$selevars<<-rv$discvars<<-rv$method<<-rv$descdigits<<-rv$ratiodigits<<-rv$refratiocat<<-rv$factratio<<-rv$xhide<<-rv$varsubset<<-NULL
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
        data(SNPs,package="SNPassoc")
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
          dataset<- try(read.table(inFile$datapath,header=input$header,sep=sepchar,quote=quote,dec=input$dechar,na.strings=input$missvalue),silent=TRUE)
        else
          dataset<- try(read.table(inFile$datapath,header=input$header,sep=sepchar,quote=quote,dec=input$dechar,na.strings=input$missvalue,encoding=input$encoding),silent=TRUE)        
        if (inherits(dataset,"try-error")){
          cat("Error in reading data\n")
          return(invisible(NULL))      
        }
        if (!is.data.frame(dataset)){
          cat("Data is not a data frame\n")
          return(invisible(NULL))      
        }          
      }
      # read SPSS
      if (input$datatype=='*.sav'){
        # if (input$encoding=='default')
        #   dataset<-try(read.spss(inFile$datapath,to.data.frame=TRUE),silent=TRUE)
        # else
        #   dataset<-try(read.spss(inFile$datapath,to.data.frame=TRUE,reencode=input$encoding),silent=TRUE)
        dataset <- try(read_sav(inFile$datapath), silent=TRUE)
        # fix date vars
        # vardict <- spss_varlist(inFile$datapath)[,'printfmt']
        # datevars<-grep("^DATE",vardict)
        # if (length(datevars)){
        #   for (ii in datevars) dataset[,ii]<-importConvertDateTime(dataset[,ii],"date", "spss")
        # }
        if (inherits(dataset,"try-error")){
          cat("Error in reading data\n")
          return(invisible(NULL))      
        }
        if (!inherits(dataset, "data.frame")){
          cat("Data is not a data frame\n")
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
          cat("Error in reading data\n")
          return(invisible(NULL))      
        }
        dataset <- get(datasetname)
        if (!is.data.frame(dataset)){
          cat("Data is not a data frame\n")
          return(invisible(NULL))      
        }      
      }
      # read EXCEL
      if (input$datatype=='*.xls'){
        if (is.null(input$tablenames))
          return(invisible(NULL)) 
        # dataset<-try(xlsx::read.xlsx(inFile$datapath,sheetName=input$tablenames),silent=TRUE)
        dataset<-try(readxl::read_excel(path=inFile$datapath, sheet=input$tablenames), silent=TRUE)
        if (inherits(dataset,"try-error"))
          return(invisible(NULL))
        dataset <- as.data.frame(dataset) # to remove tibble class.
      }
    }
    if (!inherits(dataset, "data.frame") || nrow(dataset)==0)
      return(invisible(NULL))
    # iniciate selevars and discvars
    if (is.null(rv$selevars))
      rv$selevars<<-names(dataset)
    if (is.null(rv$discvars))
      rv$discvars<<-character()
    # iniciate method
    if (is.null(rv$method)){
      res<-compareGroups(~.,dataset,max.xlev=Inf,max.ylev=Inf,method=NA)
      method<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
      method<-ifelse(method=="continuous normal",1,
                   ifelse(method=="continuous non-normal",2,3))
      names(method)<-attr(res,"varnames.orig")
      rv$method<<-method
    }
    # iniciate descdigits
    if (is.null(rv$descdigits)){
      res<-compareGroups(~.,dataset,max.xlev=Inf,max.ylev=Inf,method=NA)
      descdigits<-rep(NA,length(res))
      names(descdigits)<-attr(res,"varnames.orig")
      rv$descdigits<<-descdigits
    }
    # iniciate ratiodigits
    if (is.null(rv$ratiodigits)){
      res<-compareGroups(~.,dataset,max.xlev=Inf,max.ylev=Inf,method=NA)
      ratiodigits<-rep(NA,length(res))
      names(ratiodigits)<-attr(res,"varnames.orig")
      rv$ratiodigits<<-ratiodigits
    }    
    # iniciate reference category for OR/HR of categorical row-variables
    if (is.null(rv$refratiocat)){    
      res<-compareGroups(~.,dataset,max.xlev=Inf,max.ylev=Inf,method=NA)
      refratiocat<-rep(1,length(res))
      names(refratiocat)<-attr(res,"varnames.orig")
      rv$refratiocat<<-refratiocat
    }
    # iniciate factor to be multiplied for continuous variables in computing OR/HR
    if (is.null(rv$factratio)){        
      res<-compareGroups(~.,dataset,max.xlev=Inf,max.ylev=Inf,method=NA)
      factratio<-rep(1,length(res))
      names(factratio)<-attr(res,"varnames.orig")
      rv$factratio<<-factratio
    }
    # iniciate hide
    if (is.null(rv$xhide)){ 
      nn<-names(dataset)
      xhide<-rep(NA,length(nn))
      names(xhide)<-nn
      rv$xhide<<-xhide
    }  
    # iniciate variable subset
    if (is.null(rv$varsubset)){
      nn<-names(dataset)
      varsubset<-rep(NA,length(nn))
      names(varsubset)<-nn
      rv$varsubset<<-varsubset
    }
    # return data
    return(dataset)
    })
  })
  
  
  ###############################
  #### check if data is read ####
  ###############################

  
  #output$initial <- renderUI({
  #  if (is.null(dataset()))
  #    initial <- FALSE
  #  else
  #    initial <- TRUE
  #  checkboxInput("initial","",initial)
  #})  
  
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
        return(selectInput("tablenames", "Choose the table to read:", choices = tablenames, selectize=FALSE))
      } else {
        # TXT
        if (input$datatype=='*.txt'){
          return(
            wellPanel(
              HTML('<p style="font-style:Bold; font-size:18px">TEXT Options</p>'),
              checkboxInput('header', 'Has column headers', TRUE),
              textInput("missvalue", HTML("Missing Data String (e.g. <i>NA</i>)"), ""),
              selectInput('sep', 'Column Separator', c(Comma=',', Semicolon=';', Tab='\t', Other='o'), ','),
              conditionalPanel(
                condition = "input.sep == 'o'",
                textInput("sepother", "Specify separator character","")
              ),
              selectInput('dechar', 'Decimal point character', c('Comma'=',', 'Dot'='.'), '.'),  
              selectInput('quote', 'Values in Quotes?', c("None"=1, "Double"=2, "Single"=3), 2)
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
    rv$changeselevarsokcount
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
    
    
    progress <- shiny::Progress$new(session, min=0, max=4)
    progress$set(message = "Creating bivariate table",value=1)
    on.exit(progress$close())


    isolate({
      
      dd<-dataset()
      validate(need(dd, "Data not loaded"))      
      
      validate(need(!is.null(rv$selevars) && length(rv$selevars)>0,"No variables selected"))      

      # global subset
      if (!is.null(input$globalsubset) && input$globalsubset!=""){
        dd2<-dd
        vari.labels <- sapply(dd2, attr, which="label", exact=TRUE)
        for (i in 1:ncol(dd2))
          if (is.factor(dd2[,i]))
            dd2[,i]<-as.integer(dd2[,i])
        dd2<-try(eval(parse(text=paste("subset(dd2,",input$globalsubset,")",sep=""))),silent=TRUE)
        if (inherits(dd2,"try-error")) print(dd2)
        validate(need(dd2, "subset not correct"))
        validate(need(nrow(dd2)>0, "no data selected"))
        dd<-dd[rownames(dd2),]
        for (i in 1:ncol(dd))
          attr(dd[,i],"label") <- vari.labels[i]
      }

      # form
      if (is.null(input$resptype) || input$resptype=='None'){
        form<-as.formula(paste("~",paste(paste0("`",rv$selevars,"`"),collapse="+"),sep=""))
      } else {
        if (input$resptype=='Survival'){
          statusval<-as.numeric(strsplit(input$statuscat,":")[[1]][1])
          cens<-as.integer(dd[,input$varselestatus])==statusval 
          times<-dd[,input$varseletime]
          dd$"respsurv"<-Surv(times,cens)
          attr(dd$"respsurv","label")<-paste("[ ",input$varseletime,"; ",input$varselestatus,"=", levels(as.factor(dd[,input$varselestatus]))[statusval],"]")
          form<-as.formula(paste("respsurv~",paste(paste0("`",rv$selevars,"`"),collapse="+"),sep=""))  
        } else {
          form<-as.formula(paste(input$gvar,"~",paste(paste0("`",rv$selevars,"`"),collapse="+"),sep=""))
        }
      }
      computeratio<-if (is.null(input$computeratio) || input$resptype=='Survival') TRUE else input$computeratio 
      pvaldigits<-if (is.null(input$pvaldigits)) 3 else input$pvaldigits
      
      # variables subset
      if (!is.null(rv$varsubset) && any(!is.na(rv$varsubset))){
        dd2<-dd
        for (i in 1:ncol(dd2))
          if (is.factor(dd2[,i]))
            dd2[,i]<-as.integer(dd2[,i])
        for (i in seq_along(rv$varsubset)){
          if (!is.na(rv$varsubset[i])){
            if (is.factor(dd2[,names(rv$varsubset)[i]]))
              dd2[,i]<-as.integer(dd2[,names(rv$varsubset)[i]])
            kk<-!eval(parse(text=paste("with(dd2,",rv$varsubset[i],")",sep="")))
            dd[kk,names(rv$varsubset)[i]]<-NA
          }
        }
      }
      
      # hide.no
      if (length(input$hideno)==0 || input$hideno=='')
        hideno<-NA
      else
        hideno<-unlist(strsplit(input$hideno,","))
    
      # ref
      refno<-hideno
      refy<-if (is.null(input$gvarcat)) 1 else as.numeric(strsplit(input$gvarcat,":")[[1]][1])
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

      # compareGroups
      res<-compareGroups(form,dd,max.xlev=Inf,max.ylev=Inf,method=method,include.miss=includemiss,ref.no="no",
                         ref=refratiocat,Q1=Q1/100,Q3=Q3/100,simplify=simplify,compute.ratio=computeratio,
                         fact.ratio=factratio,ref.y=refy,min.dis=mindis,alpha=alpha,p.corrected=pcorrected,
                         Date.format=Dateformat,byrow=byrow)    

      # createTable
      restab<-createTable(res,show.p.overall=showpoverall,show.p.trend=showptrend,show.ratio=showratio,
                          show.p.ratio=showpratio,show.all=showall,show.n=shown,show.desc=showdesc,
                          hide.no=hideno,hide=xhide,type=type,sd.type=sdtype,q.type=c(qtype1,qtype2),
                          digits=descdigits,digits.ratio=ratiodigits,digits.p=pvaldigits,show.p.mul=showpmul)      
      
    
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
    # if (rv$changeglobalsubsetcount==0) return(NULL)
    # if (rv$changeselevarsokcount==0) return(NULL)
    # if (rv$changerespcount==0) return(NULL)
    # print("create SNPs")
    # input$changeselevarsok
    create()
    isolate({
      dd<-dataset()
      if (is.null(dd)){
        cat("\n\nData not loaded\n")
        return(invisible(NULL))
      }      
      if (is.null(rv$selevars) || length(rv$selevars)==0){
        cat("No variables selected\n")
        return(invisible(NULL)) 
      }       
      dd2<-dd
      for (i in 1:ncol(dd2))
        if (is.factor(dd2[,i]))
          dd2[,i]<-as.integer(dd2[,i])
      if (!is.null(input$globalsubset))
        dd2<-try(eval(parse(text=paste("subset(dd2,",input$globalsubset,")",sep=""))),silent=TRUE)
      if (inherits(dd2,"try-error")){
        cat("Subset not correct\n")
        return(invisible(NULL))      
      }  
      if (nrow(dd2)==0){
        cat("No individuals selected\n")
        return(invisible(NULL))      
      }
      dd<-dd[rownames(dd2),]
      if (is.null(input$resptype) || input$resptype=='None')
        form<-as.formula(paste("~",paste(paste0("`",rv$selevars,"`"),collapse="+"),sep=""))
      else {
        if (input$resptype=='Survival'){
          return(invisible(NULL))
        } else
        form<-as.formula(paste(input$gvar,"~",paste(paste0("`",rv$selevars,"`"),collapse="+"),sep=""))
      }      
    })    
    restabSNPs<-compareSNPs(form, dd, sep = input$sepSNPs) 
    return(restabSNPs)  
  })   
  
  ####################
  ### values table ###
  ####################
  
  ## values summary
  output$valuestable <- renderText({
    dd<-dataset()
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
    dd <- dataset()
    validate(need(dd, "Data not loaded"))
    ans <- datatable(dd,
                     escape=FALSE,
                     filter = "top",
                     rownames= FALSE,
                     extensions = list("ColReorder" = NULL,
                                        "Buttons" = NULL,
                                        "FixedColumns" = list(leftColumns=1)),
                    options = list(
                        dom = 'BRrltpi',
                        autoWidth=TRUE,
                        lengthMenu = list(c(10, 50, -1), c('10', '50', 'All')),
                        ColReorder = TRUE,
                        buttons =
                          list(
                            'copy',
                            'print',
                            list(
                              extend = 'collection',
                              buttons = c('csv', 'excel', 'pdf'),
                              text = 'Download'
                            ),
                            I('colvis')
                          )
                    ))
    formatStyle(ans,columns=0:ncol(dd),`font-size`=paste0(input$valueextsize,"%"))
  })

  output$valuextoptionsout <- renderUI({
    if (!rv$initial) return(invisible(NULL))
    return(div(
      dropdownButton(inputId="valuextoptionsaction", circle=FALSE, status="info", label="View", 
        div(id="valuextoptions",
          sliderInput("valueextsize", "Resize (%):", min=10, max=300, value=100, step=10)
        )
      )
    ))
  })
  
  
  output$responseout <- renderUI({
    if (!rv$initial) return(invisible(NULL))
    return(div(
      tabsetPanel(id="ResponseTabsetPanel",
        ## response
        tabPanel("Response",
                 radioButtons("resptype", "", c("None","Group","Survival"),"None"),                 
                 uiOutput("response"),
                 actionButton("changeresp","Update")
        ),  
        ## strata
        tabPanel("Strata",
                 radioButtons("stratatype", "", c("None","Strata"),"None"),                 
                 uiOutput("strata"),
                 actionButton("changestrata","Update")
        )
      )
    ))
  })
  
  
  
  output$settingsout <- renderUI({
    if (!rv$initial) return(invisible(NULL))
    return(div(
      tabsetPanel(
        ## methods
        tabPanel("Type",
                 uiOutput("selemethod"),
                 uiOutput("selemethodNA")
        ),       
        ## hide
        tabPanel("Hide",
                 br(),
                 wellPanel(
                   fluidRow(
                     column(6,uiOutput("selehidevar")),
                     column(6,uiOutput("selehidecat"))
                   )
                 ),
                 textInput('hideno', "Hide 'no' category", ''),
                 actionButton("changehide","Update")
        ),
        ## subset
        tabPanel("Subset", uiOutput("selevarsubset")),
        ## OR/HR ratio for row-variables
        tabPanel("OR/HR", uiOutput("ratio"))
      )
    ))
  })
  
  
  output$displayout <- renderUI({
    if (!rv$initial) return(invisible(NULL))
    return(div(
      tabsetPanel(
        ## show
        tabPanel("Show",uiOutput("show")),
        ## Format display
        tabPanel("Format", uiOutput("format")),
        ## number of decimals
        tabPanel("Decimals", uiOutput("decimals")),
        ## header labels
        tabPanel("Labels", uiOutput("labels"))
      )
    ))
  })
  
  
  output$saveout <- renderUI({
    if (!rv$initial) return(invisible(NULL))
    return(div(
      selectInput("downloadtabletype", "Select format", choices = c("PDF","CSV","HTML","TXT","Word","Excel"),selectize=FALSE),
      conditionalPanel(
        condition="input.downloadtabletype == 'PDF'",
        wellPanel(
          selectInput('sizepdf', 'Resize', c("tiny","scriptsize","footnotesize","small","normalsize","large","Large","LARGE","huge","Huge"),"normalsize", selectize=FALSE),
          h4(""),
          checkboxInput('landscape', 'Landscape', FALSE)
        )
      ),
      conditionalPanel(        
        condition="input.downloadtabletype == 'CSV'",
        wellPanel(
          radioButtons('sepcsv', 'Separator', c(Comma=',', Semicolon=';', Tab='\t'), ',')
        )
      ),
      downloadButton('actiondownloadtable', 'Download'),
      bsAlert("downloadtablealert")
    ))
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
    ans <- export2md(restab,header.labels=header.labels,caption=captionlabel,
                     width=paste0(input$htmlwidthrestab,"cm"),header.color=input$header.color,header.background=input$header.background,
                     size=input$htmlsizerestab,background=input$strip.color,strip=input$strip,first.strip=TRUE,position=position)      
  })
  
  
  ############################
  ##### print compareSNPs ####
  ############################
  
  output$restabSNPs <- renderPrint({
    restabSNPs<-createSNPs()
    if (is.null(restabSNPs))
      return(invisible(NULL))
    return(restabSNPs)
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
    export2md(restab,which.table="avail",width=paste0(input$htmlwidthrestab,"cm"),header.color=input$header.color,
              header.background=input$header.background,size=input$htmlsizerestab)
  })
  
  
  
  ##########################################
  ##### select variables to be analyzed ####
  ##########################################
  
  output$selevarslist<-renderUI({
    if (is.null(rv$initial) || !rv$initial)
      return(invisible(NULL))
    dd<-dataset()
    if (is.null(dd)){
      cat("\n\nData not loaded\n")
      return(invisible(NULL))
    }
    nn<-names(dd)
    div(
      fluidRow(
        column(4,selectInput("selevars",HTML('<div title="Choose the variables you want to analyze">Selected</div>'),rv$selevars,multiple=TRUE,selectize=FALSE),tags$style(type='text/css', paste("#selevars { height: ",ifelse(length(rv$selevars)==0,20,ifelse(length(rv$selevars)>20,300,20*length(rv$selevars)+15)),"px;}",sep=""))),
        column(2,br(),br(),br(),bsButton("changeselevars","<>",size="extra-small"),offset=1),
        column(4,selectInput("discvars",HTML('<div title="Choose the variables you DO NOT want to analyze">Discarted</div>'), rv$discvars, multiple=TRUE,selectize=FALSE),tags$style(type='text/css', paste("#discvars { height: ",ifelse(length(rv$discvars)==0,20,ifelse(length(rv$discvars)>20,300,20*length(rv$discvars)+15)),"px;}",sep=""))),offset=1      
      ),
      bsButton("changeselevarsok","Update")
    )
  })
  
  ################################
  ##### select strata variable ###
  ################################
  
  # select strata variable
  output$varstrata <- renderUI({
    dd<-dataset()
    if (is.null(dd)){
      cat("\n\nData not loaded\n")
      return(invisible(NULL))
    }  
    input$changemethod
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal",1,
                        ifelse(method.temp=="continuous non-normal",2,3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp==3]
    vlist<-vlist[sapply(dd[vlist],function(x) nlevels(as.factor(x))<=input$maxstrata)]
    vlist<-vlist
    if (length(vlist)==0){
      return(invisible(NULL))
    }
    names(vlist)<-vlist
    selectInput("svar", "Choose the strata variable:", choices = vlist, selectize=FALSE)    
  })  
  
  
  ################################
  ##### select group variable ####
  ################################
  
  # select variable
  output$vargroup <- renderUI({
    dd<-dataset()
    if (is.null(dd)){
      return(invisible(NULL))
    }  
    input$changemethod
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal",1,
                        ifelse(method.temp=="continuous non-normal",2,3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp==3]
    vlist<-vlist[sapply(dd[vlist],function(x) nlevels(as.factor(x))<=input$maxgroups)]
    vlist<-vlist
    if (length(vlist)==0){
      return(invisible(NULL))
    }
    names(vlist)<-vlist
    selectInput("gvar", "Choose the grouping variable:", choices = vlist, selectize=FALSE)    
  })
  
  # select category for OR reference (only when two categories).
  output$vargroupcat <- renderUI({
    dd<-dataset()
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
  
  ########################
  ##### select method ####
  ########################
  
  output$selemethod <- renderUI({
    if (is.null(rv$initial) || !rv$initial){
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    input$changeselevars
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(NULL)
    div(
      fluidRow(
        column(6,
          selectInput("varselemethod", "", choices = rv$selevars, multiple = TRUE, selected = isolate({ input$varselemethod}),selectize=FALSE),
          tags$style(type='text/css', paste("#varselemethod { height: ",ifelse(length(rv$selevars)==0,20,ifelse(length(rv$selevars)>20,300,18*length(rv$selevars)+5)),"px; width:120px}",sep=""))
        ),
        column(6,
          checkboxInput('varselemethodALL', 'ALL', isolate({input$varselemethodALL})),
          selectInput("method", "", c("Normal","Non-normal","Categorical","NA"),isolate({input$method}),selectize=FALSE),   
          actionButton("changemethod","Update")
        )
      )
    )
  })
  
  observeEvent(input$varselemethodALL,{
    if (input$varselemethodALL){
      updateSelectInput(session, "varselemethod", selected=rv$selevars)  
    } else {
      updateSelectInput(session, "varselemethod", selected=".xxx")
    }
  })
  
  
  
  output$selemethodNA <- renderUI({
    if (is.null(rv$initial) || !rv$initial)
      return(invisible(NULL))
    if (is.null(input$method) || input$method!='NA')    
      return(NULL)
    div(
      numericInput("alpha","alpha",value=0.05,min=0,max=1,step=0.005),
      numericInput("mindis","min categories",value=5,min=1,max=10)
    )
  })  
  
  ###################################
  ##### select response #############
  ###################################
  
  output$response <- renderUI({
    if (is.null(rv$initial) || !rv$initial){
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    if (!is.null(input$resptype) && input$resptype == 'Group'){
      div(
        numericInput('maxgroups',"Maximum number of groups:",value=5,min=2,max=10),
        uiOutput("vargroup"),
        checkboxInput('computeratio', 'Compute OR:', FALSE)
      )    
    } else {
      if (!is.null(input$resptype) && input$resptype=='Survival'){
        div(
          uiOutput("timevar"),
          uiOutput("censvar"),
          uiOutput("censcat")
        )
      } else {
        return(invisible(NULL))
      } 
    }
  })
  
  #################################
  ##### select strata #############
  #################################
  
  output$strata <- renderUI({
    if (is.null(rv$initial) || !rv$initial){
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    if (!is.null(input$stratatype) && input$stratatype == 'Strata'){
      div(
        numericInput('maxstrata',"Maximum number of stratas:",value=5,min=2,max=10),
        uiOutput("varstrata")
      )    
    } else {
      return(invisible(NULL))
    }
  })

  ####################################
  ##### select descriptive digits ####
  ####################################
  
  output$seledescdigits <- renderUI({
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(NULL)
    div(
      fluidRow(
        column(4,
          selectInput("varseledescdigits", "variable", choices = rv$selevars, multiple = TRUE, selected = isolate({input$varseledescdigits}),selectize=FALSE),
          checkboxInput('varseledescdigitsALL', 'ALL', isolate({input$varseledescdigitsALL}))
        ),
        column(8,
          numericInput("descdigits", label=HTML('<div>Number of decimals<br>(-1: default)</div>'), value = -1, min=-1, max=10),
          actionButton("changedescdigits","Update")
        )
      )
    )
  })
  
  observeEvent(input$varseledescdigitsALL,{
    if (input$varseledescdigitsALL){
      updateSelectInput(session, "varseledescdigits", selected=rv$selevars) 
    } else {
      updateSelectInput(session, "varseledescdigits", selected=".xxx") 
    }
  })
  
  
  
  
  ##############################
  ##### select ratio digits ####
  ##############################
  
  output$seleratiodigits <- renderUI({
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(NULL)
    div(
      fluidRow(
        column(4,
          selectInput("varseleratiodigits", "variable", choices = rv$selevars, multiple = TRUE, selected = isolate({input$varseleratiodigits}),selectize=FALSE),
          checkboxInput('varseleratiodigitsALL', 'ALL', isolate({input$varseleratiodigitsALL}))
        ),
        column(8,
          numericInput("ratiodigits", label=HTML('<div>Number of decimals<br>(-1: default)</div>'), value = -1, min=-1, max=10),
          actionButton("changeratiodigits","Update")
        )
      )
    )
  })   
  
  observeEvent(input$varseleratiodigitsALL,{
    if (input$varseleratiodigitsALL){
      updateSelectInput(session, "varseleratiodigits", selected=rv$selevars)    
    } else {
      updateSelectInput(session, "varseleratiodigits", selected=".xxx")  
    } 
  })
  
  
  ##########################
  ##### variable subset ####
  ##########################
  
  output$selevarsubset <- renderUI({
    if (is.null(rv$initial) || !rv$initial){
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(NULL)
    div(
      HTML('<div style="height:10px"></div>'),
      bsCollapse(
        bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">Global subset</p>'),style="info",
          textInput('globalsubset', 'Write subset expression', ''),
          actionButton("changeglobalsubset","Apply")
        ),
        bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">Variable subset</p>'),style="info",
          selectInput("varselevarsubset", "variable", choices = rv$selevars, multiple = TRUE, selected = isolate({input$varselevarsubset}),selectize=FALSE),
          checkboxInput('varselevarsubsetALL', 'ALL', isolate({input$varselevarsubsetALL})),
          textInput("varsubset", label="Write subset expression", value = ""),
          actionButton("changevarsubset","Update")
        )
      )
    )
  })  
  
  observeEvent(input$varselevarsubsetALL,{
    if (input$varselevarsubsetALL){
      updateSelectInput(session, "varselevarsubset", selected=rv$selevars)    
    } else {
      updateSelectInput(session, "varselevarsubset", selected=".xxx")  
    } 
  })
  
  
  ###############################################################
  ##### select reference category in OR/HR for row-variables ####
  ###############################################################
  
  ## ratio 
  output$ratio <- renderUI({
    if (is.null(rv$initial) || !rv$initial){ 
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    if (input$resptype!='None'){
      div(
        HTML('<div style="height:10px"></div>'),
        bsCollapse(
          bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">Reference category</p>'), style="info",
            fluidRow(
              column(6,uiOutput("selerefvar")),
              column(6,uiOutput("selerefcat"))
            )
          ),
          bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">Multiplying factor</p>'), style="info",
            uiOutput("selefactratio")
          )
        )
      )
    } else {
      return(HTML('<p style="color:red"><br>No response variable selected</p>'))
    }
  })
  
  ## select variable
  output$selerefvar <- renderUI({
    dd<-dataset()
    if (is.null(dd)){
      cat("Data not loaded\n")
      return(invisible(NULL))
    }  
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(NULL)
    input$changemethod
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal",1,
                        ifelse(method.temp=="continuous non-normal",2,3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp==3]  
    names(vlist)<-vlist
    vlist<-intersect(vlist,rv$selevars)
    if (length(vlist)==0){
      return(invisible(NULL))
    }
    div(
      selectInput("varselerefratio", "variable", choices = vlist, multiple = FALSE, selectize=FALSE)
    )
  })
  
  ## select category
  output$selerefcat <- renderUI({
    dd<-dataset()
    if (is.null(dd)){
      cat("Data not loaded\n")
      return(invisible(NULL))
    }
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(invisible(NULL))  
    if (is.null(input$varselerefratio) || input$varselerefratio=="No categorical variables")
      return(invisible(NULL))
    vv<-as.factor(dd[,input$varselerefratio])
    vlist<-1:nlevels(vv)
    names(vlist)<-paste(vlist,levels(vv),sep=":")  
    div(
      selectInput("refratiocat", "category", vlist, vlist[1],selectize=FALSE),
      actionButton("changeratiocat","Update")
    )
  }) 
  
  #########################################
  ##### select factor to compute OR/HR ####
  #########################################
  
  rv$varselefactratio.choices <- NULL
  
  output$selefactratio <- renderUI({
    dd<-dataset()
    if (is.null(dd)){
      cat("Data not loaded\n")
      return(invisible(NULL))
    }  
    input$changemethod
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(NULL)
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal",1,
                        ifelse(method.temp=="continuous non-normal",2,3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp!=3] 
    names(vlist)<-vlist
    vlist<-intersect(vlist,rv$selevars) 
    if (length(vlist)==0){
      return(invisible(NULL))
    }    
    rv$varselefactratio.choices <- vlist
    div(
      h5("Multiplying factor:"),
      div(class="row-fluid",
          div(class="span5",selectInput("varselefactratio", "variable", choices = vlist, multiple = TRUE, selected = isolate({input$varselefactratio}),selectize=FALSE)),
          div(class="span2 offset5",div(class="span2",checkboxInput('varselefactratioALL', 'ALL', isolate({input$varselefactratioALL}))))
      ),
      numericInput("factratio", label="factor", value = 1, min=1, max=100),
      actionButton("changefactratio","Update")
    )
  })    
  
  observeEvent(input$varselefactratioALL,{
    if (input$varselefactratioALL){
      updateSelectInput(session, "varselefactratio", selected=rv$varselefactratio.choices)  
    } else {
      updateSelectInput(session, "varselefactratio", selected=".xxx")
    }
  })  
  
  
  #################################
  ##### select hide category ######
  #################################
  
  ## select variable
  output$selehidevar <- renderUI({
    if (is.null(rv$initial) || !rv$initial){
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    dd<-dataset()
    if (is.null(dd)){
      cat("\n\nData not loaded\n")
      return(invisible(NULL))
    }  
    input$changemethod
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(NULL)
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal",1,
                        ifelse(method.temp=="continuous non-normal",2,3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp==3]  
    names(vlist)<-vlist 
    vlist<-intersect(vlist,rv$selevars) 
    if (length(vlist)==0){
      return(invisible(NULL))
    }
    selectInput("varselehide", "variable", choices = vlist, multiple = FALSE, selectize=FALSE)
  })
  
  ## select category
  output$selehidecat <- renderUI({
    dd<-dataset()
    if (is.null(dd)){
      cat("\n\nData not loaded\n")
      return(invisible(NULL))
    }
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(invisible(NULL))      
    if (is.null(input$varselehide))
      return(invisible(NULL))             
    vv<-as.factor(dd[,input$varselehide])
    vlist<-c(NA,1:nlevels(vv))
    names(vlist)<-paste(vlist,c("<<None>>",levels(vv)),sep=":")
    div(
      selectInput("hidecat", "category", vlist, "<<None>>", selectize=FALSE)
    )
  }) 
  
  #################################
  ##### select time variable ######
  #################################
  
  output$timevar <- renderUI({
    dd<-dataset()
    if (is.null(dd)){
      cat("\n\nData not loaded\n")
      return(invisible(NULL))
    }  
    input$changemethod
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal",1,
                        ifelse(method.temp=="continuous non-normal",2,3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp!=3] 
    if (length(vlist)==0){
      return(invisible(NULL))
    }
    names(vlist)<-vlist  
    selectInput("varseletime", "Select time-to-event variable", choices = vlist, multiple = FALSE, selectize=FALSE)
  })   
  
  #################################
  ##### select status variable ####
  #################################
  
  output$censvar <- renderUI({
    dd<-dataset()
    if (is.null(dd)){
      cat("\n\nData not loaded\n")
      return(invisible(NULL))
    }  
    input$changemethod
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal",1,
                        ifelse(method.temp=="continuous non-normal",2,3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp==3]  
    if (length(vlist)==0){
      return(invisible(NULL))
    }
    names(vlist)<-vlist  
    selectInput("varselestatus", "Select status variable", choices = vlist, multiple = FALSE, selectize=FALSE)
  })
  
  ######################################
  ##### select death category/ies ######
  ######################################
  
  output$censcat <- renderUI({
    dd<-dataset()
    if (is.null(dd)){
      cat("\n\nData not loaded\n")
      return(invisible(NULL))
    }  
    input$changemethod
    method<-rv$method
    res<-compareGroups(~.,max.xlev=Inf,max.ylev=Inf,dd,method=method,min.dis=if (is.null(input$mindis)) 5 else input$mindis,alpha=if (is.null(input$alpha)) 0.05 else input$alpha)
    method.temp<-sapply(res,function(x) paste(attr(x,"method"),collapse=" "))
    method.temp<-ifelse(method.temp=="continuous normal",1,
                        ifelse(method.temp=="continuous non-normal",2,3))
    names(method.temp)<-attr(res,"varnames.orig")
    vlist<-names(method.temp)
    vlist<-vlist[method.temp==3]  
    if (length(vlist)==0){
      return(invisible(NULL))
    }
    vv<-as.factor(dd[,input$varselestatus])
    vlist<-1:nlevels(vv)
    names(vlist)<-paste(vlist,levels(vv),sep=":")
    selectInput("statuscat", "Select event category", vlist, multiple = FALSE, selectize=FALSE)
  })   
  
  ######################################
  ####### show #########################
  ######################################
  
  output$show <- renderUI({
    if (is.null(rv$initial) || !rv$initial){
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    div(
      fluidRow(
          column(6,checkboxInput('showall', 'ALL', TRUE)),
          column(6,checkboxInput('showpoverall', 'p-overall', TRUE))
      ),
      fluidRow(
          column(6,checkboxInput('showdesc', 'Descriptives', TRUE)),
          column(6,checkboxInput('showptrend', 'p-trend', FALSE))
      ),
     fluidRow(
          column(6,checkboxInput('showratio', 'OR/HR', FALSE)),
          column(6,                    
              conditionalPanel(
                condition = "input.showratio == true",
                checkboxInput('showpratio', 'OR/HR p-value', FALSE)
              )                    
          )                    
      ),
      fluidRow(
          column(6,checkboxInput('shown', 'Available', FALSE)),
          column(6,checkboxInput('includemiss', "NA category", FALSE))
      ),
      fluidRow(
          column(6,checkboxInput('showpmul', 'Pairwise p-value', FALSE)),
          column(6,
              conditionalPanel(
                condition = "input.showpmul == true",
                checkboxInput('pcorrected', 'Correct pairwise p-values', FALSE)
              )
          )
      ),
      fluidRow(
          column(6,checkboxInput('simplify', 'Simplify', FALSE)),
          column(6,"")
      ),
      actionButton("changeshow","Update")
    )                         
  })
  
  # if show.ratio compute OR
  observeEvent(input$showratio,{
    if (input$showratio){
      updateCheckboxInput(session, "computeratio", value=TRUE)
    }
  })
  
  ##################################
  ######### format #################
  ##################################
  
  output$format <- renderUI({
    if (is.null(rv$initial) || !rv$initial){
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    div(
      HTML('<div style="height:10px"></div>'),
      bsCollapse(
        bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">Frequencies</p>'), style="info",
          radioButtons("type", "", c("%" = 1, "n (%)" = 2, "n"=3), selected="n (%)",inline = TRUE),
          radioButtons("byrow", "Percentages by:", choices=c("columns","rows","total"), inline = TRUE)
        ),
        bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">Mean, standard deviation</p>'), style="info",
          radioButtons("sdtype", "", c("Mean (SD)"=1,"Mean+-SD"=2), selected="Mean (SD)",inline = TRUE)
        ),
        bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">Median [a, b]</p>'), style="info",
          fluidRow(
            column(6,numericInput("Q1", label="[a, ]:", value = 25, min=0, max=49)),
            column(6,numericInput("Q3", label="[ , b]:", value = 75, min=51, max=100))
          ),
          fluidRow(
            column(6,radioButtons("qtype1", "brackets", c("Squared"=1,"Rounded"=2), selected="Squared")),
            column(6,radioButtons("qtype2", "separator", c("Semicolon"=1,"Comma"=2,"Slash"=3), selected="Semicolon"))
          )
        ),
        bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">Date variables</p>'), style="info",
          selectInput("Dateformat", "Date format", choices=c("d-m-Y","m-d-Y","Y-m-d","d-mon-Y","mon-d-Y"), selected="d-mon-Y")
        )
      ),
      actionButton("changeformat","Update")
    )           
  })
  
  ########################
  ##### decimals #########
  ########################  
  
  output$decimals <- renderUI({  
    if (is.null(rv$initial) || !rv$initial){
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    div(
      HTML('<div style="height:10px"></div>'),
      bsCollapse(
        bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">p-values</p>'), style="info", 
          numericInput("pvaldigits", label="Number of decimals", value = 3, min=1, max=20),
          actionButton("changepvalsdigits","Update")
        ),
        bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">Descriptives</p>'), style="info",
          uiOutput("seledescdigits")
        ),
        bsCollapsePanel(title=HTML('<div style="font-color:black; height:15px">OR/HR</p>'), style="info",      
          uiOutput("seleratiodigits")
        )
      )
    )
  })
  
  ########################
  ##### labels ###########
  ########################  
  
  output$labels <- renderUI({  
    if (is.null(rv$initial) || !rv$initial){ 
      cat("\n\nData not loaded")
      return(invisible(NULL))
    }
    div(
      textInput("alllabel", label="All:", value="[ALL]"),
      textInput("poveralllabel", label="overall p-value:", value="p.overall"),
      textInput("ptrendlabel", label="p-value for trend:", value="p.trend"),
      textInput("pratiolabel", label="OR/HR p-value:", value="p.ratio"),
      textInput("Nlabel", label="Available data:", value="N"), 
      textInput("captionlabel", label="Caption:", value="NULL"),
      hr(),
      actionButton("changeLabels","Apply") 
    )
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
  ###### ui plot #########
  ########################
  
  output$uiplot <- renderUI({ 
    validate(need(rv$initial, "Data not loaded")) 
    div(
      uiOutput("varPlot"),
      shinyjqui::jqui_draggable(shinyjqui::jqui_resizable(plotOutput('plot',width = "600px", height = "600px")))
    )
  })
  
  ########################
  ######## snps ##########
  ########################
  
  output$snps <- renderUI({  
    validate(need(rv$initial, "Data not loaded"))
    div(
      div(class="row-fluid",
        dropdownButton(inputId="SNPsoptionsaction", circle=FALSE, status="info", label="View",  
          div(id="SNPsoptions",
            fluidRow(
              column(4,textInput("sepSNPs","Allele separator")),
              column(4,br(),downloadButton('actiondownloadSNPtable', 'Download'),offset=4)
            )                    
          )
        )
      ),
      br(),
      verbatimTextOutput('restabSNPs')
    )
  })
  
  ########################
  ##### plot #############
  ########################
  
  output$varPlot <- renderUI({
    if (input$exampledata=='Own data'){
      inFile<-input$files
      if (is.null(inFile))
        return(invisible(NULL))  
    }
    if (is.null(rv$selevars) || length(rv$selevars)==0)
      return(invisible(NULL))
    input$changeselevars
    return(
      wellPanel(id="varPlotPanel",
        fluidRow(
          column(3,
            selectInput("varPlot", HTML('<div title="Choose variable to plot">Variable</div>'), choices = rv$selevars, selectize=FALSE)
          ),
          column(3,
            br(),
            shinyjs::hidden(checkboxInput("bivar","Bivariate",FALSE))
          ),
          column(3,
            br(),
            checkboxInput("perc","Plot percentage",TRUE)
          ),
          column(3,
            br(),br(),
            bsButton("downloadplot","Click to download"),
            bsModal("plotModal", "Download plot", "downloadplot",
              selectInput("downloadplottype", "Select format", choices = c('pdf','bmp','jpg','png','tif'), selectize=FALSE),
              downloadButton('actiondownloadplot', 'Download')
            )
          )
        )
      )
    )
  })

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
    ct <- create()
    validate(need(!inherits(ct,"cbind.createTable"),"Table cannot be stratified"))
    withProgress(message = 'Making plot', value = 0, {    
      validate(need(ct, "Error in performing the table"))
      bivar<-if (is.null(input$bivar)) FALSE else input$bivar
      perc<-if (is.null(input$perc)) FALSE else input$perc
      cg <- attr(ct, "x")[[1]]
      ww <- which(attr(cg, "varnames.orig")==input$varPlot)
      x <- vector("list", 1)
      x[[1]] <- cg[[ww]]
      names(x) <- input$varPlot
      class(x) <- "compareGroups"
      attr(x,"groups") <- attr(cg,"groups")
      attr(x,"yname") <- attr(cg,"yname")
      attr(x,"byrow") <- attr(cg,"byrow")
      plot(x,bivar=bivar,perc=perc)
    })
  })
  
  
  ####################################
  ############  HELP  ################
  ####################################
  
  output$helpload<-renderUI(HTML(hlp['LOAD']))
  output$helpselect<-renderUI(HTML(hlp['SELECT']))
  output$helptype<-renderUI(HTML(hlp['Type']))
  output$helpresponse<-renderUI(HTML(hlp['Response']))
  output$helpstratas<-renderUI(HTML(hlp['Stratas']))
  output$helphide<-renderUI(HTML(hlp['Hide']))
  output$helpsubset<-renderUI(HTML(hlp['Subset']))
  output$helpratio<-renderUI(HTML(hlp['OR/HR']))
  output$helpshow<-renderUI(HTML(hlp['Show']))
  output$helpformat<-renderUI(HTML(hlp['Format']))
  output$helpdecimals<-renderUI(HTML(hlp['Decimals']))
  output$helplabel<-renderUI(HTML(hlp['Label']))
  output$helpsave<-renderUI(HTML(hlp['SAVE']))

  output$helpabout<-renderUI(HTML(hlp['HELPCG']))
  output$helpwui<-renderUI(HTML(hlp['HELPWUI']))
  output$helpsecurity<-renderUI(HTML(hlp['DATASECURITY']))
  output$helpsummary<-renderUI(HTML(hlp['SUMMARY']))
  output$helpvalues<-renderUI(HTML(hlp['VALUES']))
  output$helptable<-renderUI(HTML(hlp['TABLE']))
  output$helpplot<-renderUI(HTML(hlp['PLOT']))
  output$helpsnps<-renderUI(HTML(hlp['SNPs'])) 
  
  
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
        header.labels<-c(input$alllabel,input$poveralllabel,input$ptrendlabel,input$pratiolabel,input$Nlabel)
        captionlabel<-input$captionlabel
        if (!is.null(captionlabel) && captionlabel=='NULL')
          captionlabel<-NULL 
      })    
      restab<-create()
      if (is.null(restab))
        return(invisible(NULL))
      if (input$downloadtabletype=='CSV'){
        if (inherits(restab,"cbind.createTable")) return(NULL)
        export2csv(restab,file=ff,sep=input$sepcsv,header.labels=header.labels)
      }
      if (input$downloadtabletype=='PDF'){
        export2pdf(restab,file="tableTemp.pdf",openfile=FALSE,size=input$sizepdf,landscape=input$landscape,header.labels=header.labels,caption=captionlabel)
        file.rename("tableTemp.pdf",ff)
        file.remove("tableTemp.aux")
        file.remove("tableTemp.log")
        file.remove("tableTemp.tex")
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
        if (inherits(restab,"cbind.createTable")) return(NULL)
        export2word(restab, file=ff,header.labels=header.labels)
      } 
      if (input$downloadtabletype=='Excel'){
        if (inherits(restab,"cbind.createTable")) return(NULL)
        export2xls(restab, file=ff,header.labels=header.labels)
      }         
    }
  )
  
  observe({
    if (is.null(input$downloadtabletype)) return(NULL)
    rv$changestratacount
    isolate({
      if (!is.null(input$stratatype) && input$stratatype!='None' && input$downloadtabletype%in%c('Excel','Word','CSV')){
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
  
  ####### plot #########
  output$actiondownloadplot <- downloadHandler(
    filename = function() paste("figure",tolower(input$downloadplottype),sep="."),
    content = function(ff) {
      ext<-input$downloadplottype
      ct <- create()
      validate(need(ct, "Error in performing the table"))
      validate(need(!inherits(ct,"cbind.createTable"),"Table cannot be stratified"))
      withProgress(message = 'Downloading plot', value = 0, {    
        bivar<-if (is.null(input$bivar)) FALSE else input$bivar
        perc<-if (is.null(input$perc)) FALSE else input$perc
        cg <- attr(ct, "x")[[1]]
        ww <- which(attr(cg, "varnames.orig")==input$varPlot)
        x <- vector("list", 1)
        x[[1]] <- cg[[ww]]
        names(x) <- input$varPlot
        class(x) <- "compareGroups"
        attr(x,"groups") <- attr(cg,"groups")
        attr(x,"yname") <- attr(cg,"yname")
        attr(x,"byrow") <- attr(cg,"byrow")
        plot(x,type=ext,file="./www/fig",bivar=bivar,perc=perc)
        file.rename(paste0("./www/fig","",".",ext),ff)
      })
    }
  )      
      

})


setwd(wd)
