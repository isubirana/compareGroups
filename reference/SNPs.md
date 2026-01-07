# SNPs in a case-control study

SNPs data.frame contains selected SNPs and other clinical covariates for
cases and controls in a case-control study

SNPs.info.pos data.frame contains the names of the SNPs included in the
data set 'SNPs' including their chromosome and their genomic position

## Usage

``` r
data(SNPs)
```

## Format

'SNPs' data.frame contains the following columns:

|           |                                           |
|-----------|-------------------------------------------|
| id        | identifier of each subject                |
| casco     | case or control status: 0-control, 1-case |
| sex       | gender: Male and Female                   |
| blood.pre | arterial blood presure                    |
| protein   | protein levels                            |
| snp10001  | SNP 1                                     |
| snp10002  | SNP 2                                     |
| ...       | ...                                       |
| snp100036 | SNP 36                                    |

'SNPs.info.pos' data.frame contains the following columns: A data frame
with 35 observations on the following 3 variables.

- `snp`:

  name of SNP

- `chr`:

  name of chromosome

- `pos`:

  genomic position

## Source

Data obtained from the \<code\>SNPassoc\</code\> package.
