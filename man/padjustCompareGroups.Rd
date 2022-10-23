\name{padjustCompareGroups}
\alias{padjustCompareGroups}
\title{Update p values according multiple comparisons}
\author{Jordi Real}

\usage{
padjustCompareGroups(objecte_compare, p = "p.overall", method = "BH")
}

\arguments{
\item{objecte_compare}{compareGroups class}
\item{p}{character string (Default: 'p.overall')}
\item{method}{Correction method, a character string. Can be abbreviated (see stats::p.adjust).}
}

\value{
compareGroups class with corrected p-values
}

\description{
Given a compareGroups object, returns their p-values adjusted using one of several methods (stats::p.adjust)
}

\examples{
# Define simulated data 
set.seed(123)
N_obs<-100
N_vars<-50 
data<-matrix(rnorm(N_obs*N_vars), N_obs, N_vars) 

sim_data<-data.frame(data,Y=rbinom(N_obs,1,0.5))

# Execute compareGroups
res<-compareGroups(Y~.,data=sim_data)
res

# update p values
res_adjusted<-padjustCompareGroups(res)
res_adjusted

# update p values using FDR method
res_adjusted<-padjustCompareGroups(res, method ="fdr")
res_adjusted


}
