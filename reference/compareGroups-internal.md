# Internal compareGroups functions

Internal compareGroups functions

## Usage

``` r
chisq.test2(obj, chisq.test.perm, chisq.test.B, chisq.test.seed)
combn2(x)
compareGroups.fit(X, y, Xext, selec, method, timemax, alpha, min.dis, max.ylev, max.xlev, 
         include.label, Q1, Q3, simplify, ref, ref.no, fact.ratio, ref.y, p.corrected, 
         compute.ratio, include.miss, oddsratio.method, chisq.test.perm, byrow, 
         chisq.test.B, chisq.test.seed, Date.format, var.equal, conf.level, surv, 
         riskratio, riskratio.method, compute.prop, lab.missing, p.trend.method)
compare.i(x, y, selec.i, method.i, timemax.i, alpha, min.dis, max.xlev, varname, Q1, Q3, 
          groups, simplify, Xext, ref, fact.ratio, ref.y, p.corrected, compute.ratio, 
          include.miss, oddsratio.method, chisq.test.perm, byrow,chisq.test.B, 
          chisq.test.seed, Date.format, var.equal, conf.level, surv, riskratio, 
          riskratio.method, compute.prop, lab.missing, p.trend.method)
descripSurv(x, y, timemax, surv)
descrip(x, y, method, Q1, Q3, conf.level)
confinterval(x, method, conf.level)
flip(x)
format2(x, digits = NULL, stars = FALSE, ...)
# S3 method for class 'compareGroups'
formula(x, ...) 
logrank.pval(x,y)
signifdec.i(x, digits)
signifdec(x, digits)
summ.i(x)
table.i(x, hide.i, digits, digits.ratio, type, varname, hide.i.no, digits.p, sd.type, 
        q.type, spchar, show.ci, lab.ref, stars)
# S3 method for class 'formula2'
update(object, new, ...) 
KMg.plot(x, y, file, var.label.x, var.label.y, ...)
Cox.plot(x, y, file, var.label.x, var.label.y, ...)
bar2.plot(x, y, file, var.label.x, var.label.y, perc, byrow, ...)
box.plot(x, y, file, var.label.x, var.label.y, ...)
KM.plot(x, file, var.label.x, ...)
bar.plot(x, file, var.label.x, perc, ...)
norm.plot(x, file, var.label.x, z, n.breaks, ...)
prepare(x, nmax, nmax.method, header.labels)
snpQC(X, sep, verbose)
export2mdcbind(x, which.table, nmax, nmax.method, header.labels, caption, 
      strip, first.strip, background, width, size, landscape, format, 
      header.background, header.color, position, ...)
export2mdword(x, which.table, nmax, nmax.method, header.labels, caption, strip, 
      first.strip, background, size, header.background, header.color)
export2mdwordcbind(x, which.table, nmax, nmax.method, header.labels, caption, 
      strip, first.strip, background, size, header.background, header.color)         
        
trim(x)

oddsratio(x, method = c("midp", "fisher", "wald", "small"), conf.level = 0.95)
riskratio(x, method = c("wald", "small", "boot"), conf.level = 0.95)
epitable(..., ncol = 2, byrow = TRUE, rev = c("neither", "rows", "columns", "both"))
table.margins(x)
or.midp(x, conf.level = 0.95, byrow = TRUE, interval = c(0,1000))
tab2by2.test(x)
ormidp.test(a1, a0, b1, b0, or = 1)
oddsratio.midp(x, conf.level = 0.95)
oddsratio.fisher(x, conf.level = 0.95)
oddsratio.wald(x, conf.level = 0.95)
oddsratio.small(x, conf.level = 0.95)
riskratio.small(x, conf.level = 0.95)
riskratio.wald(x, conf.level = 0.95)
riskratio.boot(x, conf.level = 0.95)

setupSNP2(data, colSNPs, sep)
snp2(x, sep = "/", name.genotypes, reorder = "common", 
          remove.spaces = TRUE, allow.partial.missing = FALSE) 

reorder.snp2(x, ref = "common", ...)

# S3 method for class 'snp2'
summary(object, ...)

SNPHWE2(x)
```

## Details

These are not to be called by the user
