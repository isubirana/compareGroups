prepare<-
function (x, nmax, header.labels) 
{
    varnames <- attr(x, "varnames")
    nr <- attr(x, "nr")
    desc <- x$desc
    avail <- x$avail
    nmax.pos <- attr(x, "nmax.pos")
    nmax.avail.pos <- NULL
    if (length(nmax.pos[[1]]) == 0 & length(nmax.pos[[2]]) == 0) nmax.avail.pos <- integer(0)
    if (length(nmax.pos[[1]]) == 0 & length(nmax.pos[[2]]) > 0) nmax.avail.pos <- nmax.pos[[2]] + 1
    if (length(nmax.pos[[1]]) > 0 & length(nmax.pos[[2]]) == 0) nmax.avail.pos <- 1
    if (length(nmax.pos[[1]]) > 0 & length(nmax.pos[[2]]) > 0) nmax.avail.pos <- c(1, nmax.pos[[2]])
    if (length(nmax.avail.pos) > 0 && nmax) {
        Nmax <- apply(avail[, nmax.avail.pos, drop = FALSE],2, function(x) max(as.double(x)))
    } else {
        Nmax <- NULL
        nmax <- FALSE
    }

    dd.pos <- attr(x, "dd.pos")
    j <- 1
    table1 <- NULL
    if (!is.null(attr(x, "caption"))) 
        cc <- character(0)
    for (i in 1:length(varnames)) {
        if (nr[i] == 1) {
            t.i <- desc[j, , drop = FALSE]
        }
        else {
            t.i <- rbind(rep(NA, ncol(desc)), desc[j:(j + nr[i] - 
                1), , drop = FALSE])
            rownames(t.i)[1] <- paste(varnames[i], ":", sep = "")
            rownames(t.i)[-1] <- sub(varnames[i], "", rownames(t.i)[-1], 
                fixed = TRUE)
            rownames(t.i)[-1] <- sub(": ", "    ", rownames(t.i)[-1])
            if (length(dd.pos) < ncol(t.i)) {
                t.i[1, -dd.pos] <- t.i[2, -dd.pos]
                t.i[2, -dd.pos] <- NA
            }
        }
        table1 <- rbind(table1, t.i)
        j <- j + nr[i]
        if (!is.null(attr(x, "caption"))) {
            if (attr(x, "caption")[[i]] == "") 
                cc <- c(cc, rep("", NROW(t.i)))
            else cc <- c(cc, attr(x, "caption")[[i]], rep("", 
                NROW(t.i) - 1))
        }
    }
    if (ncol(table1) == 0) table1 <- table1[-1, ]
    if (nmax) table1 <- rbind(colnames(table1), c(paste("N=", Nmax, sep = ""), rep("", ncol(table1) - length(Nmax))), table1) else table1 <- rbind(colnames(table1), table1)
    table1 <- ifelse(is.na(table1), "", table1)
    if (length(header.labels)==6 && is.null(names(header.labels))){
      names(header.labels)<-c("all","p.overall","p.trend","ratio","p.ratio","N")
    }
    if ("all"%in%names(header.labels)){
      ww.all<-grep("^\\[ALL\\]",trim(table1[1,]))
      if (length(ww.all)>0){
        ww.all<-ww.all[1]
        table1[1,ww.all]<-header.labels["all"]
      }
    }    
    if ("p.overall"%in%names(header.labels)){
      ww.p.overall<-which(table1[1,]=="p.overall")
      if (length(ww.p.overall)>0){
        ww.p.overall<-rev(ww.p.overall)[1]
        table1[1,ww.p.overall]<-header.labels["p.overall"]
      }
    }
    if ("p.trend"%in%names(header.labels)){
      ww.p.trend<-which(table1[1,]=="p.trend")
      if (length(ww.p.trend)>0){
        ww.p.trend<-rev(ww.p.trend)[1]
        table1[1,ww.p.trend]<-header.labels["p.trend"]
      }
    } 
    if ("ratio"%in%names(header.labels)){
      ww.ratio<-which(table1[1,]%in%c("OR","HR"))
      if (length(ww.ratio)>0){
        ww.ratio<-rev(ww.ratio)[1]
        table1[1,ww.ratio]<-header.labels["ratio"]
      }
    }     
    if ("p.ratio"%in%names(header.labels)){
      ww.p.ratio<-which(table1[1,]=="p.ratio")
      if (length(ww.p.ratio)>0){
        ww.p.ratio<-rev(ww.p.ratio)[1]
        table1[1,ww.p.ratio]<-header.labels["p.ratio"]
      }
    } 
    if ("N"%in%names(header.labels)){
      ww.N<-which(table1[1,]=="N")
      if (length(ww.N)>0){
        ww.N<-rev(ww.N)[1]
        table1[1,ww.N]<-header.labels["N"]
      }
    }          
    table1 <- apply(table1, 2, format, justify = "centre")
    colnames(table1) <- rep("", ncol(table1))
    table2 <- x[[2]]
    table2 <- as.matrix(table2)
    table2 <- ifelse(is.na(table2), "", table2)
    table2 <- rbind(colnames(table2), table2)
    table2 <- apply(table2, 2, format, justify = "centre")
    colnames(table2) <- rep("", ncol(table2))
    out <- list(table1 = table1, table2 = table2)
    if (!is.null(attr(x, "caption"))) attr(out, "cc") <- cc
    attr(out, "nmax") <- nmax
    out
}


