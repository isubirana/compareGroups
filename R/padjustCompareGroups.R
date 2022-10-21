#' @title                 Update p values according multiple comparisons
#' @description           Given a compareGroups object, returns their p-values adjusted using one of several methods (stats::p.adjust)
#' @param objecte_compare compareGroups class
#' @param p               character string (Default: 'p.overall')
#' @param method          Correction method, a character string. Can be abbreviated (see stats::p.adjust).
#' @return                compareGroups class with corrected p-values
#' @export                padjustCompareGroups
#' @examples
#' # Define simulated data 
#' set.seed(123)
#' N_obs<-100
#' N_vars<-50 
#' data<-matrix(rnorm(N_obs*N_vars), N_obs, N_vars) 
#' 
#' sim_data<-data.frame(data,Y=rbinom(N_obs,1,0.5))
#' 
#' # Execute compareGroups
#' res<-compareGroups(Y~.,data=sim_data)
#' res
#' 
#' # update p values
#' res_adjusted<-padjustCompareGroups(res)
#' res_adjusted
#' 
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



