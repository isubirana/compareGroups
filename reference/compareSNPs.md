# Summarise genetic data by groups.

This function provides an extensive summary range of your SNP data,
allowing you to perform in-depth quality control of your genotyping
results, and to explore your data before analysis. Summary measures
include allele and genotype frequencies and counts, missingness rate,
Hardy Weinberg equilibrium and more in the whole data set or stratified
by other variables, such as case-control status. It can also test for
differences in missingness between groups.

## Usage

``` r
compareSNPs(formula, data, subset, na.action = NULL, sep = "", verbose = FALSE, ...)
```

## Arguments

- formula:

  an object of class "formula" (or one that can be coerced to that
  class). The right side of ~ must have the terms in an additive way,
  and these terms must refer to variables in 'data' must be of character
  or factor classes whose levels are the genotypes with the alleles
  written in their levels (e.g. A/A, A/T and T/T). The left side of ~
  must contain the name of the grouping variable or can be left blank
  (in this case, summary data are provided for the whole sample, and no
  missingness test is performed).

- data:

  an optional data frame, list or environment (or object coercible by
  'as.data.frame' to a data frame) containing the variables in the
  model. If they are not found in 'data', the variables are taken from
  'environment(formula)'.

- subset:

  an optional vector specifying a subset of individuals to be used in
  the computation process (applied to all genetic variables).

- na.action:

  a function which indicates what should happen when the data contain
  NAs. The default is NULL, and that is equivalent to
  [`na.pass`](https://rdrr.io/r/stats/na.fail.html), which means no
  action. Value [`na.exclude`](https://rdrr.io/r/stats/na.fail.html) can
  be useful if it is desired to removed all individuals with some NA in
  any variable.

- sep:

  character string indicating the separator between alleles (e.g. when
  using A/A, A/T and T/T genotype codification, 'sep' should be set to
  '/'. Default value is ” indicating that genotypes are coded as AA, AT
  and TT.

- verbose:

  logical, print results from
  [`HWChisq`](https://rdrr.io/pkg/HardyWeinberg/man/HWChisq.html)
  function. Default value is FALSE.

- ...:

  currently ignored.

## Value

An object of class 'compareSNPs' which is a data.frame (when no groups
are specified on the left of the '~' in the 'formula' argument) or a
list of data.frames, otherwise. Each data.frame contains the following
fields:  
- Ntotal: Total number of samples for which genotyping was attempted  
- Ntyped: Number of genotypes called  
- Typed.p: Percentage genotyped  
- Miss.t: Number of missing genotypes  
- Miss.p: Proportion of missing genotypes  
- Minor: Minor Allele  
- MAF: Minor allele frequency  
- A1: Allele 1  
- A2: Allele 2  
- A1.ct: Count Allele 1  
- A2.ct: Count Allele 2  
- A1.p: Frequency of Allele 1  
- A2.p: Frequency of Allele 2  
- Hom1: Allele 1 Homozygote  
- Het: Heterozygote  
- Hom2: Allele 2 Homozygote  
- Hom1.ct: Allele 1 Homozygote count  
- Het.ct: Heterozygote Count  
- Hom2.ct: Allele 2 Homozygote count  
- Hom1.p: Frequency of Allele 1 Homozygote  
- Het.p: Heterozygote frequency  
- Hom2.p: Frequency of Allele 2 Homozygote  
- HWE.p: Hardy-Weinberg equilibrium p-value  
Additionaly, when analysis is stratified by groups, the last component
consists of a data.frame containing the p-values of missingness
comparison among groups.  

'print' returns a 'nice' format table for each group with the main
results for each SNP (Ntotal, Ntyped, Minor, MAF, A1, A2, HWE.p), and
the missingness test when group is considered.  

## Note

It uses some functions taken from SNPassoc created by Juan Ram?n
Gonz?lez et al.  

Hardy-Weinberg equilibrium test is performed using the
[`HWChisqMat`](https://rdrr.io/pkg/HardyWeinberg/man/HWChisqMat.html)

## Author

Gavin Lucas (gavin.lucas\<at\>cleargenetics.com)  

Isaac Subirana (isubirana\<at\>imim.es)

## See also

[`createTable`](https://isubirana.github.io/compareGroups/index.html/reference/createTable.md)

## Examples

``` r
require(compareGroups) 

# load example data
data(SNPs)

# visualize first rows
head(SNPs)
#>   id casco    sex blood.pre  protein snp10001 snp10002 snp10003 snp10004
#> 1  1     1 Female      13.7 75640.52       TT       CC       GG       GG
#> 2  2     1 Female      12.7 28688.22       TT       AC       GG       GG
#> 3  3     1 Female      12.9 17279.59       TT       CC       GG       GG
#> 4  4     1   Male      14.6 27253.99       CT       CC       GG       GG
#> 5  5     1 Female      13.4 38066.57       TT       AC       GG       GG
#> 6  6     1 Female      11.3  9872.46       TT       CC       GG       GG
#>   snp10005 snp10006 snp10007 snp10008 snp10009 snp100010 snp100011 snp100012
#> 1       GG       AA       CC       CC       AA        TT        GG        GG
#> 2       AG       AA       CC       CC       AG        TT        GG        CG
#> 3       GG       AA       CC       CC       AA        TT        CC        GG
#> 4       GG       AA       CC       CC       AA        TT        GG        GG
#> 5       GG       AA       CC       CC       AG        TT        GG        GG
#> 6       GG       AA       CC       CC       AA        TT        GG        GG
#>   snp100013 snp100014 snp100015 snp100016 snp100017 snp100018 snp100019
#> 1        AA        AA        GG        GG        TT        TT        CC
#> 2        AA        AC        GG        GG        CT        CT        CG
#> 3        AA        CC        GG        GG        TT        TT        CC
#> 4        AA        AC        GG        GG        TT        TT        CG
#> 5        AA        AC        GG        GG        CT        CT        CG
#> 6        AA        AA        GG        GG        TT        TT        CC
#>   snp100020 snp100021 snp100022 snp100023 snp100024 snp100025 snp100026
#> 1        GG        GG        AA        TT        TT        CC        GG
#> 2        GG        GG        AA        AT        TT        CC        GG
#> 3        GG        GG        AA        TT        TT        CC        GG
#> 4        GG        GG        AA        TT        CT        CC        GG
#> 5        GG        GG        AA        AT        TT        CC        GG
#> 6        GG        GG        AA        TT        TT        CC        GG
#>   snp100027 snp100028 snp100029 snp100030 snp100031 snp100032 snp100033
#> 1        CC        CC        GG        AA        TT        AA        AA
#> 2        CG        CT        GG        AA        TT        AG        AG
#> 3        CC        CC        GG        AA        TT        AA        AA
#> 4        CC        CT        AG        AA        TT        AG        AG
#> 5        CG        CT        GG        AA        TT        AG        AG
#> 6        CC        CC        GG        AA        TT        AA        AA
#>   snp100034 snp100035
#> 1        TT        TT
#> 2        TT        TT
#> 3        TT        TT
#> 4        CT        TT
#> 5        TT        TT
#> 6        TT      <NA>

# select casco and all SNPs
myDat <- SNPs[,c(2,6:40)]

# QC of three SNPs by groups of cases and controls
res<-compareSNPs(casco ~ .-casco, myDat)
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
res
#> *********** Summary of genetic data (SNPs) by groups ***********
#> 
#> 
#>   *** casco = '0' ***
#> 
#> ________________________________________________________ 
#> SNP       Ntyped    MAF Genotypes     Genotypes.p  HWE.p 
#> ======================================================== 
#> snp10001      47  26.6%  TT|TC|CC  51.1|44.7| 4.3  0.487 
#> snp10002      47  26.6%  CC|CA|AA  46.8|53.2| 0.0  0.029 
#> snp10003      44 100.0%        GG 100.0| 0.0| 0.0  1.000 
#> snp10004      47 100.0%        GG 100.0| 0.0| 0.0  1.000 
#> snp10005      47  23.4%  GG|GA|AA  53.2|46.8| 0.0  0.078 
#> snp10006      47 100.0%        AA 100.0| 0.0| 0.0  1.000 
#> snp10007      47 100.0%        CC 100.0| 0.0| 0.0  1.000 
#> snp10008      47  20.2%  CC|CG|GG  63.8|31.9| 4.3  0.745 
#> snp10009      46  27.2%  AA|AG|GG  45.7|54.3| 0.0  0.025 
#> snp100010     37 100.0%        TT 100.0| 0.0| 0.0  1.000 
#> snp100011     47   1.1%  GG|GC|CC  97.9| 2.1| 0.0 <0.001 
#> snp100012     45  22.2%  GG|GC|CC  55.6|44.4| 0.0  0.118 
#> snp100013     46  19.6%  AA|AG|GG  65.2|30.4| 4.3  0.840 
#> snp100014     44  40.9%  AA|AC|CC  38.6|40.9|20.5  0.431 
#> snp100015     47   4.3%  GG|GA|AA  91.5| 8.5| 0.0  0.152 
#> snp100016     47 100.0%        GG 100.0| 0.0| 0.0  1.000 
#> snp100017     45  28.9%  TT|TC|CC  42.2|57.8| 0.0  0.015 
#> snp100018     46  29.3%  TT|TC|CC  41.3|58.7| 0.0  0.011 
#> snp100019     47  42.6%  CC|CG|GG  38.3|38.3|23.4  0.207 
#> snp100020     47  20.2%  GG|GA|AA  63.8|31.9| 4.3  0.745 
#> snp100021     47 100.0%        GG 100.0| 0.0| 0.0  1.000 
#> snp100022     47 100.0%        AA 100.0| 0.0| 0.0  1.000 
#> snp100023     46  27.2%  TT|TA|AA  45.7|54.3| 0.0  0.025 
#> snp100024     46  27.2%  TT|TC|CC  52.2|41.3| 6.5  0.927 
#> snp100025     47 100.0%        CC 100.0| 0.0| 0.0  1.000 
#> snp100026     46 100.0%        GG 100.0| 0.0| 0.0  1.000 
#> snp100027     46  29.3%  CC|CG|GG  41.3|58.7| 0.0  0.011 
#> snp100028     47  43.6%  CC|CT|TT  38.3|36.2|25.5  0.111 
#> snp100029     46  25.0%  GG|GA|AA  56.5|37.0| 6.5  0.810 
#> snp100030     47 100.0%        AA 100.0| 0.0| 0.0  1.000 
#> snp100031      0     .%         -   0.0| 0.0| 0.0      . 
#> snp100032     47  43.6%  AA|AG|GG  38.3|36.2|25.5  0.111 
#> snp100033     45  44.4%  AA|AG|GG  37.8|35.6|26.7  0.098 
#> snp100034     46  25.0%  TT|TC|CC  56.5|37.0| 6.5  0.810 
#> snp100035     44 100.0%        TT 100.0| 0.0| 0.0  1.000 
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
#> 
#> 
#>   *** casco = '1' ***
#> 
#> _______________________________________________________ 
#> SNP       Ntyped    MAF Genotypes     Genotypes.p HWE.p 
#> ======================================================= 
#> snp10001     110  23.6%  TT|TC|CC  61.8|29.1| 9.1 0.069 
#> snp10002     110  28.6%  CC|CA|AA  47.3|48.2| 4.5 0.091 
#> snp10003     100 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp10004     109 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp10005     110  24.5%  GG|GA|AA  53.6|43.6| 2.7 0.097 
#> snp10006     110 100.0%        AA 100.0| 0.0| 0.0 1.000 
#> snp10007     110 100.0%        CC 100.0| 0.0| 0.0 1.000 
#> snp10008     110  19.5%  CC|CG|GG  67.3|26.4| 6.4 0.149 
#> snp10009     110  29.1%  AA|AG|GG  46.4|49.1| 4.5 0.070 
#> snp100010    110 100.0%        TT 100.0| 0.0| 0.0 1.000 
#> snp100011    110   1.4%  GG|GC|CC  98.2| 0.9| 0.9 0.001 
#> snp100012    110  24.5%  GG|GC|CC  53.6|43.6| 2.7 0.097 
#> snp100013     99  17.7%  AA|AG|GG  71.7|21.2| 7.1 0.016 
#> snp100014    109  42.2%  AA|AC|CC  32.1|51.4|16.5 0.682 
#> snp100015    110   4.1%  GG|GA|AA  91.8| 8.2| 0.0 0.460 
#> snp100016    105 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp100017    110  30.5%  TT|TC|CC  43.6|51.8| 4.5 0.030 
#> snp100018    110  30.5%  TT|TC|CC  43.6|51.8| 4.5 0.030 
#> snp100019    110  45.0%  CC|CG|GG  29.1|51.8|19.1 0.727 
#> snp100020    110  19.1%  GG|GA|AA  68.2|25.5| 6.4 0.113 
#> snp100021    110 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp100022    109 100.0%        AA 100.0| 0.0| 0.0 1.000 
#> snp100023    108  29.2%  TT|TA|AA  46.3|49.1| 4.6 0.077 
#> snp100024    110  24.5%  TT|TC|CC  60.9|29.1|10.0 0.041 
#> snp100025    110 100.0%        CC 100.0| 0.0| 0.0 1.000 
#> snp100026    110 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp100027    109  29.8%  CC|CG|GG  45.0|50.5| 4.6 0.049 
#> snp100028    109  45.4%  CC|CT|TT  29.4|50.5|20.2 0.950 
#> snp100029    110  24.1%  GG|GA|AA  61.8|28.2|10.0 0.028 
#> snp100030    110 100.0%        AA 100.0| 0.0| 0.0 1.000 
#> snp100031    102 100.0%        TT 100.0| 0.0| 0.0 1.000 
#> snp100032    109  44.5%  AA|AG|GG  31.2|48.6|20.2 0.959 
#> snp100033    107  45.3%  AA|AG|GG  29.9|49.5|20.6 0.882 
#> snp100034    110  24.1%  TT|TC|CC  61.8|28.2|10.0 0.028 
#> snp100035    102 100.0%        TT 100.0| 0.0| 0.0 1.000 
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
#> 
#> 
#>   *** Missingness test ***
#> 
#> _________________ 
#> snps      p.value 
#> ================= 
#> snp10001    1.000 
#> snp10002    1.000 
#> snp10003    0.756 
#> snp10004    1.000 
#> snp10005    1.000 
#> snp10006    1.000 
#> snp10007    1.000 
#> snp10008    1.000 
#> snp10009    0.299 
#> snp100010  <0.001 
#> snp100011   1.000 
#> snp100012   0.088 
#> snp100013   0.110 
#> snp100014   0.081 
#> snp100015   1.000 
#> snp100016   0.323 
#> snp100017   0.088 
#> snp100018   0.299 
#> snp100019   1.000 
#> snp100020   1.000 
#> snp100021   1.000 
#> snp100022   1.000 
#> snp100023   1.000 
#> snp100024   0.299 
#> snp100025   1.000 
#> snp100026   0.299 
#> snp100027   0.510 
#> snp100028   1.000 
#> snp100029   0.299 
#> snp100030   1.000 
#> snp100031  <0.001 
#> snp100032   1.000 
#> snp100033   0.636 
#> snp100034   0.299 
#> snp100035   1.000 
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 

# QC of three SNPs of the whole data set
res<-compareSNPs( ~ .-casco, myDat)
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: No genotype labels supplied; default order (AA,AB,BB) is assumed.
#> Warning: Expected counts below 5: chi-square approximation may be incorrect
#> Warning: Monomorphic marker, f is NaN.
res
#> *********** Summary of genetic data (SNPs) ***********
#> _______________________________________________________ 
#> SNP       Ntyped    MAF Genotypes     Genotypes.p HWE.p 
#> ======================================================= 
#> snp10001     157  24.5%  TT|TC|CC  58.6|33.8| 7.6 0.353 
#> snp10002     157  28.0%  CC|CA|AA  47.1|49.7| 3.2 0.006 
#> snp10003     144 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp10004     156 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp10005     157  24.2%  GG|GA|AA  53.5|44.6| 1.9 0.012 
#> snp10006     157 100.0%        AA 100.0| 0.0| 0.0 1.000 
#> snp10007     157 100.0%        CC 100.0| 0.0| 0.0 1.000 
#> snp10008     157  19.7%  CC|CG|GG  66.2|28.0| 5.7 0.215 
#> snp10009     156  28.5%  AA|AG|GG  46.2|50.6| 3.2 0.004 
#> snp100010    147 100.0%        TT 100.0| 0.0| 0.0 1.000 
#> snp100011    157   1.3%  GG|GC|CC  98.1| 1.3| 0.6 0.002 
#> snp100012    155  23.9%  GG|GC|CC  54.2|43.9| 1.9 0.017 
#> snp100013    145  18.3%  AA|AG|GG  69.7|24.1| 6.2 0.038 
#> snp100014    153  41.8%  AA|AC|CC  34.0|48.4|17.6 0.948 
#> snp100015    157   4.1%  GG|GA|AA  91.7| 8.3| 0.0 0.656 
#> snp100016    152 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp100017    155  30.0%  TT|TC|CC  43.2|53.5| 3.2 0.001 
#> snp100018    156  30.1%  TT|TC|CC  42.9|53.8| 3.2 0.001 
#> snp100019    157  44.3%  CC|CG|GG  31.8|47.8|20.4 0.779 
#> snp100020    157  19.4%  GG|GA|AA  66.9|27.4| 5.7 0.176 
#> snp100021    157 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp100022    156 100.0%        AA 100.0| 0.0| 0.0 1.000 
#> snp100023    154  28.6%  TT|TA|AA  46.1|50.6| 3.2 0.005 
#> snp100024    156  25.3%  TT|TC|CC  58.3|32.7| 9.0 0.128 
#> snp100025    157 100.0%        CC 100.0| 0.0| 0.0 1.000 
#> snp100026    156 100.0%        GG 100.0| 0.0| 0.0 1.000 
#> snp100027    155  29.7%  CC|CG|GG  43.9|52.9| 3.2 0.001 
#> snp100028    156  44.9%  CC|CT|TT  32.1|46.2|21.8 0.473 
#> snp100029    156  24.4%  GG|GA|AA  60.3|30.8| 9.0 0.059 
#> snp100030    157 100.0%        AA 100.0| 0.0| 0.0 1.000 
#> snp100031    102 100.0%        TT 100.0| 0.0| 0.0 1.000 
#> snp100032    156  44.2%  AA|AG|GG  33.3|44.9|21.8 0.313 
#> snp100033    152  45.1%  AA|AG|GG  32.2|45.4|22.4 0.366 
#> snp100034    156  24.4%  TT|TC|CC  60.3|30.8| 9.0 0.059 
#> snp100035    146 100.0%        TT 100.0| 0.0| 0.0 1.000 
#> ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 
```
