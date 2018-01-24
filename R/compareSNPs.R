compareSNPs <- function(formula, data, subset, na.action = NULL, sep = "", verbose = FALSE, ...) 
{
    call <- match.call()
    if (missing(data)) 
        data <- environment(formula)
    frame.call <- call("model.frame", formula = formula)
    k = length(frame.call)
    for (i in c("data", "subset", "na.action", "drop.unused.levels")) {
        if (!is.null(call[[i]])) {
            frame.call[[i]] <- call[[i]]
            k <- k + 1
            if (is.R()) 
                names(frame.call)[k] = i
        }
    }
    if (is.null(frame.call$drop.unused.levels)) 
        frame.call$drop.unused.levels <- TRUE
    if (is.null(frame.call$na.action)) 
        frame.call$na.action = na.pass
    m <- eval(frame.call, sys.parent())
    if (is.environment(data)) 
        data <- m
    if (!all(names(m) %in% names(data))) 
        stop("Invalid formula terms")
    mt <- attr(m, "terms")
    pn <- attr(mt, "term.labels")
    if (!all(pn %in% names(data))) 
        stop("Invalid formula terms")
    if (attr(mt, "response") == 0) 
        y <- NULL
    else y <- m[, 1]
    rv <- paste(deparse(mt), collapse = "")
    rv <- strsplit(rv, "~")[[1]]
    rv <- rv[length(rv)]
    rv <- trim(rv)
    rv <- strsplit(rv, " ")[[1]]
    rv <- rv[rv != ""]
    rv <- gsub("\\(", "", rv)
    rv <- gsub("\\)", "", rv)
    if (rv[1] %in% names(data)) {
        rv <- c("+", rv)
    }
    else {
        rv[1] <- trim(sub("^-", "", rv[1]))
        rv <- c("-", rv)
    }
    pos <- neg <- integer()
    for (i in 1:(length(rv)/2)) {
        if (rv[i * 2 - 1] == "+") 
            pos <- c(pos, which(names(data) == rv[i * 2]))
        if (rv[i * 2 - 1] == "-") 
            neg <- c(neg, which(names(data) == rv[i * 2]))
    }
    if (length(neg) > 0) {
        kk <- match(neg, pos)
        kk <- kk[!is.na(kk)]
        if (length(kk) > 0) 
            pos <- pos[-kk]
    }
    if (!length(pos) > 0) 
        stop("no row-variables selected")
    X <- data[rownames(m), pos, drop = FALSE]
    checkit<-try(setupSNP(X,1:ncol(X),sep=sep))
    if (inherits(checkit,"try-error"))
      stop(" some variables cannot be converted to snp")
    if (is.null(y)){
      ans <- snpQC(X,sep=sep,verbose=verbose)
      attr(ans,"groups")<-FALSE
      class(ans)<-c("compareSNPs","data.frame")
    }else{
      ans <- list()
      X.s <- split(X,y)
      for (i in 1:length(X.s))
        ans[[i]] <- snpQC(X.s[[i]], sep=sep, verbose=FALSE)
      p.miss <- sapply(1:ncol(X), function(j) fisher.test(sapply(ans,function(ans.i) unlist(ans.i[j,c("Ntyped","Miss.ct")])))$p.value)
      ans[[length(ans)+1]] <- data.frame(snps=names(X),p.miss)
      lab.y <- label(y)
      if (is.null(lab.y) || lab.y=='')
        lab.y <- names(m)[1] 
      attr(ans,"groups")<-TRUE
      names(ans)<- c(paste(lab.y," = '",levels(as.factor(y)),"'",sep=""),"Missingness test")
      class(ans)<-"compareSNPs"
    }
    ans
}
