export2html<-function(x, file, which.table="descr", nmax=TRUE, header.labels=c(), ...){
    if (!inherits(x, "createTable")) 
        stop("x must be of class 'createTable'")
    if (inherits(x, "cbind.createTable")) 
        stop("x cannot be of class 'cbind.createTable'")
    ww <- charmatch(which.table, c("descr", "avail", "both"))
    if (is.na(ww)) 
        stop(" argument 'which.table' must be either 'descr', 'avail' or 'both'")
    if (ww %in% c(1, 3)) {
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
            nn <- paste(trim(table1[1, wn]), "<br/>", trim(table1[2, wn]))
            table1[1, wn] <- nn
            table1 <- table1[-2, ]
        }
        align <- c("l", "l", rep("c", ncol(table1) - 1))
        table1[1, 1] <- " "
        colnames(table1) <- table1[1, ]
        table1 <- table1[-1, ,drop=FALSE]
        if (!missing(file) && is.character(file))
          print(xtable(table1, align = align), type = "html", file = file, include.rownames = FALSE, sanitize.text.function = function(x) x)
        else{
          xcode <- print(xtable(table1, align = align), type = "html", include.rownames = FALSE, sanitize.text.function = function(x) x)
          return(invisible(xcode))
        }
    }
    if (ww %in% c(2, 3)) {
        table2 <- prepare(x, nmax = nmax, c())[[2]]
        table2 <- cbind(rownames(table2), table2)
          if (!is.null(attr(x, "caption"))) {
            cc <- unlist(attr(x, "caption"))
            table2[, 1] <- paste("    ", table2[, 1])
        }
        aux <- NULL
        for (i in 2:nrow(table2)) {
            if (!is.null(attr(x, "caption")) && !is.null(cc) && cc[i - 1] != "") {
                aux <- rbind(aux, c(cc[i - 1], rep("", ncol(table2) - 
                  1)))
                aux <- rbind(aux, table2[i, ])
            }
            else {
                aux <- rbind(aux, table2[i, ])
            }
        }
        table2 <- rbind(table2[1, ], aux)
        table2[, 1] <- sub("^    ", "&nbsp;&nbsp;&nbsp;&nbsp;", table2[, 1])
        table2[, 1] <- sub("^\\&nbsp;\\&nbsp;\\&nbsp;\\&nbsp;    ", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;", table2[, 1])
        table2[1, 1] <- " "
        align <- c("l", "l", rep("c", ncol(table2) - 1))
        colnames(table2) <- table2[1, ]
        table2 <- table2[-1, ,drop=FALSE]
        if (!missing(file) && is.character(file)){
          file.save<-paste(sub("\\.html$","",file),"_appendix.html",sep="")
          print(xtable(table2, align = align), type = "html", file = file.save, include.rownames = FALSE, sanitize.text.function = function(x) x)
        } else{
          xcode <- print(xtable(table2, align = align), type = "html", include.rownames = FALSE, sanitize.text.function = function(x) x)        
          return(invisible(xcode))
        }
    }
}




