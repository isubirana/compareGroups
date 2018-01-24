\name{predimed}
\alias{predimed}
\docType{data}

\title{
PREDIMED randomized trial
}

\description{
The PREDIMED trial (Prevención con Dieta Mediterránea) is a randomized, parallel and multicentric cohort with more than 7,000 participants who were randomly assigned to three diet groups (olive oil + mediterranean diet, nuts + mediterranean diet, and low-fat diet -control group-) and followed-up during more than 7 years.
}

\usage{data(predimed)}
\format{
  A data frame with 6324 observations on the following 15 variables:
  \describe{
    \item{\code{group}}{a factor with levels \code{Control} \code{MedDiet + Nuts} \code{MedDiet + VOO}. Intervention group.}             
    \item{\code{sex}}{a factor with levels \code{Male} \code{Female}.Sex.}                            
    \item{\code{age}}{Age.}                            
    \item{\code{smoke}}{a factor with levels \code{Never} \code{Current} \code{Former}.Smoking.}                        
    \item{\code{bmi}}{Body mass index.}                
    \item{\code{waist}}{Waist circumference.}            
    \item{\code{wth}}{Waist-to-height ratio.}          
    \item{\code{htn}}{a factor with levels \code{No} \code{Yes}.Hypertension.}                   
    \item{\code{diab}}{a factor with levels \code{No} \code{Yes} .Type-2 diabetes.}                
    \item{\code{hyperchol}}{a factor with levels \code{No} \code{Yes}.Dyslipidemia.}                   
    \item{\code{famhist}}{a factor with levels \code{No} \code{Yes}.Family history of premature CHD.}
    \item{\code{hormo}}{a factor with levels \code{No} \code{Yes}.Hormone-replacement therapy.}    
    \item{\code{p14}}{MeDiet Adherence score.}         
    \item{\code{toevent}}{follow-up to main event (years).}
    \item{\code{event}}{a factor with levels \code{No} \code{Yes}.AMI, stroke, or CV Death.}
  }
}


\details{
Participants of PREDIMED study were recruited in 2003 and were revisited anually until 2010. In each visit, a large variety of different information was collected: antropometric (body mass index, age, ...), blood samples (Total cholesterol, HDL cholesterol, ...), dietary pattern consumtion using validated questionaries, treatments, etc. Also, cardiovascular events were recorded during the follow-up period.
At recruitment period, each participant was assigned to each of the three diet type group. Periodically (every 6-months approximately),  participants were advised to follow the diet corresponding to their group.
To build this example data set approx 85\% of original participants were randomly selected. For more information about this data set, see the vignette.
}


\source{
For more information about the study these data come from, visit \code{http://predimed.onmedic.net/}.
}


\references{
Estruch R, Ros E, Salas-Salvadó J, Covas MI, Corella D, Arós F, Gómez-Gracia E, Ruiz-Gutiérrez V, Fiol M, Lapetra J, Lamuela-Raventos RM, Serra-Majem L, Pintó X, Basora J, Muñoz MA, Sorlí JV, Martínez JA, Martínez-González MA; PREDIMED Study Investigators (2013). Primary prevention of cardiovascular disease with a Mediterranean diet. New England Journal of Medicine 368(14): 1279-1290.
}

                          
\examples{
require(compareGroups)
data(predimed)
summary(predimed)
}

\keyword{datasets}
