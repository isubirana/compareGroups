.cGroupsGUIEnv <- new.env(parent=emptyenv())

cGroupsGUI <- function(X){

      requireNamespace("tcltk2", quietly=TRUE)
      requireNamespace("haven", quietly=TRUE) # read spss
  
      #assignInMyNamespace(".cGroupsGUIEnv", NULL)    
        
      call <- match.call()
      if (!missing(X)){
         if (!is.matrix(X) & !is.data.frame(X))  stop("X must be a matrix or a data.frame")
         if (is.matrix(X))    x <- as.data.frame(X)
         if (is.data.frame(X))    x <- X
         datatemp.name <- as.character(call)[2]
      } else {
         stop("Some data must be provided: for example 'regicor' data after being loaded using data(regicor).")
      }
      assign(".p.mult","0", envir = .cGroupsGUIEnv)                 
      assign(".p.trend","0", envir = .cGroupsGUIEnv)              
      assign(".show.all","1", envir = .cGroupsGUIEnv) 
      assign(".show.n","1", envir = .cGroupsGUIEnv)              
      assign(".type.cat.value","nperc", envir = .cGroupsGUIEnv) 
      assign(datatemp.name, x, envir = .cGroupsGUIEnv)
      matrix.info <- data.frame(c(NA,NA))
      matrix.info[,1:7] <- NA
      names(matrix.info) <- c("name","type","digits","hide","subset.all","subset.part","label")
      matrix.info[,2] <- 0
      for (i in 1:ncol(x)){
         if (is.null(attr(x[,names(x)[i]],"label",exact=TRUE)))
           attr(x[,names(x)[i]],"label") <- names(x)[i]
         matrix.info[i,1] <- names(x)[i]
         if(is.factor(x[,i])) matrix.info[i,2] <- 3
         if(is.character(x[,i])) matrix.info[i,2] <- 3
         if(is.numeric(x[,i])) matrix.info[i,2] <- 1
         if(inherits(x[,i], "Surv")) matrix.info[i,2] <- 0
         if(length(unique(x[,i]))<6)  matrix.info[i,2] <- 3
         if(is.na(matrix.info[i,2])) matrix.info[i,2] <- 1
         matrix.info[i,7] <- attr(x[,names(x)[i]],"label",exact=TRUE)
      }
      matrix.info[,3] <- 1
      matrix.info[,4] <- 0
      matrix.info <- matrix.info[matrix.info$type!=0,]
      matrix.info$subset.part <- ""
      matrix.info$subset.all <- ""
      matrix.info$type[matrix.info$type==1] <- "Normal"
      matrix.info$type[matrix.info$type==2] <- "Non-Normal"
      matrix.info$type[matrix.info$type==3] <- "Categorical"
      matrix.info$type[matrix.info$type==4] <- "Survival"
      matrix.info$hide <- "No"
      read.list <- function(){
         sel1 <- cbind(as.character(tcltk::tkget(report.list,0,"end")))
         mat <- data.frame(NA,NA)
         mat[,1:6] <- NA
         names(mat) <- c("names","type","digits","hide","subs","label")
         for (i in 1:length(sel1)){
             size <- length(strsplit(sel1," ")[[i]])
             sel2 <- strsplit(sel1," ")
             nam <- sel2[[i]][1]
             typ <- sel2[[i]][2]
             dig <- sel2[[i]][3]
             hid <- sel2[[i]][4]
             tmp <- grep("{",sel2[[i]],fixed=TRUE)
             tmp2 <- grep("}",sel2[[i]],fixed=TRUE)
             if(length(tmp)==0){
                 subs <- sel2[[i]][5]
                 labl <- sel2[[i]][6]
             }
             if(length(tmp)==1){
                 if(length(grep("{",sel2[[i]][5],fixed=TRUE))==1){
                      subs <-  paste(sel2[[i]][tmp[1]:tmp2[1]], collapse=" ")
                      subs <- substring(subs,2,nchar(subs)-1)
                      labl <- sel2[[i]][size]
                  }
                  if(length(grep("{",sel2[[i]][6],fixed=TRUE))==1){
                      labl <- paste(sel2[[i]][tmp[1]:tmp2[1]], collapse=" ")
                      labl <- substring(labl,2,nchar(labl)-1)
                      subs <- sel2[[i]][5]
                  }
              }
              if (length(tmp)==2){
                  if (tmp[1]==tmp2[1]) subs <- ""
                  if (tmp[1]!=tmp2[1]){
                      subs <-  paste(sel2[[i]][tmp[1]:tmp2[1]], collapse=" ")
                      subs <- substring(subs,2,nchar(subs)-1)
                  }
                  if (tmp[2]==tmp2[2]) labl <- ""
                  if (tmp[2]!=tmp2[2]){
                        labl <-  paste(sel2[[i]][tmp[2]:tmp2[2]], collapse=" ")
                        labl <- substring(labl,2,nchar(labl)-1)
                  }
              }
              mat[i,] <- c(nam, typ, dig, hid,subs, labl)
            }
         return(mat)
      }
      fam <- "comic"
      size <- 10
      fontype <- tcltk::tkfont.create(family=fam,size=size)
      tt <- tcltk::tktoplevel()
      tcltk::tktitle(tt) <- paste("Compare Groups : ",datatemp.name,sep="")
      tcltk::tkwm.resizable(tt,0,0)
      topframe <- tcltk::tkframe(tt)
      tcltk::tkgrid(topframe, column=0, row=0, sticky="nwes", ipadx=3,ipady=3,padx=12,pady=20)
      
      frame1 <- tcltk::tkwidget(topframe, "labelframe", text ="Variables", fg="blue",padx=10,pady=10, font=fontype)
      var.scr  <- tcltk::tkscrollbar(frame1, repeatinterval=5,command=function(...)tcltk::tkyview(tlist.var,...))
      tlist.var <- tcltk::tklistbox(frame1,height=5,selectmode="extended", yscrollcommand=function(...)tcltk::tkset(var.scr,...),
                    background="white",exportselection=FALSE, height =22, width =10, font=fontype)
      for (i in 1:nrow(matrix.info)){
          tcltk::tkinsert(tlist.var,"end",matrix.info[i,1])
      }
      tcltk::tkbind(tlist.var)
      tcltk::tkgrid(tlist.var,var.scr)
      tcltk::tkgrid.configure(var.scr,sticky="nsw")
      tcltk::tkgrid(frame1, padx=5,pady=5, row=0, column=0,rowspan=16,columnspan=1,sticky="ns")
      tcltk2::tk2tip(tlist.var,"List of variables in data frame")
      frame2 <- tcltk::tkwidget(topframe, "labelframe", text ="Factor to report", fg="blue", font=fontype)
      disable1 <- function(){
        tcltk2::tk2state.set(tlist.factor.selection, state='disabled')
        tcltk2::tk2state.set(tlist.timeto.selection, state='disabled')
        tcltk2::tk2state.set(tlist.status.selection, state='disabled')
        tcltk2::tk2state.set(entry4, state='disabled')
        tcltk2::tk2state.set(entry.factor, state='disabled')
        tcltk2::tk2state.set(select.timeto1, state='disabled')
        tcltk2::tk2state.set(select.status1, state='disabled')
        tcltk2::tk2state.set(select.factor1, state='disabled')
     }
    disable2 <- function(){
      tcltk2::tk2state.set(tlist.factor.selection, state='normal')
      tcltk2::tk2state.set(entry.factor, state='readonly')
      tcltk2::tk2state.set(tlist.timeto.selection, state='disabled')
      tcltk2::tk2state.set(tlist.status.selection, state='disabled')
      tcltk2::tk2state.set(entry4, state='disabled')
      tcltk2::tk2state.set(select.timeto1, state='disabled')
      tcltk2::tk2state.set(select.status1, state='disabled')
      tcltk2::tk2state.set(select.factor1, state='normal')
    }  
    disable3 <- function(){
      tcltk2::tk2state.set(tlist.factor.selection, state='disabled')
      tcltk2::tk2state.set(entry.factor, state='disabled')
      tcltk2::tk2state.set(tlist.timeto.selection, state='normal')
      tcltk2::tk2state.set(tlist.status.selection, state='normal')
      tcltk2::tk2state.set(entry4, state='readonly')
      tcltk2::tk2state.set(select.timeto1, state='normal')
      tcltk2::tk2state.set(select.status1, state='normal')
      tcltk2::tk2state.set(select.factor1, state='disabled')
    }
    type.var1 <- tcltk::tkradiobutton(frame2)
    type.var2 <- tcltk::tkradiobutton(frame2)
    type.var3 <- tcltk::tkradiobutton(frame2)
    type.var.valuex <-  tcltk::tclVar("none")
    tcltk::tkconfigure(type.var1, variable = type.var.valuex, value = "none", command = disable1)
    tcltk::tkconfigure(type.var2, variable = type.var.valuex, value = "factor", command = disable2)
    tcltk::tkconfigure(type.var3, variable = type.var.valuex, value = "surv", command = disable3)
    tcltk::tkgrid(type.var1, tcltk::tklabel(frame2,text="None", font=fontype), sticky="w")
    tcltk::tkgrid(type.var2, tcltk::tklabel(frame2,text="Factor", font=fontype), sticky="w")
      select.factor <- function(){
           var.name <- as.numeric(tcltk::tkcurselection(tlist.var))
           if(length(var.name)==0) return(tcltk::tkmessageBox(message = "No factor selected", icon = "info", type="ok"))
           if(length(var.name)==1){
                if(matrix.info[var.name+1,]$type!="Categorical")  tcltk::tkmessageBox(message = "Only for categorical variables", icon = "info", type="ok")
                if(matrix.info[var.name+1,]$type=="Categorical"){
                     tcltk::tkdelete(tlist.factor.selection,0,"end")
                     tcltk::tkinsert(tlist.factor.selection,"active",matrix.info[var.name+1,]$name)
                     if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
                       tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]
                     else
                       tmp.data <- x
                     tmp.data <- factor(tmp.data[,var.name+1])
                     if(length(levels(tmp.data))==2) tcltk::tkconfigure(entry.factor,value= levels(tmp.data), textvariable=levels(tmp.data)[1])
                     if(length(levels(tmp.data))!=2) tcltk::tkconfigure(entry.factor,value= "--", textvariable="--")
                     
                }
           }
           if(length(var.name)>1){
                 tcltk::tkmessageBox(message = "Select only one categorical variable", icon = "info", type="ok")
           }
      }
    tlist.factor.selection <- tcltk::tklistbox(frame2, height=1, width=18, selectmode="single",background= "white", exportselection=FALSE,state='normal', font=fontype)
    select.factor1 <- tcltk::tkbutton(frame2,text="u",command = select.factor ,height=1, width=2, font="{Wingdings 3} {8}" )
    tcltk::tkgrid(select.factor1,column=2, padx=5,pady=5,sticky="e")
    tcltk::tkgrid(tlist.factor.selection,column=3,row=2,padx=5,pady=5,sticky="w")
    entry.factor <- tcltk::ttkcombobox(frame2)
    tcltk::tkconfigure(entry.factor,value=c(" "),state="readonly",text=" ")
    tcltk::tkgrid(entry.factor,column=5,row=2,padx=5,pady=5,sticky="w", columnspan=4)
    tcltk::tkgrid(tcltk::tklabel(frame2,text="Reference", font=fontype),column=5,row=1)
    tcltk::tkgrid(tcltk::tklabel(frame2,text="Variable", font=fontype),column=3,row=1)
    tcltk::tkgrid(type.var3, tcltk::tklabel(frame2,text="Survival", font=fontype), sticky="w")
    select.timeto <- function(){
           var.name <- as.numeric(tcltk::tkcurselection(tlist.var))
           if(length(var.name)==0) return(tcltk::tkmessageBox(message = "No 'time to' selected", icon = "info", type="ok"))
           if(length(var.name)==1){
                if(matrix.info[var.name+1,]$type=="Categorical")  tcltk::tkmessageBox(message = "Only for numerical variables", icon = "info", type="ok")
                if(matrix.info[var.name+1,]$type!="Categorical"){
                     tcltk::tkdelete(tlist.timeto.selection,0,"end")
                     tcltk::tkinsert(tlist.timeto.selection,"active",matrix.info[var.name+1,]$name)
                }
           }
           if(length(var.name)>1){
                 tcltk::tkmessageBox(message = "Select only one numerical variable", icon = "info", type="ok")
           }
      }
      
    select.status <- function(){
           var.name <- as.numeric(tcltk::tkcurselection(tlist.var))
           if(length(var.name)==0) return(tcltk::tkmessageBox(message = "No 'status' selected", icon = "info", type="ok"))
           if(length(var.name)==1){
                if(matrix.info[var.name+1,]$type!="Categorical")  tcltk::tkmessageBox(message = "Only for categorical variables", icon = "info", type="ok")
                if(matrix.info[var.name+1,]$type=="Categorical"){
                     tcltk::tkdelete(tlist.status.selection,0,"end")
                     tcltk::tkinsert(tlist.status.selection,"active",matrix.info[var.name+1,]$name)
                     if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
                       tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]                    
                     else
                       tmp.data <- x
                     tmp.data <- factor(tmp.data[,var.name+1])
                     tcltk::tkconfigure(entry4,value= levels(tmp.data), textvariable=levels(tmp.data)[1])
                }
           }
           if(length(var.name)>1){
                 tcltk::tkmessageBox(message = "Select only one categorical variable", icon = "info", type="ok")
           }
    } 
    tlist.timeto.selection <- tcltk::tklistbox(frame2, height=1, width=18, selectmode="single",background= "white", exportselection=FALSE,state='normal', font=fontype)
    select.timeto1 <- tcltk::tkbutton(frame2,text="u",command = select.timeto ,height=1, width=2, font="{Wingdings 3} {8}" )
    tcltk::tkgrid(select.timeto1,column=2,padx=5,pady=5,sticky="e")
    tcltk::tkgrid(tlist.timeto.selection,column=3,row=4,padx=5,pady=5,sticky="w")
    tlist.status.selection <- tcltk::tklistbox(frame2, height=1, width=18, selectmode="single",background= "white", exportselection=FALSE,state='normal', font=fontype)
    select.status1 <- tcltk::tkbutton(frame2,text="u",command = select.status ,height=1, width=2, font="{Wingdings 3} {8}" )
    tcltk::tkgrid(select.status1,column=4,row=4, padx=5,pady=5,sticky="e")
    tcltk::tkgrid(tlist.status.selection,column=5,row=4,padx=5,pady=5,sticky="w")
    tcltk::tkgrid(tcltk::tklabel(frame2,text="--"),column=6,row=4, padx=5,pady=5,sticky="e")
    entry4 <- tcltk::ttkcombobox(frame2)
    tcltk::tkconfigure(entry4,value=c(" "),state="readonly",text=" ")
    tcltk::tkgrid(entry4,column=7,row=4,padx=5,pady=5,sticky="w")
    tcltk::tkgrid(tcltk::tklabel(frame2,text="Time to event", font=fontype),column=3,row=3)
    tcltk::tkgrid(tcltk::tklabel(frame2,text="Status", font=fontype),column=5,row=3)
    tcltk::tkgrid(tcltk::tklabel(frame2,text="Event", font=fontype),column=7,row=3)
    plots.factor <- function(){
          var.name <- as.character(tcltk::tkget(tlist.factor.selection,0,"end"))
          if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No factor selected", icon = "info", type="ok"))
          if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
            tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]  
          else
            tmp.data <- x
          tmp.data <- factor(tmp.data[,var.name])
          coor <- barplot(table(tmp.data) ,main=paste("Plot of",var.name,sep=" "),xlab="", beside=FALSE)
          percent <- paste(round(prop.table(table(tmp.data))*100),"%",sep="")
          text(coor,mean(table(tmp.data))/2,percent)
      }   
    plots.factor.uni <- function(){
          var.name <- as.character(tcltk::tkget(tlist.timeto.selection,0,"end"))
          if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No 'time to' selected", icon = "info", type="ok"))
          var.name2 <- as.character(tcltk::tkget(tlist.status.selection,0,"end"))
          if( length(var.name2)==0) return(tcltk::tkmessageBox(message = "No 'status' selected", icon = "info", type="ok"))
          event <- as.character(tcltk::tkget(entry4))
          if( length(event)==0) return(tcltk::tkmessageBox(message = "No 'event' selected", icon = "info", type="ok"))
          if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
            tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]  
          else
            tmp.data <- x       
          timeto <- tmp.data[,var.name]
          eventto <- as.integer(tmp.data[, var.name2]==event)
          variableF <- Surv(timeto, eventto)
          KM.plot(x = variableF, file = NULL, var.label.x = attr(x[, var.name2],"label",exact=TRUE))
    }  
    plot.uni.surv <- function(){
      if (tcltk::tclvalue(type.var.valuex)=='none') return()
      if (tcltk::tclvalue(type.var.valuex)=='factor')  plots.factor()
      if (tcltk::tclvalue(type.var.valuex)=='surv')  plots.factor.uni()
    } 
    factor.plot <- tcltk::tkbutton(frame2,text="Plot",command = plot.uni.surv ,height=1, width=10, font=fontype)
    tcltk::tkgrid(factor.plot,row=2,column=8,padx=5,pady=5)
    tcltk::tkgrid(frame2,column=3,columnspan=5, rowspan=6, row=0,padx=5,pady=5,sticky="nw")
    tcltk2::tk2state.set(tlist.factor.selection, state='disabled')
    tcltk2::tk2state.set(tlist.timeto.selection, state='disabled')
    tcltk2::tk2state.set(tlist.status.selection, state='disabled')
    tcltk2::tk2state.set(entry4, state='disabled')
    tcltk2::tk2state.set(entry.factor, state='disabled')
    tcltk2::tk2state.set(select.timeto1, state='disabled')
    tcltk2::tk2state.set(select.status1, state='disabled')
    tcltk2::tk2state.set(select.factor1, state='disabled')
    matrix.report <- matrix.info
      matrix.ini <- ""
      frame3 <- tcltk::tkwidget(topframe, "labelframe", text ="Variable to report", fg="blue",padx=5,pady=5, font=fontype)
      var.scry  <- tcltk::tkscrollbar(frame3, repeatinterval=5,command=function(...)tcltk::tkyview(report.list ,...))
      var.scrx  <- tcltk::tkscrollbar(frame3, orient="horizontal",command=function(...)tcltk::tkxview(report.list ,...))
      report.list <- tcltk2::tk2mclistbox(frame3, width = 85, height=10,resizablecolumns = TRUE,selectmode="extended",labelfont=paste("{",fam,"} {",size,"}",sep=""),
                                  yscrollcommand=function(...)tcltk::tkset(var.scry,...),
                                  xscrollcommand=function(...)tcltk::tkset(var.scrx,...))
      tcltk2::tk2column(report.list , "add", "var", label = "Name", width = 25, font=fontype)
      tcltk2::tk2column(report.list , "add", "type",label = "Type", width = 13, font=fontype)
      tcltk2::tk2column(report.list , "add", "dig", label = "Digits", width = 13, font=fontype)
      tcltk2::tk2column(report.list , "add", "hid", label = "Hide (Ref.)", width = 13, font=fontype)
      tcltk2::tk2column(report.list , "add", "sub", label = "Subset", width = 20, font=fontype)
      tcltk2::tk2column(report.list , "add", "lab", label = "Label", width = 100, font=fontype)
      tcltk::tkgrid(report.list,var.scry)
      tcltk::tkgrid(report.list,var.scrx)
      tcltk::tkgrid.configure(var.scry,sticky="nse")
      tcltk::tkgrid.configure(var.scrx,sticky="sew")
      tcltk::tkgrid(frame3,column=3,columnspan=8, rowspan=9, row=7,padx=5,pady=5,sticky="new")
    insert.var <- function(){
          var.name <- as.numeric(tcltk::tkcurselection(tlist.var))
          if(length(var.name)==0) tcltk::tkmessageBox(message = "No variable selected", icon = "info", type="ok")
          if(length(var.name)>0) tcltk2::tk2insert.multi(report.list , "end", matrix.info[var.name+1,c("name","type","digits","hide","subset.part","label")])
      }
    exclude.var <- function(){
          var.name <- as.numeric(tcltk::tkcurselection(report.list))
          if(length(var.name)==0) tcltk::tkmessageBox(message = "No variable selected", icon = "info", type="ok")
          if(length(var.name)>0){
                  tcltk::tkselection.clear(tlist.var,0,"end")
                  sel1 <- cbind(as.character(tcltk::tkget(report.list,0,"end")))
                  sel2 <- strsplit(sel1," ")
                  lvar <- as.character()
                  for(i in 1:nrow(sel1)){
                     lvar[i] <- sel2[[i]][1]
                  }
                  sel3 <- as.numeric(tcltk::tkcurselection(report.list))+1
                  lvar <- lvar[sel3]
                  for (i in 1:length(var.name)){
                      lvar[i] <- as.numeric(rownames(matrix.info[matrix.info$name%in%lvar[i],]))
                  }
                  lvar <- as.numeric(lvar)
                  for(i in 1:length(var.name)){
                     tcltk::tkselection.set(tlist.var,lvar[i]-1)
                     tcltk::tkdelete(report.list , as.numeric(tcltk::tkcurselection(report.list))[1])
                  }
          }
      }
      select.report.var <- tcltk::tkbutton(topframe,text="u",command = insert.var,height=1, width=2, font="{Wingdings 3} {8}" )
      tcltk::tkbind(report.list , select.report.var)
      tcltk::tkgrid(select.report.var,column=2,row=11,padx=5,padx=10,sticky="s")
      exclude.report.var <- tcltk::tkbutton(topframe,text="t",command =exclude.var,height=1, width=2, font="{Wingdings 3} {8}" )
      tcltk::tkbind(report.list , select.report.var)
      tcltk::tkgrid(exclude.report.var,column=2,row=12,padx=5,padx=10,sticky="n")
      frame4 <- tcltk::tkwidget(topframe, "labelframe", text ="Global subset", fg="blue",padx=5,pady=5, font=fontype)
      subset.glob <- tcltk::tclVar("")
      subset.glob.sel <- tcltk::tclvalue(subset.glob)
      text.subset.glob <- tcltk::tkentry(frame4, width= 30, textvariable = subset.glob, font=fontype)
      tcltk::tkbind(text.subset.glob)
      assign(".global.subset.selection","", envir = .cGroupsGUIEnv)
      send.subset.glob <- function(){
          subset.select <- tcltk::tclvalue(subset.glob)
          print(subset.select)
          if (subset.select!="")
            subset.dataframe <- try(x[eval(parse(text=paste("with(x,",subset.select,")",sep=""))),], silent=TRUE)
          else
            subset.dataframe <- x          
          if(inherits(subset.dataframe, "try-error"))
                  return(tcltk::tkmessageBox(message = "Syntax error. Try again", icon = "info", type = "ok"))
          if(nrow(subset.dataframe)==0)
                  return(tcltk::tkmessageBox(message = paste("0 people will be analyzed. No applying subset"), icon = "info", type = "ok"))
          if(nrow(subset.dataframe)>0){
                   assign(".global.subset.selection", subset.select, envir = .cGroupsGUIEnv)
                   return(tcltk::tkmessageBox(message = paste("Correct syntax. Subset applied to dataframe"), icon = "info", type = "ok"))
          }
      }
      tcltk::tkgrid.configure(text.subset.glob)
      tcltk::tkbind(send.subset.glob)
      subset.but.glob <-tcltk::tkbutton(frame4,text="Apply subset",command=send.subset.glob, width=15, font=fontype)
      tcltk::tkbind(subset.but.glob, "<Return>",send.subset.glob)
      tcltk::tkgrid(frame4,column=3,columnspan=4, rowspan=2, row=17,padx=5,pady=5,sticky="w")
      tcltk::tkgrid(subset.but.glob, column=9,columnspan=3, row=0,rowspan=2,sticky="e")
      tcltk2::tk2tip(frame4, "Subset for dataframe")
      frame5 <- tcltk::tkwidget(topframe, "labelframe", text ="'Variable' subset", fg="blue",padx=5,pady=5, font=fontype)
      subset.part <- tcltk::tclVar("")
      subset.part.sel <- tcltk::tclvalue(subset.part)
      text.subset.part <- tcltk::tkentry(frame5, width= 30,textvariable = subset.part, font=fontype)
      tcltk::tkbind(text.subset.part)
      send.subset.part <- function(){
          var.name <- (as.numeric(tcltk::tkcurselection(report.list)))+1
          if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No variable selected", icon = "info", type="ok"))
          subset.select <- tcltk::tclvalue(subset.part)
          print(subset.select)
          if (subset.select!="")
            subset.dataframe <- try(x[eval(parse(text=paste("with(x,",subset.select,")",sep=""))),], silent=TRUE)
          else
            subset.dataframe <- x
          if(inherits(subset.dataframe, "try-error"))
                  return(tcltk::tkmessageBox(message = "Syntax error. Try again", icon = "info", type = "ok"))
          if(nrow(subset.dataframe)==0)
                  return(tcltk::tkmessageBox(message = paste("0 people will be analyzed. No applying subset"), icon = "info", type = "ok"))
          if(nrow(subset.dataframe)>0){
                  new.mat <- read.list()
                  new.mat[var.name,5] <- subset.select
                  tcltk::tkdelete(report.list,0,"end")
                  tcltk2::tk2insert.multi(report.list , "end", new.mat)
                  for(i in 1:length(var.name)){
                        tcltk::tkselection.set(report.list,(var.name[i]-1))
                  }
                  return(tcltk::tkmessageBox(message = paste("Correct syntax"), icon = "info", type = "ok"))
          }
      }
      tcltk::tkgrid.configure(text.subset.part)
      tcltk::tkbind(send.subset.part)
      subset.but.part <-tcltk::tkbutton(frame5,text="Apply subset",command=send.subset.part, width=15, font=fontype)
      tcltk::tkbind(subset.but.part, "<Return>",send.subset.part)
      tcltk::tkgrid(frame5,column=5,columnspan=3, rowspan=2, row=17,padx=5,pady=5,sticky="e")
      tcltk::tkgrid(subset.but.part,column=5,columnspan=3,row=0,rowspan=2)
      tcltk2::tk2tip(frame5, "Subset for a selected report variable")
      frame6 <- tcltk::tkwidget(topframe, "labelframe", text ="Method", fg="blue",padx=5,pady=5, font=fontype)
      type.var.function <- function(){
          var.name <- (as.numeric(tcltk::tkcurselection(report.list)))+1
          if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No variable selected", icon = "info", type="ok"))
          sw.selection <- as.numeric(as.character(tcltk::tclvalue(swtest)))
          new.mat <- read.list()
          type.var.val <- as.character(tcltk::tclvalue(type.var.value))
          total <- as.integer(sum(as.integer(matrix.info[matrix.info$name%in%new.mat[var.name,1],2]%in%'Categorical'))==length(var.name))
          total2 <- sum(as.integer(matrix.info[matrix.info$name%in%new.mat[var.name,1],2]%in%'Categorical'))
          if(total==1){
                 if(type.var.val!="cat") return(tcltk::tkmessageBox(message = "Only for  numerical variables", icon = "info", type="ok"))
          }
          if(total==0){
                 if (total2>=1)  tcltk::tkmessageBox(message = "Applied changes in original non factor class", icon = "info", type="ok")
                 for (i in 1:length(var.name)){
                      if(!matrix.info[matrix.info$name==new.mat[var.name[i],1],2]%in%c('Categorical','Survival')){
                          if(type.var.val=="cat") new.mat[var.name[i],2] <- "Categorical"
                          if(type.var.val=="non.param") new.mat[var.name[i],2] <- "Non-Normal"
                          if(type.var.val=="yes.param") new.mat[var.name[i],2] <- "Normal"
                          if(type.var.val=="test.param"){
                             tmp <- ifelse(is.na(new.mat[var.name[i],5]),"",new.mat[var.name[i],5])
                             if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
                               tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]  
                             else
                               tmp.data <- x
                             if (tmp!="")
                               tmp.data <- tmp.data[eval(parse(text=paste("with(tmp.data,",tmp,")",sep=""))),]
                             if (length(unique(tmp.data[,new.mat[var.name[i],1]]))<6){
                                    tcltk::tkmessageBox(message = paste("Less than 6 different values for '",new.mat[var.name[i],1],"'",". Not performs S-W test",sep=""), icon = "info", type = "ok")
                                   new.mat[var.name[i],2] <- "Categorical"
                                } else{
                                    if(length(tmp.data[,new.mat[var.name[i],1]])>5000) return(tcltk::tkmessageBox(message = "Error in shapiro.test: sample size must be between 3 and 5000", icon = "info", type="ok"))
                                    SW <- shapiro.test(tmp.data[,new.mat[var.name[i],1]])$p.value
                                    if (SW<sw.selection)   new.mat[var.name[i],2] <- "Non-Normal"
                                    if (SW>=sw.selection)   new.mat[var.name[i],2] <- "Normal"
                                  }
                          }
                      }
                 }
          }
          tcltk::tkdelete(report.list,0,"end")
          tcltk2::tk2insert.multi(report.list , "end", new.mat)
          for(i in 1:length(var.name)){
             if(matrix.info[matrix.info$name==new.mat[var.name[i],1],2]!='Categorical') tcltk::tkselection.set(report.list,(var.name[i]-1))
          }
      }
      type.var1 <- tcltk::tkradiobutton(frame6)
      type.var2 <- tcltk::tkradiobutton(frame6)
      type.var3 <- tcltk::tkradiobutton(frame6)
      type.var4 <- tcltk::tkradiobutton(frame6)
      type.var.value <-  tcltk::tclVar("test.param")
      tcltk::tkconfigure(type.var1, variable = type.var.value, value = "cat", command = type.var.function)
      tcltk::tkconfigure(type.var2, variable = type.var.value, value = "non.param", command = type.var.function)
      tcltk::tkconfigure(type.var3, variable = type.var.value, value = "yes.param", command = type.var.function)
      tcltk::tkconfigure(type.var4, variable = type.var.value, value = "test.param", command = type.var.function)
      tcltk::tkgrid(tcltk::tklabel(frame6,text="Categorical", font=fontype),type.var1)
      tcltk::tkgrid(tcltk::tklabel(frame6,text="Non Normal", font=fontype),type.var2)
      tcltk::tkgrid(tcltk::tklabel(frame6,text="Normal", font=fontype),type.var3)
      tcltk::tkgrid(tcltk::tklabel(frame6,text="Test (S-W)", font=fontype),type.var4)
      swtest <- tcltk::tclVar("0.05")
      tspin <- tcltk2::tk2spinbox(frame6, from = 0, to = 1, increment = 0.01,state="readonly", width=4,readonlybackground="white",textvariable=swtest,font="-size 8")
      tcltk::tkgrid(tspin,row=4,column=0,sticky="w")
      
      tcltk::tkgrid(tcltk::tklabel(frame6,text="\U03B1 level",font="-size 8"),row=4,column=0,sticky="e")
      
      tcltk2::tk2tip(tspin, "Significance level for Shapiro-Wilks test")
      tcltk2::tk2tip(frame6, "Select method for analyze each variable")
      tcltk::tkgrid(frame6,column=12, rowspan=6, row=0,padx=5,pady=5,sticky="n")
      frame8 <- tcltk::tkwidget(topframe, "labelframe", text ="Plots", fg="blue",padx=5,pady=5,font=fontype)
      plots.uni <- function(){
          var.name <- (as.numeric(tcltk::tkcurselection(report.list)))+1
         	if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No variable selected", icon = "info", type="ok"))
         	if(length(var.name)>1)  return(tcltk::tkmessageBox(message = "Select only one variable", icon = "info", type="ok"))
          mat <- read.list()
          variable <- mat[var.name,]
          tmp <- ifelse(is.na(variable[5]),"",variable[5])[[1]]
          if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
            tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]  
          else
            tmp.data <- x
          if (tmp!="")  
            tmp.data <- tmp.data[eval(parse(text=paste("with(tmp.data,",tmp,")",sep=""))),]
          if(variable[,2]=='Categorical'){
            tmp.data <- factor(tmp.data[,as.character(variable[1])])
            coor <- barplot(table(tmp.data) ,main=paste("Plot of",as.character(variable[1]),sep=" "),xlab="", beside=FALSE)
            percent <- paste(round(prop.table(table(tmp.data))*100),"%",sep="")
            text(coor,mean(table(tmp.data))/2,percent)
          }
          if(variable[,2]%in%c('Normal', 'Non-Normal')){
            tmp.data <- tmp.data[,as.character(variable[1])]
            norm.plot(x=tmp.data, file=NULL,var.label.x = as.character(variable[1]), z=1.5,n.breaks="Sturges")
          }
          if(variable[,2]=='Survival'){
            tmp.data <- tmp.data[,as.character(variable[1])]
            KM.plot(x = tmp.data, file = NULL, var.label.x = as.character(variable[1]))
          }
      }
      plots.bi <- function(){
          if (tcltk::tclvalue(type.var.valuex)=='factor'){
            var.name <- (as.numeric(tcltk::tkcurselection(report.list)))+1
            var.plot <- as.character(tcltk::tkget(tlist.factor.selection,0,"end"))
           	if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No variable selected", icon = "info", type="ok"))
           	if(length(var.name)>1)  return(tcltk::tkmessageBox(message = "Select only one variable", icon = "info", type="ok"))
         	  if( length(var.plot)==0) return(tcltk::tkmessageBox(message = "No factor selected", icon = "info", type="ok"))
            mat <- read.list()
            variable <- mat[var.name,]
            tmp <- ifelse(is.na(variable[5]),"",variable[5])[[1]]
            if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
              tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]  
            else
              tmp.data <- x
            if (tmp!="")
              tmp.data <- tmp.data[eval(parse(text=paste("with(tmp.data,",tmp,")",sep=""))),]
            if(variable[,2]=='Categorical'){
              at <- table(factor(tmp.data[,as.character(variable[1])]), factor(tmp.data[,var.plot]))
              barplot(at, beside=TRUE, main = paste("Barplot of",as.character(variable[1]),"by",var.plot, sep=" "),
              legend.text=TRUE,col=rainbow(nrow(at)),args.legend = list(bg = "white"))
            }
            if(!variable[,2]%in%c('Categorical','Survival')){
              boxplot(tmp.data[,as.character(variable[1])] ~ factor(tmp.data[,var.plot]),
              main = paste("Boxplot of",as.character(variable[1]),"by",var.plot, sep=" "), ylab=as.character(variable[1]), xlab=var.plot,
              col="bisque")
            }
          }
          if(tcltk::tclvalue(type.var.valuex)=='surv'){
            var.name <- as.character(tcltk::tkget(tlist.timeto.selection,0,"end"))
            if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No 'time to' selected", icon = "info", type="ok"))
            var.name2 <- as.character(tcltk::tkget(tlist.status.selection,0,"end"))
            if( length(var.name2)==0) return(tcltk::tkmessageBox(message = "No 'status' selected", icon = "info", type="ok"))
            event <- as.character(tcltk::tkget(entry4))
            if( length(event)==0) return(tcltk::tkmessageBox(message = "No 'event' selected", icon = "info", type="ok"))
          
            var.report <- (as.numeric(tcltk::tkcurselection(report.list)))+1
            if( length(var.report)==0) return(tcltk::tkmessageBox(message = "No variable selected", icon = "info", type="ok"))
           	if(length(var.report)>1)  return(tcltk::tkmessageBox(message = "Select only one variable", icon = "info", type="ok"))
            mat <- read.list()
            variable <- mat[var.report,]
            tmp <- ifelse(is.na(variable[5]),"",variable[5])[[1]]
            if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
              tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]  
            else
              tmp.data <- x
            if (tmp!="")
              tmp.data <- tmp.data[eval(parse(text=paste("with(tmp.data,",tmp,")",sep=""))),]
            timeto <- tmp.data[,var.name]
            eventto <- as.integer(tmp.data[, var.name2]==event)
            variableF <- Surv(timeto, eventto)
            if(variable[,2]=='Categorical'){ 
              KMg.plot(x = tmp.data[,as.character(variable[1])], y= variableF, file=NULL, var.label.x=attr(x[,as.character(variable[1])],"label",exact=TRUE), var.label.y = attr(x[,var.name2],"label",exact=TRUE))
            }
            if(variable[,2]%in%c('Normal','Non-Normal')){
              Cox.plot(x = tmp.data[,as.character(variable[1])], y= variableF, file=NULL, var.label.x=attr(x[,as.character(variable[1])],"label",exact=TRUE), var.label.y = attr(x[,var.name2],"label",exact=TRUE))
            }
         }
      }
      uni.plot <- tcltk::tkbutton(frame8,text="Univariate",command = plots.uni,height=1, width=10, font=fontype)
      bi.plot <- tcltk::tkbutton(frame8,text="Bivariate",command = plots.bi, height=1, width=10, font=fontype)
      tcltk::tkbind(uni.plot, plots.uni)
      tcltk::tkbind(bi.plot, plots.bi)
      tcltk::tkgrid(uni.plot)
      tcltk::tkgrid(bi.plot)
      tcltk::tkgrid(frame8,column=12, row=7, rowspan=3, padx=5,pady=5,sticky="n")
      tcltk2::tk2tip(frame8, "Plot the selected variable/s") 
      frame7 <- tcltk::tkwidget(topframe, "labelframe", text ="Decimals digits", fg="blue",padx=5,pady=5, font=fontype)
      decimals.function <- function(){
          var.name <- (as.numeric(tcltk::tkcurselection(report.list)))+1
         	if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No variable selected", icon = "info", type="ok"))
          dec.select <- tcltk::tclvalue(dec.value)
          new.mat <- read.list()
          if(dec.select=='defdec') new.mat[var.name,3] <- "Default"
          if(dec.select=='1dec') new.mat[var.name,3] <- "1"
          if(dec.select=='2dec') new.mat[var.name,3] <- "2"
          if(dec.select=='3dec') new.mat[var.name,3] <- "3"
          tcltk::tkdelete(report.list,0,"end")
          tcltk2::tk2insert.multi(report.list , "end", new.mat)
          for(i in 1:length(var.name)){
              tcltk::tkselection.set(report.list,(var.name[i]-1))
          }
      }
      dec1 <- tcltk::tkradiobutton(frame7)
      dec2 <- tcltk::tkradiobutton(frame7)
      dec3 <- tcltk::tkradiobutton(frame7)
      dec4 <- tcltk::tkradiobutton(frame7)
      dec.value <- tcltk::tclVar("defdec")
      tcltk::tkconfigure(dec1, variable = dec.value, value = "1dec", command = decimals.function)
      tcltk::tkconfigure(dec2, variable = dec.value, value = "2dec", command = decimals.function)
      tcltk::tkconfigure(dec3, variable = dec.value, value = "3dec", command = decimals.function)
      tcltk::tkconfigure(dec4, variable = dec.value, value = "defdec", command = decimals.function)
      tcltk::tkgrid(tcltk::tklabel(frame7,text="1 dec", font=fontype),dec1)
      tcltk::tkgrid(tcltk::tklabel(frame7,text="2 dec", font=fontype),dec2)
      tcltk::tkgrid(tcltk::tklabel(frame7,text="3 dec", font=fontype),dec3)
      tcltk::tkgrid(tcltk::tklabel(frame7,text="Default dec", font=fontype),dec4)
      tcltk2::tk2tip(frame7, "Number of decimals in report")
      tcltk::tkgrid(frame7,column=12,row=10,padx=5,pady=5,sticky="n",rowspan=5)
      frame9 <- tcltk::tkwidget(topframe, "labelframe", text ="Hide (Ref.) category", fg="blue",padx=5,pady=5, font=fontype)
      hide.function <- function(){
              var.name <- (as.numeric(tcltk::tkcurselection(report.list)))+1
             	if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No variable selected", icon = "info", type="ok"))
             	hide.select <- tcltk::tclvalue(hide.value)
              new.mat <- read.list()
              res <- sum(as.integer(new.mat[var.name,"type"]%in%'Categorical'))
              if (res==0) return(tcltk::tkmessageBox(message = "No 'Categorical' variable selected", icon = "info", type="ok"))
              if (length(var.name)>res) tcltk::tkmessageBox(message = "Applied changes in 'Categorical' variables", icon = "info", type="ok")
              var.name <- var.name[new.mat[var.name,"type"]%in%'Categorical']
              if(hide.select=='1cat') new.mat[var.name,"hide"] <- "First"
              if(hide.select=='2cat') new.mat[var.name,"hide"] <- "Last"
              if(hide.select=='nocat') new.mat[var.name,"hide"] <- "No"
              tcltk::tkdelete(report.list,0,"end")
              tcltk2::tk2insert.multi(report.list , "end", new.mat)
              for(i in 1:length(var.name)){
                  tcltk::tkselection.set(report.list,(var.name[i]-1))
              }
      }
      hide1 <- tcltk::tkradiobutton(frame9)
      hide2 <- tcltk::tkradiobutton(frame9)
      hide3 <- tcltk::tkradiobutton(frame9)
      hide.value <- tcltk::tclVar("nocat")
      tcltk::tkconfigure(hide1, variable = hide.value, value = "1cat", command = hide.function)
      tcltk::tkconfigure(hide2, variable = hide.value, value = "2cat", command = hide.function)
      tcltk::tkconfigure(hide3, variable = hide.value, value = "nocat", command = hide.function)
      tcltk::tkgrid(tcltk::tklabel(frame9,text="First", font=fontype),hide1)
      tcltk::tkgrid(tcltk::tklabel(frame9,text="Last", font=fontype),hide2)
      tcltk::tkgrid(tcltk::tklabel(frame9,text="No category", font=fontype),hide3)
      tcltk2::tk2tip(frame9, "Hide a category in categorical variable")
      tcltk::tkgrid(frame9,column=12,row=15,padx=5,pady=5,rowspan=4)  
      spssLoad <- function(){
              name <- tcltk::tclvalue(tcltk::tkgetOpenFile(parent = tt, title = "SPSS Data",filetypes = "{{SPSS Files} {.sav}}"))
              if (name=="") return(" ")
              if (length(name)>1)  stop(paste("More than one object in",name))
              # load.data <- try(spss.get(file = name))
              load.data <- try(haven::read_sav(file = name))
              if (inherits(load.data,"try-error")){
                  return("Problems loading .sav")
              } else{
                  cGroupsGUI(load.data)
                  tcltk::tkdestroy(tt)
                }
      }
      RWspace <- function(){
        all.ls <- ls(envir =.GlobalEnv)
        n <- length(all.ls)
        j <- 1
        num <- NULL
        for (i in 1:n){
            if (inherits(get(all.ls[i]),"data.frame")){
                num[j] <- i
                j <- j+1
            }
        }
        if (is.null(num)) return(tcltk::tkmessageBox(message = "No dataframes in workspace", icon = "info", type="ok"))
        names.data <- all.ls[num]
        special <- tcltk::tktoplevel(parent=topframe)
        tcltk::tktitle(special) <- "Dataframes in Workspace"
        pos <- as.character(tcltk::tkwm.geometry(tt))
        pos <- paste("+",paste(strsplit(pos,"+", fixed=TRUE)[[1]][2:3],collapse="+"),sep="")
        pos <- paste("238x195", pos, sep="")
        tcltk::tkwm.resizable(special,0,0)
        tcltk::tkwm.geometry(special,pos)
        tcltk::tkgrab(special)
        topspecial <- tcltk::tkframe(special)
        tcltk::tkfocus(special)
        tcltk::tkgrid(topspecial, column=0, row=0, sticky="nwes", ipadx=3,ipady=3,padx=20,pady=15)
        frame0 <- tcltk::tkwidget(topspecial, "labelframe", text ="", fg="blue",padx=10,pady=10)
        var.scr0  <- tcltk::tkscrollbar(frame0, repeatinterval=5,command=function(...)tcltk::tkyview(tlist.var0,...))
        tlist.var0 <- tcltk::tklistbox(frame0,height=5,selectmode="single", yscrollcommand=function(...)tcltk::tkset(var.scr0,...),
                    background="white",exportselection=FALSE, height =6, width =20, font=fontype)
        for (i in 1:length(num)){
             tcltk::tkinsert(tlist.var0,"end",names.data[i])
        }
        tcltk::tkbind(tlist.var0)
        tcltk::tkgrid(tlist.var0,var.scr0)
        tcltk::tkgrid.configure(var.scr0,sticky="nsw")
        tcltk::tkgrid(frame0, padx=5,pady=5)
        select.rdata <- function(){
             var.name <- (as.numeric(tcltk::tkcurselection(tlist.var0)))+1
            	if( length(var.name)==0){
                  tcltk::tkmessageBox(message = "No dataframe selected", icon = "info", type="ok")
                  return(tcltk::tkdestroy(special))
              }
              cGroupsGUI(get(names.data[var.name],envir=.GlobalEnv))
              tcltk::tkdestroy(tt)
        }
        cancel.rdata <- function(){
            tcltk::tkdestroy(special)
        }
        selection <- tcltk::tkbutton(frame0,text="Load",command = select.rdata, height=1, width=8,fg='blue', font=fontype)
        tcltk::tkgrid(selection,sticky="se",row=2)
        cancel <- tcltk::tkbutton(frame0,text="Cancel",command = cancel.rdata, height=1, width=8,fg='red', font=fontype)
        tcltk::tkgrid(cancel,sticky="sw",row=2)
      }
      RData <- function(){
              name <- tcltk::tclvalue(tcltk::tkgetOpenFile(parent = tt, title = "R Data",
                        filetypes = "{{Rdata Files} {.rdata .rda .Rdata .RData}}"))
              if (name=="") return(" ")
              if (length(name)>1)  stop(paste("More than one object in",name))
              load.data <- try(load(file = name,envir=.cGroupsGUIEnv))
              if (inherits(load.data,"try-error")){
                  return("Problems loading .Rdata")
              } else{
                   cGroupsGUI(get("load.data",envir=.cGroupsGUIEnv))
                   tcltk::tkdestroy(tt)
              }
      }
      plaincomma <- function(){
              name <- tcltk::tclvalue(tcltk::tkgetOpenFile(parent = tt, title = "Plain Data",filetypes = "{{Plain Files} {.csv}}"))
              if (name=="") return(" ")
              if (length(name)>1)  stop(paste("More than one object in",name))
              load.data <- try(read.csv(file = name))
              if (inherits(load.data,"try-error")){
                  return("Problems loading .csv")
              } else{
                   cGroupsGUI(load.data)
                   tcltk::tkdestroy(tt)
              }
      }
      plaincolon   <- function(){
              name <- tcltk::tclvalue(tcltk::tkgetOpenFile(parent = tt, title = "Plain Data",filetypes = "{{Plain Files} {.csv}}"))
              if (name=="") return(" ")
              if (length(name)>1)  stop(paste("More than one object in",name))
              load.data <- try(read.csv2(file = name))
              if (inherits(load.data,"try-error")){
                  return("Problems loading .csv")
              } else{
                   cGroupsGUI(load.data)
                   tcltk::tkdestroy(tt)
              }
      }
      report.options <- function(){
             var.plot <- as.character(tcltk::tkget(tlist.factor.selection,0,"end"))
             if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
                tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]
             else
                tmp.data <- x
             aux <- as.integer(length(var.plot)==1)
             if (aux!=0) nx <- length(levels(factor(tmp.data[,var.plot])))
             if (aux==0) nx <- 0
             stat <- "disabled"
             stat.mult <- "disabled"
             if (!exists(".p.overall", envir = .cGroupsGUIEnv))  assign(".p.overall","0", envir = .cGroupsGUIEnv)
             if (!exists(".p.trend", envir = .cGroupsGUIEnv))  assign(".p.trend","0", envir = .cGroupsGUIEnv)
             if (!exists(".p.mult", envir = .cGroupsGUIEnv))   assign(".p.mult","0", envir = .cGroupsGUIEnv)
             if (exists(".p.overall", envir = .cGroupsGUIEnv) & aux==0)  assign(".p.overall","0", envir = .cGroupsGUIEnv)
             if (exists(".p.trend", envir = .cGroupsGUIEnv) & aux==0)  assign(".p.trend","0", envir = .cGroupsGUIEnv)
             if (exists(".p.mult", envir = .cGroupsGUIEnv) & aux==0)  assign(".p.mult","0", envir = .cGroupsGUIEnv)
             if (!exists(".show.all", envir = .cGroupsGUIEnv))  assign(".show.all","1", envir = .cGroupsGUIEnv)
             if (!exists(".show.desc", envir = .cGroupsGUIEnv))  assign(".show.desc","1", envir = .cGroupsGUIEnv)
             if (!exists(".show.haz", envir = .cGroupsGUIEnv))  assign(".show.haz","0", envir = .cGroupsGUIEnv)
             if (!exists(".show.n", envir = .cGroupsGUIEnv))   assign(".show.n","1", envir = .cGroupsGUIEnv)
             if (!exists(".type.cat.value", envir = .cGroupsGUIEnv))  assign(".type.cat.value","nperc", envir = .cGroupsGUIEnv)
             if (aux==1 & nx>=3){
                  stat.mult <- "normal"
                  stat <- "normal"
             }
              if (aux==1 & nx==2){
                  stat <- "normal"
             }

             pos <- as.character(tcltk::tkwm.geometry(tt))
             pos1 <- paste("+",paste(strsplit(pos,"+", fixed=TRUE)[[1]][2:3],collapse="+"),sep="")
             size1 <- round(as.numeric(strsplit(pos,"x", fixed=TRUE)[[1]][1])/4.5)
             size2 <- round(as.numeric(strsplit( strsplit(pos,"x", fixed=TRUE)[[1]][2],"+",fixed=TRUE)[[1]][1])/1.4)
             pos <- paste(size1,"x",size2,pos1,sep="")
             report <- tcltk::tktoplevel(parent=topframe)
             tcltk::tktitle(report) <- "Options for report"
             tcltk::tkwm.resizable(report,0,0)
             tcltk::tkwm.geometry(report,pos)
             tcltk::tkgrab(report)
             tcltk::tkfocus(report)
             topreport <- tcltk::tkframe(report)
             tcltk::tkgrid(topreport,columnspan=8)
             topreportframe <- tcltk::tkwidget(topreport, "labelframe", text ="", fg="blue",padx=10,pady=10)
             results.show <- tcltk::tkcheckbutton(topreportframe)
             results.show2 <- tcltk::tkcheckbutton(topreportframe)
             results.show3 <- tcltk::tkcheckbutton(topreportframe)
             results.value <- tcltk::tclVar(get(".p.trend",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE))
             results.value2 <- tcltk::tclVar(get(".p.mult",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE))
             results.value3 <- tcltk::tclVar(get(".p.overall",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE))
             tcltk::tkconfigure(results.show,variable=results.value, state= stat.mult)
             tcltk::tkconfigure(results.show2,variable=results.value2, state= stat.mult)
             tcltk::tkconfigure(results.show3,variable=results.value3, state=stat)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="P-values in report",fg="blue", font=fontype))
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="P overall", font=fontype),results.show3)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="P trend", font=fontype),results.show)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="Multiple comparisons", font=fontype),results.show2)
             results.n <- tcltk::tkcheckbutton(topreportframe)
             results.n.value <- tcltk::tclVar(get(".show.n",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE))
             tcltk::tkconfigure(results.n,variable=results.n.value)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="Show N in each variable",fg="blue", font=fontype),results.n, sticky="nw")
             results.all <- tcltk::tkcheckbutton(topreportframe)
             results.value.all <- tcltk::tclVar(get(".show.all",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE))
             tcltk::tkconfigure(results.all ,variable=results.value.all)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="Show 'ALL' column",fg="blue", font=fontype),results.all, sticky="nw")
             results.desc <- tcltk::tkcheckbutton(topreportframe)
             results.value.desc <- tcltk::tclVar(get(".show.desc",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE))
             tcltk::tkconfigure(results.desc ,variable=results.value.desc)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="Show descriptives",fg="blue", font=fontype),results.desc, sticky="nw")
             results.haz <- tcltk::tkcheckbutton(topreportframe)
             results.value.haz <- tcltk::tclVar(get(".show.haz",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE))
             tcltk::tkconfigure(results.haz ,variable=results.value.haz)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="Show odds/hazard ratio",fg="blue", font=fontype),results.haz, sticky="nw")
             type.cat1 <- tcltk::tkradiobutton(topreportframe)
             type.cat2 <- tcltk::tkradiobutton(topreportframe)
             type.cat3 <- tcltk::tkradiobutton(topreportframe)
             type.cat.valuex <-  tcltk::tclVar(get(".type.cat.value",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE))
             tcltk::tkconfigure(type.cat1, variable = type.cat.valuex, value = "nperc", command = I)
             tcltk::tkconfigure(type.cat2, variable = type.cat.valuex, value = "perc", command = I)
             tcltk::tkconfigure(type.cat3, variable = type.cat.valuex, value = "nsample", command = I)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="Type for categorical",fg="blue", font=fontype), sticky="nw")
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="n (%)", font=fontype),type.cat1)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="(%)", font=fontype),type.cat2)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="n", font=fontype),type.cat3)
             tcltk::tkgrid(tcltk::tklabel(topreportframe,text="",fg="blue", font=fontype),results.all, sticky="nw")
                 accept.fun <- function(){
                  assign(".p.overall" ,tcltk::tclvalue(results.value3) , envir = .cGroupsGUIEnv)
                  assign(".p.trend" ,tcltk::tclvalue(results.value) , envir = .cGroupsGUIEnv)
                  assign(".p.mult" ,tcltk::tclvalue(results.value2) , envir = .cGroupsGUIEnv)
                  assign(".show.all" ,tcltk::tclvalue(results.value.all) , envir = .cGroupsGUIEnv)
                  assign(".show.desc" ,tcltk::tclvalue(results.value.desc) , envir = .cGroupsGUIEnv)
                  assign(".show.haz" ,tcltk::tclvalue(results.value.haz) , envir = .cGroupsGUIEnv)
                  assign(".show.n"  ,tcltk::tclvalue(results.n.value) , envir = .cGroupsGUIEnv)
                  assign(".type.cat.value"  ,tcltk::tclvalue(type.cat.valuex) , envir = .cGroupsGUIEnv)
                 tcltk::tkdestroy(report)
            }
            cancel.fun <- function(){
                tcltk::tkdestroy(report)
            }
            accept <- tcltk::tkbutton(topreportframe,text="Accept",command = accept.fun, height=1, width=8,fg='blue', font=fontype)
            cancel <- tcltk::tkbutton(topreportframe,text="Cancel",command = cancel.fun , height=1, width=8,fg='red', font=fontype)
            tcltk::tkgrid(cancel,row=12,column=0,sticky="w")
            tcltk::tkgrid(accept,row=12,column=0,sticky="e")
            tcltk::tkgrid(topreportframe, padx=25,pady=25, columnspan=8)
      }
      prepare.input <- function(){
          tmp.data <- x
          if(tcltk::tclvalue(type.var.valuex)=='factor'){  
              var.plot <- as.character(tcltk::tkget(tlist.factor.selection,0,"end"))
              label.aux <- attr(tmp.data[,var.plot],"label",exact=TRUE)
              variableF <- factor(tmp.data[,var.plot])
              if (label.aux=="")   attr(variableF,"label") <- var.plot
              if (label.aux!="")   attr(variableF,"label") <- label.aux
          }
          if(tcltk::tclvalue(type.var.valuex)=='none'){  
              variableF <- NULL
              ref.y <- 1
          }
          if(tcltk::tclvalue(type.var.valuex)=='surv'){
              var.name <- as.character(tcltk::tkget(tlist.timeto.selection,0,"end"))
              if( length(var.name)==0) return(tcltk::tkmessageBox(message = "No 'time to' selected", icon = "info", type="ok"))
              var.name2 <- as.character(tcltk::tkget(tlist.status.selection,0,"end"))
              if( length(var.name2)==0) return(tcltk::tkmessageBox(message = "No 'status' selected", icon = "info", type="ok"))
              event <- as.character(tcltk::tkget(entry4))
              if( length(event)==0) return(tcltk::tkmessageBox(message = "No 'event' selected", icon = "info", type="ok"))
              timeto <- tmp.data[,var.name]
              eventto <- as.integer(tmp.data[, var.name2]==event)
              variableF <- Surv(timeto, eventto)
              ref.y <- 1
          } 
    
            if (length(as.character(tcltk::tkget(report.list,0,"end")))==0) return(tcltk::tkmessageBox(message = "Select at least one variables to report", icon = "info", type="ok"))
            mat <- read.list()
            variables <- tmp.data[,mat$names, drop=FALSE]
            method <- mat$type
            subs <- mat$subs
            hide <- mat$hide
            decimals <- mat$digits
            subs.aux <- NULL
            for (i in 1:nrow(mat)){
                if(method[i]=='Categorical') method[i] <- 3
                if(method[i]=='Non-Normal') method[i] <- 2
                if(method[i]=='Normal') method[i] <- 1
                if(subs[i]=="") subs[i] <- NA
                if(hide[i]=="First") hide[i] <- 1
                if(hide[i]=="Last") hide[i] <- Inf
                if(hide[i]=="No") hide[i] <- NA
                if(decimals[i]=="Default") decimals[i] <- NA
                if(get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits=FALSE)==""){
                      if(is.na(subs[i]))  subs.aux[i] <- ""
                      if(!is.na(subs[i])) subs.aux[i] <- paste(mat$names[i],"=",subs[i],sep="")
               }
               if(get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits=FALSE)!=""){
                     if(is.na(subs[i]))  subs.aux[i] <- paste(mat$names[i],"=",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits=FALSE),sep="")
                     if(!is.na(subs[i])) subs.aux[i] <- paste(mat$names[i],"=",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits=FALSE)," & ",subs[i],sep="")
                }
            }
              subs.aux[subs.aux==""] <- NA
              subs <- subs.aux
              if(all(is.na(subs))) subs <- NA
              if(any(!is.na(subs))){ 
                  subs <- subs[!is.na(subs)]
                  subs <- paste("list(",paste(subs, collapse=","),")",sep="")
              }
            method <- as.numeric(method)
            hide <- as.numeric(hide)
            decimals <- as.numeric(decimals)
            if (!exists(".p.trend", envir = .cGroupsGUIEnv)) assign(".p.trend",0,envir=.cGroupsGUIEnv)
            if (!exists(".p.mult", envir = .cGroupsGUIEnv)) assign(".p.mult",0,envir=.cGroupsGUIEnv)
            if (!exists(".show.all", envir = .cGroupsGUIEnv)) assign(".show.all",1,envir=.cGroupsGUIEnv)
            if (!exists(".show.n", envir = .cGroupsGUIEnv)) assign(".show.n",1,envir=.cGroupsGUIEnv)
            if (!exists(".p.overall", envir = .cGroupsGUIEnv)) assign(".p.overall",1,envir=.cGroupsGUIEnv)
            if (!exists(".show.haz", envir = .cGroupsGUIEnv)) assign(".show.haz",0,envir=.cGroupsGUIEnv)
            if (!exists(".show.desc", envir = .cGroupsGUIEnv)) assign(".show.desc",1,envir=.cGroupsGUIEnv)
            if(tcltk::tclvalue(type.var.valuex)=='factor'){
              ref.y <- as.character(tcltk::tkget(entry.factor))
              if(length(ref.y)==0) ref.y <- 1
              if(ref.y=='--') ref.y <- 1
              if(ref.y!=1){
                     if (get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE)!="")
                        tmp.data <- x[eval(parse(text=paste("with(x,",get(".global.subset.selection",envir=.cGroupsGUIEnv,inherits = FALSE),")",sep=""))),,drop=FALSE]
                     else
                        tmp.data <- x
                     pos <- levels(factor(tmp.data[,var.plot]))==ref.y
                     if(pos[1]==TRUE) ref.y <- 1
                     if(pos[2]==TRUE) ref.y <- 2
              }
           } 
           nlev <- as.vector(unlist(lapply(variables,function(x) nlevels(x))))
           ref <- hide
           ref[is.na(ref)] <- 1
           ref[is.infinite(ref)] <- nlev[is.infinite(ref)] 
           p.trend <- as.numeric(get(".p.trend",envir=.cGroupsGUIEnv,inherits=FALSE))
            p.mult <- as.numeric(get(".p.mult",envir=.cGroupsGUIEnv,inherits=FALSE))
            show.all <- as.numeric(get(".show.all",envir=.cGroupsGUIEnv,inherits=FALSE))
            show.n <- as.numeric(get(".show.n",envir=.cGroupsGUIEnv,inherits=FALSE))
            if(get(".p.overall",envir=.cGroupsGUIEnv,inherits=FALSE)=='1') show.p.overall <- TRUE
            if(get(".p.overall",envir=.cGroupsGUIEnv,inherits=FALSE)=='0') show.p.overall <- FALSE
            if(get(".show.haz",envir=.cGroupsGUIEnv,inherits=FALSE)=='1') show.ratio <- TRUE
            if(get(".show.haz",envir=.cGroupsGUIEnv,inherits=FALSE)=='0') show.ratio <- FALSE
            if(get(".show.desc",envir=.cGroupsGUIEnv,inherits=FALSE)=='1') show.descr <- TRUE
            if(get(".show.desc",envir=.cGroupsGUIEnv,inherits=FALSE)=='0') show.descr <- FALSE       
            if(get(".type.cat.value",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE)=="nsample") typecat <- 3
            if(get(".type.cat.value",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE)=="nperc") typecat <- 2
            if(get(".type.cat.value",envir=.cGroupsGUIEnv,mode="any", inherits = FALSE)=="perc") typecat <- 1
            alpha <- as.numeric(as.character(tcltk::tclvalue(swtest)))
            res <- list(X = variables, y = variableF, Xext = x, selec = subs, method = method, alpha = alpha, hide = hide, digits = decimals, type = typecat, show.all = show.all, show.p.trend = p.trend, show.p.mul = p.mult, show.n=show.n, show.ratio=show.ratio, show.descr = show.descr, show.p.overall= show.p.overall, ref.y = ref.y, ref=ref)
      }
      print.aux <- function(){
            res <- prepare.input()
            if(!inherits(res,"list")) return()
            ans <- try(eval(parse(text= paste("compareGroups.fit(X = res$X, y = res$y, Xext=res$Xext, selec =", res$selec,", 
                                              method = res$method, alpha = res$alpha,min.dis = 5, max.ylev = 5, ref.y = res$ref.y, 
                                              ref= res$ref, 
                                              max.xlev=10, timemax=NA, Q1=0.25, Q3=0.75, simplify=TRUE, ref.no=NA, fact.ratio=1, p.corrected=TRUE,
                                              compute.ratio=TRUE, include.miss=FALSE, oddsratio.method='midp',chisq.test.perm = FALSE, 
                                              byrow = FALSE, chisq.test.B = 2000, chisq.test.seed = NULL, 
                                              Date.format = 'd-mon-Y', var.equal = TRUE, 
                                              conf.level=0.95, surv=FALSE, riskratio=FALSE, riskratio.method='wald')"))))
            if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'compareGroups' function", icon = "info", type="ok"))
            print(ans)
            if(!inherits(ans,"try-error")) ans <- try(createTable(x=ans,hide=res$hide, digits=res$digits,type=res$type, show.all= res$show.all, show.p.trend= res$show.p.trend,show.p.mul= res$show.p.mul,show.n=res$show.n, show.p.overall = res$show.p.overall, show.ratio = res$show.ratio, show.descr = res$show.descr))
            if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'createTable' function", icon = "info", type="ok"))
            print(ans, which.table = 'both')
      }
      export2latex.aux <- function(){
            res <- prepare.input()
            if(!inherits(res,"list")) return()
            ans <- try(eval(parse(text= paste("compareGroups.fit(X = res$X, y = res$y, Xext=res$Xext, selec =", res$selec,", 
                                              method = res$method, alpha = res$alpha,min.dis = 5, max.ylev = 5, ref.y = res$ref.y, 
                                              ref= res$ref, 
                                              max.xlev=10, timemax=NA, Q1=0.25, Q3=0.75, simplify=TRUE, ref.no=NA, fact.ratio=1, p.corrected=TRUE,
                                              compute.ratio=TRUE, include.miss=FALSE, oddsratio.method='midp',chisq.test.perm = FALSE, 
                                              byrow = FALSE, chisq.test.B = 2000, chisq.test.seed = NULL, 
                                              Date.format = 'd-mon-Y', var.equal = TRUE, 
                                              conf.level=0.95, surv=FALSE, riskratio=FALSE, riskratio.method='wald')"))))
            if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'compareGroups' function", icon = "info", type="ok"))
            if(!inherits(ans,"try-error")) ans <- try(createTable(x=ans,hide=res$hide, digits=res$digits,type=res$type, show.all= res$show.all, show.p.trend= res$show.p.trend,show.p.mul= res$show.p.mul,show.n=res$show.n, show.p.overall = res$show.p.overall, show.ratio = res$show.ratio, show.descr = res$show.descr))
            if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'createTable' function", icon = "info", type="ok"))
            GetDir <- function(){
                   directory <- tcltk::tclvalue(tcltk::tkgetSaveFile(parent = tt,initialfile="CompareGroupsTable",title = "Select where to save table"))
                   directory <- as.character(directory)
                   if (directory=="") return()
                   return(directory)
             }
            directory <- GetDir()
            if(is.null(directory)) return()
            setwd(dirname(directory))
            ans <- try(export2latex(ans, file = directory, which.table = 'both'))
            if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'export2latex' function", icon = "info", type="ok"))
            if(!inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Correct 'export2latex'", icon = "info", type="ok"))
      }
     export2csv.aux1 <- function(){
        res <- prepare.input()
        if(!inherits(res,"list")) return()
        ans <- try(eval(parse(text=paste("compareGroups.fit(X = res$X, y = res$y, Xext=res$Xext, selec =", res$selec,", 
                                          method = res$method, alpha = res$alpha,min.dis = 5, max.ylev = 5, ref.y = res$ref.y, 
                                          ref= res$ref, 
                                          max.xlev=10, timemax=NA, Q1=0.25, Q3=0.75, simplify=TRUE, ref.no=NA, fact.ratio=1, p.corrected=TRUE,
                                          compute.ratio=TRUE, include.miss=FALSE, oddsratio.method='midp',chisq.test.perm = FALSE, 
                                          byrow = FALSE, chisq.test.B = 2000, chisq.test.seed = NULL, 
                                          Date.format = 'd-mon-Y', var.equal = TRUE,
                                          conf.level=0.95, surv=FALSE, riskratio=FALSE, riskratio.method='wald')"))))
        if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'compareGroups' function", icon = "info", type="ok"))
            if(!inherits(ans,"try-error")) ans <- try(createTable(x=ans,hide=res$hide, digits=res$digits,type=res$type, show.all= res$show.all, show.p.trend= res$show.p.trend,show.p.mul= res$show.p.mul,show.n=res$show.n, show.p.overall = res$show.p.overall, show.ratio = res$show.ratio, show.descr = res$show.descr))
        if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'createTable' function", icon = "info", type="ok"))
        GetDir <- function(){
               directory <- tcltk::tclvalue(tcltk::tkgetSaveFile(parent = tt,initialfile="CompareGroupsTable",title = "Select where to save table"))
               directory <- as.character(directory)
               if (directory=="") return()
               return(directory)
        }
        directory <- GetDir()
        if(is.null(directory)) return()
        setwd(dirname(directory))
        ans <- try(export2csv(ans, file = directory, sep=",", which.table="both"))
        if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'export2csv' function", icon = "info", type="ok"))
        if(!inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Correct 'export2csv'", icon = "info", type="ok"))
     }
     export2csv.aux2 <- function(){
          res <- prepare.input()
          if(!inherits(res,"list")) return()
          ans <- try(eval(parse(text= paste("compareGroups.fit(X = res$X, y = res$y, Xext=res$Xext, selec =", res$selec,", 
                                             method = res$method, alpha = res$alpha,min.dis = 5, max.ylev = 5, ref.y = res$ref.y, 
                                             ref= res$ref, 
                                             max.xlev=10, timemax=NA, Q1=0.25, Q3=0.75, simplify=TRUE, ref.no=NA, fact.ratio=1, p.corrected=TRUE,
                                             compute.ratio=TRUE, include.miss=FALSE, oddsratio.method='midp',chisq.test.perm = FALSE, 
                                             byrow = FALSE, chisq.test.B = 2000, chisq.test.seed = NULL, 
                                             Date.format = 'd-mon-Y', var.equal = TRUE, 
                                             conf.level=0.95, surv=FALSE, riskratio=FALSE, riskratio.method='wald')"))))
          if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'compareGroups' function", icon = "info", type="ok"))
            if(!inherits(ans,"try-error")) ans <- try(createTable(x=ans,hide=res$hide, digits=res$digits,type=res$type, show.all= res$show.all, show.p.trend= res$show.p.trend,show.p.mul= res$show.p.mul,show.n=res$show.n, show.p.overall = res$show.p.overall, show.ratio = res$show.ratio, show.descr = res$show.descr))
          if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'createTable' function", icon = "info", type="ok"))
          GetDir <- function(){
               directory <- tcltk::tclvalue(tcltk::tkgetSaveFile(parent = tt,initialfile="CompareGroupsTable",title = "Select where to save table"))
               directory <- as.character(directory)
               if (directory=="") return()
               return(directory)
           }
           directory <- GetDir()
           if(is.null(directory)) return()
           setwd(dirname(directory))
           ans <- try(export2csv(ans, file = directory, sep=";", which.table="both"))
          if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'export2csv' function", icon = "info", type="ok"))
          if(!inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Correct 'export2csv'", icon = "info", type="ok"))
     }
     export2html.aux <- function(){
          res <- prepare.input()
          if(!inherits(res,"list")) return()
          ans <- try(eval(parse(text= paste("compareGroups.fit(X = res$X, y = res$y, Xext=res$Xext, selec =", res$selec,", 
                                              method = res$method, alpha = res$alpha,min.dis = 5, max.ylev = 5, ref.y = res$ref.y, 
                                              ref= res$ref, 
                                              max.xlev=10, timemax=NA, Q1=0.25, Q3=0.75, simplify=TRUE, ref.no=NA, fact.ratio=1, p.corrected=TRUE,
                                              compute.ratio=TRUE, include.miss=FALSE, oddsratio.method='midp',chisq.test.perm = FALSE, 
                                              byrow = FALSE, chisq.test.B = 2000, chisq.test.seed = NULL, 
                                              Date.format = 'd-mon-Y', var.equal = TRUE, 
                                              conf.level=0.95, surv=FALSE, riskratio=FALSE, riskratio.method='wald')"))))
          if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'compareGroups' function", icon = "info", type="ok"))
            if(!inherits(ans,"try-error")) ans <- try(createTable(x=ans,hide=res$hide, digits=res$digits,type=res$type, show.all= res$show.all, show.p.trend= res$show.p.trend,show.p.mul= res$show.p.mul,show.n=res$show.n, show.p.overall = res$show.p.overall, show.ratio = res$show.ratio, show.descr = res$show.descr))
          if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'createTable' function", icon = "info", type="ok"))
          GetDir <- function(){
               directory <- tcltk::tclvalue(tcltk::tkgetSaveFile(parent = tt,initialfile="CompareGroupsTable",title = "Select where to save table"))
               directory <- as.character(directory)
               if (directory=="") return()
               return(directory)
           }
           directory <- GetDir()
           if(is.null(directory)) return()
           setwd(dirname(directory))
           ans <- try(export2html(ans, file = directory, sep=";", which.table="both"))
          if(inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Error occurred in 'export2html' function", icon = "info", type="ok"))
          if(!inherits(ans,"try-error")) return(tcltk::tkmessageBox(message = "Correct 'export2html'", icon = "info", type="ok"))
     }     
     topMenu <- tcltk::tkmenu(tt)
     tcltk::tkconfigure(tt,menu=topMenu)
     fileMenu <- tcltk::tkmenu(topMenu,tearoff=FALSE)
     tcltk::tkadd(topMenu,"cascade",label="Load File",menu=fileMenu, font=fontype)
     tcltk::tkadd(fileMenu,"command",label="SPSS",command=spssLoad)
     tcltk::tkadd(fileMenu,"command",label="Rdata",command=RData)
     tcltk::tkadd(fileMenu,"command",label="Workspace",command=RWspace)
     openMenu <- tcltk::tkmenu(topMenu,tearoff=FALSE)
     tcltk::tkadd(openMenu,"command",label="Sep: comma (,)", command=plaincomma)
     tcltk::tkadd(openMenu,"command",label="Sep: semicolon (;)", command=plaincolon)
     tcltk::tkadd(fileMenu,"cascade",label="Plain text",menu=openMenu)
     fileMenu1 <- tcltk::tkmenu(topMenu,tearoff=FALSE)
     tcltk::tkadd(topMenu,"command",label="Report options",command=report.options)
     fileMenu2 <- tcltk::tkmenu(topMenu,tearoff=FALSE)
     tcltk::tkadd(topMenu,"cascade",label="Export",menu=fileMenu2)
     tcltk::tkadd(fileMenu2,"command",label="Print",command=print.aux)
     tcltk::tkadd(fileMenu2,"command",label="LaTeX",command=export2latex.aux)
     tcltk::tkadd(fileMenu2,"command",label="HTML",command=export2html.aux)
     openRecentMenu <- tcltk::tkmenu(topMenu,tearoff=FALSE)
     tcltk::tkadd(openRecentMenu,"command",label="Sep: comma (,)", command=export2csv.aux1)
     tcltk::tkadd(openRecentMenu,"command",label="Sep: semicolon (;)", command=export2csv.aux2)
     tcltk::tkadd(fileMenu2,"cascade",label="CSV",menu=openRecentMenu)
}
