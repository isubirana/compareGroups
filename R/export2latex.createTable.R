export2latex.createTable<-function(x, file, which.table='descr', size='same', nmax = TRUE, header.labels = c(), caption = NULL, loc.caption = 'top', label = NULL, landscape = NA, colmax = 10, ...){  

  if (!inherits(x,"createTable"))
    stop("x must be of class 'createTable'")
  if (inherits(x,"cbind.createTable"))
    stop("x cannot be of class 'cbind.createTable'")
  
  ww <- charmatch(which.table, c("descr","avail","both"))
  if (is.na(ww))
    stop(" argument 'which.table' must be either 'descr', 'avail' or 'both'")
    
  if (inherits(x,"missingTable"))
    if (ww != 1){
      warning(" only 'descr' table can be displayed for 'missingTable' object. Argument 'which.table' set to 'descr'")
      ww <- 1
    }        
    
  size.type <- charmatch(size, c("tiny","scriptsize","footnotesize","small","normalsize","large","Large","LARGE","huge","Huge","same"))
  if (is.na(size.type))
    stop(" argument 'which.table' must be either 'tiny', 'scriptsize', 'footnotesize', 'small', 'normalsize', 'large', 'Large', 'LARGE','huge', 'Huge' or 'same'") 
  
  if (is.na(landscape))  
    landscape <- ncol(x$desc) > colmax
    
  size<-c("tiny","scriptsize","footnotesize","small","normalsize","large","Large","LARGE","huge","Huge","same")[size.type]
  
  loc.caption.type <- charmatch(loc.caption, c("top","bottom"))
  if (is.na(loc.caption.type))
    stop(" argument 'loc.caption' must be either 'top' or 'bottom'")   
  
  loc.caption <- c("top","bottom")[loc.caption.type]
  
  if (attr(x,"groups")){
    y.name.label<-attr(x,"yname")  
    y.name.label<-gsub("\\$","\\\\$",y.name.label)
    y.name.label<-gsub("%","\\\\%",y.name.label)  
    y.name.label<-gsub("&","\\\\&",y.name.label)  
    y.name.label<-gsub("_","\\\\_",y.name.label)
    y.name.label<-gsub(">=","$\\\\geq$",y.name.label)
    y.name.label<-gsub("<=","$\\\\leq$",y.name.label)  
    y.name.label<-gsub(">","$>$",y.name.label)
    y.name.label<-gsub("<","$<$",y.name.label)
    y.name.label<-gsub(intToUtf8(0xB1L),"$\\\\pm$",y.name.label)
  }  
  
  if (!is.null(caption)){
    if (!is.character(caption))
      stop(" argument 'caption' must be a character'")
    else
      if (length(caption)==1 & ww == 3)
        caption = rep(caption,2)
  } else {
    if (ww==1){
      if (attr(x,"groups"))
        if (inherits(x,"missingTable"))
          caption<-paste("Missingness table by groups of `",y.name.label,"'",sep="")
        else
          caption<-paste("Summary descriptives table by groups of `",y.name.label,"'",sep="")
      else
        if (inherits(x,"missingTable"))  
          caption<-"Missingess table"   
        else
          caption<-"Summary descriptives table"           
    }
    if (ww==2){
      if (attr(x,"groups"))
        caption<-paste("Available data by groups of `",y.name.label,"'",sep="")
      else
        caption<-"Available data"
    }  
    if (ww==3){
      caption<-c("","")
      if (attr(x,"groups")){
        caption[1]<-paste("Summary descriptives table by groups of `",y.name.label,"'",sep="")
        caption[2]<-paste("Available data by groups of `",y.name.label,"'",sep="")      
      } else {
        caption[1]<-"Summary descriptives table"     
        caption[2]<-"Available data"
      }
    }
  }    

  if (!is.null(label)){
    if (!is.character(label))
      stop(" argument 'label' must be a character'")
    else{
      if (length(label)==1 & ww == 3)
        stop(" argument 'label' must have two components, one for descr table and other for avail table")
      if (ww==1 | ww==2)
        caption <- paste(caption, "\\label{",label,"}",sep="")
      if (ww==3){
        caption[1] <- paste(caption[1], "\\label{",label[1],"}",sep="")
        caption[2] <- paste(caption[2], "\\label{",label[2],"}",sep="")
      }
    }
  }
  
  cap<-attr(x,"caption")
  if (!is.null(cap)){
    cap<-gsub("\\$","\\\\$",cap)
    cap<-gsub("%","\\\\%",cap)  
    cap<-gsub("&","\\\\&",cap)  
    cap<-gsub("_","\\\\_",cap)
    cap<-gsub(">=","$\\\\geq$",cap)
    cap<-gsub("<=","$\\\\leq$",cap)  
    cap<-gsub(">","$>$",cap)
    cap<-gsub("<","$<$",cap)
    cap<-gsub(intToUtf8(0xB1L),"$\\\\pm$",cap)      
  }
  
  out <- list()
  
  if (ww %in% c(1,3)){

    pp<-prepare(x,nmax=nmax,header.labels)
    table1<-prepare(x,nmax=nmax,header.labels)[[1]]
    cc<-unlist(attr(pp,"cc"))
    if (!is.null(cc)){
      cc<-gsub("\\$","\\\\$",cc)
      cc<-gsub("%","\\\\%",cc)  
      cc<-gsub("&","\\\\&",cc)  
      cc<-gsub("_","\\\\_",cc)
      cc<-gsub(">=","$\\\\geq$",cc)
      cc<-gsub("<=","$\\\\leq$",cc)  
      cc<-gsub(">","$>$",cc)
      cc<-gsub("<","$<$",cc) 
      cc<-gsub(intToUtf8(0xB1L),"$\\\\pm$",cc) 
    }
    nmax<-rownames(table1)[2]==''
    if (nmax)
      nmax.pos<-!trim(table1[2,])==''    
  
    rownames(table1)<-gsub("\\$","\\\\$",rownames(table1))
    rownames(table1)<-gsub("%","\\\\%",rownames(table1))  
    rownames(table1)<-gsub("&","\\\\&",rownames(table1))  
    rownames(table1)<-gsub("_","\\\\_",rownames(table1))
    rownames(table1)<-gsub(">=","$\\\\geq$",rownames(table1))
    rownames(table1)<-gsub("<=","$\\\\leq$",rownames(table1))
    rownames(table1)<-gsub(">","$>$",rownames(table1))
    rownames(table1)<-gsub("<","$<$",rownames(table1))
    rownames(table1)<-sub("^    ","$\\\\qquad$",rownames(table1))
    rownames(table1)<-gsub(intToUtf8(0xB1L),"$\\\\pm$",rownames(table1))     
      
    if (!is.null(cc))
      rownames(table1)<-paste("$\\qquad$",rownames(table1))
  
    if (ncol(table1)>0){
      table1<-ifelse(is.na(table1),"",table1)
      table1<-gsub("%","\\\\%",table1)
      table1<-gsub("<","$<$",table1)
      table1<-gsub(">","$>$",table1)
      table1<-gsub(intToUtf8(0xB1L),"$\\\\pm$",table1)           
      if (nmax)
        table1[1,!nmax.pos]<-paste("\\multirow{2}{*}{",table1[1,!nmax.pos],"}",sep="")
    }
    
    nc<-ncol(table1)
    table1<-cbind(rownames(table1),table1)
    table1<-apply(table1,1,paste,collapse=" & ")
    
    if (nmax){
      head<-table1[1:2]
      body<-table1[-c(1:2)]
    }else{
      head<-table1[1]
      body<-table1[-1]
    }
  
    if (!is.null(attr(x,"caption"))){  
      aux<-NULL
      for (i in 1:length(body)){ 
        if (cc[i]!=""){
          aux<-c(aux,paste("\\multicolumn{",nc+1,"}{l}{\\textbf{",cc[i],":}}",sep=""))
          aux<-c(aux,body[i])
        }else{
          aux<-c(aux,body[i])
        }      
      } 
      body<-aux
    }
    body.tex<-paste(paste(body,collapse="\\\\ \n"),"\\\\ \n")
    head.tex<-paste(paste(head,collapse="\\\\ \n"),"\\\\ \n")
    head.loc<-paste(c("l",rep("c",nc)),collapse="")
  
    tex<-paste(
    if (landscape) paste("\\begin{landscape}",sep="") else "",
    if (size!='same') paste("\\begin{", size ,"}",sep="") else "","    
    \\begin{longtable}{",head.loc,"}" 
    ,if (caption[1]!='') ifelse(loc.caption=='top',paste("\\caption{",caption[1],"}\\\\",sep=""),"") else "","
    \\hline  
    ",head.tex,"  
    \\hline
    \\hline     
    \\endfirsthead 
    \\multicolumn{",nchar(head.loc),"}{l}{\\tablename\\ \\thetable{} \\textit{-- continued from previous page}}\\\\ 
    \\hline
    ",head.tex,"
    \\hline
    \\hline  
    \\endhead   
    \\hline
    \\multicolumn{",nchar(head.loc),"}{l}{\\textit{continued on next page}} \\\\ 
    \\endfoot   
    \\multicolumn{",nchar(head.loc),"}{l}{}  \\\\ 
    \\endlastfoot 
    ",body.tex," 
    \\hline",
    if (caption[1]!='') ifelse(loc.caption=='bottom',paste("\\\\ \\caption{",caption[1],"}\\\\",sep=""),"") else "","
    \\end{longtable}",
    if (size!='same') paste("\\end{", size ,"}",sep="") else "", 
    if (landscape) paste("\\end{landscape}",sep="") else ""   
    ,sep="")
    
    if (ww%in%c(1,3)){
      if (missing(file))
        cat(tex,"\n\n")    
      else 
        write(tex,file=file)
    }
    
    out$desc<-tex
  }  
  
  if (ww%in%c(2,3)){

    table2<-prepare(x,nmax=nmax,c())[[2]]
    rownames(table2)<-gsub("\\$","\\\\$",rownames(table2))
    rownames(table2)<-gsub("%","\\\\%",rownames(table2))  
    rownames(table2)<-gsub("&","\\\\&",rownames(table2))  
    rownames(table2)<-gsub("_","\\\\_",rownames(table2))
    rownames(table2)<-gsub(">=","$\\\\geq$",rownames(table2))
    rownames(table2)<-gsub("<=","$\\\\leq$",rownames(table2))
    rownames(table2)<-gsub(">","$>$",rownames(table2))
    rownames(table2)<-gsub("<","$<$",rownames(table2))    
    colnames(table2)<-gsub("\\$","\\\\$",colnames(table2))
    colnames(table2)<-gsub("%","\\\\%",colnames(table2))  
    colnames(table2)<-gsub("&","\\\\&",colnames(table2))  
    colnames(table2)<-gsub("_","\\\\_",colnames(table2))
    colnames(table2)<-gsub(">=","$\\\\geq$",colnames(table2))
    colnames(table2)<-gsub("<=","$\\\\leq$",colnames(table2))
    colnames(table2)<-gsub(">","$>$",colnames(table2))
    colnames(table2)<-gsub("<","$<$",colnames(table2))   
    colnames(table2)<-gsub(intToUtf8(0xB1L),"$\\\\pm$",colnames(table2))              
    head.loc<-paste(c("l",rep("c",ncol(table2))),collapse="")
    
    if (!is.null(attr(x,"caption")))
      rownames(table2)<-paste("$\\qquad$",rownames(table2),sep="")
        
    nc<-ncol(table2)
    table2<-cbind(rownames(table2),table2)
    table2<-apply(table2,1,paste,collapse=" & ")

    head<-table2[1]
    head.tex<-paste(head,"\\\\ \n")

    body<-table2[-1]
    cc<-cap
    if (!is.null(cc)){  
      aux<-NULL
      for (i in 1:length(body)){ 
        if (cc[i]!=""){
          aux<-c(aux,paste("\\multicolumn{",nc+1,"}{l}{\\textbf{",cc[i],":}}",sep=""))
          aux<-c(aux,body[i])
        }else{
          aux<-c(aux,body[i])
        }      
      } 
      body<-aux
    }
    body.tex<-paste(paste(body,collapse="\\\\ \n"),"\\\\ \n")
  
    if (ww==2)
      caption<-c(NA,caption)
      
    tex<-paste(
    if (landscape) paste("\\begin{landscape}",sep="") else "",
    if (size!='same') paste("\\begin{", size ,"}",sep="") else "","    
    \\begin{longtable}{",head.loc,"}", 
    if (caption[2]!='') ifelse(loc.caption=='top',paste("\\caption{",caption[2],"}\\\\",sep=""),"") else "","
    \\hline  
    ",head.tex," 
    \\hline 
    \\hline  
    \\endfirsthead 
    \\multicolumn{",nchar(head.loc),"}{l}{\\tablename\\ \\thetable{} \\textit{-- continued from previous page}}\\\\ 
    \\hline
    ",head.tex," 
    \\hline
    \\hline 
    \\endhead   
    \\hline
    \\multicolumn{",nchar(head.loc),"}{l}{\\textit{continued on next page}} \\\\ 
    \\endfoot    
    \\multicolumn{",nchar(head.loc),"}{l}{}  \\\\ 
    \\endlastfoot 
    ",body.tex,"
    \\hline",
    if (caption[2]!='') ifelse(loc.caption=='bottom',paste("\\\\ \\caption{",caption[2],"}\\\\",sep=""),"") else "","
    \\end{longtable}",
    if (size!='same') paste("\\end{", size ,"}",sep="") else "",
    if (landscape) paste("\\end{landscape}",sep="") else ""    
    ,sep="")    
    
    if (missing(file))
      cat(tex,"\n")
    else
      write(tex,file=paste(sub("\\.tex$","",file),"appendix.tex",sep=""))

    out$avail<-tex
  
  }
  
  return(invisible(out))

}

