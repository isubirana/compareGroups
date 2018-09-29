compareGroups <-
function (formula, data, subset, na.action = NULL, y = NULL, Xext = NULL, selec = NA, method = 1, 
          timemax = NA, alpha = 0.05, min.dis = 5, max.ylev = 5, max.xlev = 10, include.label = TRUE, Q1 = 0.25, Q3 = 0.75, 
          simplify = TRUE, ref = 1, ref.no = NA, fact.ratio = 1, ref.y = 1, p.corrected = TRUE, compute.ratio = TRUE, 
          include.miss = FALSE, oddsratio.method = "midp", chisq.test.perm = FALSE, byrow = FALSE, chisq.test.B = 2000, 
          chisq.test.seed = NULL, Date.format = "d-mon-Y", var.equal = TRUE) 
{
    tibble <- FALSE
    if (missing(formula)) 
      formula <- as.formula(" ~ . ")
    else {
      if (inherits(formula, "matrix") || inherits(formula, "data.frame")){
        if (!missing(data))
          warning("data argument will be ignored since formula is already a data set")
        data <- formula
        formula <- as.formula(" ~ . ")
      } else {
        if (!is.null(y)){
          if (inherits(formula,"formula")){
            if (length(formula)>2){ # response variable specifyied in formula and in y argument!!
              formula <- as.formula(paste0("~", as.character(formula)[[3]]))
              stop("you cannot specify a response variable on left hand side of '~' and 'y' argument at the same time.")
            }
          }
        }
      }
    }

    call <- match.call()
    if (missing(data))
        data <- environment(formula)
    else{   # needed to handle tibbles
      if (!inherits(data, "data.frame"))
        stop("data must be a data.frame")
      if (inherits(data, "tbl_df")){ # can handle tibble data.frames
        tibble <- TRUE
        data <- as.data.frame(data)
        vl <- sapply(data, attr, which="labels", exact=TRUE) # store value.labels
      }
    }
    
    # remove labelled class (for incompatibility with haven and Hmisc)
    for (i in 1:ncol(data)){
      if (inherits(data[,i],"labelled"))
        class(data[,i]) <- class(data[,i])[class(data[,i])!="labelled"]
      if (!is.null(y))
        class(y) <- class(y)[class(y)!="labelled"]
    }

    if (!is.null(y)){
      if (length(y)!=NROW(data))
        stop("y must be the same lenght of data (rows)")
      names(y) <- rownames(data)
    }

    frame.call <- call("model.frame", formula = formula)

    k = length(frame.call)
    for (i in c("data", "subset", "na.action", "drop.unused.levels")) {
    # for (i in c("subset", "na.action", "drop.unused.levels")) {
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
    frame.call[["data"]] <- data # in data, non standard characters in names are replaced by . (tibbles)

    m <- eval(frame.call, sys.parent())

    if (is.environment(data))
      data <- m
    if (!all(names(m) %in% names(data)))
      stop("Invalid formula terms")
    
    mt <- attr(m, "terms")
    pn <- attr(mt, "term.labels")
    if (!all(pn %in% names(data))) 
      stop("Invalid formula terms")
    
    
    if (is.null(y)){
      if (attr(mt, "response") == 0) 
        y <- NULL
      else 
        y <- m[, 1]
    } else {
      lab.y <- attr(y, "label", exact=TRUE)
      y <- y[rownames(m)]
      attr(y, "label") <- lab.y      
    }
    
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
    
    
    Xext <- data[rownames(m), ]

    X <- Xext[, pos, drop = FALSE]
    
    # put labels
    for (i in 1:length(pos)){
      # value labels
      if (tibble){
        vl.i <- vl[[names(data)[pos[i]]]]
        if (!is.null(vl.i)){
          X[,i] <- factor(X[,i], levels=vl.i, labels=names(vl.i)) # non labelled codes will be set to NA
        }
      }
      # variable label
      lab.i <- attr(data[,pos[i]], "label", exact=TRUE)
      if (!is.null(lab.i) & include.label)
        attr(X[,i], "label") <- lab.i
      else
        attr(X[,i], "label") <- names(data)[pos[i]]
    }
    
    cmd <- paste0("compareGroups.fit(X = X, y = y, include.label = include.label, Xext = Xext, selec = ", deparse(substitute(selec)), ", 
                  method = method, timemax = timemax, alpha = alpha, min.dis = min.dis, max.ylev = max.ylev, 
                  max.xlev = max.xlev, Q1 = Q1, Q3 = Q3, simplify = simplify, ref = ref, ref.no = ref.no, 
                  fact.ratio = fact.ratio, ref.y = ref.y, p.corrected = p.corrected, compute.ratio = compute.ratio, 
                  include.miss = include.miss, oddsratio.method = oddsratio.method, chisq.test.perm = chisq.test.perm, byrow = byrow, 
                  chisq.test.B = chisq.test.B, chisq.test.seed = chisq.test.seed, Date.format = Date.format, var.equal=var.equal)")

    ans <- eval(parse(text=cmd))
    
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
        attr(ans, "subset") <- nfs
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




