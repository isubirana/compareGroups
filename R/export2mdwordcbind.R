export2mdwordcbind <- function(x, which.table, nmax, nmax.method, header.labels, caption, strip, first.strip, background, size, header.background, header.color){   

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
    aux.desc<-cbind(aux.desc,desc.i)
    aux.avail<-cbind(aux.avail,avail.i)
  }


  if (ww == 1){

    cc<-attr(prepare(x[[1]],nmax=nmax,nmax.method=nmax.method,header.labels),"cc")  
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
    table1 <- rbind(colnames(table1), table1)
    # add stratas in header
    ncols <- sapply(x, function(x.i) ncol(prepare(x.i, nmax=TRUE,nmax.method=nmax.method, header.labels=character())$table1))
    table1 <- rbind(c("",rep(names(ncols), ncols)), table1)
    colnames(table1) <- NULL

    ii <- 1+n.exists
    if (!is.null(attr(x[[1]], "caption"))){
      table1[, 1] <- paste("    ", table1[, 1])
      table1 <- cbind(NA, table1)
    }
    ii <- ii+1
    
    aux <- NULL
    for (i in (ii + 1):nrow(table1)) {
      if (!is.null(cc) && cc[i - ii] != "") {
        table1[i,1] <- cc[i - ii]
      }
      aux <- rbind(aux, table1[i, ])
    }
    
    if (!is.null(attr(x[[1]], "caption"))){
      for (i in 2:nrow(aux)){
        if (is.na(aux[i,1])) aux[i,1] <- aux[i-1,1]
      }
    }
    
    body <- as.data.frame(aux)
    nr <- attr(prepare(x[[1]],nmax=nmax,nmax.method=nmax.method,header.labels), "nr")  # to strip variables
    
    # header
    header <- data.frame(cbind(
      col_keys = colnames(body),
      t(table1[1:ii,,drop=FALSE])),
      stringsAsFactors = FALSE
    )

    # row variables group
    if (!is.null(attr(x[[1]], "caption"))){ 
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
    
    ft <- if (!is.null(attr(x[[1]], "caption"))) as_flextable(body) else flextable(body)
    if (!is.null(attr(x[[1]], "caption"))){
      gr.labels <- unlist(attr(x, "caption"))
      gr.labels <- gr.labels[gr.labels!=""]
      ft <- flextable::compose(ft, i= which(!is.na(body$V1)), j=1, value=as_paragraph(as_chunk(gr.labels)))
      ft <- bold(ft, i=which(!is.na(body[,1])), bold=TRUE)
    }
    ft <- set_header_df(ft, mapping = header, key = "col_keys")
    ft <- align(ft, j = 1, align = "left", part = "body")
    ft <- align(ft, j = -1, align = "center", part = "body")
    ft <- autofit(ft)
    ft <- align(ft, part="header", align="center")
    ft <- bold(ft, part="header", bold=TRUE)
    if (nmax) ft <- italic(ft, i=ii, part="header", italic = TRUE)
    ft <- hline_top(ft, part="header", border=fp_border(color="black", style="solid", width=2))
    ft <- hline(ft, part="header", i=ii, border=fp_border(color="black", style="solid", width=2))
    ft <- hline(ft, part="header", i=1, j=-1, border=fp_border(color="black", style="solid", width=1))
    if (!is.null(attr(x, "caption"))){
      ft <- flextable::hline(ft, i=which(nr==9), part="body", border=fp_border(color="black", style="solid", width=1))
    }
    
    ## merge groups 
    ft <- merge_h(ft, i=1, part="header")
    
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

  ### available table

  if (ww == 2){  
    
    avail <-aux.avail
    avail<-cbind(rownames(avail),avail)
    table2 <- avail
    cc <- attr(x[[1]], "caption")
    if (!is.null(cc)) {
      cc <- unlist(attr(x[[1]], "caption"))
      table2[, 1] <- paste("    ", table2[, 1])
      table2 <- cbind(NA, table2)
    }
    
    ncols <- sapply(x, function(x.i) ncol(prepare(x.i, nmax=TRUE,nmax.method=nmax.method, header.labels=character())$table2))
    table2 <- rbind(c("", "", rep(names(ncols), ncols)), table2)
    colnames(table2) <- NULL
    
    aux <- NULL
    for (i in 3:nrow(table2)) {
      if (!is.null(cc) && cc[i-2] != "") {
        table2[i,1] <- cc[i-2]
      }
      aux <- rbind(aux, table2[i, ])
    }
    
    if (!is.null(attr(x[[1]], "caption"))){
      for (i in 2:nrow(aux)){
        if (is.na(aux[i,1])) aux[i,1] <- aux[i-1,1]
      }
    }
    
    body <- as.data.frame(aux)
    nr <- attr(prepare(x[[1]],nmax=nmax,nmax.method=nmax.method,header.labels), "nr")  # to strip variables
    
    # header
    header <- data.frame(cbind(
      col_keys = colnames(body),
      t(table2[1:2,,drop=FALSE])),
      stringsAsFactors = FALSE
    )
    
    # row variables group
    if (!is.null(attr(x[[1]], "caption"))){ 
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
    
    ft <- if (!is.null(attr(x[[1]], "caption"))) as_flextable(body) else flextable(body)
    if (!is.null(attr(x[[1]], "caption"))){
      gr.labels <- unlist(attr(x, "caption"))
      gr.labels <- gr.labels[gr.labels!=""]
      ft <- flextable::compose(ft, i= !is.na(body$V1), j=1, value=as_paragraph(as_chunk(gr.labels)))
      ft <- bold(ft, i=which(!is.na(body[,1])), bold=TRUE)
    }
    ft <- set_header_df(ft, mapping = header, key = "col_keys")
    ft <- align(ft, j = 1, align = "left", part = "body")
    ft <- align(ft, j = -1, align = "center", part = "body")
    ft <- autofit(ft)
    ft <- align(ft, part="header", align="center")
    ft <- bold(ft, part="header", bold=TRUE)
    ft <- hline_top(ft, part="header", border=fp_border(color="black", style="solid", width=2))
    ft <- hline(ft, part="header", i=2, border=fp_border(color="black", style="solid", width=2))
    ft <- hline(ft, part="header", i=1, j=-1, border=fp_border(color="black", style="solid", width=1))
    if (!is.null(attr(x, "caption"))){
      ft <- flextable::hline(ft, i=which(nr==9), part="body", border=fp_border(color="black", style="solid", width=1))
    }
    
    ## merge groups 
    ft <- merge_h(ft, i=1, part="header")
    
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

