Write the name of the variable as well as its label. If label is left in blank it will take the variable name.
If the variable name is already present in the dataset, the variable will be replaced.

Write R code to compute the variable.

For example, to create the body mass index from the `height` and `weight` variables just write. required.

```
weight / (height/100)^2
``` 
Notice that the name of the data.frame is not

if you want to create a random normal variable with mean 200 and standard deviation equals to 10, then it is necessary to write the dataset name (with the keyname `dataset`) to indicate the number of rows.

```
rnorm(nrow(dataset), 200, 10)
``` 

or if you want to convert a variable to a factor (with categories), use `factor` function

```
factor(var)
``` 

and if you want to set the labels

```
factor(var, 0:1, c("No","Yes"))
``` 

If you want to create a time-to-event survival, i.e. to be described as incidence or free event probability, make use of `Surv` funcion

```
Surv(toevent, event)
```


Finally, click on "Create" to run the code and create the variable. 


**IMPORTANT NOTE:**

- When a new variable is created or an existent variable is recomputed, all existent filters present in the filter boxes of data frame are removed.