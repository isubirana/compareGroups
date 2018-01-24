formula.compareGroups<-
function (x, ...) 
{
    form <- attr(x,"form")$formula
    if (!is.null(form)) {
        form <- formula(attr(x,"form")$terms)
        environment(form) <- environment(attr(x,"form")$formula)
        form
    }
    else formula(x$terms)
}