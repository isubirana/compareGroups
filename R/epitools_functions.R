##############
oddsratio <- function (x, method = c("midp", "fisher", "wald", "small"), conf.level = 0.95){
  x <- epitable(x, rev = "neither")
  method <- match.arg(method)
  if (method == "midp") rr <- oddsratio.midp(x, conf.level = conf.level)
  if (method == "fisher") rr <- oddsratio.fisher(x, conf.level = conf.level)
  if (method == "wald") rr <- oddsratio.wald(x, conf.level = conf.level)
  if (method == "small") rr <- oddsratio.small(x, conf.level = conf.level)
  rr
}

###############
riskratio <- function (x, method = c("wald", "small", "boot"), conf.level = 0.95){
  x <- epitable(x, rev = "neither")
  method <- match.arg(method)
  if (method == "wald") rr <- riskratio.wald(x, conf.level = conf.level)
  if (method == "small") rr <- riskratio.small(x, conf.level = conf.level)
  if (method == "boot") rr <- riskratio.boot(x, conf.level = conf.level)
  rr
}

##############
epitable <- function (..., ncol = 2, byrow = TRUE, rev = c("neither", "rows", "columns", "both")) {
  lx <- list(...)
  if (length(lx) == 0) {
    stop("No arguments provided")
  }
  if (length(lx) == 1 && (is.character(lx[[1]]) || is.factor(lx[[1]]))) {
    stop("Single factor or character vector not allowed.")
  }
  if (length(lx) == 1 && is.matrix(lx[[1]]) && nrow(lx[[1]]) >= 
      2 && ncol(lx[[1]]) >= 2) {
    x <- lx[[1]]
    if (is.null(dimnames(lx[[1]]))) {
      nr <- nrow(x)
      nc <- ncol(x)
      rn <- paste("Exposed", 1:nr, sep = "")
      cn <- paste("Disease", 1:nc, sep = "")
      dimnames(x) <- list(Predictor = rn, Outcome = cn)
    }
  }
  if (length(lx) == 2 && (is.vector(lx[[1]]) || is.factor(lx[[1]])) && 
      (is.vector(lx[[2]]) || is.factor(lx[[2]]))) {
    x <- table(lx[[1]], lx[[2]])
    if (nrow(x) < 2 || ncol(x) < 2) {
      stop("must have 2 or more rows and columns")
    }
    if (is.null(names(lx))) {
      names(dimnames(x)) <- c("Predictor", "Outcome")
    }
    else names(dimnames(x)) <- names(lx)
  }
  is.even <- function(x) {
    ifelse(x%%2 == 0, TRUE, FALSE)
  }
  if (length(lx) >= 4 && all(sapply(list(1, 2, 3, 4, 5), is.numeric)) && 
      is.even(length(lx)) && all(sapply(lx, length) == 1)) {
    x <- matrix(sapply(lx, as.vector), ncol = ncol, byrow = byrow)
    nr <- nrow(x)
    nc <- ncol(x)
    rn <- paste("Exposed", 1:nr, sep = "")
    cn <- paste("Disease", 1:nc, sep = "")
    dimnames(x) <- list(Predictor = rn, Outcome = cn)
  }
  if (length(lx) == 1 && is.vector(lx[[1]]) && is.numeric(lx[[1]]) && 
      is.even(length(lx[[1]]))) {
    x <- matrix(lx[[1]], ncol = ncol, byrow = byrow)
    nr <- nrow(x)
    nc <- ncol(x)
    rn <- paste("Exposed", 1:nr, sep = "")
    cn <- paste("Disease", 1:nc, sep = "")
    dimnames(x) <- list(Predictor = rn, Outcome = cn)
  }
  nrx <- nrow(x)
  ncx <- ncol(x)
  reverse <- match.arg(rev)
  if (reverse == "rows") 
    finalx <- x[nrx:1, ]
  if (reverse == "columns") 
    finalx <- x[, ncx:1]
  if (reverse == "both") 
    finalx <- x[nrx:1, ncx:1]
  if (reverse == "neither") 
    finalx <- x
  finalx
}


###############
oddsratio.midp <- function (x, conf.level = 0.95) {
  interval <- c(0, 1000)
  x <- epitable(x, rev = "neither")
  tmx <- table.margins(x)
  p.exposed <- sweep(tmx, 2, tmx["Total", ], "/")
  p.outcome <- sweep(tmx, 1, tmx[, "Total"], "/")
  nr <- nrow(x)
  midp <- matrix(NA, nr, 3)
  midp[1, 1] <- 1
  for (i in 2:nr) {
    a0 <- x[1, 2]
    b0 <- x[1, 1]
    a1 <- x[i, 2]
    b1 <- x[i, 1]
    tmpx <- matrix(c(a1, a0, b1, b0), 2, 2, byrow = TRUE)
    OR <- or.midp(tmpx, conf.level = conf.level, interval = interval)
    midp[i, ] <- c(OR$estimate, OR$conf.int)
  }
  pv <- tab2by2.test(x)
  colnames(midp) <- c("estimate", "lower", "upper")
  rownames(midp) <- rownames(x)
  cn2 <- paste("odds ratio with", paste(100 * conf.level, "%", 
                                        sep = ""), "C.I.")
  names(dimnames(midp)) <- c(names(dimnames(x))[1], cn2)
  rr <- list(x = x, data = tmx, p.exposed = p.exposed, p.outcome = p.outcome, 
             measure = midp, conf.level = conf.level, p.value = pv$p.value, 
             correction = pv$correction)
  rrs <- list(data = tmx, measure = midp, p.value = pv$p.value, 
              correction = pv$correction)
  attr(rr, "method") <- "median-unbiased estimate & mid-p exact CI"
  attr(rrs, "method") <- "median-unbiased estimate & mid-p exact CI"
  verbose <- FALSE
  if (verbose == FALSE) {
    rrs
  }
  else rr
}

##################
table.margins <- function (x) {
  if (!is.array(x)) 
    stop("x is not an array")
  dd <- dim(x)
  y <- matrix(x, nrow = dd[1])
  z <- rbind(y, apply(y, 2, sum))
  y2 <- matrix(t(z), nrow = dd[2])
  z2 <- rbind(y2, apply(y2, 2, sum))
  z3 <- t(matrix(t(z2), nrow = prod(dd[-c(1, 2)])))
  fin <- array(z3, c(dd[1:2] + 1, dd[-c(1, 2)]))
  rownames(fin) <- c(rownames(x, do.NULL = FALSE), "Total")
  colnames(fin) <- c(colnames(x, do.NULL = FALSE), "Total")
  if (!is.null(names(dimnames(x)))) {
    names(dimnames(fin)) <- names(dimnames(x))
  }
  fin
}



############
or.midp <- function (x, conf.level = 0.95, byrow = TRUE, interval = c(0,1000)){
  if (is.vector(x)) {
    if (!is.numeric(x)) {
      stop("vector must be numeric")
    }
    if (length(x) != 4) {
      stop("vector must be of length 4")
    }
    x <- matrix(x, 2, 2, byrow = byrow)
  }
  if (is.matrix(x)) {
    if (!is.numeric(x)) {
      stop("matrix must be numeric")
    }
    if (nrow(x) != 2 || ncol(x) != 2) {
      stop("must be 2 x 2 matrix")
    }
    a1 <- x[1, 1]
    a0 <- x[1, 2]
    b1 <- x[2, 1]
    b0 <- x[2, 2]
  }
  else {
    stop("must be numeric vector of length=4 or 2x2 numeric matrix")
  }
  mue <- function(a1, a0, b1, b0, or) {
    mm <- matrix(c(a1, a0, b1, b0), 2, 2, byrow = TRUE)
    fisher.test(mm, or = or, alternative = "l")$p - fisher.test(x = x, 
                                                                or = or, alternative = "g")$p
  }
  midp <- function(a1, a0, b1, b0, or = 1) {
    mm <- matrix(c(a1, a0, b1, b0), 2, 2, byrow = TRUE)
    lteqtoa1 <- fisher.test(mm, or = or, alternative = "l")$p.val
    gteqtoa1 <- fisher.test(mm, or = or, alternative = "g")$p.val
    0.5 * (lteqtoa1 - gteqtoa1 + 1)
  }
  alpha <- 1 - conf.level
  EST <- uniroot(function(or) {
    mue(a1, a0, b1, b0, or)
  }, interval = interval)$root
  LCL <- uniroot(function(or) {
    1 - midp(a1, a0, b1, b0, or) - alpha/2
  }, interval = interval)$root
  UCL <- 1/uniroot(function(or) {
    midp(a1, a0, b1, b0, or = 1/or) - alpha/2
  }, interval = interval)$root
  rr <- list(x = x, estimate = EST, conf.int = c(LCL, UCL), 
             conf.level = conf.level)
  attr(rr, "method") <- "median-unbiased estimate & mid-p exact CI"
  return(rr)
}

#######
tab2by2.test <- function(x) {
  correction = FALSE
  x <- epitable(x, rev = "neither")
  nr <- nrow(x)
  nc <- ncol(x)
  fish <- chi2 <- midp <- rep(NA, nr)
  for (i in 2:nr) {
    xx <- x[c(1, i), ]
    a0 <- x[1, 2]
    b0 <- x[1, 1]
    a1 <- x[i, 2]
    b1 <- x[i, 1]
    fish[i] <- fisher.test(xx)$p.value
    chi2[i] <- chisq.test(xx, correct = FALSE)$p.value
    midp[i] <- ormidp.test(a1, a0, b1, b0)$two.sided
  }
  pv <- cbind(midp, fish, chi2)
  colnames(pv) <- c("midp.exact", "fisher.exact", "chi.square")
  rownames(pv) <- rownames(x)
  names(dimnames(pv)) <- c(names(dimnames(x))[1], "two-sided")
  list(x = x, p.value = pv, correction = FALSE)
}

######
ormidp.test <- function (a1, a0, b1, b0, or = 1) {
  x <- matrix(c(a1, a0, b1, b0), 2, 2, byrow = TRUE)
  lteqtoa1 <- fisher.test(x, or = or, alternative = "l")$p.val
  gteqtoa1 <- fisher.test(x, or = or, alternative = "g")$p.val
  pval1 <- 0.5 * (lteqtoa1 - gteqtoa1 + 1)
  one.sided <- min(pval1, 1 - pval1)
  two.sided <- 2 * one.sided
  data.frame(one.sided = one.sided, two.sided = two.sided)
}

#########
oddsratio.fisher <- function (x, conf.level = 0.95){
  correction <- FALSE
  verbose <- FALSE
  x <- epitable(x, rev = "neither")
  tmx <- table.margins(x)
  p.exposed <- sweep(tmx, 2, tmx["Total", ], "/")
  p.outcome <- sweep(tmx, 1, tmx[, "Total"], "/")
  nr <- nrow(x)
  fisher <- matrix(NA, nr, 3)
  fisher[1, 1] <- 1
  for (i in 2:nr) {
    xx <- rbind(x[1, ], x[i, ])
    ftestxx <- fisher.test(xx, conf.level = conf.level)
    est <- ftestxx$estimate
    ci <- ftestxx$conf.int
    fisher[i, ] <- c(est, ci)
  }
  pv <- tab2by2.test(x)
  colnames(fisher) <- c("estimate", "lower", "upper")
  rownames(fisher) <- rownames(x)
  cn2 <- paste("odds ratio with", paste(100 * conf.level, "%", 
                                        sep = ""), "C.I.")
  names(dimnames(fisher)) <- c(names(dimnames(x))[1], cn2)
  rr <- list(x = x, data = tmx, p.exposed = p.exposed, p.outcome = p.outcome, 
             measure = fisher, conf.level = conf.level, p.value = pv$p.value, 
             correction = pv$correction)
  rrs <- list(data = tmx, measure = fisher, p.value = pv$p.value, 
              correction = pv$correction)
  attr(rr, "method") <- "Conditional MLE & exact CI from 'fisher.test'"
  attr(rrs, "method") <- "Conditional MLE & exact CI from 'fisher.test'"
  if (verbose == FALSE) {
    rrs
  }
  else rr
}


#######
oddsratio.wald <- function (x, conf.level = 0.95){
  correction <- FALSE
  verbose <- FALSE
  x <- epitable(x, rev = "neither")
  tmx <- table.margins(x)
  p.exposed <- sweep(tmx, 2, tmx["Total", ], "/")
  p.outcome <- sweep(tmx, 1, tmx[, "Total"], "/")
  Z <- qnorm(0.5 * (1 + conf.level))
  nr <- nrow(x)
  wald <- matrix(NA, nr, 3)
  wald[1, 1] <- 1
  for (i in 2:nr) {
    a0 <- x[1, 2]
    b0 <- x[1, 1]
    a1 <- x[i, 2]
    b1 <- x[i, 1]
    est <- (b0 * a1)/(a0 * b1)
    logOR <- log(est)
    SElogOR <- sqrt((1/b0) + (1/a0) + (1/b1) + (1/a1))
    ci <- exp(logOR + c(-1, 1) * Z * SElogOR)
    wald[i, ] <- c(est, ci)
  }
  pv <- tab2by2.test(x)
  colnames(wald) <- c("estimate", "lower", "upper")
  rownames(wald) <- rownames(x)
  cn2 <- paste("odds ratio with", paste(100 * conf.level, "%", 
                                        sep = ""), "C.I.")
  names(dimnames(wald)) <- c(names(dimnames(x))[1], cn2)
  rr <- list(x = x, data = tmx, p.exposed = p.exposed, p.outcome = p.outcome, 
             measure = wald, conf.level = conf.level, p.value = pv$p.value, 
             correction = pv$correction)
  rrs <- list(data = tmx, measure = wald, p.value = pv$p.value, 
              correction = pv$correction)
  attr(rr, "method") <- "Unconditional MLE & normal approximation (Wald) CI"
  attr(rrs, "method") <- "Unconditional MLE & normal approximation (Wald) CI"
  if (verbose == FALSE) {
    rrs
  }
  else rr
}

######
oddsratio.small <- function (x, conf.level = 0.95){
  correction <- FALSE
  verbose <- FALSE
  x <- epitable(x, rev = "neither")
  tmx <- table.margins(x)
  p.exposed <- sweep(tmx, 2, tmx["Total", ], "/")
  p.outcome <- sweep(tmx, 1, tmx[, "Total"], "/")
  Z <- qnorm(0.5 * (1 + conf.level))
  nr <- nrow(x)
  small <- matrix(NA, nr, 3)
  or <- rep(NA, nr)
  small[1, 1] <- 1
  for (i in 2:nr) {
    a0 <- x[1, 2]
    b0 <- x[1, 1]
    a1 <- x[i, 2]
    b1 <- x[i, 1]
    or[i] <- (b0 * a1)/(a0 * b1)
    est <- (b0 * a1)/((a0 + 1) * (b1 + 1))
    logORss <- log(((b0 + 0.5) * (a1 + 0.5))/((a0 + 0.5) * 
                                                (b1 + 0.5)))
    SElogORss <- sqrt((1/(b0 + 0.5)) + (1/(a0 + 0.5)) + (1/(b1 + 
                                                              0.5)) + (1/(a1 + 0.5)))
    ci <- exp(logORss + c(-1, 1) * Z * SElogORss)
    small[i, ] <- c(est, ci)
  }
  if (any(or, na.rm = TRUE) < 1) {
    cat("CAUTION: At least one unadjusted odds ratio < 1.\nDo not use small sample-adjusted OR to esimate 1/OR.", 
        fill = 1)
  }
  pv <- tab2by2.test(x)
  colnames(small) <- c("estimate", "lower", "upper")
  rownames(small) <- rownames(x)
  cn2 <- paste("odds ratio with", paste(100 * conf.level, "%", 
                                        sep = ""), "C.I.")
  names(dimnames(small)) <- c(names(dimnames(x))[1], cn2)
  rr <- list(x = x, data = tmx, p.exposed = p.exposed, p.outcome = p.outcome, 
             measure = small, conf.level = conf.level, p.value = pv$p.value, 
             correction = pv$correction)
  rrs <- list(data = tmx, measure = small, p.value = pv$p.value, 
              correction = pv$correction)
  attr(rr, "method") <- "small sample-adjusted UMLE & normal approx (Wald) CI"
  attr(rrs, "method") <- "small sample-adjusted UMLE & normal approx (Wald) CI"
  if (verbose == FALSE) {
    rrs
  }
  else rr
}


#####
riskratio.small <- function(x, conf.level = 0.95){
  correction <- FALSE
  verbose <- FALSE
  x <- epitable(x, rev = "neither")
  tmx <- table.margins(x)
  p.exposed <- sweep(tmx, 2, tmx["Total", ], "/")
  p.outcome <- sweep(tmx, 1, tmx[, "Total"], "/")
  Z <- qnorm(0.5 * (1 + conf.level))
  nr <- nrow(x)
  small <- matrix(NA, nr, 3)
  small[1, 1] <- 1
  for (i in 2:nr) {
    a0 <- x[1, 2]
    b0 <- x[1, 1]
    a1 <- x[i, 2]
    b1 <- x[i, 1]
    n1 <- a1 + b1
    n0 <- a0 + b0
    m0 <- b0 + b1
    m1 <- a0 + a1
    est <- (a1/n1)/((a0 + 1)/(n0 + 1))
    logRR <- log(est)
    SElogRR <- sqrt((1/a1) - (1/n1) + (1/a0) - (1/n0))
    ci <- exp(logRR + c(-1, 1) * Z * SElogRR)
    small[i, ] <- c(est, ci)
  }
  pv <- tab2by2.test(x)
  colnames(small) <- c("estimate", "lower", "upper")
  rownames(small) <- rownames(x)
  cn2 <- paste("risk ratio with", paste(100 * conf.level, "%", 
                                        sep = ""), "C.I.")
  names(dimnames(small)) <- c(names(dimnames(x))[1], cn2)
  rr <- list(x = x, data = tmx, p.exposed = p.exposed, p.outcome = p.outcome, 
             measure = small, conf.level = conf.level, p.value = pv$p.value, 
             correction = pv$correction)
  rrs <- list(data = tmx, measure = small, p.value = pv$p.value, 
              correction = pv$correction)
  attr(rr, "method") <- "small sample-adjusted UMLE & normal approx (Wald) CI"
  attr(rrs, "method") <- "small sample-adjusted UMLE & normal approx (Wald) CI"
  if (verbose == FALSE) {
    rrs
  }
  else rr
}

####
riskratio.wald <- function (x, conf.level = 0.95){
  correction <- FALSE
  verbose <- FALSE
  x <- epitable(x, rev = "neither")
  tmx <- table.margins(x)
  p.exposed <- sweep(tmx, 2, tmx["Total", ], "/")
  p.outcome <- sweep(tmx, 1, tmx[, "Total"], "/")
  Z <- qnorm(0.5 * (1 + conf.level))
  nr <- nrow(x)
  wald <- matrix(NA, nr, 3)
  wald[1, 1] <- 1
  for (i in 2:nr) {
    a0 <- x[1, 2]
    b0 <- x[1, 1]
    a1 <- x[i, 2]
    b1 <- x[i, 1]
    n1 <- a1 + b1
    n0 <- a0 + b0
    m0 <- b0 + b1
    m1 <- a0 + a1
    est <- (a1/n1)/(a0/n0)
    logRR <- log(est)
    SElogRR <- sqrt((1/a1) - (1/n1) + (1/a0) - (1/n0))
    ci <- exp(logRR + c(-1, 1) * Z * SElogRR)
    wald[i, ] <- c(est, ci)
  }
  pv <- tab2by2.test(x)
  colnames(wald) <- c("estimate", "lower", "upper")
  rownames(wald) <- rownames(x)
  cn2 <- paste("risk ratio with", paste(100 * conf.level, "%", 
                                        sep = ""), "C.I.")
  names(dimnames(wald)) <- c(names(dimnames(x))[1], cn2)
  rr <- list(x = x, data = tmx, p.exposed = p.exposed, p.outcome = p.outcome, 
             measure = wald, conf.level = conf.level, p.value = pv$p.value, 
             correction = pv$correction)
  rrs <- list(data = tmx, measure = wald, p.value = pv$p.value, 
              correction = pv$correction)
  attr(rr, "method") <- "Unconditional MLE & normal approximation (Wald) CI"
  attr(rrs, "method") <- "Unconditional MLE & normal approximation (Wald) CI"
  if (verbose == FALSE) {
    rrs
  }
  else rr
}

#####
riskratio.boot <- function (x, conf.level = 0.95){
  correction <- FALSE
  verbose <- FALSE
  replicates <- 5000
  x <- epitable(x, rev = "neither")
  tmx <- table.margins(x)
  p.exposed <- sweep(tmx, 2, tmx["Total", ], "/")
  p.outcome <- sweep(tmx, 1, tmx[, "Total"], "/")
  Z <- qnorm(0.5 * (1 + conf.level))
  nr <- nrow(x)
  boot <- matrix(NA, nr, 3)
  boot[1, 1] <- 1
  rr.boot <- function(a1, a0, b1, b0, conf.level = 0.95, replicates = 5000) {
    alpha <- 1 - conf.level
    n1 <- a1 + b1
    n0 <- a0 + b0
    p1 <- a1/n1
    p0 <- a0/n0
    r1 <- rbinom(replicates, n1, p1)/n1
    r0 <- rbinom(replicates, n0, p0)/n0
    rrboot <- r1/r0
    rrbar <- mean(rrboot, na.rm = T)
    ci <- quantile(rrboot, c(alpha/2, 1 - alpha/2), na.rm = T)
    list(p0 = p0, p1 = p1, rr = p1/p0, rr.mean = rrbar, conf.level = conf.level, 
         conf.int = unname(ci), replicates = replicates)
  }
  for (i in 2:nr) {
    a0 <- x[1, 2]
    b0 <- x[1, 1]
    a1 <- x[i, 2]
    b1 <- x[i, 1]
    rrb <- rr.boot(a1 = a1, a0 = a0, b1 = b1, b0 = b0, conf.level = conf.level, 
                   replicates = replicates)
    boot[i, ] <- c(rrb$rr, rrb$conf.int)
  }
  pv <- tab2by2.test(x)
  colnames(boot) <- c("estimate", "lower", "upper")
  rownames(boot) <- rownames(x)
  cn2 <- paste("risk ratio with", paste(100 * conf.level, "%", 
                                        sep = ""), "C.I.")
  names(dimnames(boot)) <- c(names(dimnames(x))[1], cn2)
  rr <- list(x = x, data = tmx, p.exposed = p.exposed, p.outcome = p.outcome, 
             measure = boot, replicates = rrb$replicates, p.value = pv$p.value, 
             correction = pv$correction)
  rrs <- list(data = tmx, measure = boot, p.value = pv$p.value, 
              correction = pv$correction)
  attr(rr, "method") <- "Unconditional MLE & bootstrap CI"
  attr(rrs, "method") <- "Unconditional MLE & bootstrap CI"
  if (verbose == FALSE) {
    rrs
  }
  else rr
}

