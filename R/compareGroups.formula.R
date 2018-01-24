compareGroups.formula <-
function (X, data, subset, na.action = NULL, include.label = TRUE, 
    ...) 
{
    formula <- X
    call <- match.call()
    if (missing(data))
        data <- environment(formula)
    frame.call <- call("model.frame", formula = X)
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
    Xext <- data[rownames(X), , drop = FALSE]
    ans <- compareGroups(X = X, y = y, include.label = include.label, 
        Xext = Xext, ...)
    if (attr(ans, "groups")) {
        if (!is.null(attr(y, "label")) & include.label) 
            attr(ans, "yname") <- attr(y, "label")
        else attr(ans, "yname") <- names(m)[1]
    }
    else attr(ans, "yname") <- NULL
    attr(ans, "call") <- list()
    attr(ans, "call")$call <- call
    if (any(names(call) == "subset")) {
        nf <- as.character(call)
        nfs <- nf[which(names(call) == "subset")]
        for (i in 1:length(ans)) {
            selec.i <- attr(ans[[i]], "selec")
            attr(ans[[i]], "selec") <- ifelse(is.na(selec.i), 
                nfs, paste("(", nfs, ") & (", selec.i, ")", sep = ""))
        }
    }
    if (attr(ans, "groups")) 
        attr(ans, "yname.orig") <- names(m)[1]
    else attr(ans, "yname.orig") <- NULL
    attr(ans, "form") <- list()
    attr(ans, "form")$formula <- formula
    attr(ans, "form")$terms <- mt
    ans
}




