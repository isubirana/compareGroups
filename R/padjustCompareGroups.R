#' @title                 Update p values according multiple comparisons
#' @description           Given a compareGroups object, returns their p-values adjusted using one of several methods (stats::p.adjust)
#' @param object_compare compareGroups class
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
#' # update p values using FDR method
#' res_adjusted<-padjustCompareGroups(res, ,method ="fdr")
#' res_adjusted
#' 
padjustCompareGroups<-function(object_compare,p="p.overall",method ="BH") {

  # 1. Excract p-values from compareGroups object
  pvalors <- compareGroups::getResults(object_compare, p)
  
  # 2. Recompute p-values accorging to multiple testing method
  pvalors<-stats::p.adjust(pvalors, method = method) 
  
  # 3. Update compareGroups object
  vars_names<-names(object_compare)
  
  for(i in unique(vars_names)){
    object_compare[[i]][p][p]<- pvalors[i] 
  }
  
  # return object
  object_compare
}


