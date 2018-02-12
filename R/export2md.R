export2md<-function(x, which.table="descr", nmax=TRUE, header.labels=c(), caption=NULL, ...){
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
  
  if (ww %in% c(1)) {  
    pp <- prepare(x, nmax = nmax, header.labels)
    table1 <- prepare(x, nmax = nmax, header.labels)[[1]]
    cc <- unlist(attr(pp, "cc"))
    ii <- ifelse(rownames(table1)[2] == "", 2, 1)
    table1 <- cbind(rownames(table1), table1)
    if (!is.null(attr(x, "caption"))) 
      table1[, 1] <- paste("    ", table1[, 1])
    aux <- NULL
    for (i in (ii + 1):nrow(table1)) {
      if (!is.null(cc) && cc[i - ii] != "") {
        aux <- rbind(aux, c(cc[i - ii], rep("", ncol(table1) - 1)))
        aux <- rbind(aux, table1[i, ])
      }
      else {
        aux <- rbind(aux, table1[i, ])
      }
    }
    table1 <- rbind(table1[1:ii, ], aux)
    table1[, 1] <- sub("^    ", "&nbsp;&nbsp;&nbsp;&nbsp;", table1[, 1])
    table1[, 1] <- sub("^\\&nbsp;\\&nbsp;\\&nbsp;\\&nbsp;    ", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", table1[, 1])
    if (nrow(table1) > 1 && length(grep("^N=", trim(table1[2, 2])))) {
      wn <- grep("^N=", trim(table1[2, ]))
      nn <- paste(trim(table1[1, wn]), " ", trim(table1[2, wn]))
      table1[1, wn] <- nn
      table1 <- table1[-2, ]
    }
    align <- c("l", rep("c", ncol(table1)))
    table1[1, 1] <- " "
    colnames(table1) <- table1[1, ]
    table1 <- table1[-1, , drop = FALSE]
    return(knitr::kable(table1, align = align, row.names = FALSE, caption=caption[1], ...))
  }      
  if (ww %in% c(2)){
    table2 <- prepare(x, nmax = nmax, c())[[2]]
    table2 <- cbind(rownames(table2), table2)
    if (!is.null(attr(x, "caption"))) {
      cc <- unlist(attr(x, "caption"))
      table2[, 1] <- paste("    ", table2[, 1])
    }
    aux <- NULL
    for (i in 2:nrow(table2)) {
      if (!is.null(attr(x, "caption")) && !is.null(cc) && cc[i - 1] != "") {
        aux <- rbind(aux, c(cc[i - 1], rep("", ncol(table2) - 1)))
        aux <- rbind(aux, table2[i, ])
      } else {
        aux <- rbind(aux, table2[i, ])
      }
    }
    table2 <- rbind(table2[1, ], aux)
    table2[, 1] <- sub("^    ", "&nbsp;&nbsp;&nbsp;&nbsp;", table2[, 1])
    table2[, 1] <- sub("^\\&nbsp;\\&nbsp;\\&nbsp;\\&nbsp;    ", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", table2[, 1])
    table2[1, 1] <- " "
    align <- c("l", rep("c", ncol(table2)))
    colnames(table2) <- table2[1, ]
    table2 <- table2[-1, ,drop=FALSE]
    return(knitr::kable(table2, align = align, row.names = FALSE, caption=caption[2], ...))
  }    
}
