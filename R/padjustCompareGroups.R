#' @title                 Update p values according multiple comparisons
#' @description           Given a compareGroups object, returns their p-values adjusted using one of several methods (stats::p.adjust)
#' @param objecte_compare compareGroups class
#' @param p               character string (Default: 'p.overall')
#' @param method          Correction method, a character string. Can be abbreviated (see stats::p.adjust).
#' @return                compareGroups class with corrected p-values
#' @export                padjustCompareGroups
#' @examples
#' # Define simulated data 
#' N<-100
#' M<-10
#' groups<-2
#' data<-matrix( rnorm(N*M,mean=0,sd=1), N, M) 
#' rbinom(N,1,0.5)
#' sim_data<-data.frame(data,Y=rbinom(N,1,0.5))
#' 
#' # Execute compareGroups
#' res<-compareGroups::compareGroups(Y~X1+X2+X3+X4+X5+X6+X7+X8+X9+X10,data=sim_data)
#' res
#' 
#' # update p values
#' res_adjusted<-compareGroups::padjustCompareGroups(res)
#' res_adjusted
padjustCompareGroups<-function(objecte_compare,p="p.overall",method ="BH") {
  
  # objecte_compare=res
  # p="p.trend"
  # method="bonferroni"
  
  # 1. Extrect els p-valors 
  pvalors <- compareGroups::getResults(objecte_compare, p)
  
  # 2. Recalculo p-valors segons metode
  pvalors<-stats::p.adjust(pvalors, method = method) 
  
  # 3. Actualitzo Objecte compare
  vars_names<-names(objecte_compare)
  
  for(i in unique(vars_names)){                                # achieved here
    # objecte_compare[[i]][p]$p.overall <- pvalors[i] 
    objecte_compare[[i]][p][p]<- pvalors[i] }
  # 4. Resultat
  objecte_compare
}



