confinterval <- function(x, method, conf.level){
  alpha <- 1-conf.level
  n <- length(x)
  if (method=="param"){
    m <- mean(x)
    se <- sd(x)/sqrt(n)
    low <- m + qt(alpha/2, n - 1) * se
    upp <- m - qt(alpha/2, n - 1) * se
    return(c('Mean' = m, 'lower' = low, 'upper' = upp))
  } else {
    if (qbinom(alpha/2, n, 0.5) == 0){ 
      warning("cannot compute CI")
      return(c('Mean' = NA, 'lower' = NA, 'upper' = NA))
    }
    L <- qbinom(alpha/2, n, 0.5)
    U <- n - L + 1
    if (L >= U) {
      warning("cannot compute CI")
      return(c('Mean' = NA, 'lower' = NA, 'upper' = NA))      
    }
    order.x <- sort(x)
    c('Median' = median(x), 'lower' = order.x[L], 'upper' = order.x[n - L + 1])
  }
}