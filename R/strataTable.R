strataTable <- 
  function(x, strata, strata.names=NULL, max.nlevels = 5)
{
  
  if (missing(strata))
    stop("'strata' argument must be specified")
  
  if (!is.character(strata))
    stop("'strata' must be a character")
  
  if (length(strata)!=1)
    stop("'strata' must be a single character")
  
  if (!inherits(x, "createTable"))
    stop("'x' must be of class createTable")
  
  if (inherits(x, "cbind.createTable"))
    stop("'x' cannot be of class cbind.createTable")
    
  if (inherits(x, "rbind.createTable"))
    stop("'x' cannot be of class rbind.createTable")    

  cg <- attr(x, "x", exact = TRUE)[[1]]
  
  Xext <- attr(cg, "Xext", exact = TRUE)

  if (!strata%in%names(Xext))
    stop(strata," not found in data set")
  
  strata.var <- factor(Xext[,strata])
  if (nlevels(strata.var) > max.nlevels)
    stop("too many levels in strata variable")

  
  global.subset <- attr(cg, "subset")
  if (!is.null(global.subset))
    global.subset <- paste0(" & (",global.subset,")") 
  else 
    global.subset <- ""

  x.list <- lapply(levels(strata.var), function(i){
    subset.i <- paste0("as.factor(",strata,")=='",i,"'",global.subset)
    cg.i <- eval(parse(text=paste0("update(cg, subset=",subset.i,", simplify=FALSE)")))
    x.i <- update(x, x=cg.i)
    x.i
  })
  
  if (is.null(strata.names)) 
    strata.names <- levels(strata.var) 
  
  ans <- do.call(cbind, structure(x.list, names=strata.names))
  
  ans

}

