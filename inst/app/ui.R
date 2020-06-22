ui <- fluidPage(

  useShinyjs(),

  # verbatimTextOutput("xxx"),

  uiOutput("leftPanelAspect"),
  uiOutput("rightPanelAspect"),
  # uiOutput("sidebarAspect"),
  
  HTML("<style type='text/css'> #ResponseVariableORPanel, #LoadDataOptionsExcel, #LoadDataOptionsTxt, #extralabelsPanel {color:white;background-color:rgba(60,141,188,1)}</style>"),
  HTML("<style type='text/css'> #ratioAccordion, #formatAccordion, #decimalsAccordion {color:rgba(60,141,188,1)}</style>"),
  
  # get window sizes.
  tags$head(tags$script('var dimension = [0, 0];
                        $(document).on("shiny:connected", function(e) {
                        dimension[0] = window.innerWidth;
                        dimension[1] = window.innerHeight;
                        Shiny.onInputChange("dimension", dimension);
                        });
                        $(window).resize(function(e) {
                        dimension[0] = window.innerWidth;
                        dimension[1] = window.innerHeight;
                        Shiny.onInputChange("dimension", dimension);
                        });
                        ')),
 
  # HTML("<style type='text/css'> #toggleLeftPanel{size:50%}</style>"),
  # HTML("<style type='text/css'> .main-sidebar{background-color:red}</style>"),
  HTML("<link href='https://fonts.googleapis.com/css?family=Knewave' rel='stylesheet'>"),
  
  titlePanel(HTML("<p style='margin-top:-20px'></p>"), windowTitle="compareGroups | Explore and Summarise Epidemiological Data in R"),
  
  dashboardPagePlus(
    # md = TRUE,
    loading_duration=0,
    skin="blue",
    sidebar_background=NULL,
    sidebar_fullCollapse=FALSE,
    header = dashboardHeaderPlus(
      # title = logo_cg,
      title=tagList(
             span(class = "logo-lg", 
                  HTML("<img src='logo.png' width=35 style='margin-right:10px;margin-bottom:10px'/><format style='text-align: left; font-family: Knewave; font-size: 30px; font-style: normal; font-variant: normal;'>compareGroups<br>xxx</format>")),
                                          # <br><format style='color:yellow'>R package to easily build publication-ready univariate or bivariate descriptive tables from a data set</format>")),
             img(src = "logo.png", width=35)
      ),
      titleWidth = 300,
      fixed = FALSE,
      enable_rightsidebar = TRUE,
      rightSidebarIcon = "gears",
      left_menu=tagList(
        hidden(div(id="dropdownData",
          tags$table(
            tags$tr(
              tags$td(style="padding-right:5px",
                dropdownButton(inputId="valuextoptionsaction", circle=FALSE, status="primary", label=HTML("<format style='font-size:13pt'>View options</format>"),
                  checkboxInput("showlabels","Show variable labels",TRUE),
                  sliderInput("valueextsize", "Resize (%):", min=10, max=300, value=100, step=10),
                  sliderInput("valueextwidth", "Width (%)", value=100, min=50, max=200)
                )
              ),
              tags$td(style="padding-right:5px",
                bsButton("udpateSelection",HTML("<format style='font-size:13pt'>Update Selection</format>"),style="primary")
              )
            )
          )
        )),
        hidden(div(id="dropdownDescriptives",
          tags$table(
            tags$tr(
              tags$td(style="padding-right:5px",
                bsButton("varinfotabbtn",HTML("<format style='font-size:13pt'>Names/Labels</format>"),style="primary")
              ),
              tags$td(style="padding-right:5px",
                shinyWidgets::dropdownButton(circle=FALSE, label=HTML("<format style='font-size:13pt'>Options</format>"), icon=icon("gears"), width=600, status="primary",
                  sliderInput("htmlsizerestab", "Resize:", min=7, max=30, value=16, step=1),
                  sliderInput("htmlwidthrestab", "Variable column width (cm):", min=2, max=20, value=8, step=0.5),
                  radioButtons("position", "Table position", c("left","center","right"), inline=TRUE),
                  fluidRow(
                    column(6,colorSelectorInput("header.background","Header background colour:",choices=choices_brewer,selected="#F7FBFF",display_label=FALSE)),
                    column(6, colorSelectorInput("header.color","Header colour:",choices=choices_brewer,selected="#000000",display_label=FALSE))
                  ),
                  checkboxInput("strip", "Strip variables", FALSE),
                  conditionalPanel("input.strip",
                    colorSelectorInput("strip.color","Strip colour:",choices=choices_brewer,selected="#F0F0F0",display_label=FALSE)
                  )
                )
              ),
              tags$td(style="padding-right:5px",
                shinyWidgets::dropdownButton(circle=FALSE, label=HTML("<format style='font-size:13pt'>Save</format>"), icon=icon("save"), status="primary",
                  h3("Save table"),
                  hr(), 
                  div(id="SavePanel",
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
                  )
                )
              )
            )
          )
        )),
        hidden(div(id="dropdownPlot",
          fluidRow(
            column(6,
              shinyWidgets::dropdownButton(circle=FALSE,icon = icon("down"),label = HTML("<format style='font-size:13pt'>Download</format>"),inputId = "downPlotOptionsBtn", status="primary",
                tooltip = "Click here to download the plot. You can choose also the format.",
                selectInput("downloadplottype", "Select format", choices = c('pdf','bmp','jpg','png','tif'), selectize=FALSE),
                div(style="width:80px",downloadButton('actiondownloadplot', 'OK'))
              )
            ),
            column(6,
              shinyjs::hidden(checkboxInput("perc",HTML("<format style='color:white;font-size:13pt'>Show percentage</format>"),TRUE))
            )
          )
        )),
        hidden(div(id="dropdownSNPs",
          downloadButton('actiondownloadSNPtable', HTML("<format style='font-size:13pt'>Download</format>"), style="color:white; background-color:#3C8DBC;border:2px solid #357CA5")        
        ))
      ),
      
      userOutput("github")
    ),

    ## sidebar
    sidebar = dashboardSidebar(
      sidebarMenu(id="leftmenu",
        menuItem(HTML("<format style='font-size:13pt'>Home</format>"), tabName="Home", icon=icon("home")),                  
        div(id="DataHeader",style="padding-top:5px;",
          uiOutput("DataHeaderText"),
          div(style="border: 1px solid white;height:0px; margin-top:-3px; margin-bottom:0px")
        ),          
        menuItem(HTML("<format style='font-size:13pt'>Load data</format>"), tabName="LoadData", icon = icon("upload")),
        menuItem(HTML("<format style='font-size:13pt'>Filter Data</format>"), tabName="FilterData", icon = icon("filter")),        
        menuItem(HTML("<format style='font-size:13pt'>Recode variables</format>"), tabName="RecodeVars", icon = icon("calculator")),
        ##       
        div(id="TableHeader",style="padding-top:5px",
          uiOutput("TableHeaderText"),
          div(style="border: 1px solid white;height:0px; margin-top:-3px; margin-bottom:0px")
        ),          
        menuItem(HTML("<format style='font-size:13pt'>Variables</format>"), tabName="Variables", icon = icon("bars"), startExpanded=FALSE,
          menuSubItem(HTML("<format style='font-size:12pt'>Described variables</format>"), tabName="DescribedVariables"),
          menuSubItem(HTML("<format style='font-size:12pt'>Response / groups</format>"), tabName="ResponseVariable"),
          menuSubItem(HTML("<format style='font-size:12pt'>Stratas</format>"), tabName="StrataVariable")
        ),
        menuItem(HTML("<format style='font-size:13pt'>Settings</format>"), tabName="Settings", icon = icon("cogs"),
          menuSubItem(HTML("<format style='font-size:12pt'>Type</format>"), tabName="Type"),
          menuSubItem(HTML("<format style='font-size:12pt'>Hide</format>"), tabName="Hide"),
          menuSubItem(HTML("<format style='font-size:12pt'>Subset</format>"), tabName="Subset"),
          menuSubItem(HTML("<format style='font-size:12pt'>Odds/Hazard/Risk Ratio</format>"), tabName="ORHR")
        ),
        menuItem(HTML("<format style='font-size:13pt'>Display</format>"), tabName="Display", icon = icon("eye"),
          menuSubItem(HTML("<format style='font-size:12pt'>Show</format>"), tabName="Show"),
          menuSubItem(HTML("<format style='font-size:12pt'>Format</format>"), tabName="Format"),
          menuSubItem(HTML("<format style='font-size:12pt'>Decimals</format>"), tabName="Decimals"),
          menuSubItem(HTML("<format style='font-size:12pt'>Labels</format>"), tabName="Labels")
        ),
        ##
        div(id="PlotHeader",style="padding-top:5px",
          uiOutput("PlotHeaderText"),
          div(style="border: 1px solid white;height:0px; margin-top:-3px; margin-bottom:0px")
        ),    
        menuItem(HTML("<format style='font-size:13pt'>Variable</format>"), tabName="PlotVariables", icon = icon("bars")),
        menuItem(HTML("<format style='font-size:13pt'>Groups</format>"), tabName="PlotGroups", icon = icon("user-friends")),
        ##
        div(id="SNPsHeader",style="padding-top:5px",
          uiOutput("SNPsHeaderText"),
          div(style="border: 1px solid white;height:0px; margin-top:-3px; margin-bottom:0px")
        ),
        menuItem(HTML("<format style='font-size:13pt'>Variables</format>"), tabName="SNPsVariables", icon = icon("bars")),
        menuItem(HTML("<format style='font-size:13pt'>Groups</format>"), tabName="SNPsGroups", icon = icon("user-friends")),
        menuItem(HTML("<format style='font-size:13pt'>Options</format>"), tabName="SNPsOptions", icon=icon("gears"))
      )
    ),

    ## body
    body = dashboardBody(
      setShadow(class = "dropdown-menu"),
      # cg_theme,
      tags$head(tags$style(HTML('.content-wrapper, .right-side {background-color: white;}'))),
      fluidRow(
        column(id="leftPanel", width = 12,
          bsButton("toggleLeftPanel","",type = "action",icon=icon("angle-double-left"),size="extra-small"),
          shinyBS::bsTooltip("toggleLeftPanel","Hide panel"),
          #### Load data #####
          conditionalPanel("input.leftmenu=='LoadData'",
            shinyhelper::helper(h3("Load data"), title="Load data", type="markdown", content="loadhelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            hidden(div(id="resetbtnPanel",
              actionButton("resetbtn","Load a new dataset"),
              br(),
              "In order to read a new data set, all parameteres will be resetted",
              hr()
            )),
            div(id="LoadDataPanel",
              HTML(
                '<div id="exampledata" class="form-group shiny-input-radiogroup shiny-input-container" style="width:100%;text-align:justify">
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
              fileInput("files", ""),
              div(id="ownPanel",
                selectInput("datatype", "Data format", c('SPSS'='*.sav', 'TEXT'='*.txt','EXCEL'='*.xls','Stata'='*.dta','R'='*.rda'),'*.sav'),
                conditionalPanel("input.datatype=='*.xls'",  # EXCELL
                  wellPanel(id="LoadDataOptionsExcel",
                    HTML('<p style="font-style:Bold; font-size:18px">Excel options</p>'),
                    selectInput("tablenames", "Choose the table to read:", choices = NULL, selectize=FALSE),
                    checkboxInput('headerexcel', 'Has column headers', TRUE),
                    numericInput("skipexcel", "Number of rows to skip", value=0),
                    textInput("missvalueexcel", HTML("Missing Data String (e.g. <i>NA</i>)"), ""),
                    checkboxInput("stringToFactorexcel", "Convert string variables to factor", value=TRUE)
                  )
                ),
                conditionalPanel("input.datatype=='*.txt'",
                  wellPanel(id="LoadDataOptionsTxt",
                    HTML('<p style="font-style:Bold; font-size:18px">TEXT options</p>'),
                    downloadButton("previewtxtdown","Preview data"),
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
              ),
              actionButton("loadok","Read data")
            ),
            br()
          ),
          
          #### Filter data ######
          conditionalPanel("input.leftmenu=='FilterData'",
            shinyhelper::helper(h3("Filter data"), title="Filter data", type="markdown", content="filterhelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            textAreaInput("filterexpr", "Write R code", placeholder = "Some R code  or left in blank to remove the filter"),
            tags$table(
              tags$tr(
                tags$td(shinyBS::bsButton("filterdataok", "Filter", width=80)),
                tags$td(HTML("&nbsp")),
                tags$td(shinyBS::bsButton("removefilterdataok", "Clean", icon=icon("brush"), width=80, style="warning"))
              )
            ),
            br()
          ),          
          
          #### Recode variables ######
          conditionalPanel("input.leftmenu=='RecodeVars'",
            shinyhelper::helper(h3("Recode variables"), title="Recode variables", type="markdown", content="recodehelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            textInput("newvarname", "Variable name"),
            textInput("newvarlabel", "Variable label"),
            textAreaInput("newvarexpr", "Write R code"),
            tags$table(
              tags$tr(
                tags$td(shinyBS::bsButton("newvarok", "Create", width=80)),
                tags$td(HTML("&nbsp")),
                tags$td(shinyBS::bsButton("removenewvarok", "Clean", icon=icon("brush"), width=80, style="warning"))
              )
            ),
            br()         
          ),

          #### Described variables ######
          conditionalPanel("input.leftmenu=='DescribedVariables'",
            shinyhelper::helper(h3("Selected described variables"), title="Selected described variables", type="markdown", content="selecthelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            div(id="DescribedVariablesPanel",
              fluidRow(
                fluidRow(
                  tags$table(
                    tags$tr(
                      tags$td(HTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp")),
                      tags$td(width="50px",shinyBS::bsButton("selevarsAll","All",style="info",size="extra-small",block=TRUE)),
                      tags$td(HTML("&nbsp;")),
                      tags$td(width="50px",shinyBS::bsButton("selevarsNone","None",style="danger",size="extra-small",block=TRUE))
                    )  
                  )
                ),
                fluidRow(
                  column(12,selectizeInput("selevars",NULL,
                                           width="100%",
                                           choices=NULL,
                                           # selected=rv$selevars,
                                           multiple=TRUE,
                                           options=list(plugins=list('remove_button', 'drag_drop')))
                  )
                ),
                column(3, offset=0, shinyBS::bsButton("changeselevarsok","Update"))
              )
            ),
            br()
          ),

          #### Response Variable ######
          conditionalPanel("input.leftmenu=='ResponseVariable'",
            shinyhelper::helper(h3("Define groups"), title="Define groups", type="markdown", content="responsehelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            div(id="ResponseVariablePanel",
              radioGroupButtons("resptype", "", c("None","Group","Survival"),justified=TRUE, checkIcon=list(yes=icon("ok",lib = "glyphicon"))),
              conditionalPanel("input.resptype == 'Group'",
                numericInput('maxgroups',"Maximum number of groups:",value=5,min=2,max=10),
                selectInput("gvar", "Choose the grouping variable:", choices = NULL, selectize=FALSE),
                actionLink("ResponseVariableORPanelBtn",HTML("<format style='color:white'>OR/RR options</format>")),
                wellPanel(id="ResponseVariableORPanel",
                  checkboxInput('computeratio', 'Compute OR/RR:', FALSE),
                  conditionalPanel(
                    condition = "input.computeratio == true",
                    selectInput("gvarcat", "OR/RR ref. cat:", choices = NULL, selectize=FALSE),
                    radioButtons("riskratio","OR or RR", c("OR", "RR"), inline=TRUE),
                    conditionalPanel(
                      "input.riskratio=='OR'",
                      selectInput("oddsratiomethod","OR method",c("midp", "fisher", "wald", "small"))
                    ),
                    conditionalPanel(
                      "input.riskratio=='RR'",
                      selectInput("riskratiomethod","RR method",c("wald", "small", "boot"))
                    )                    
                  )
                )
              ),
              conditionalPanel("input.resptype=='Survival'",
                selectInput("varseletime", "Select time-to-event variable", choices = NULL, multiple = FALSE, selectize=FALSE),
                selectInput("varselestatus", "Select status variable", choices = NULL, multiple = FALSE, selectize=FALSE),
                selectInput("statuscat", "Select event category/ies", choices=NULL, multiple = TRUE, selectize=FALSE)
              ),
              actionButton("changeresp","Update")
            ),    
            br()
          ),

          #### Stratas ######
          conditionalPanel("input.leftmenu=='StrataVariable'",
            shinyhelper::helper(h3("Define strata"), title="Define strata", type="markdown", content="stratahelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            div(id="StrataVariablePanel",
              radioGroupButtons("stratatype", "", c("None","Strata"), justified=TRUE, checkIcon=list(yes=icon("ok",lib = "glyphicon"))),
              conditionalPanel("input.stratatype=='Strata'",
                numericInput('maxstrata',"Maximum number of stratas:",value=5,min=2,max=10),
                selectInput("svar", "Choose the strata variable:", choices = NULL, selectize=FALSE)
              ),
              actionButton("changestrata","Update")
            ),
            br()
          ),
          
          #### Type ####
          conditionalPanel("input.leftmenu=='Type'",
            shinyhelper::helper(h3("Define the type of variables"), title="Define the type of variables", type="markdown", content="typehelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            div(id="TypePanel",
              shinyWidgets::pickerInput("varselemethod", "Select variables", choices=NULL, multiple=TRUE, 
                options = pickerOptions(actionsBox=TRUE, title="Select variables", header="",liveSearch=TRUE)
              ),
              selectInput("method", "Select type of chosen variable/s", c("Normal","Non-normal","Categorical","NA"), selectize=FALSE),  
              conditionalPanel("input.method=='NA'",
                fluidRow(
                  column(6,numericInput("alpha","alpha",value=0.05,min=0,max=1,step=0.005)),
                  column(6,numericInput("mindis","min categories",value=5,min=1,max=10))
                )
              ),
              actionButton("changemethod","Update")
            ),
            br()
          ),

          #### Hide ####
          conditionalPanel("input.leftmenu=='Hide'",
            shinyhelper::helper(h3("Hide settings"), title="Hide settings", type="markdown", content="hidehelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            div(id="HidePanel",
              div(
                fluidRow(
                  column(6, selectInput("varselehide", "variable", choices = NULL, multiple = FALSE, selectize=FALSE)),
                  column(6, selectInput("hidecat", "category", choices = NULL, "<<None>>", selectize=FALSE))
                ),
                textInput('hideno', "Hide 'no' category", ''),
                actionButton("changehide","Update")
              )
            ),
            br()
          ),

          #### Subset ####
          conditionalPanel("input.leftmenu=='Subset'",
            shinyhelper::helper(h3("Variable subset settings"), title="Variable subset settings", type="markdown", content="subsethelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            div(id="SubsetPanel",
              HTML('<div style="height:10px"></div>'),
              shinyWidgets::pickerInput("varselevarsubset", "Select variables", choices=NULL, multiple=TRUE, 
                options = pickerOptions(actionsBox=TRUE, title="Select variables", header="",liveSearch=TRUE)
              ),
              br(),
              textAreaInput("varsubset", label="Write subset expression", value = ""),
              tags$table(
                tags$tr(
                  tags$td(shinyBS::bsButton("changevarsubset","Update", width=80)),
                  tags$td(HTML("&nbsp;")),
                  tags$td(shinyBS::bsButton("removechangevarsubset","Clean", width=80, icon=icon("brush"), style="warning"))
                )
              )
            ),
            br()
          ),
          
          #### Odds Ratio / Hazard Ratio ####
          conditionalPanel("input.leftmenu=='ORHR'",
            shinyhelper::helper(h3("Odds/Risk/Hazard Ratio settings"), title="Odds/Risk/Hazard Ratio settings", type="markdown", content="ratiohelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            div(id="RatioPanel",
              conditionalPanel("input.computeratio || input.resptype=='Survival'",
                HTML('<div style="height:10px"></div>'),
                bsCollapse(id="ratioAccordion", open="xxx", multiple=FALSE,
                  bsCollapsePanel(value="Reference category", style="info", title=HTML('<div style="font-color:black; height:15px">Reference category</p>'),
                    fluidRow(
                      column(6, selectInput("varselerefratio", "variable", choices=NULL, multiple=FALSE, selectize=FALSE)),
                      column(6, selectInput("refratiocat", "category", choices=NULL, selectize=FALSE))
                    ),
                    actionButton("changeratiocat","Update")
                  ),
                  bsCollapsePanel(value="Multiplying factor", style="info", title=HTML('<div style="font-color:black; height:15px">Multiplying factor</p>'),
                    shinyWidgets::pickerInput("varselefactratio", "Select variables", choices=NULL, multiple=TRUE,
                      options = pickerOptions(actionsBox=TRUE, title="Select variables", header="",liveSearch=TRUE)
                    ),
                    numericInput("factratio", label=NULL, value = 1, min=1, max=100, width=100),
                    actionButton("changefactratio","Update")
                  )
                )
              ),
              conditionalPanel("!input.computeratio && input.resptype!='Survival'",
                helpText("No binary non survival response variable selected")
              )
            ),
            br()
          ),

          #### Show ####
          conditionalPanel("input.leftmenu=='Show'",
            shinyhelper::helper(h3("Show settings"), title="Show settings", type="markdown", content="showhelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            div(id="ShowPanel",
              fluidRow(
                column(6,checkboxInput('showall', 'ALL', TRUE)),
                column(6,checkboxInput('showpoverall', 'p-overall', TRUE))
              ),
              fluidRow(
                column(6,checkboxInput('showdesc', 'Descriptives', TRUE)),
                column(6,checkboxInput('showptrend', 'p-trend', FALSE))
              ),
              fluidRow(
                column(6,checkboxInput('showratio', 'OR/RR/HR', FALSE)),
                column(6,
                  conditionalPanel("input.showratio == true",
                    checkboxInput('showpratio', 'OR/RR/HR p-value', FALSE)
                  )
                )
              ),
              fluidRow(
                column(6,checkboxInput('shown', 'Available', FALSE)),
                column(6,checkboxInput('includemiss', "Add 'Missing' category", FALSE))
              ),
              fluidRow(
                column(6,checkboxInput('showpmul', 'Pairwise p-value', FALSE)),
                column(6,
                  conditionalPanel("input.showpmul == true",
                    checkboxInput('pcorrected', 'Correct pairwise p-values', FALSE)
                  )
                )
              ),
              fluidRow(
                column(6,checkboxInput('simplify', 'Simplify', FALSE)),
                column(6,"")
              ),
              actionButton("changeshow","Update")
            ),
            br()
          ),

          #### Format ####
          conditionalPanel("input.leftmenu=='Format'",
            shinyhelper::helper(h3("Format settings"), title="Format settings", type="markdown", content="formathelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            div(id="FormatPanel",
              HTML('<div style="height:10px"></div>'),
              fluidRow(
                column(6,checkboxInput('showci', 'Report Confidence Interval', FALSE)),
                column(6,
                  conditionalPanel('input.showci',
                    div(style="color:white",sliderInput('conflevel', 'Confidence level', min=50, max=100, value=95, step=1))
                  )
                )
              ),
              numericInput("timemax","Time for survival variables",NA),
              conditionalPanel("!input.showci",
                bsCollapse(id="formatAccordion",multiple=FALSE,open="xxx",
                  bsCollapsePanel(value="Frequencies", style="info", title=HTML('<div style="font-color:black; height:15px">Frequencies</p>'),
                    radioButtons("type", "", c("%" = 1, "n (%)" = 2, "n"=3), selected="n (%)",inline = TRUE),
                    radioButtons("byrow", "Percentages by:", choices=c("columns","rows","total"), inline = TRUE)
                  ),
                  bsCollapsePanel(value="Mean, standard deviation", style="info", title=HTML('<div style="font-color:black; height:15px">Mean, standard deviation</p>'),
                    radioButtons("sdtype", "", c("Mean (SD)"=1,"Mean\u00B1SD"=2), selected="Mean (SD)",inline = TRUE)
                  ),
                  bsCollapsePanel(value="Median [a, b]", style="info", title=HTML('<div style="font-color:black; height:15px">Median [a, b]</p>'),
                    fluidRow(
                      column(6,numericInput("Q1", label="[a, ]:", value = 25, min=0, max=49)),
                      column(6,numericInput("Q3", label="[ , b]:", value = 75, min=51, max=100))
                    ),
                    fluidRow(
                      column(6,radioButtons("qtype1", "brackets", c("Squared"=1,"Rounded"=2), selected="Squared")),
                      column(6,radioButtons("qtype2", "separator", c("Semicolon"=1,"Comma"=2,"Slash"=3), selected="Semicolon"))
                    )
                  ),
                  bsCollapsePanel(value="Date variables", style="info", title=HTML('<div style="font-color:black; height:15px">Date variables</p>'),
                    selectInput("Dateformat", "Date format", choices=c("d-m-Y","m-d-Y","Y-m-d","d-mon-Y","mon-d-Y"), selected="d-mon-Y")
                  )
                )
              ),
              checkboxInput("extralabels","Show variable format indicators", FALSE),
              conditionalPanel("input.extralabels",
                wellPanel(id="extralabelsPanel",
                  textInput("extralabelmean","Mean and standard deviation", "Mean (SD)"),
                  textInput("extralabelmedian","Median and quartiles", "Median [25th; 75th]"),
                  textInput("extralabelperc","Frequencies", "N (%)"),
                  textInput("extralabelsurv","Survival variable", "Incidence")
                )
              ),              
              actionButton("changeformat","Update")
            ),
            br()
          ),

          #### Decimals ####
          conditionalPanel("input.leftmenu=='Decimals'",
            shinyhelper::helper(h3("Decimals"), title="Decimals", type="markdown", content="decimalshelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(), 
            div(id="DecimalsPanel",
              HTML('<div style="height:10px"></div>'),
              bsCollapse(id="decimalsAccordion", open="xxx", multiple=FALSE,
                bsCollapsePanel(value="p-values", style="info", title=HTML('<div style="font-color:black; height:15px">p-values</p>'),
                  numericInput("pvaldigits", label="Number of decimals", value = 3, min=1, max=20),
                  actionButton("changepvalsdigits","Update")
                ),
                bsCollapsePanel(value="Descriptives", style="info", title=HTML('<div style="font-color:black; height:15px">Descriptives</p>'),
                  shinyWidgets::pickerInput("varseledescdigits", "", choices=NULL, multiple=TRUE, 
                    options = pickerOptions(actionsBox=TRUE, title="Select variables", header="",liveSearch=TRUE)
                  ),
                  numericInput("descdigits", label=NULL, value = -1, min=-1, max=10, width=100),
                  actionButton("changedescdigits","Update")
                ),
                bsCollapsePanel(value="OR/RR/HR", style="info", title=HTML('<div style="font-color:black; height:15px">OR/RR/HR</p>'),
                  shinyWidgets::pickerInput("varseleratiodigits", "", choices=NULL, multiple=TRUE, 
                    options = pickerOptions(actionsBox=TRUE, title="Select variables", header="",liveSearch=TRUE)
                  ),
                  numericInput("ratiodigits", label=NULL, value = -1, min=-1, max=10, width=100),
                  actionButton("changeratiodigits","Update")
                )
              )
            ),
            br()
          ),

          #### Labels ####
          conditionalPanel("input.leftmenu=='Labels'",
            shinyhelper::helper(h3("Labels"), title="Labels", type="markdown", content="labelshelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),         
            div(id="LabelsPanel",
              textInput("alllabel", label="All:", value="[ALL]"),
              textInput("poveralllabel", label="overall p-value:", value="p.overall"),
              textInput("ptrendlabel", label="p-value for trend:", value="p.trend"),
              textInput("pratiolabel", label="OR/RR/HR p-value:", value="p.ratio"),
              textInput("Nlabel", label="Available data:", value="N"),
              textInput("captionlabel", label="Caption:", value="NULL"),
              tags$table(
                tags$tr(
                  tags$td(shinyBS::bsButton("changeLabels","Apply", width=80)),
                  tags$td(HTML("&nbsp;")),
                  tags$td(shinyBS::bsButton("refreshLabels","Refresh", style="warning", width=80))
                )
              )
            ),
            br()
          ),

          #### PlotVariables #####
          conditionalPanel("input.leftmenu=='PlotVariables'",
            shinyhelper::helper(h3("Plot variable"), title="Plot variable", type="markdown", content="PlotVariableshelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),            
            div(id="PlotVariablesPanel",
              HTML('<div style="height:10px"></div>'),
              selectInput("plotselevars", "Select variable", choices=NULL),
              actionButton("plotvarchange","Update")
            ),
            br()
          ) ,
          
          #### PlotGroups #####
          conditionalPanel("input.leftmenu=='PlotGroups'",
            shinyhelper::helper(h3("Plot Groups"), title="Plot Groups", type="markdown", content="PlotGroupshelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),            
            div(id="PlotGroupsPanel",
              HTML('<div style="height:10px"></div>'),
              radioGroupButtons("plotresptype", "", c("None","Group","Survival"),justified=TRUE, checkIcon=list(yes=icon("ok",lib = "glyphicon"))),
              br(),
              conditionalPanel("input.plotresptype == 'Group'",
                numericInput('plotmaxgroups',"Maximum number of groups:",value=5,min=2,max=10),
                selectInput("plotgvar", "Choose the grouping variable:", choices = NULL, selectize=FALSE)
              ),
              conditionalPanel("input.plotresptype=='Survival'",
                selectInput("plotvarseletime", "Select time-to-event variable", choices = NULL, multiple = FALSE, selectize=FALSE),
                selectInput("plotvarselestatus", "Select status variable", choices = NULL, multiple = FALSE, selectize=FALSE),
                selectInput("plotstatuscat", "Select event category", choices=NULL, multiple = TRUE, selectize=FALSE)
              ),
              actionButton("plotgroupschange","Update")
            ),
            br()
          ) ,          
          
          #### SNPs Variables #####
          conditionalPanel("input.leftmenu=='SNPsVariables'",
            shinyhelper::helper(h3("SNPs Variables"), title="SNPs Variables", type="markdown", content="SNPsVariableshelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),            
            div(id="SNPsVariablesPanel",
              HTML('<div style="height:10px"></div>'),
              fluidRow(
                tags$table(
                  tags$tr(
                    tags$td(HTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp")),
                    tags$td(width="50px",shinyBS::bsButton("snpsselevarsAll","All",style="info",size="extra-small",block=TRUE)),
                    tags$td(HTML("&nbsp;")),
                    tags$td(width="50px",shinyBS::bsButton("snpsselevarsNone","None",style="danger",size="extra-small",block=TRUE))
                  )  
                )
              ),
              fluidRow(
                selectizeInput("snpsselevars",NULL,
                               width="100%",
                               choices=NULL,
                               # selected=rv$selevars,
                               multiple=TRUE,
                               options=list(plugins=list('remove_button', 'drag_drop')))
              ),
              actionButton("snpsvarchange","Update")
              
            ),
            br()
          ),
          
          #### SNPs Groups #####
          conditionalPanel("input.leftmenu=='SNPsGroups'",
            shinyhelper::helper(h3("SNPs Groups"), title="SNPs Groups", type="markdown", content="SNPsGroupshelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),            
            div(id="SNPsGroupsPanel",
              HTML('<div style="height:10px"></div>'),
              radioGroupButtons("snpsresptype", "", c("None","Group"),justified=TRUE, checkIcon=list(yes=icon("ok",lib = "glyphicon"))),
              conditionalPanel("input.snpsresptype == 'Group'",
                numericInput('snpsmaxgroups',"Maximum number of groups:",value=5,min=2,max=10),
                selectInput("snpsgvar", "Choose the grouping variable:", choices = NULL, selectize=FALSE)
              ),
              actionButton("snpsgroupschange","Update")
              
            )  ,
            br()
                           
          ),
          
          ##### SNPs options #####
          conditionalPanel("input.leftmenu=='SNPsOptions'",
            shinyhelper::helper(h3("SNPs Options"), title="SNPs Options", type="markdown", content="SNPsOptionshelp", size="l", colour="white", style="font-size:14pt; margin-right:10px"),
            hr(),
            div(id="SNPsOptionsPanel",
              textInput("sepSNPs","Allele separator"),
              bsButton("snpsoptionschange","Update")
            ),
            br()
          )

        ),
        
        # br(),   

        ##################################################
        ################# right panel ####################
        ##################################################

        column(id="rightPanel", width = 12,

          ### Home ####
          div(id="homePanel",
            HTML("<p style='text-align: center;><format  color:#357CA5; font-family: Knewave; font-size: 40pt; font-style: normal; font-variant: normal;'>compareGroups WUI</format></p>"),
            HTML("<h3 style='text-align: center;><format style='text-align: center'><i><strong>Web User Interface to explore data and create descriptive tables with <code>compareGroups</code> package</strong></format></i></h3>"),
            includeMarkdown("home.md")
            # uiOutput("helpabout"),
            # br(),
            # column(4,shinyBS::bsButton("helpcg","view examples",size="small",type="info"),offset=4),
            # shinyjs::hidden(div(id="mycarouselPanel",
            #   shinydashboardPlus::carousel(id = "mycarousel",
            #     carouselItem(caption="", h4("Descriptive table directly from R-console"),tags$img(src = "./examples/example1.png", height="42", width="42")),
            #     carouselItem(caption="Export tables to LaTeX file", tags$img(src = "./examples/example2.png", height="42", width="42")),
            #     carouselItem(caption="Save tables on Word documents", tags$img(src = "./examples/example3.png", height="200px")),
            #     carouselItem(caption="Store the descriptives table on Excel spread sheets", tags$img(src = "./examples/example4.png", height="200px")),
            #     carouselItem(caption="Normality plots", tags$img(src = "./examples/example5.png", height="200px")),
            #     carouselItem(caption="Bivariate plots", tags$img(src = "./examples/example6.png", height="200px")),
            #     carouselItem(caption="Analyses of SNPs", tags$img(src = "./examples/example7.png", height="200px"))
            #   )
            # )),
            # br(),
            # # WUI
            # uiOutput("helpwui"),
            # # Security
            # uiOutput("helpsecurity")
          ),

          ### Table ####
          shinyjs::hidden(div(id="descrTableBox",
            shinyhelper::helper(flipBox(id=1, 
              main_img = "",
              header_img = "",
              front_title = "Descriptive table",
              back_title = "Variable information",
              front_btn_text="Go to variable information",
              back_btn_text="Go to descriptive table",
              uiOutput("table"),
              back_content=tagList(
                uiOutput("sumtab")  
              )
            ),title="Descriptive table", type="markdown", content="descrTablehelp", size="l", colour="#3C8DBC", style="font-size:14pt; margin-right:10px")
          )),
          
          #### Data ####
          shinyjs::hidden(div(id="showDataPanel",
            shinyhelper::helper(uiOutput("valuesextui"),title="Data Panel", type="markdown", content="DataPanelhelp", size="l", colour="#3C8DBC", style="font-size:14pt; margin-right:10px"),
            bsAlert("dataAlert")
          )),
          
          #### Plot #####
          shinyjs::hidden(div(id="showPlotPanel",
            shinyhelper::helper(plotOutput("plot", height=600, width=800),title="Plot Panel", type="markdown", content="PlotPanelhelp", size="l", colour="#3C8DBC", style="font-size:14pt; margin-right:10px")
          )),
          
          ##### SNPs #####
          shinyjs::hidden(div(id="showSNPsPanel",
            shinyhelper::helper(verbatimTextOutput("restabSNPs"),title="SNPs Panel", type="markdown", content="SNPsPanelhelp", size="l", colour="#3C8DBC", style="font-size:14pt; margin-right:10px")                    
          ))
        )
      )
    ),


    #########################################
    ########### right side bar ##############

    rightsidebar = rightSidebar(
      background = "dark",
      # whidth=500,
      rightSidebarTabContent(id=1, active=TRUE, icon=NULL,
        sliderInput("leftPanelWidth", HTML("<format style='color:white'>Middle Panel width</format>"), value=30, min=0, max=100)
        # sliderInput("sidebarwidth", HTML("<format style='color:white'>Left bar width (%)</format>"), value=14, min=10, max=50)
      )
    ),
    
    ### footer ###
    footer = dashboardFooter(
      left_text = HTML("<b>By Isaac Subirana</b><br>CIBERESP, IMIM-Parc de Salut Mar, Barcelona"), 
      right_text = HTML("Powered by <a href='https://shiny.rstudio.com/'>Shiny</a>")
    ),

    ### preloader ###
    enable_preloader = FALSE
  )

)

