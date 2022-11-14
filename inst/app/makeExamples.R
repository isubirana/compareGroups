library(compareGroups)
library(htmlwidgets)
library(webshot)
library(readr)
library(survival)

data(regicor)

### Example 1. Descriptives all cohort

tab <- descrTable(regicor,
                  method = c(triglyc=2),
                  hide.no = 'no', hide = c(sex="Male"))

out <- export2md(tab[2:16],
                 header.label=c("all"="All","N"="available"),
                 strip = TRUE, first = TRUE, background = grey(0.95), 
                 size = 14, position = "left")

readr::write_file(out, "./www/examples/example1.html")
webshot::webshot("./www/examples/example1.html", "./www/examples/example1.png")
file.remove("./www/examples/example1.html")

### Example 2. Descriptives by groups 

tab <- descrTable(year ~ ., regicor,
                  method = c(triglyc=2),
                  hide.no = 'no', hide = c(sex="Male"))

out <- export2md(tab[2:16],
          header.label=c("p.overall"="p-value","N"="available"),
          strip = TRUE, first = TRUE, background = grey(0.95), 
          size=14, position = "left")

readr::write_file(out, "./www/examples/example2.html")
webshot::webshot("./www/examples/example2.html", "./www/examples/example2.png")
file.remove("./www/examples/example2.html")

### Example 3. Descriptives by groups customized

tab <- descrTable(year ~ ., regicor,
                  method = c(triglyc=2),
                  hide.no = 'no', hide = c(sex="Male"))

out <- export2md(tab[2:16],
                 header.label=c("p.overall"="p-value","N"="available"),
                 strip = TRUE, first = TRUE, background = grey(0.95), 
                 size=14, position = "left")

readr::write_file(out, "./www/examples/example3.html")
webshot::webshot("./www/examples/example3.html", "./www/examples/example3.png")
file.remove("./www/examples/example3.html")


### Example 4. Cohort study

regicor$tevent <- with(regicor, Surv(tocv, cv=='Yes'))

tab <- descrTable(tevent ~ . , regicor,
                  method = c(p14=2, wht=2), show.ratio=TRUE, show.p.overall=FALSE,
                  hide.no = 'no', hide = c(sex="Male"))

out <- export2md(tab[2:16],
                 header.label=c("p.ratio"="p-value"),
                 strip = TRUE, first = TRUE, background = grey(0.95), 
                 size = 14, position = "left")

readr::write_file(out, "./www/examples/example4.html")
webshot::webshot("./www/examples/example4.html", "./www/examples/example4.png")
file.remove("./www/examples/example4.html")


##### Example 5. Stratified table

tab <- strataTable(tab, "year")[-1]

out <- export2md(tab[2:16],
                 header.label=c("p.ratio"="p-value"),
                 strip = TRUE, first = TRUE, background = grey(0.95), 
                 header.color = "white",header.background = "blue",
                 size=10, position = "left")

readr::write_file(out, "./www/examples/example5.html")
webshot::webshot("./www/examples/example5.html", "./www/examples/example5.png")
file.remove("./www/examples/example5.html")

##### Example 6. Normality plot

tab <- descrTable(regicor)
plot(tab['age'], file="./www/examples/var", type="png")
file.rename("./www/examples/varage.png","./www/examples/example6.png")


##### Exmample 7. Bivariate barplot

tab <- descrTable(year ~ ., regicor)
plot(tab['smoker'], bivar=TRUE, file="./www/examples/var", type="png")
file.rename("./www/examples/varsmoker.png","./www/examples/example7.png")


##### Example 8. SNP

data(SNPs)

tab <- compareSNPs(~ . , SNPs[,6:20])
sink("./www/examples/example8.txt")
tab
sink()

# capturar pantalla i guardar amb png
