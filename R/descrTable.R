descrTable <- 
function(
  formula, data, subset, na.action = NULL, y = NULL, Xext = NULL, selec = NA, method = 1, 
  timemax = NA, alpha = 0.05, min.dis = 5, max.ylev = 5, max.xlev = 10, include.label = TRUE, Q1 = 0.25, Q3 = 0.75, 
  simplify = TRUE, ref = 1, ref.no = NA, fact.ratio = 1, ref.y = 1, p.corrected = TRUE, compute.ratio = TRUE, 
  include.miss = FALSE, oddsratio.method = "midp", chisq.test.perm = FALSE, byrow = FALSE, chisq.test.B = 2000, 
  chisq.test.seed = NULL, Date.format = "d-mon-Y", var.equal = TRUE, conf.level = 0.95, surv=FALSE, 
  riskratio = FALSE, riskratio.method = "wald",
  hide = NA, digits = NA, type = NA, show.p.overall = TRUE, show.all, show.p.trend, show.p.mul = FALSE, show.n, 
  show.ratio = FALSE, show.descr = TRUE, show.ci = FALSE, hide.no = NA, digits.ratio = NA, show.p.ratio = show.ratio, 
  digits.p = 3, sd.type = 1, q.type = c(1, 1), extra.labels = NA
){

  call <- match.call()
  
  # get arguments from compareGroups and createTable
  names.args.cg <- formalArgs(compareGroups)
  names.args.ct <- formalArgs(createTable)
  
  # get arguments and values passed to this function
  aa <- as.list( match.call() )

  # match which arguments corresponds to compareGroups and which corresponds to createTable
  aa.cg <- aa[names(aa)%in%names.args.cg]
  aa.ct <- aa[names(aa)%in%names.args.ct]

  # first call compareGroups
  res.cg <- do.call(compareGroups, aa.cg)

  # then call createTable
  aa.ct$x <- res.cg
  ans <- do.call(createTable, aa.ct)
  
  attr(ans, "call") <- list()
  attr(ans, "call")$call <- call

  class(ans) <- c("descrTable", class(ans))
  
  # result is an ordinary createTable object
  return(ans)

}
