export2md<-function(x, which.table="descr", nmax=TRUE, header.labels=c(), caption=NULL, format="html", width=Inf, 
                    strip=FALSE, first.strip=FALSE, background="#D2D2D2", size=NULL, landscape=FALSE, 
                    header.background=NULL, header.color=NULL, position="center", ...){

  # compiled.format <- try(rmarkdown::all_output_formats(knitr::current_input())[1],silent=TRUE)
  # 
  # if (inherits(compiled.format, "try-error") || is.null(compiled.format)){
  #   warning("you are using export2md out of Rmarkdown context...")
  # } else {
  #   if (compiled.format%in%c("html_document","ioslides_presentation","slidy_presentation")) format <- "html"
  #   if (compiled.format%in%c("pdf_document","beamer_presentation")) format <- "latex"
  #   if (compiled.format=="word_document") format <- "markdown"
  # }
  
  if (missing(format)){
    format <- NA
    if (!interactive()){ # execute inside Rmarkdown
      if (knitr::is_html_output()) format="html"
      if (knitr::is_latex_output()) format="latex"
      if (!knitr::is_html_output() & !knitr::is_latex_output()) format="markdown"
      if (is.na(format)){
        warning("Unable to identify format -> HTML assigned.")
        format <- "html"
      }
    } else {# execute inside Rmarkdown
      warning("You are calling export2md outside Rmarkdown without specifying format -> html format is assigned")
      format <- "html"
    }
  }

  if (format == "markdown") 
    return(export2mdword(x, which.table, nmax, header.labels, caption, strip, first.strip, background, size, header.background, header.color))

  if (inherits(x, "cbind.createTable")) 
    return(export2mdcbind(x, which.table, nmax, header.labels, caption, strip, first.strip, background, width, size, landscape, format, header.background, header.color, position,...))

  extras <- list(...)
  if (!inherits(x, "createTable")) 
    stop("x must be of class 'createTable'")
  if (inherits(x, "cbind.createTable")) 
    stop("x cannot be of class 'cbind.createTable'")
  ww <- charmatch(which.table, c("descr", "avail"))
  if (is.na(ww)) 
    stop(" argument 'which.table' must be either 'descr' or 'avail'")
  
  if (attr(x,"groups")){
    y.name.label<-attr(x,"yname")  
  }  
  
  if (!is.null(caption)){
    if (!is.character(caption))
      stop(" argument 'caption' must be a character'")
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
  }    
  # pp <- compareGroups:::prepare(x, nmax = nmax, header.labels)
  pp <- prepare(x, nmax = nmax, header.labels)
  cc <- unlist(attr(pp, "cc"))  
  if (ww %in% c(1)) {  
    table1 <- pp[[1]]
    ii <- ifelse(rownames(table1)[2] == "", 2, 1)
    table1 <- cbind(rownames(table1), table1)
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
                        booktabs=format=="latex", longtable=FALSE, linesep="", ...)
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
      nr <- attr(pp, "nr")
      ans <- row_spec(ans, which(nr==!first.strip)+n.exists, background = background)
    }
    if (n.exists){
      ans <- row_spec(ans, 1, hline_after=TRUE)
    }

    if (landscape) ans <- landscape(ans)
    if (format=="latex"){
      ans <- kable_styling(ans, latex_options = c("repeat_header"), font_size=size, position=position)
      if (n.exists) ans <- gsub("\\\\midrule", "", ans) # remove lines after N
      if (strip) ans <- gsub("\\textbackslash{}vphantom\\{\\}", "\\vphantom{}", ans, fixed=TRUE)
    }
    if (format=="html"){
      ans <- kable_styling(ans, bootstrap_options=c("striped", "condensed"), full_width = FALSE, font_size=size, position=position)  
      ans <- row_spec(ans, 0, background=header.background, color=header.color)
      ans <- row_spec(ans, if (sum(unlist(attr(x, "nmax.pos")))>0) 1 else 0, italic=sum(unlist(attr(x, "nmax.pos")))>0, extra_css = "border-bottom: 1px solid grey")      
    }
    return(ans)
  }      
  if (ww %in% c(2)){
    # table2 <- compareGroups:::prepare(x, nmax = nmax, c())[[2]]
    table2 <- prepare(x, nmax = nmax, c())[[2]]
    table2 <- cbind(rownames(table2), table2)
    if (!is.null(attr(x, "caption"))) {
      cc <- unlist(attr(x, "caption"))
      table2[, 1] <- paste("    ", table2[, 1])
    }
    table2[1, 1] <- " "
    align <- c("l", rep("c", ncol(table2)))
    colnames(table2)[-1] <- trim(table2[1, -1])
    table2 <- table2[-1, ,drop=FALSE]
    ans <- knitr::kable(table2, align = align, row.names = FALSE, caption=caption[1], format=format, booktabs=format=="latex", longtable=FALSE, ...)
    # ans <- knitr::kable(table2, align = align, row.names = FALSE, caption=caption[1], format=format, booktabs=format=="latex")
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
    if (strip) ans <- row_spec(ans, which(rep(0:1, nrow(table2))[1:nrow(table2)]==!first.strip), background = background) 
    if (width!=Inf) ans <- column_spec(ans, 1, width = width)
    if (landscape) ans <- landscape(ans)
    if (format=="latex"){
      ans <- kable_styling(ans, latex_options = c("repeat_header"), font_size = size, position=position)
    }
    if (format=="html"){
      ans <- kable_styling(ans, bootstrap_options=c("striped", "condensed"), full_width = FALSE, font_size = size, position=position)
      ans <- row_spec(ans, 0, background=header.background, color=header.color)
      ans <- row_spec(ans, 0, italic=FALSE, extra_css = "border-bottom: 1px solid grey")
    }
    
    return(ans)
  }    
}
