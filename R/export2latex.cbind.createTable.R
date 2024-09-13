export2latex.cbind.createTable<-function(x, file, which.table='descr', size='same', nmax = TRUE, nmax.method=1, header.labels = c(), caption = NULL, loc.caption = 'top', label = NULL, landscape = NA, colmax = 10, ...){   


  if (!inherits(x,"cbind.createTable"))
    stop("'x' must be of class 'cbind.createTable")

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
    landscape <- sum(sapply(x,function(x.i) ncol(x.i$desc))) > colmax    
    
    
  size<-c("tiny","scriptsize","footnotesize","small","normalsize","large","Large","LARGE","huge","Huge","same")[size.type]
  
  loc.caption.type <- charmatch(loc.caption, c("top","bottom"))
  if (is.na(loc.caption.type))
    stop(" argument 'loc.caption' must be either 'top' or 'bottom'")   
  
  loc.caption <- c("top","bottom")[loc.caption.type]

  if (!is.null(caption)){
    if (!is.character(caption))
      stop(" argument 'caption' must be a character'")
    else
      if (length(caption)==1 & ww == 3)
        caption = rep(caption,2)
  } else {
    if (ww==1)
      if (inherits(x[[1]],"missingTable"))
        caption<-paste("Missingness tables")
      else
        caption<-paste("Summary descriptive tables")      
    if (ww==2)
      caption<-paste("Available data")
    if (ww==3){
      caption<-c("","")
      caption[1]<-"Summary descriptive tables"     
      caption[2]<-"Available data"
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
  cap<-gsub("\\$","\\\\$",cap)
  cap<-gsub("%","\\\\%",cap)  
  cap<-gsub("&","\\\\&",cap)  
  cap<-gsub("_","\\\\_",cap)
  cap<-gsub(">=","$\\\\geq$",cap)
  cap<-gsub("<=","$\\\\leq$",cap)
  cap<-gsub(">","$>$",cap)
  cap<-gsub("<","$<$",cap) 
  cap<-gsub(intToUtf8(0xB1L),"$\\\\pm$",cap)   
  
  desc<-lapply(x,function(vv) prepare(vv,nmax=nmax,nmax.method=nmax.method,header.labels)[[1]])
  avail<-lapply(x,function(vv) prepare(vv,nmax=nmax,nmax.method=nmax.method,c())[[2]])
  nc.desc<-lapply(desc,ncol)
  nc.avail<-lapply(avail,ncol)
  if (all(nc.desc==0))
    stop("Stratified table cannot be printed since no columns are displayed")
  if (any(nc.desc==0)){
    desc<-desc[-which(nc.desc==0)]  
    avail<-avail[-which(nc.desc==0)]  
    warning(paste("tables ",paste(which(nc.desc==0),collapse=", ")," removed since they have no columns to be displayed",sep=""))
    cap<-cap[-which(nc.desc==0)]
  }  
  
  nmax.i<-unlist(lapply(desc,function(vv) rownames(vv)[2]==''))
  if (diff(range(nmax.i))!=0){
    for (i in which(!nmax.i)){
      desc.i<-desc[[i]]
      desc[[i]]<-rbind(desc.i[1,,drop=FALSE],rep("",ncol(desc.i)),desc.i[-1,,drop=FALSE])
    }
  }  
  
  aux.desc<-aux.avail<-NULL
  ll.desc<-ll.avail<-integer(0)
  lcap.desc<-lcap.avail<-character(0)
  for (i in 1:length(desc)){
    if (i>1 && !identical(rownames(aux.desc),rownames(desc[[i]])))
      stop(paste("table",i,"does not have the same row.names"))
    desc.i<-desc[[i]]
    avail.i<-avail[[i]]
    aux.desc<-cbind(aux.desc,desc.i,rep("",nrow(desc.i)))
    aux.avail<-cbind(aux.avail,avail.i,rep("",nrow(avail.i)))
  }

  out<-list()

  if (ww %in% c(1,3)){

    cc<-attr(prepare(x[[1]],nmax=nmax,nmax.method=nmax.method,header.labels),"cc")  
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
  
    desc<-aux.desc[,-ncol(aux.desc),drop=FALSE]
    if (nmax){
      mr.pos<-  grep("^N=[0-9]+$",trim(desc[2,]))
      if (length(mr.pos)>0){
        mr.pos<-!(1:ncol(desc))%in%mr.pos
        desc[1,mr.pos]<-paste("\\multirow{2}{*}{",desc[1,mr.pos],"}",sep="")
      } else 
        nmax <- FALSE
    }  
    
    rownames(desc)<-gsub("\\$","\\\\$",rownames(desc))
    rownames(desc)<-gsub("%","\\\\%",rownames(desc))  
    rownames(desc)<-gsub("&","\\\\&",rownames(desc))  
    rownames(desc)<-gsub("_","\\\\_",rownames(desc))
    rownames(desc)<-gsub(">=","$\\\\geq$",rownames(desc))
    rownames(desc)<-gsub("<=","$\\\\leq$",rownames(desc))
    rownames(desc)<-gsub(">","$>$",rownames(desc))
    rownames(desc)<-gsub("<","$<$",rownames(desc))
    rownames(desc)<-sub("^    ","$\\\\qquad$",rownames(desc))
    rownames(desc)<-gsub(intToUtf8(0xB1L),"$\\\\pm$",rownames(desc))          
    desc<-gsub("\\$","\\\\$",desc)
    desc<-gsub("%","\\\\%",desc)  
    desc<-gsub("&","\\\\&",desc)  
    desc<-gsub("_","\\\\_",desc)
    desc<-gsub(">=","$\\\\geq$",desc)
    desc<-gsub("<=","$\\\\leq$",desc)
    desc<-gsub(">","$>$",desc)
    desc<-gsub("<","$<$",desc)
    desc<-gsub(intToUtf8(0xB1L),"$\\\\pm$",desc)            
  
    nc<-ncol(desc)

    head.loc<-paste(c("l",rep("c",nc)),collapse="")

    if (!is.null(cc))
      rownames(desc)<-paste("$\\qquad$",rownames(desc),sep="")
    desc<-cbind(rownames(desc),desc)
    desc<-apply(desc,1,paste,collapse=" & ")
  
    ii<-ifelse(nmax,2,1)
    head<-paste(desc[1:ii],"\\\\ \n")
    ini.cap<-2*(1:length(cap))+c(0,cumsum(unlist(nc.desc)-1)[-length(nc.desc)])
    end.cap<-ini.cap+unlist(nc.desc)-1
    head.tex<-paste(
    "\\hline","\n",
    paste(" & ",paste(paste("\\multicolumn{",nc.desc,"}{c}{",cap,"}",sep=""),collapse=" & & "),"\\\\ \n"),
    paste(paste(apply(cbind(ini.cap,end.cap),1,function(vv) paste("\\cline{",vv[1],"-",vv[2],"}",sep="")),collapse=" "),"\n"),
    paste(head,collapse=""),
    "\\hline \\hline"
    )
  
    body<-paste(desc[(ii+1):length(desc)],"\\\\ \n")
    if (!is.null(attr(x[[1]],"caption"))){  
      aux<-NULL
      for (i in 1:length(body)){ 
        if (cc[i]!=""){
          aux<-c(aux,paste("\\multicolumn{",nc+1,"}{l}{\\textbf{",cc[i],":}}\\\\",sep=""))
          aux<-c(aux,body[i])
        }else{
          aux<-c(aux,body[i])
        }      
      } 
      body<-aux
    }
    body.tex<-paste(body,collapse="")
  
    tex<-paste(
    if (landscape) paste("\\begin{landscape}",sep="") else "",
    if (size!='same') paste("\\begin{", size ,"}",sep="") else "","    
    \\begin{longtable}{",head.loc,"}",
    if (caption[1]!='') ifelse(loc.caption=='top',paste("\\caption{",caption[1],"}\\\\",sep=""),"") else "","
    ",head.tex,"  
    \\endfirsthead 
    \\multicolumn{",nchar(head.loc),"}{l}{\\tablename\\ \\thetable{} \\textit{-- continued from previous page}}\\\\ 
    ",head.tex,"
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
    
    if (missing(file))
      cat(tex,"\n\n")    
    else 
      write(tex,file=file)
   
    out$desc<-tex

  }



  if (ww %in% c(2,3)){  
  
    cc<-unlist(attr(x[[1]],"caption"))
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

    avail<-aux.avail[,-ncol(aux.avail),drop=FALSE]  
    rownames(avail)<-gsub("\\$","\\\\$",rownames(avail))
    rownames(avail)<-gsub("%","\\\\%",rownames(avail))  
    rownames(avail)<-gsub("&","\\\\&",rownames(avail))  
    rownames(avail)<-gsub("_","\\\\_",rownames(avail))
    rownames(avail)<-gsub(">=","$\\\\geq$",rownames(avail))
    rownames(avail)<-gsub("<=","$\\\\leq$",rownames(avail))
    rownames(avail)<-gsub(">","$>$",rownames(avail))
    rownames(avail)<-gsub("<","$<$",rownames(avail))
    rownames(avail)<-sub("^    ","$\\\\qquad$",rownames(avail))
    rownames(avail)<-gsub(intToUtf8(0xB1L),"$\\\\pm$",rownames(avail))   
    avail<-gsub("\\$","\\\\$",avail)
    avail<-gsub("%","\\\\%",avail)  
    avail<-gsub("&","\\\\&",avail)  
    avail<-gsub("_","\\\\_",avail)
    avail<-gsub(">=","$\\\\geq$",avail)
    avail<-gsub("<=","$\\\\leq$",avail)
    avail<-gsub(">","$>$",avail)
    avail<-gsub("<","$<$",avail)
    avail<-gsub(intToUtf8(0xB1L),"$\\\\pm$",avail)    
    nc<-ncol(avail)

    head.loc<-paste(c("l",rep("c",nc)),collapse="")
  
    if (!is.null(cc))
      rownames(avail)<-paste("$\\qquad$",rownames(avail),sep="")
    avail<-cbind(rownames(avail),avail)
    avail<-apply(avail,1,paste,collapse=" & ")
  
    ii<-1
    head<-paste(avail[1:ii],"\\\\ \n")
    ini.cap<-2*(1:length(cap))+c(0,cumsum(unlist(nc.avail)-1)[-length(nc.avail)])
    end.cap<-ini.cap+unlist(nc.avail)-1
    head.tex<-paste(
    "\\hline","\n",
    paste(" & ",paste(paste("\\multicolumn{",nc.avail,"}{c}{",cap,"}",sep=""),collapse=" & & "),"\\\\ \n"),
    paste(paste(apply(cbind(ini.cap,end.cap),1,function(vv) paste("\\cline{",vv[1],"-",vv[2],"}",sep="")),collapse=" "),"\n"),
    paste(head,collapse=""),
    "\\hline \\hline"
    )
    
    body<-paste(avail[(ii+1):length(avail)],"\\\\ \n")
    if (!is.null(attr(x[[1]],"caption"))){  
      aux<-NULL
      for (i in 1:length(body)){ 
        if (cc[i]!=""){
          aux<-c(aux,paste("\\multicolumn{",nc+1,"}{l}{\\textbf{",cc[i],":}}\\\\",sep=""))
          aux<-c(aux,body[i])
        }else{
          aux<-c(aux,body[i])
        }      
      } 
      body<-aux
    }
    body.tex<-paste(body,collapse="")

    if (ww==2)
      caption<-c(NA,caption)
    
    tex<-paste(
    if (landscape) paste("\\begin{landscape}",sep="") else "",
    if (size!='same') paste("\\begin{", size ,"}",sep="") else "","    
    \\begin{longtable}{",head.loc,"}",
    if (caption[2]!='') ifelse(loc.caption=='top',paste("\\caption{",caption[2],"}\\\\",sep=""),""),"
    ",head.tex,"  
    \\endfirsthead 
    \\multicolumn{",nchar(head.loc),"}{l}{\\tablename\\ \\thetable{} \\textit{-- continued from previous page}}\\\\ 
    ",head.tex,"
    \\endhead   
    \\hline
    \\multicolumn{",nchar(head.loc),"}{l}{\\textit{continued on next page}} \\\\ 
    \\endfoot   
    \\multicolumn{",nchar(head.loc),"}{l}{}  \\\\ 
    \\endlastfoot 
    ",body.tex," 
    \\hline","
    ",
    if (caption[2]!='') ifelse(loc.caption=='bottom',paste("\\\\ \\caption{",caption[2],"}\\\\",sep=""),"") else "","
    \\end{longtable}",
    if (size!='same') paste("\\end{", size ,"}",sep="") else "",    
    if (landscape) paste("\\end{landscape}",sep="") else "" 
    ,sep="")
    
    if (missing(file))
      cat(tex,"\n\n")    
    else 
      write(tex,file=paste(sub("\\.tex$","",file),"appendix.tex",sep=""))
   
    out$avail<-tex

  }
  
  return(invisible(out))

}

