shinyUI(
  
  fluidPage(
  
    # theme = shinytheme("cerulean"),

    shinyjs::useShinyjs(), # Set up shinyjs
     
    headerPanel("",windowTitle="compareGroups | Explore and Summarise Epidemiological Data in R"),
    
    uiOutput("shinythemesout"),
    uiOutput("panelwidthout"),
    
    HTML('<style type="text/css"> #inputpanel{ max-height:800px; overflow:auto; margin-right:-3%} </style>'),
    HTML('<style type="text/css"> #outpanel {min-height:150px} </style>'), 
    HTML('<style type="text/css"> #showload { background-color: rgb(250,250,250); border: 2px solid grey;} </style>'),
    HTML('<style type="text/css"> #selevars { width: 120px;} </style>'), 
    HTML('<style type="text/css"> #discvars { width: 120px;} </style>'),
    HTML('<style type="text/css"> #changeselevars { font-size: 15px; border: 2px solid grey;} </style>'),
    HTML('<style type="text/css"> #varPlot { width: 120px;} </style>'),
    HTML('<style type="text/css"> #maxvalues { width: 100px;} </style>'),
    HTML('<style type="text/css"> #exampledata { width: 200px;} </style>'),
    #HTML('<style type="text/css"> #initial { height: 0px; width: 0px} </style>'),
    HTML('<style type="text/css"> #count { height: 0px; width: 0px} </style>'),
    HTML('<style type="text/css"> #bsModalhelpcg .modal-content { width:120%;height:120%;} </style>'),
    HTML('<style type="text/css"> #bsModalhelpcg .modal-header { background-color:rgb(68,110,155);} </style>'),
    HTML('<style type="text/css"> #tableoptions,#infooptions,#valuessumoptions,#valuextoptions,#SNPsoptions {background-color:#D1F0F0;padding:20px;text-align:center;margin-top:-10px;margin-bottom:10px;border:1px solid black; border-radius: 8px;} </style>'),    
    HTML('<style type="text/css"> #results {font-size:18px;font-weight:bold;font-color:red;} </style>'),        
    
    
    HTML('<button title="Settings" id="settingaction" type="button" class="btn btn-default action-button btn-sm" style="margin-bottom:5px;"><i class="fa fa-gear"></i></button>'),
    bsModal(id="modalSettings",title="Settings",trigger="settingaction",
      selectInput("shinythemes","Select shiny theme",choices=c("cerulean","cosmo","cyborg","darkly","flatly","journal","lumen","paper","readable","sandstone","simplex","slate","united","spacelab","superhero","yeti"),selected="spacelab"),
      sliderInput("panelwidth","Left panel width %",0,100,30,5)
    ),
    
    
     
    fluidRow(

    ##################################################     
    ################ CONTROL PANEL ###################
    ##################################################
    
    column(4,

      div(id="inputpanel",  

          bsCollapse(id = "collapseInput", open = c("collapseLoad"),
            
            ## load data
            bsCollapsePanel(title=HTML('<font style="font-size:18px">Step 1. Load data</font>'), value="collapseLoad", style = "primary",
              uiOutput("initial"),
              column(1,bsButton("infoLoad","",size="extra-small",style="info",icon=shiny::icon("info-circle")),offset=11),
              bsModal("infoLoadModal",HTML('<p> <strong>Step 1. Load data</strong></p>'), "infoLoad",uiOutput("helpload")),
              #radioButtons("exampledata", "", choices = c("Own data","REGICOR","PREDIMED","SNPS")),
              HTML('
              <div id="exampledata" class="form-group shiny-input-radiogroup shiny-input-container" style="text-align:justify">
                <label class="control-label" for="exampledata"></label>
                <div class="shiny-options-group">
                <div class="radio">
                <label>
                <input type="radio" name="exampledata" value="Own data" checked="checked"/>
                <span>Upload your own data set from a file</span>
                </label>
                <div><br><font style="weight:bold">...or choose an example data set</font></p></div>
                </div>
                <div class="radio" style="margin-left:10px">
                <label>
                <input type="radio" name="exampledata" value="REGICOR"/>
                <span>REGICOR</span>
                </label>
                </div>
                <div class="radio" style="margin-left:10px">
                <label>
                <input type="radio" name="exampledata" value="PREDIMED"/>
                <span>PREDIMED</span>
                </label>
                </div>
                <div class="radio" style="margin-left:10px">
                <label>
                <input type="radio" name="exampledata" value="SNPS"/>
                <span>SNPS</span>
                </label>
                </div>
                </div>
                </div>'
              ), 
              conditionalPanel(
                condition = "input.exampledata == 'Own data'",
                fileInput("files", "", accept=c('', 'sav', 'csv', 'dat', 'txt', 'xls', 'xlsx', 'mdb')),
                uiOutput("loadpanel")
              ),
              uiOutput("loadokui")
            ),
            
            ## vars list
            bsCollapsePanel(title=HTML('<font style="font-size:18px">Step 2. Select variables</font>'), value="collapseSelect", style = "primary", 
              column(1,bsButton("infoSelect","",size="extra-small",style="info",icon=icon("info-circle")),offset=11),
              bsModal("infoSelectModal",HTML('<p> <strong>Step 2. Select variables</strong></p>'), "infoSelect",uiOutput("helpselect")),
              uiOutput("selevarslist")
            ),
            ## settings
            bsCollapsePanel(title=HTML('<font style="font-size:18px">Step 3. Settings</font>'), value="collapseSettings", style = "primary", 
              column(1,bsButton("infoSettings","",size="extra-small",style="info",icon=icon("info-circle")),offset=11),
              bsModal("infoSettingsModal",HTML('<p> <strong>Step 3. Settings</strong></p>'), "infoSettings",
                tabsetPanel(
                  tabPanel("Type",uiOutput("helptype")),
                  tabPanel("Response",uiOutput("helpresponse")),
                  tabPanel("Hide",uiOutput("helphide")),
                  tabPanel("Subset",uiOutput("helpsubset")),
                  tabPanel("OR/HR", uiOutput("helpratio"))
                )
              ),
              uiOutput("settingsout")
            ),
            ## display
            bsCollapsePanel(title=HTML('<font style="font-size:18px">Step 4. Display</font>'), value="collapseDisplay", style = "primary",
              column(1,bsButton("infoDisplay","",size="extra-small",style="info",icon=icon("info-circle")),offset=11),
              bsModal("infoDisplayModal",HTML('<p> <strong>Step 4. Display</strong></p>'), "infoDisplay",
                tabsetPanel(
                  tabPanel("Show",uiOutput("helpshow")),
                  tabPanel("Format",uiOutput("helpformat")),
                  tabPanel("Decimals",uiOutput("helpdecimals")),
                  tabPanel("Labels",uiOutput("helplabel"))
                )
              ), 
              uiOutput("displayout")
            ),
            ## save
            bsCollapsePanel(title=HTML('<font style="font-size:18px">Step 5. Save table</font>'), value="collapseSave", style = "primary",
              column(1,bsButton("infoSave","",size="extra-small",style="info",icon=icon("info-circle")),offset=11),
              bsModal("infoSaveModal",HTML('<p> <strong>Step 5. Save table</strong></p>'), "infoSave", uiOutput("helpsave")),
              uiOutput("saveout")
            )
          )
      )
    ),
    
    #################################
    #######  RESULTS PANEL ##########
    #################################


    column(8,
           
      div(id="outpanel",

          navbarPage(title="", id="results", inverse=FALSE, position="static-top",
            # About
            tabPanel(value="resultsAbout",HTML('<p title="About compareGroups project">ABOUT</p>'),
              # compareGroups
              uiOutput("helpabout"),
              br(),
              column(4,bsButton("helpcg","view examples",size="small",type="info"),offset=4),
              bsModal(id="bsModalhelpcg", title=HTML('<font style="color:white;">Examples</font>'), trigger="helpcg",size="large",
                fluidRow(
                  column(1,bsButton("dec",HTML('<p style="font-size:20px"><</p>'),style="primary",size="extra-small")),
                  column(10,uiOutput("helpModalContents")),
                  column(1,bsButton("inc",HTML('<p style="font-size:20px">></p>'),style="primary",size="extra-small"))
                )
              ),  
              br(),
              # WUI
              uiOutput("helpwui"),
              # Security
              uiOutput("helpsecurity")
            ),                     
            # Data
            navbarMenu("DATA",
              # summary         
              tabPanel(value="resultsSummary",title=HTML('<p title="Short summary from loaded data set">Summary</p>'),
                column(1,bsButton("infoSummary","",size="extra-small",style="info",icon=icon("info-circle")),offset=11),
                bsModal("infoSummaryModal",HTML('<p> <strong>Summary</strong></p>'), "infoSummary",uiOutput("helpsummary")),
                uiOutput("values")
              ),
              # VALUES (extended)
              tabPanel(value="resultsValues",title=HTML('<p title="Navigate thru the whole data set">Values</p>'),
                column(1,bsButton("infoExtended","",size="extra-small",style="info",icon=icon("info-circle")),offset=11),
                bsModal("infoExtendedModal",HTML('<p> <strong>Values</strong></p>'), "infoExtended",uiOutput("helpvalues")),
                uiOutput("valuextoptionsout"),
                uiOutput("valuesext")
              )
            ),
            tabPanel(value="resultsTable",title=HTML('<p title="View descriptive table" style="font-size:140%;">TABLE</p>'),
              column(1,bsButton("infoTable","",size="extra-small",style="info",icon=icon("info-circle")),offset=11),
              bsModal("infoTableModal",HTML('<p> <strong>TABLE</strong></p>'), "infoTable",uiOutput("helptable")),
              uiOutput("tableoptionsout"),
              uiOutput("table")
            ),
            tabPanel(value="resultsPlot",title=HTML('<p title="Visualize data">PLOT</p>'),
              column(1,bsButton("infoPlot","",size="extra-small",style="info",icon=icon("info-circle")),offset=11),
              bsModal("infoPlotModal",HTML('<p> <strong>PLOT</strong></p>'), "infoPlot",uiOutput("helpplot")),
              uiOutput("uiplot")
            ),
            tabPanel(value="resultsSNPs",title=HTML('<p title="single nucleotide polymorphisms (SNPs) analyses">SNPs</p>'),
              column(1,bsButton("infoSNPs","",size="extra-small",style="info",icon=icon("info-circle")),offset=11),
              bsModal("infoSNPsModal",HTML('<p> <strong>SNPs</strong></p>'), "infoSNPs",uiOutput("helpsnps")),
              uiOutput("snps")
            )
          )
    
      )
    )
  )

))                               
