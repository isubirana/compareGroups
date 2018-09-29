% --- compareGroups-internal.Rd ---

\name{compareGroups-internal}
\alias{compareGroups-internal}
\alias{chisq.test2}
\alias{combn2}
\alias{compare.i}       
\alias{descrip}
\alias{descripSurv}
\alias{flip}
\alias{format2}
\alias{logrank.pval}
\alias{rcorr.cens.pval}
\alias{signifdec.i}
\alias{signifdec}
\alias{summ.i}
\alias{table.i}
\alias{udpate.formula2}
\alias{simplify.formula}
\alias{KMg.plot}
\alias{Cox.plot}
\alias{bar2.plot}
\alias{box.plot}
\alias{KM.plot}
\alias{bar.plot}
\alias{norm.plot}
\alias{prepare}


\title{Internal compareGroups functions}
\description{Internal compareGroups functions}
\usage{
chisq.test2(obj, chisq.test.perm, chisq.test.B, chisq.test.seed)
combn2(x)
compareGroups.fit(X, y, Xext, selec, method, timemax, alpha, min.dis, max.ylev, max.xlev, 
         include.label, Q1, Q3, simplify, ref, ref.no, fact.ratio, ref.y, p.corrected, 
         compute.ratio, include.miss, oddsratio.method, chisq.test.perm, byrow, 
         chisq.test.B, chisq.test.seed, Date.format, var.equal)
compare.i(x, y, selec.i, method.i, timemax.i, alpha, min.dis, max.xlev, varname, Q1, Q3, 
          groups, simplify, Xext, ref, fact.ratio, ref.y, p.corrected, compute.ratio, 
          include.miss, oddsratio.method, chisq.test.perm, byrow,chisq.test.B, 
          chisq.test.seed, Date.format, var.equal)
descripSurv(x, y, timemax)
descrip(x, y, method, Q1, Q3)
flip(x)
format2(x, digits = NULL, ...)
formula.compareGroups(x, ...) 
logrank.pval(x,y)
signifdec.i(x, digits)
signifdec(x, digits)
summ.i(x)
table.i(x, hide.i, digits, digits.ratio, type, varname, hide.i.no, digits.p, sd.type, 
        q.type, spchar)
update.formula2(old, new) 
simplify.formula(form)
KMg.plot(x, y, file, var.label.x, var.label.y, ...)
Cox.plot(x, y, file, var.label.x, var.label.y, ...)
bar2.plot(x, y, file, var.label.x, var.label.y, perc, byrow, ...)
box.plot(x, y, file, var.label.x, var.label.y, ...)
KM.plot(x, file, var.label.x, ...)
bar.plot(x, file, var.label.x, perc, ...)
norm.plot(x, file, var.label.x, z, n.breaks, ...)
prepare(x, nmax, header.labels)
snpQC(X, sep, verbose)
}

\details{These are not to be called by the user}
\keyword{internal}
