compare.i <- 
function (x, y, selec.i, method.i, timemax.i, alpha, min.dis, 
    max.xlev, varname, Q1, Q3, groups, simplify, Xext, ref, fact.ratio, 
    ref.y, p.corrected, compute.ratio, include.miss, oddsratio.method, 
    chisq.test.perm, byrow, chisq.test.B, chisq.test.seed, Date.format, 
    var.equal, conf.level, surv, riskratio, riskratio.method, 
    compute.prop, lab.missing, p.trend.method) 
{
    x.orig <- x
    y.orig <- y
    if (!inherits(x, "Surv") && !is.factor(x) && !is.na(method.i) && 
        method.i == 3) {
        if (inherits(x, "Date") || inherits(x, "dates")) 
            x <- as.factor(chron(as.numeric(x), out.format = Date.format))
        else x <- as.factor(x)
    }
    if (!inherits(x, "Surv") && !is.factor(x) && is.na(method.i) && 
        length(unique(x)) < min.dis) {
        warning(paste("variable '", varname, "' converted to factor since few different values contained", 
            sep = ""))
        if (inherits(x, "Date") || inherits(x, "dates")) 
            x <- as.factor(chron(as.numeric(x), out.format = Date.format))
        else x <- as.factor(x)
    }
    if (is.factor(x) && include.miss) {
        x <- addNA(x)
        levels(x)[nlevels(x)] <- lab.missing
    }
    xlong <- x
    ylong <- y
    if (!is.na(selec.i)) {
        select.eval <- try(eval(parse(text = paste("with(Xext,", 
            selec.i, ")", sep = ""))), silent = TRUE)
        if (inherits(select.eval, "try-error")) 
            select.eval <- eval(parse(text = selec.i), envir = .GlobalEnv)
        x <- x[select.eval]
        xlong[!select.eval] <- NA
        xlong[is.na(select.eval)] <- NA
        if (!is.null(y)) {
            y <- y[select.eval]
            ylong[!select.eval] <- NA
            ylong[is.na(select.eval)] <- NA
        }
    }
    if (inherits(ylong, "Surv")) 
        ylong <- ylong[, 2]
    if (inherits(xlong, "Surv")) 
        xlong <- ifelse(is.na(xlong[, 1]) | is.na(xlong[, 2]), 
            NA, xlong[, 2])
    keep <- !is.na(x) & !is.na(y)
    x <- x[keep]
    y <- y[keep]
    if (inherits(y, "Surv")) {
        ny <- 2
        gy <- factor(y[, 2], levels = c(0, 1), labels = c("No event", 
            "Event"))
    }
    else {
        ny <- length(levels(y))
    }
    if (!inherits(x, "Surv") && is.character(x)) 
        x <- as.factor(x)
    if (!inherits(x, "Surv") && is.factor(x) & simplify) {
        if (any(table(x) == 0)) {
            warning(paste("Some levels of '", varname, "' are removed since no observation in that/those levels", 
                sep = ""))
            x <- factor(x)
        }
    }
    if (inherits(x, "Surv")) {
        if (NROW(x) > 0 & is.na(timemax.i)) 
            timemax.i <- median(x[, 1], na.rm = TRUE)
    }
    if (inherits(x, "Surv")) {
        if (NROW(x) > 0 && all(x[, 2] == 0)) {
            stop(paste("No observed events in ", varname))
        }
    }
    if (!inherits(x, "Surv") && (!is.factor(x) & is.na(method.i) & 
        length(unique(x)) < min.dis)) {
        warning(paste("variable '", varname, "' converted to factor since few different values contained after possible subseting and NA removed", 
            sep = ""))
        x <- as.factor(x)
    }
    if (inherits(x, "factor")) 
        if ("" %in% levels(x)) 
            levels(x)[levels(x) == ""] <- " "
    if (!inherits(x, "Surv") && (!is.factor(x) & is.na(method.i))) {
        sh <- try(shapiro.test(x), silent = TRUE)
        if (inherits(sh, "try-error")) 
            method.i <- 2
        else method.i <- ifelse(sh$p.value > alpha, 1, 2)
    }
    if (inherits(x, "Surv") & inherits(y, "Surv")) 
        stop(paste("variable '", varname, "' not analysed since both response and row-variable are of class 'Surv'", 
            sep = ""))
    if (!inherits(x, "Surv") && (is.factor(x) & length(levels(x)) > 
        max.xlev)) 
        stop(paste("too many values for variable '", varname, 
            "'", sep = ""))
    if (NROW(x) == 0) {
        sam <- rep(0, ny + 1)
        names(sam) <- c("[ALL]", levels(y))
        nn <- matrix(NaN, ncol = 1, nrow = ny + 1)
        colnames(nn) <- "No data"
        if (inherits(y, "Surv")) 
            rownames(nn) <- c("[ALL]", levels(gy))
        else rownames(nn) <- c("[ALL]", levels(y))
        if (ny <= 2) {
            p.mul <- rep(NaN, max(c(choose(ny, 2), 1)))
            if (ny == 2) {
                if (inherits(y, "Surv")) 
                  names(p.mul) <- paste("p.", "No event", " vs ", 
                    "Event", sep = "")
                else names(p.mul) <- paste("p.", levels(y)[1], 
                  " vs ", levels(y)[2], sep = "")
            }
            else names(p.mul) <- paste("p.", levels(y)[1], " vs ", 
                levels(y)[1], sep = "")
        }
        else {
            p.mul <- rep(NaN, choose(ny, 2))
            names(p.mul) <- paste("p", apply(combn2(levels(y)), 
                2, paste, collapse = "-"), sep = ".")
        }
        ans <- list(descriptive = nn, sam = sam, p.overall = NaN, 
            p.trend = NaN, p.mul = p.mul)
        attr(ans, "method") <- "no-data"
    }
    else {
        if (is.factor(x)) {
            if (inherits(y, "Surv")) 
                tt <- table(gy, x)
            else tt <- table(y, x)
            nn <- rbind(table(x), tt)
            prop <- rbind(prop.table(table(x)), prop.table(tt, 
                margin = if (is.na(byrow)) 
                  NULL
                else as.integer(byrow) + 1))
            upper <- lower <- matrix(NA, nrow(prop), ncol(prop))
            for (i in 1:nrow(prop)) {
                for (j in 1:ncol(prop)) {
                  if (is.na(byrow)) 
                    n.ij <- sum(nn[-1, ])
                  else if (byrow) 
                    n.ij <- sum(nn[-1, j, drop = FALSE])
                  else n.ij <- sum(nn[i, ])
                  bt.ci <- try(binom.test(nn[i, j], n.ij, conf.level = conf.level)$conf.int, 
                    silent = TRUE)
                  if (inherits(bt.ci, "try-error")) {
                    lower[i, j] <- NA
                    upper[i, j] <- NA
                  }
                  else {
                    lower[i, j] <- bt.ci[1] * (if (compute.prop) 
                      1
                    else 100)
                    upper[i, j] <- bt.ci[2] * (if (compute.prop) 
                      1
                    else 100)
                  }
                }
            }
            if (!compute.prop) 
                colnames(prop) <- paste(colnames(prop), "%", 
                  sep = "")
            rownames(nn)[1] <- rownames(prop)[1] <- "[ALL]"
            colnames(lower) <- colnames(upper) <- colnames(prop)
            rownames(lower) <- rownames(upper) <- rownames(prop)
            if (!compute.prop) 
                prop <- prop * 100
            if (groups) {
                if (inherits(y, "Surv")) 
                  p.overall <- try(logrank.pval(x, y), silent = TRUE)
                else p.overall <- try(chisq.test2(t(tt), chisq.test.perm, 
                  chisq.test.B, chisq.test.seed), silent = TRUE)
                if (inherits(p.overall, "try-error")) 
                  p.overall <- NaN
            }
            else p.overall <- NaN
            if (ny <= 2) {
                p.trend <- p.overall
                p.mul <- p.overall
                if (ny == 2) {
                  if (inherits(y, "Surv")) 
                    names(p.mul) <- paste("p.", "No event", " vs ", 
                      "Event", sep = "")
                  else names(p.mul) <- paste("p.", levels(y)[1], 
                    " vs ", levels(y)[2], sep = "")
                }
                else names(p.mul) <- paste("p.", levels(y)[1], 
                  " vs ", levels(y)[1], sep = "")
            }
            else {
                p.trend <- try(1 - pchisq(cor(as.integer(x), 
                  as.integer(y))^2 * (length(x) - 1), 1), silent = TRUE)
                if (inherits(p.trend, "try-error")) 
                  p.trend <- NaN
                if (is.na(p.trend)) 
                  p.trend <- NaN
                pp <- np <- NULL
                for (i in 1:(ny - 1)) for (j in (i + 1):ny) {
                  np <- c(np, paste(levels(y)[i], levels(y)[j], 
                    sep = " vs "))
                  p.ij <- try(chisq.test2(t(tt[c(i, j), ]), chisq.test.perm, 
                    chisq.test.B, chisq.test.seed), silent = TRUE)
                  if (inherits(p.ij, "try-error")) 
                    p.ij <- NaN
                  pp <- c(pp, p.ij)
                }
                if (p.corrected) 
                  p.mul <- structure(p.adjust(pp, "BH"), names = paste("p", 
                    np, sep = "."))
                else p.mul <- structure(pp, names = paste("p", 
                  np, sep = "."))
            }
            ans <- list(descriptive = nn, prop = prop, sam = rowSums(nn), 
                p.overall = p.overall, p.trend = p.trend, p.mul = p.mul, 
                lower = lower, upper = upper)
            attr(ans, "method") <- "categorical"
        }
        else {
            if (inherits(x, "Surv")) {
                tt <- descripSurv(x, y, timemax.i, surv)
                p.overall <- try(logrank.pval(y, x), silent = TRUE)
                if (inherits(p.overall, "try-error")) 
                  p.overall <- NaN
                if (ny <= 2) {
                  p.trend <- p.overall
                  p.mul <- p.overall
                  if (ny == 2) {
                    names(p.mul) <- paste("p.", levels(y)[1], 
                      " vs ", levels(y)[2], sep = "")
                  }
                  else names(p.mul) <- paste("p.", levels(y)[1], 
                    " vs ", levels(y)[1], sep = "")
                }
                else {
                  p.trend <- try(summary(coxph(x ~ as.integer(y)))$sctest["pvalue"], 
                    silent = TRUE)
                  if (inherits(p.trend, "try-error")) 
                    p.trend <- NaN
                  if (is.na(p.trend)) 
                    p.trend <- NaN
                  pp <- np <- NULL
                  for (i in 1:(ny - 1)) {
                    for (j in (i + 1):ny) {
                      np <- c(np, paste(levels(y)[i], levels(y)[j], 
                        sep = " vs "))
                      ss.ij <- y %in% c(levels(y)[i], levels(y)[j])
                      p.ij <- try(logrank.pval(y[ss.ij], x[ss.ij]), 
                        silent = TRUE)
                      if (inherits(p.ij, "try-error")) 
                        p.ij <- NaN
                      pp <- c(pp, p.ij)
                    }
                  }
                  if (p.corrected) 
                    p.mul <- structure(p.adjust(pp, "BH"), names = paste("p", 
                      np, sep = "."))
                  else p.mul <- structure(pp, names = paste("p", 
                    np, sep = "."))
                }
                ans <- list(descriptive = tt[, -1, drop = FALSE], 
                  sam = tt[, 1], p.overall = p.overall, p.trend = p.trend, 
                  p.mul = p.mul)
                attr(ans, "method") <- c("Surv", timemax.i)
            }
            else {
                if (inherits(x, "Date") || inherits(x, "dates")) {
                  if (method.i != 2) 
                    warning(paste("for variable", varname, "method 2 is applied since it is a date."))
                  x <- as.numeric(x)
                  if (inherits(y, "Surv")) 
                    tt <- descrip(x, gy, method = "no", Q1, Q3, 
                      conf.level)
                  else tt <- descrip(x, y, method = "no", Q1, 
                    Q3, conf.level)
                  if (groups) {
                    if (inherits(y, "Surv")) 
                      p.overall <- try(coef(summary(coxph(y ~ 
                        as.numeric(x))))[, "Pr(>|z|)"], silent = TRUE)
                    else p.overall <- try(kruskal.test(x ~ y)$p.value, 
                      silent = TRUE)
                    if (inherits(p.overall, "try-error")) 
                      p.overall <- NaN
                  }
                  else p.overall <- NaN
                  if (ny <= 2) {
                    p.trend <- p.overall
                    p.mul <- p.overall
                    if (ny == 2) {
                      if (inherits(y, "Surv")) 
                        names(p.mul) <- paste("p.", "No event", 
                          " vs ", "Event", sep = "")
                      else names(p.mul) <- paste("p.", levels(y)[1], 
                        " vs ", levels(y)[2], sep = "")
                    }
                    else names(p.mul) <- paste("p.", levels(y)[1], 
                      " vs ", levels(y)[1], sep = "")
                  }
                  else {
                    p.trend <- try(cor.test(x, as.integer(y), 
                      method = "spearman")$p.value, silent = TRUE)
                    if (inherits(p.trend, "try-error")) 
                      p.trend <- NaN
                    if (is.na(p.trend)) 
                      p.trend <- NaN
                    pp <- np <- NULL
                    for (i in 1:(ny - 1)) {
                      for (j in (i + 1):ny) {
                        np <- c(np, paste(levels(y)[i], levels(y)[j], 
                          sep = " vs "))
                        p.ij <- try(kruskal.test(x ~ y, subset = y %in% 
                          c(levels(y)[i], levels(y)[j]))$p.value, 
                          silent = TRUE)
                        if (inherits(p.ij, "try-error")) 
                          p.ij <- NaN
                        pp <- c(pp, p.ij)
                      }
                    }
                    if (p.corrected) 
                      p.mul <- structure(p.adjust(pp, "BH"), 
                        names = paste("p", np, sep = "."))
                    else p.mul <- structure(pp, names = paste("p", 
                      np, sep = "."))
                  }
                  ans <- list(descriptive = as.character(chron(round(tt[, 
                    -1], 0), out.format = Date.format)), sam = tt[, 
                    1], p.overall = p.overall, p.trend = p.trend, 
                    p.mul = p.mul)
                  attr(ans, "method") <- c("continuous", "non-normal")
                }
                else {
                  x <- as.double(x)
                  if (method.i == 1) {
                    if (inherits(y, "Surv")) 
                      tt <- descrip(x, gy, method = "param", 
                        Q1, Q3, conf.level)
                    else tt <- descrip(x, y, method = "param", 
                      Q1, Q3, conf.level)
                    if (ny <= 2) {
                      if (groups) {
                        if (inherits(y, "Surv")) 
                          p.overall <- try(coef(summary(coxph(y ~ 
                            x)))[, "Pr(>|z|)"], silent = TRUE)
                        else p.overall <- try(t.test(x ~ y)$p.value, 
                          silent = TRUE)
                        if (inherits(p.overall, "try-error")) 
                          p.overall <- NaN
                      }
                      else p.overall <- NaN
                      p.trend <- p.overall
                      p.mul <- p.trend
                      if (ny == 2) {
                        if (inherits(y, "Surv")) 
                          names(p.mul) <- paste("p.", "No event", 
                            " vs ", "Event", sep = "")
                        else names(p.mul) <- paste("p.", levels(y)[1], 
                          " vs ", levels(y)[2], sep = "")
                      }
                      else names(p.mul) <- paste("p.", levels(y)[1], 
                        " vs ", levels(y)[1], sep = "")
                    }
                    else {
                      if (var.equal) 
                        p.overall <- try(anova(lm(x ~ y), lm(x ~ 
                          1))[2, "Pr(>F)"], silent = TRUE)
                      else p.overall <- try(oneway.test(x ~ y)$p.value, 
                        silent = TRUE)
                      if (inherits(p.overall, "try-error")) 
                        p.overall <- NaN
                      p.trend <- try(cor.test(x, as.integer(y))$p.value, 
                        silent = TRUE)
                      if (inherits(p.trend, "try-error")) 
                        p.trend <- NaN
                      if (is.na(p.trend)) 
                        p.trend <- NaN
                      if (p.corrected) {
                        temp <- try(TukeyHSD(aov(x ~ y)), silent = TRUE)
                        p.mul <- rep(NaN, choose(ny, 2))
                        names(p.mul) <- apply(combn2(levels(y)), 
                          2, function(nnn) paste(rev(nnn), collapse = "-"))
                        if (!inherits(temp, "try-error")) {
                          p.mul[rownames(temp$y)] <- temp[[1]][, 
                            4]
                        }
                        names(p.mul) <- paste("p", apply(combn2(levels(y)), 
                          2, function(nnn) paste(nnn, collapse = " vs ")), 
                          sep = ".")
                      }
                      else {
                        pp <- np <- NULL
                        for (i in 1:(ny - 1)) {
                          for (j in (i + 1):ny) {
                            np <- c(np, paste(levels(y)[i], levels(y)[j], 
                              sep = " vs "))
                            ss.ij <- y %in% c(levels(y)[i], levels(y)[j])
                            p.ij <- try(t.test(x[ss.ij] ~ y[ss.ij])$p.value, 
                              silent = TRUE)
                            if (inherits(p.ij, "try-error")) 
                              p.ij <- NaN
                            pp <- c(pp, p.ij)
                          }
                        }
                        p.mul <- structure(pp, names = paste("p", 
                          np, sep = "."))
                      }
                    }
                    ans <- list(descriptive = tt[, -1], sam = tt[, 
                      1], p.overall = p.overall, p.trend = p.trend, 
                      p.mul = p.mul)
                    attr(ans, "method") <- c("continuous", "normal")
                  }
                  else {
                    if (inherits(y, "Surv")) 
                      tt <- descrip(x, gy, method = "no", Q1, 
                        Q3, conf.level)
                    else tt <- descrip(x, y, method = "no", Q1, 
                      Q3, conf.level)
                    if (groups) {
                      if (inherits(y, "Surv")) 
                        p.overall <- try(coef(summary(coxph(y ~ 
                          x)))[, "Pr(>|z|)"], silent = TRUE)
                      else p.overall <- try(kruskal.test(x ~ 
                        y)$p.value, silent = TRUE)
                      if (inherits(p.overall, "try-error")) 
                        p.overall <- NaN
                    }
                    else p.overall <- NaN
                    if (ny <= 2) {
                      p.trend <- p.overall
                      p.mul <- p.overall
                      if (ny == 2) {
                        if (inherits(y, "Surv")) 
                          names(p.mul) <- paste("p.", "No event", 
                            " vs ", "Event", sep = "")
                        else names(p.mul) <- paste("p.", levels(y)[1], 
                          " vs ", levels(y)[2], sep = "")
                      }
                      else names(p.mul) <- paste("p.", levels(y)[1], 
                        " vs ", levels(y)[1], sep = "")
                    }
                    else {
                      if (p.trend.method == "spearman") 
                        p.trend <- try(cor.test(x, as.integer(y), 
                          method = "spearman")$p.value, silent = TRUE)
                      if (p.trend.method == "kendall") 
                        p.trend <- try(cor.test(x, as.integer(y), 
                          method = "kendall")$p.value, silent = TRUE)
                      if (p.trend.method == "cuzick") 
                        p.trend <- try(cuzickTest(x, y)$p.value, 
                          silent = TRUE)
                      if (inherits(p.trend, "try-error")) 
                        p.trend <- NaN
                      if (is.na(p.trend)) 
                        p.trend <- NaN
                      pp <- np <- NULL
                      for (i in 1:(ny - 1)) {
                        for (j in (i + 1):ny) {
                          np <- c(np, paste(levels(y)[i], levels(y)[j], 
                            sep = " vs "))
                          p.ij <- try(kruskal.test(x ~ y, subset = y %in% 
                            c(levels(y)[i], levels(y)[j]))$p.value, 
                            silent = TRUE)
                          if (inherits(p.ij, "try-error")) 
                            p.ij <- NaN
                          pp <- c(pp, p.ij)
                        }
                      }
                      if (p.corrected) 
                        p.mul <- structure(p.adjust(pp, "BH"), 
                          names = paste("p", np, sep = "."))
                      else p.mul <- structure(pp, names = paste("p", 
                        np, sep = "."))
                    }
                    ans <- list(descriptive = tt[, -1], sam = tt[, 
                      1], p.overall = p.overall, p.trend = p.trend, 
                      p.mul = p.mul)
                    attr(ans, "method") <- c("continuous", "non-normal")
                  }
                }
            }
        }
    }
    if (groups && ny == 2 && compute.ratio) {
        if (inherits(y, "Surv")) {
            if (length(x) == 0) {
                ci <- matrix(NaN, 1, 3)
                p.ratio <- NaN
            }
            else {
                if (is.factor(x)) {
                  if (ref > nlevels(x)) {
                    ref <- 1
                    warning(paste("Variable", varname, ": reference > nlevels, reference set to 1"))
                  }
                  ci <- matrix(NA, nlevels(x), 3)
                  p.ratio <- rep(NA, nlevels(x))
                  ci[ref, 1] <- 1
                  fit <- try(coxph(y ~ C(x, base = ref)), silent = TRUE)
                  if (inherits(fit, "try-error")) {
                    ci <- matrix(NaN, nlevels(x), 3)
                    ci[ref, ] <- c(1, NA, NA)
                    p.ratio <- rep(NaN, nlevels(x))
                    p.ratio[ref] <- NA
                  }
                  else {
                    ci[-ref, ] <- exp(cbind(coef(fit), suppressMessages(confint(fit, 
                      level = conf.level))))
                    p.ratio[-ref] <- coef(summary(fit))[, 5]
                  }
                  rownames(ci) <- levels(x)
                  names(p.ratio) <- levels(x)
                }
                else {
                  if (!inherits(x, "Surv")) {
                    x <- x/fact.ratio
                    fit <- try(coxph(y ~ x), silent = TRUE)
                    if (inherits(fit, "try-error")) {
                      ci <- matrix(NaN, 1, 3)
                      p.ratio <- NaN
                    }
                    else ci <- rbind(exp(c(coef(fit), suppressMessages(confint(fit, 
                      level = conf.level)))))
                    p.ratio <- coef(summary(fit))[1, 5]
                  }
                  else {
                    ci <- matrix(NaN, 1, 3)
                    p.ratio <- NaN
                  }
                }
            }
            colnames(ci) <- c("HR", "HR.lower", "HR.upper")
            attr(ans, "HR") <- ci
        }
        else {
            if (length(x) == 0) {
                ci <- matrix(NaN, 1, 3)
                p.ratio <- NaN
            }
            else {
                if (is.factor(x)) {
                  if (ref > nlevels(x)) {
                    ref <- 1
                    warning(paste("Variable", varname, ": reference > nlevels, reference set to 1"))
                  }
                  tb <- table(x, y)
                  if (ref.y == 2) 
                    tb <- tb[, 2:1]
                  if (ref != 1) 
                    tb <- rbind(tb[ref, , drop = FALSE], tb[-ref, 
                      , drop = FALSE])
                  if (riskratio) 
                    or.res <- try(riskratio(tb, method = riskratio.method, 
                      conf.level = conf.level), silent = TRUE)
                  else or.res <- try(oddsratio(tb, method = oddsratio.method, 
                    conf.level = conf.level), silent = TRUE)
                  if (inherits(or.res, "try-error")) {
                    ci <- matrix(NaN, nlevels(x), 3)
                    ci[ref, ] <- c(1, NA, NA)
                    rownames(ci) <- levels(x)
                    p.ratio <- rep(NaN, nlevels(x))
                    p.ratio[ref] <- NA
                    names(p.ratio) <- levels(x)
                  }
                  else {
                    ci <- or.res$measure
                    ci <- ci[levels(x), ]
                    p.ratio <- or.res$p.value[levels(x), 1]
                  }
                  ci <- cbind(ci)
                }
                else {
                  if (!inherits(x, "Surv")) {
                    x <- x/fact.ratio
                    if (riskratio) 
                      fit <- try(glm(y ~ x, family = binomial(link = log)), 
                        silent = TRUE)
                    else fit <- try(glm(y ~ x, family = binomial()), 
                      silent = TRUE)
                    if (sum(table(y) > 0) < 2 | inherits(fit, 
                      "try-error")) {
                      ci <- matrix(NaN, 1, 3)
                      p.ratio <- NaN
                    }
                    else {
                      ci <- rbind(exp(c(coef(fit)[-1], suppressMessages(confint.default(fit, 
                        level = conf.level)[-1, ]))))
                      if (ref.y == 2) 
                        ci <- 1/ci
                      p.ratio <- coef(summary(fit))[2, 4]
                    }
                  }
                  else {
                    ci <- matrix(NaN, 1, 3)
                    p.ratio <- NaN
                  }
                }
            }
            if (riskratio) 
                colnames(ci) <- c("RR", "RR.lower", "RR.upper")
            else colnames(ci) <- c("OR", "OR.lower", "OR.upper")
            attr(ans, "OR") <- ci
        }
        attr(ans, "p.ratio") <- p.ratio
    }
    attr(ans, "x") <- x
    attr(ans, "x.orig") <- x.orig
    attr(ans, "y") <- y
    attr(ans, "y.orig") <- y.orig
    attr(ans, "selec") <- selec.i
    attr(ans, "fact.ratio") <- fact.ratio
    attr(ans, "groups") <- groups
    attr(ans, "xlong") <- xlong
    attr(ans, "ylong") <- ylong
    attr(ans, "riskratio") <- riskratio
    attr(ans, "compute.prop") <- compute.prop
    ans
}

