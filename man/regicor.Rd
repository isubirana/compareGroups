\name{regicor}
\alias{regicor}
\docType{data}

\title{
REGICOR cross-sectional data
}

\description{
These data come from 3 different cross-sectional surveys of individuals representative of the population from a north-west Spanish province (Girona), REGICOR study.
}

\usage{data(regicor)}
\format{
  A data frame with 2294 observations on the following 21 variables:
  \describe{
    \item{\code{id}}{Individual id}
    \item{\code{year}}{a factor with levels \code{1995} \code{2000} \code{2005}. Recruitment year}
    \item{\code{age}}{Patient age at recruitment date}
    \item{\code{sex}}{a factor with levels \code{male} \code{female}. Sex}
    \item{\code{smoker}}{a factor with levels \code{Never smoker} \code{Current or former < 1y} \code{Never or former >= 1y}. Smoking status}
    \item{\code{sbp}}{Systolic blood pressure}
    \item{\code{dbp}}{Diastolic blood pressure}
    \item{\code{histhtn}}{a factor with levels \code{Yes} \code{No}. History of hypertension}
    \item{\code{txhtn}}{a factor with levels \code{No} \code{Yes}. Hypertension (HTN) treatment}
    \item{\code{chol}}{Total cholesterol (mg/dl)}
    \item{\code{hdl}}{HDL cholesterol (mg/dl)}
    \item{\code{triglyc}}{Triglycerides (mg/dl)}
    \item{\code{ldl}}{LDL cholesterol (mg/dl)}
    \item{\code{histchol}}{a factor with levels \code{Yes} \code{No}. History of hypercholesterolemia}
    \item{\code{txchol}}{a factor with levels \code{No} \code{Yes}. Cholesterol treatment}
    \item{\code{height}}{Height (cm)}
    \item{\code{weight}}{Weight (Kg)}
    \item{\code{bmi}}{Body mass index}
    \item{\code{phyact}}{Physical activity (Kcal/week)}
    \item{\code{pcs}}{Physical component summary}
    \item{\code{mcs}}{Mental component summary}
    \item{\code{death}}{a factor with levels \code{No} \code{Yes}. Overall death}
    \item{\code{todeath}}{Days to overall death or end of follow-up}
    \item{\code{cv}}{a factor with levels \code{No} \code{Yes}. Cardiovascular event}
    \item{\code{tocv}}{Days to cardiovascular event or end of follow-up}    
  }
}

\details{
The variables collected in the REGICOR study were mainly cardiovascular risk factors (hundreds of variables were collected in the different questionnaires and blood measurements), but the variables present in this data set are just a few of them. Also, for reasons of confidentiality, the individuals in this data set are a 30\% approx. random subsample of the original one. \cr \cr
Each variable of this data.frame contains label describing them in the attribute "label". \cr \cr
For more information, see the vignette.
}

\note{
Variables \code{death}, \code{todeath}, \code{cv}, \code{tocv} are not real but they have been simulated at random to complete the data example with some time-to-event variables.
}

\source{
For reasons of confidentiality, the whole data set is not publicly available. For more information about the study these data come from, visit \code{www.regicor.org}.
}

                           
\examples{
require(compareGroups)
data(regicor)
summary(regicor)
}
\keyword{datasets}
