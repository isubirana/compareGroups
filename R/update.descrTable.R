update.descrTable <- function (object, formula., ..., evaluate = TRUE) 
{
   if (is.null(call <- attr(object, "call")$call))
     stop("need an object with call component")

   if(!inherits(object, "descrTable"))
     stop("argument 'object' must be of class 'descrTable'")
    
   extras <- match.call(expand.dots = FALSE)$...
    
    if (!missing(formula.)){
      if (inherits(formula., "formula")){ 
        if (inherits(eval(call$formula), "formula"))
          call$formula <- update.formula2(call$formula, formula.)
        else {
          call$data <- call$formula
          call$formula <- formula.
          # print(call)
        }
      } else {
        call$formula <- formula.
      }
    }
    if (length(extras)) {
      existing <- !is.na(match(names(extras), names(call)))
      for (a in names(extras)[existing]) call[[a]] <- extras[[a]]
      if (any(!existing)) {
        call <- c(as.list(call), extras[!existing])
        call <- as.call(call)
      }
    }
    if (evaluate)
      eval(call, parent.frame())
    else 
      call
}
