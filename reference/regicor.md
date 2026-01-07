# REGICOR cross-sectional data

These data come from 3 different cross-sectional surveys of individuals
representative of the population from a north-west Spanish province
(Girona), REGICOR study.

## Usage

``` r
data(regicor)
```

## Format

A data frame with 2294 observations on the following 21 variables:

- `id`:

  Individual id

- `year`:

  a factor with levels `1995` `2000` `2005`. Recruitment year

- `age`:

  Patient age at recruitment date

- `sex`:

  a factor with levels `male` `female`. Sex

- `smoker`:

  a factor with levels `Never smoker` `Current or former < 1y`
  `Never or former >= 1y`. Smoking status

- `sbp`:

  Systolic blood pressure

- `dbp`:

  Diastolic blood pressure

- `histhtn`:

  a factor with levels `Yes` `No`. History of hypertension

- `txhtn`:

  a factor with levels `No` `Yes`. Hypertension (HTN) treatment

- `chol`:

  Total cholesterol (mg/dl)

- `hdl`:

  HDL cholesterol (mg/dl)

- `triglyc`:

  Triglycerides (mg/dl)

- `ldl`:

  LDL cholesterol (mg/dl)

- `histchol`:

  a factor with levels `Yes` `No`. History of hypercholesterolemia

- `txchol`:

  a factor with levels `No` `Yes`. Cholesterol treatment

- `height`:

  Height (cm)

- `weight`:

  Weight (Kg)

- `bmi`:

  Body mass index

- `phyact`:

  Physical activity (Kcal/week)

- `pcs`:

  Physical component summary

- `mcs`:

  Mental component summary

- `death`:

  a factor with levels `No` `Yes`. Overall death

- `todeath`:

  Days to overall death or end of follow-up

- `cv`:

  a factor with levels `No` `Yes`. Cardiovascular event

- `tocv`:

  Days to cardiovascular event or end of follow-up

## Details

The variables collected in the REGICOR study were mainly cardiovascular
risk factors (hundreds of variables were collected in the different
questionnaires and blood measurements), but the variables present in
this data set are just a few of them. Also, for reasons of
confidentiality, the individuals in this data set are a 30% approx.
random subsample of the original one.  
  
Each variable of this data.frame contains label describing them in the
attribute "label".  
  
For more information, see the vignette.

## Note

Variables `death`, `todeath`, `cv`, `tocv` are not real but they have
been simulated at random to complete the data example with some
time-to-event variables.

## Source

For reasons of confidentiality, the whole data set is not publicly
available. For more information about the study these data come from,
visit `www.regicor.org`.

## Examples

``` r
require(compareGroups)
data(regicor)
summary(regicor)
#>        id              year           age            sex      
#>  Min.   :2.000e+00   1995: 431   Min.   :35.00   Male  :1101  
#>  1st Qu.:2.128e+03   2000: 786   1st Qu.:46.00   Female:1193  
#>  Median :1.000e+09   2005:1077   Median :55.00                
#>  Mean   :1.216e+09               Mean   :54.74                
#>  3rd Qu.:3.000e+09               3rd Qu.:64.00                
#>  Max.   :3.000e+09               Max.   :74.00                
#>                                                               
#>                     smoker          sbp             dbp         histhtn    
#>  Never smoker          :1201   Min.   : 80.0   Min.   : 40.00   Yes : 723  
#>  Current or former < 1y: 593   1st Qu.:116.0   1st Qu.: 72.00   No  :1563  
#>  Former >= 1y          : 439   Median :129.0   Median : 80.00   NA's:   8  
#>  NA's                  :  61   Mean   :131.2   Mean   : 79.66              
#>                                3rd Qu.:144.0   3rd Qu.: 86.00              
#>                                Max.   :229.0   Max.   :123.00              
#>                                NA's   :14      NA's   :14                  
#>   txhtn           chol            hdl            triglyc           ldl       
#>  No  :1823   Min.   : 95.0   Min.   : 19.58   Min.   : 25.0   Min.   : 36.3  
#>  Yes : 428   1st Qu.:189.0   1st Qu.: 42.00   1st Qu.: 72.0   1st Qu.:115.8  
#>  NA's:  43   Median :215.0   Median : 51.00   Median : 97.0   Median :140.6  
#>              Mean   :218.8   Mean   : 52.69   Mean   :115.6   Mean   :143.2  
#>              3rd Qu.:245.0   3rd Qu.: 61.43   3rd Qu.:136.0   3rd Qu.:168.1  
#>              Max.   :488.0   Max.   :112.00   Max.   :960.0   Max.   :329.6  
#>              NA's   :101     NA's   :69       NA's   :63      NA's   :168    
#>  histchol     txchol         height          weight            bmi       
#>  Yes : 709   No  :2011   Min.   :137.0   Min.   : 41.20   Min.   :17.15  
#>  No  :1564   Yes : 228   1st Qu.:156.0   1st Qu.: 63.50   1st Qu.:24.38  
#>  NA's:  21   NA's:  55   Median :162.5   Median : 73.00   Median :27.18  
#>                          Mean   :162.9   Mean   : 73.44   Mean   :27.64  
#>                          3rd Qu.:169.2   3rd Qu.: 82.00   3rd Qu.:30.41  
#>                          Max.   :199.0   Max.   :127.20   Max.   :48.24  
#>                          NA's   :35      NA's   :35       NA's   :35     
#>      phyact            pcs             mcs            cv      
#>  Min.   :   0.0   Min.   :13.95   Min.   : 3.424   No  :2071  
#>  1st Qu.: 159.5   1st Qu.:45.01   1st Qu.:42.181   Yes :  92  
#>  Median : 303.7   Median :52.27   Median :51.260   NA's: 131  
#>  Mean   : 398.8   Mean   :49.62   Mean   :47.983              
#>  3rd Qu.: 521.9   3rd Qu.:55.78   3rd Qu.:56.047              
#>  Max.   :5083.2   Max.   :67.06   Max.   :69.904              
#>  NA's   :88       NA's   :240     NA's   :240                 
#>       tocv            death         todeath         
#>  Min.   :   0.1151   No  :1975   Min.   :   0.2199  
#>  1st Qu.: 782.7098   Yes : 173   1st Qu.: 787.6281  
#>  Median :1718.0257   NA's: 146   Median :1668.4002  
#>  Mean   :1754.6679               Mean   :1721.3051  
#>  3rd Qu.:2690.5491               3rd Qu.:2662.5389  
#>  Max.   :3650.6737               Max.   :3651.2599  
#>  NA's   :131                     NA's   :146        
```
