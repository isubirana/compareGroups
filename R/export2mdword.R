export2mdword<-function(x, which.table, nmax, nmax.method, header.labels, caption, strip, first.strip, background, size, header.background, header.color){

  if (!inherits(x, "createTable"))
    stop("x must be of class 'createTable'")

  if (inherits(x, "cbind.createTable"))
    return(export2mdwordcbind(x, which.table, nmax, nmax.method, header.labels, caption, strip, first.strip, background, size, header.background, header.color))   

  ww <- charmatch(which.table, c("descr", "avail"))

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
  
  pp <- prepare(x, nmax = nmax,nmax.method=nmax.method, header.labels)
  cc <- unlist(attr(pp, "cc"))
  
  if (ww %in% c(1)) {  

    ## table1 ##
    
    table1 <- pp[[1]]
    
    ii <- ifelse(rownames(table1)[2] == "", 2, 1)
    table1 <- cbind(rownames(table1), table1)
    if (!is.null(attr(x, "caption"))){
      table1[, 1] <- paste("    ", table1[, 1])
      table1 <- cbind(NA, table1)
    }

    aux <- NULL
    for (i in (ii + 1):nrow(table1)) {
      if (!is.null(cc) && cc[i - ii] != "") {
        table1[i,1] <- cc[i - ii]
      }
      aux <- rbind(aux, table1[i, ])
    }
    
    if (!is.null(attr(x, "caption"))){
      for (i in 2:nrow(aux)){
        if (is.na(aux[i,1])) aux[i,1] <- aux[i-1,1]
      }
    }

    body <- as.data.frame(aux)
    nr <- attr(pp, "nr")  # to strip variables
    
    # row variables group
    if (!is.null(attr(x, "caption"))){ 
      body <- as_grouped_data(x = body, groups = "V1", columns=NULL)
      nr.temp <- integer()
      nr.index <- 0
      for (i in 1:nrow(body)){
        if (!is.na(body[i,1])) {
          nr.temp <- c(nr.temp, 9) 
        } else {
          nr.index <- nr.index+1
          nr.temp <- c(nr.temp, nr[nr.index])
        }
      }
      nr <- nr.temp
    }
    
    ft <- if (!is.null(attr(x, "caption"))) as_flextable(body) else flextable(body)
    if (!is.null(attr(x, "caption"))){
      gr.labels <- unlist(attr(x, "caption"))
      gr.labels <- gr.labels[gr.labels!=""]
      ft <- flextable::compose(ft, i= !is.na(body$V1), j=1, value=as_paragraph(as_chunk(gr.labels)))
      ft <- bold(ft, i=which(!is.na(body[,1])), bold=TRUE)
    }
    
    # header
    header <- data.frame(cbind(
      col_keys = colnames(body),
      t(table1[1:ii,,drop=FALSE])),
      stringsAsFactors = FALSE
    )
    ft <- set_header_df(ft, mapping = header, key = "col_keys")
    ft <- align(ft, j = 1, align = "left", part = "body")
    ft <- align(ft, j = -1, align = "center", part = "body")
    ft <- autofit(ft)
    ft <- align(ft, part="header", align="center")
    ft <- bold(ft, part="header", bold=TRUE)
    if (nmax) ft <- italic(ft, i=ii, part="header", italic = TRUE)
    ft <- hline_top(ft, part="header", border=fp_border(color="black", style="solid", width=2))
    ft <- hline(ft, part="header", i=ii, border=fp_border(color="black", style="solid", width=2))
    if (!is.null(attr(x, "caption"))){
      ft <- flextable::hline(ft, i=which(nr==9), part="body", border=fp_border(color="black", style="solid", width=1))
    }

    ## font-size
    if (!is.null(size)){
      ft <- fontsize(ft, size = size)
      ft <- fontsize(ft, part="header", size = size)
    }

    ## header background-color and color
    if (!is.null(header.background))
      ft <- bg(ft, bg = header.background, part = "header")
    if (!is.null(header.color))
      ft <- color(ft, color=header.color, part = "header")

    ## caption
    ft <- set_caption(ft, caption)
    
    ## strip
    if (strip) {
      ft <- bg(ft, i=which(nr == !first.strip), bg = background, part="body")
    }
    
    ## table position (put in the chunk)
    # Use ft.align when placing tables in a word document. See ?knit_print.flextable for more info.
    
    ## width 
    # ignored when format=word
    
    return(ft)

  }      
  if (ww %in% c(2)){
    
    # table2
    
    table2 <- pp[[2]]
    
    ii <- ifelse(rownames(table2)[2] == "", 2, 1)
    table2 <- cbind(rownames(table2), table2)
    if (!is.null(attr(x, "caption"))){
      table2[,1] <- paste0("     ",table2[,1])
      table2 <- cbind(NA, table2)
      for (i in (ii+1):nrow(table2)){
        if (attr(x, "caption")[[i-ii]]!='')
          table2[i, 1] <- attr(x, "caption")[[i-ii]]
        else 
          table2[i, 1] <- table2[i-1, 1]
      }
    }
    aux <- table2[-c(1:ii),,drop=FALSE]

    body <- as.data.frame(aux)
    
    if (!is.null(attr(x, "caption"))){
      body <- as_grouped_data(x = body, groups = "V1", columns=NULL)
      nr <- integer()
      val <- 1
      for (i in 1:nrow(body)){
        if (!is.na(body[i,1]))
          nr <- c(nr,9)
        else{
          val <- as.integer(!val)
          nr <- c(nr, val)
        }
      }
    } else {
      nr <- rep(0:1, nrow(aux))[1:nrow(aux)]  
    }
    
    ft <- if (!is.null(attr(x, "caption"))) as_flextable(body) else flextable(body)
    
    if (!is.null(attr(x, "caption"))){
      gr.labels <- unlist(attr(x, "caption"))
      gr.labels <- gr.labels[gr.labels!=""]
      ft <- flextable::compose(ft, i= !is.na(body$V1), j=1, value=as_paragraph(as_chunk(gr.labels)))
      ft <- bold(ft, i=which(!is.na(body[,1])), bold=TRUE)
    }
    # header
    header <- data.frame(cbind(
      col_keys = colnames(body),
      t(table2[1:ii,,drop=FALSE])),
      stringsAsFactors = FALSE
    )
    ft <- set_header_df(ft, mapping = header, key = "col_keys")
    ft <- align(ft, j = 1, align = "left", part = "body")
    ft <- align(ft, j = -1, align = "center", part = "body")
    ft <- autofit(ft)
    ft <- align(ft, part="header", align="center")
    ft <- bold(ft, part="header", bold=TRUE)
    if (nmax) ft <- italic(ft, i=ii, part="header", italic = TRUE)
    ft <- hline_top(ft, part="header", border=fp_border(color="black", style="solid", width=2))
    ft <- hline(ft, part="header", i=ii, border=fp_border(color="black", style="solid", width=2))
    if (!is.null(attr(x, "caption"))){
      ft <- flextable::hline(ft, i=which(nr==9), part="body", border=fp_border(color="black", style="solid", width=1))
    }
    
    ## font-size
    if (!is.null(size)){
      ft <- fontsize(ft, size = size)
      ft <- fontsize(ft, part="header", size = size)
    }
    
    ## header background-color and color
    if (!is.null(header.background))
      ft <- bg(ft, bg = header.background, part = "header")
    if (!is.null(header.color))
      ft <- color(ft, color=header.color, part = "header")
    
    ## caption
    ft <- set_caption(ft, caption)
    
    ## strip
    if (strip) {
      ft <- bg(ft, i=which(nr == !first.strip), bg = background, part="body")
    }
    ## table position (put in the chunk)
    # Use ft.align when placing tables in a word document. See ?knit_print.flextable for more info.
    
    ## width 
    # ignored when format=word
    
    return(ft)
  }    
}
