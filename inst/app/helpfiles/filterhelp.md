Write `R` code to select individuals.

Note the following symbols for certain logical expressions in `R`:

|Action    | Symbol | Example |     
|:---------|:------:|:--------|
|equals to | `==`   | `sex=="Male"` |
|less than | `<`   |   `age < 60` |
|greater than | `>`   |  `age > 60` |
|equals or less than | `<=`   | `age<=60` |
|equals or greater than | `>=`   | `age>=60` |
| and                   | `&`  | `age>=40 & age<=60` |
| or   |  `|`  |  `smoke=="Current" | smoke=="Former"` |
|not available | `is.na()` | `is.na(p14)` |
| not | `!` |

For example, to select women younger than 60 years old:

```
sex=="Female" & age<60
```

**IMPORTANT**: when applying a filter with this panel, all interactive selection throught little boxes below colnames of data set Panel on right side is ignored.

