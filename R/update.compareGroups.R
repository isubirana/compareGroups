update.compareGroups<-
function (object, X., ..., evaluate = TRUE) 
{
    if(!inherits(object, "compareGroups"))
        stop("argument 'object' must be of class 'compareGroups'")
    
    if(inherits(object, "compareGroups.subset"))
        stop("Update process might not work properly (different variables selected) since 'obj' has been subset previously")
    
    if(inherits(object, "rbind.compareGroups"))
        stop("Update process does not work for rbind.compareGroups objects")

    call <- attr(object,"call")$call
    if (is.null(call)) 
        stop("need an object with call component")
    extras <- match.call(expand.dots = FALSE)$...
    if (!missing(X.) && class(X.)=="formula") 
        call$X <- update.formula2(formula(object), X.)
    if (!missing(X.) && class(X.)%in%c("matrix","data.frame")) 
        call$X <- X.
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