\name{compareSNPs}
\alias{compareSNPs}
\alias{print.compareSNPs}

\title{
Summarise genetic data by groups.
}


\description{
This function provides an extensive summary range of your SNP data, allowing you to perform in-depth quality control of your genotyping results, and to explore your data before analysis. Summary measures include allele and genotype frequencies and counts, missingness rate, Hardy Weinberg equilibrium and more in the whole data set or stratified by other variables, such as case-control status. It can also test for differences in missingness between groups.
}

\usage{
compareSNPs(formula, data, subset, na.action = NULL, sep = "", verbose = FALSE, ...) 
}

\arguments{

  \item{formula}{an object of class "formula" (or one that can be coerced to that class). The right side of ~ must have the terms in an additive way, and these terms must refer to variables in 'data' must be of character or factor classes whose levels are the genotypes with the alleles written in their levels (e.g. A/A, A/T and T/T). The left side of ~ must contain the name of the grouping variable or can be left blank (in this case, summary data are provided for the whole sample, and no missingness test is performed).}
  
  \item{data}{an optional data frame, list or environment (or object coercible by 'as.data.frame' to a data frame) containing the variables in the model. If they are not found in 'data', the variables are taken from 'environment(formula)'.}
  
  \item{subset}{an optional vector specifying a subset of individuals to be used in the computation process (applied to all genetic variables).}
  
  \item{na.action}{a function which indicates what should happen when the data contain NAs. The default is NULL, and that is equivalent to \code{\link[stats]{na.pass}}, which means no action. Value \code{\link[stats]{na.exclude}} can be useful if it is desired to removed all individuals with some NA in any variable.}    

  \item{sep}{character string indicating the separator between alleles (e.g. when using A/A, A/T and T/T genotype codification, 'sep' should be set to '/'. Default value is '' indicating that genotypes are coded as AA, AT and TT.} 
  
  \item{verbose}{logical, print results from \code{\link[HardyWeinberg]{HWChisq}} function. Default value is FALSE.}
  
  \item{\dots}{currently ignored.}

}



\value{

  An object of class 'compareSNPs' which is a data.frame (when no groups are specified on the left of the '~' in the 'formula' argument) or a list of data.frames, otherwise. Each data.frame contains the following fields: \cr
  - Ntotal: Total number of samples for which genotyping was attempted \cr
  - Ntyped: Number of genotypes called \cr
  - Typed.p: Percentage genotyped \cr
  - Miss.t: Number of missing genotypes  \cr
  - Miss.p: Proportion of missing genotypes    \cr
  - Minor: Minor Allele        \cr
  - MAF: Minor allele frequency  \cr
  - A1: Allele 1     \cr
  - A2: Allele 2     \cr
  - A1.ct: Count Allele 1  \cr
  - A2.ct: Count Allele 2  \cr
  - A1.p: Frequency of Allele 1 \cr
  - A2.p: Frequency of Allele 2   \cr
  - Hom1: Allele 1 Homozygote   \cr
  - Het: Heterozygote    \cr
  - Hom2: Allele 2 Homozygote  \cr
  - Hom1.ct: Allele 1 Homozygote count  \cr
  - Het.ct: Heterozygote Count     \cr
  - Hom2.ct: Allele 2 Homozygote count \cr
  - Hom1.p: Frequency of Allele 1 Homozygote   \cr
  - Het.p: Heterozygote frequency      \cr
  - Hom2.p: Frequency of Allele 2 Homozygote  \cr
  - HWE.p: Hardy-Weinberg equilibrium p-value \cr
Additionaly, when analysis is stratified by groups, the last component consists of a data.frame containing the p-values of missingness comparison among groups.   \cr
 

  'print' returns a 'nice' format table for each group with the main results for each SNP (Ntotal, Ntyped, Minor, MAF, A1, A2, HWE.p), and the missingness test when group is considered.  \cr

}
               

\note{

  It uses some functions taken from \pkg{SNPassoc} created by Juan Ram?n Gonz?lez et al. \cr
  
  Hardy-Weinberg equilibrium test is performed using the  \code{\link[HardyWeinberg]{HWChisqMat}}

}


\author{

Gavin Lucas (gavin.lucas<at>cleargenetics.com) \cr

Isaac Subirana (isubirana<at>imim.es)

}


\seealso{
\code{\link{createTable}}
}

\examples{

require(compareGroups) 


# load example data (taken from SNPassoc)
data(SNPs)

# visualize first rows
head(SNPs)

# select casco and all SNPs
myDat <- SNPs[,c(2,6:40)]

# QC of three SNPs by groups of cases and controls
res<-compareSNPs(casco ~ .-casco, myDat)
res

# QC of three SNPs of the whole data set
res<-compareSNPs( ~ .-casco, myDat)
res

}

\keyword{misc}
