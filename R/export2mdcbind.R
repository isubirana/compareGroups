export2mdcbind <- function(x, which.table, nmax, header.labels, caption, strip, first.strip, background, width, size, landscape, format, header.background, header.color, position, ...){   

  if (format=="rmarkdown")
    stop("Word format not suported for 'cbind.createTable' objects")
  
  if (!inherits(x,"cbind.createTable"))
    stop("'x' must be of class 'cbind.createTable'")

  ww <- charmatch(which.table, c("descr","avail"))
  if (is.na(ww))
    stop(" argument 'which.table' must be either 'descr' or 'avail'")
    
  if (inherits(x,"missingTable"))
    if (ww != 1){
      warning(" only 'descr' table can be displayed for 'missingTable' object. Argument 'which.table' set to 'descr'")
      ww <- 1
    }      

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

  desc<-lapply(x,function(vv) prepare(vv,nmax=nmax,header.labels)[[1]])
  avail<-lapply(x,function(vv) prepare(vv,nmax=nmax,c())[[2]])
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
    aux.desc<-cbind(aux.desc,desc.i)
    aux.avail<-cbind(aux.avail,avail.i)
  }


  if (ww == 1){

    cc<-attr(prepare(x[[1]],nmax=nmax,header.labels),"cc")  
    desc <-aux.desc
    desc<-cbind(rownames(desc),desc)

    table1 <- desc
    align <- c("l", rep("c", ncol(table1)))
    table1[1, 1] <- " "
    colnames(table1) <- table1[1, ]
    colnames(table1)[-1] <- trim(colnames(table1)[-1])
    table1 <- table1[-1, , drop = FALSE]
    table1[,2:ncol(table1)] <- apply(table1[,-1,drop=FALSE],2,trim)
    # N in the second row
    n.exists <- nrow(table1) > 1 && length(grep("^N=", trim(table1[1, 2])))    
    if (format=="latex" & strip) 
      table1[((1+n.exists):nrow(table1)),ncol(table1)] <- ifelse(table1[((1+n.exists):nrow(table1)),ncol(table1)]=="", "\\vphantom{}", table1[((1+n.exists):nrow(table1)),ncol(table1)])
    if (format=="latex") caption <- gsub("%","\\\\%",caption)
    ans <- knitr::kable(table1, align = align, row.names = FALSE, caption=caption[1], format=format, 
                        booktabs=format=="latex", longtable=TRUE, linesep="", ...)
    ans <- add_indent(ans, grep("^ ",table1[,1]))
    if (width!=Inf) ans <- column_spec(ans, 1, width = width)
    # groups    
    if (!is.null(cc)){
      for (cci in 1:length(cc)){
        if (cc[cci]!=""){
          group.label <- cc[cci]
          inici <- 0
          final <- 0
        } else {
          if (cc[cci-1]!="")
            group.begin <- cci-1
          if (cci==length(cc) || cc[cci+1]!=""){
            group.end <- cci
            ans <- group_rows(ans, group.label, group.begin+n.exists, group.end+n.exists) 
          }
        }
      }
    }
    if (strip){
      nr <- attr(prepare(x[[1]], nmax, header.labels), "nr")
      ans <- row_spec(ans, which(nr==!first.strip)+n.exists, background = background)
    }
    if (n.exists){
      ans <- row_spec(ans, 1, hline_after=TRUE)
    }
    ncols <- sapply(x, function(x.i) ncol(prepare(x.i, nmax=TRUE, header.labels=character())$table1))
    # if (format=="html") ans <- add_header_above(ans, structure(c(1, ncols), names=c("\n", attr(x, "caption"))), background=header.background, color=header.color)
    if (landscape) ans <- landscape(ans)

    if (format=="latex"){
      ans <- add_header_above(ans, structure(c(1, ncols), names=c(" ", attr(x, "caption"))))    
      ans <- kable_styling(ans, latex_options = c("repeat_header"), font_size = size, position = position)
      if (n.exists) ans <- gsub("\\\\midrule", "", ans) # remove lines after N
      if (strip) ans <- gsub("\\textbackslash{}vphantom\\{\\}", "\\vphantom{}", ans, fixed=TRUE)
    }
    
    if (format=="html"){
      ans <- add_header_above(ans, structure(c(1, ncols), names=c("\n", attr(x, "caption"))))  #use the line above when kableExtra is submitted to CRAN    
      ans <- kable_styling(ans, bootstrap_options=c("striped", "condensed"), full_width = FALSE, font_size = size, position = position)
      ans <- row_spec(ans, 0, background=header.background, color=header.color)
      ans <- row_spec(ans, if (sum(sapply(x, function(x.i) sum(unlist(attr(x.i, which="nmax.pos")))))>0) 1 else 0, 
                                            italic=sum(sapply(x, function(x.i) sum(unlist(attr(x.i, which="nmax.pos")))))>0, extra_css = "border-bottom: 1px solid grey")
      ans <- sub('colspan="1"><div style="border-bottom: 1px', 'colspan="1"><div style="border-bottom: 0px',fixed = TRUE, ans)
      ans <- gsub('<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan=',    paste('<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; color: ',header.color,';padding-right: 4px; padding-left: 4px; background-color: ',header.background,';" colspan='),ans) # this would be not necessary when kableExtra will be submitted to CRAN.
    }
    
    
    return(ans)

  }



  if (ww == 2){  
    
    # cc<-attr(prepare(x[[1]],nmax=nmax,header.labels),"cc")  
    avail <-aux.avail
    avail<-cbind(rownames(avail),avail)
    table2 <- avail
    cc <- attr(x[[1]], "caption")
    if (!is.null(cc)) {
      cc <- unlist(attr(x[[1]], "caption"))
      table2[, 1] <- paste("    ", table2[, 1])
    }
    table2[1, 1] <- " "
    align <- c("l", rep("c", ncol(table2)))
    colnames(table2)[-1] <- trim(table2[1, -1])
    table2 <- table2[-1, ,drop=FALSE]
    ans <- knitr::kable(table2, align = align, row.names = FALSE, caption=caption[1], format=format, 
                        booktabs=format=="latex", longtable=TRUE, ...)
    # groups    
    if (!is.null(cc)){
      for (cci in 1:length(cc)){
        if (cc[cci]!=""){
          group.label <- cc[cci]
          inici <- 0
          final <- 0
        } else {
          if (cc[cci-1]!="")
            group.begin <- cci-1
          if (cci==length(cc) || cc[cci+1]!=""){
            group.end <- cci
            ans <- group_rows(ans, group.label, group.begin, group.end) 
          }
        }
      }
    }
    ans <- add_indent(ans, integer())
    ncols <- sapply(x, function(x.i) ncol(prepare(x.i, nmax=TRUE, header.labels=character())$table2))
    
    # if (format=="html") ans <- add_header_above(ans, structure(c(1, ncols), names=c("\n", attr(x, "caption"))), background=header.background, color=header.color)

    if (strip) ans <- row_spec(ans, which(rep(0:1, nrow(table2))[1:nrow(table2)]==!first.strip), background = background) 
    if (width!=Inf) ans <- column_spec(ans, 1, width = width)
    if (landscape) ans <- landscape(ans)
    
    if (format=="latex"){
      ans <- add_header_above(ans, structure(c(1, ncols), names=c(" ", attr(x, "caption"))))
      ans <- kable_styling(ans, latex_options = c("repeat_header"), font_size = size, position = position)
    }
    
    if (format=="html"){
      ans <- add_header_above(ans, structure(c(1, ncols), names=c("\n", attr(x, "caption")))) #use the line above when kableExtra is submitted to CRAN    
      ans <- kable_styling(ans, bootstrap_options=c("striped", "condensed"), full_width = FALSE, font_size = size, position = position)
      ans <- row_spec(ans, 0, background=header.background, color=header.color)
      ans <- row_spec(ans, 0, italic=FALSE, extra_css = "border-bottom: 1px solid grey")
      ans <- sub('colspan="1"><div style="border-bottom: 1px', 'colspan="1"><div style="border-bottom: 0px',fixed = TRUE, ans)
      ans <- gsub('<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan=',    paste('<th style="border-bottom:hidden; padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; color: ',header.color,';padding-right: 4px; padding-left: 4px; background-color: ',header.background,';" colspan='),ans) # this would be not necessary when kableExtra will be submitted to CRAN.
    }
    
    return(ans)

  }
  

}

