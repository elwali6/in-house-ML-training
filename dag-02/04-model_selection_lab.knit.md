
<!-- rnb-text-begin -->

---
title: "Lab: Linear Model Selection and Regularization"
author: "Hicham Zmarrou"
date: "2018-02-27"
output:
  html_notebook:
    highlight: pygments
    number_sections: no
    theme: cosmo
    toc: yes
    toc_float: yes
  html_document:
    df_print: paged
    toc: yes
  word_document:
    toc: yes
---
___________________________________________________________________________________________________________



<!-- rnb-text-end -->



<!-- rnb-text-begin -->


## Subset Selection Methods
### Best Subset Selection

Here we apply the best subset selection approach to the Hitters data. We wish to predict a baseball player's `Salary` on the basis of various statistics associated with performance in the previous year.
First of all, we note that the Salary variable is missing for some of the players. The `is.na()` function can be used to identify the missing observations. It returns a vector of the same length as the input vector, with a TRUE for any elements that are missing, and a `FALSE` for non-missing elements. The `sum()` function can then be used to count all of the missing elements


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShJU0xSKVxuZGF0YShIaXR0ZXJzKVxubmFtZXMoSGl0dGVycylcbmBgYCJ9 -->

```r
library(ISLR)
data(Hitters)
names(Hitters)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIFsxXSBcIkF0QmF0XCIgICAgIFwiSGl0c1wiICAgICAgXCJIbVJ1blwiICAgICBcIlJ1bnNcIiAgICAgIFwiUkJJXCIgICAgICAgXCJXYWxrc1wiICAgICBcIlllYXJzXCIgICAgIFwiQ0F0QmF0XCIgICAgXCJDSGl0c1wiICAgICBcIkNIbVJ1blwiICAgIFwiQ1J1bnNcIiAgICBcblsxMl0gXCJDUkJJXCIgICAgICBcIkNXYWxrc1wiICAgIFwiTGVhZ3VlXCIgICAgXCJEaXZpc2lvblwiICBcIlB1dE91dHNcIiAgIFwiQXNzaXN0c1wiICAgXCJFcnJvcnNcIiAgICBcIlNhbGFyeVwiICAgIFwiTmV3TGVhZ3VlXCJcbiJ9 -->

```
 [1] "AtBat"     "Hits"      "HmRun"     "Runs"      "RBI"       "Walks"     "Years"     "CAtBat"    "CHits"     "CHmRun"    "CRuns"    
[12] "CRBI"      "CWalks"    "League"    "Division"  "PutOuts"   "Assists"   "Errors"    "Salary"    "NewLeague"
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZGltKEhpdHRlcnMpXG5gYGAifQ== -->

```r
dim(Hitters)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDMyMiAgMjBcbiJ9 -->

```
[1] 322  20
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc3VtKGlzLm5hKEhpdHRlcnMkU2FsYXJ5KSlcbmBgYCJ9 -->

```r
sum(is.na(Hitters$Salary))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDU5XG4ifQ== -->

```
[1] 59
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Hence we see that `Salary` is missing for 59 players. The `na.omit()` function
removes all of the rows that have missing values in any variable.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuSGl0dGVycyA9bmEub21pdChIaXR0ZXJzKVxuZGltKEhpdHRlcnMpXG5gYGAifQ== -->

```r
Hitters =na.omit(Hitters)
dim(Hitters)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDI2MyAgMjBcbiJ9 -->

```
[1] 263  20
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc3VtKGlzLm5hKEhpdHRlcnMpKVxuYGBgIn0= -->

```r
sum(is.na(Hitters))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDBcbiJ9 -->

```
[1] 0
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


The `regsubsets()` function(part of the leaps library) performs best `subregsubsets()` set selection by identifying the best model that contains a given number of predictors, where best is quantified using RSS. The syntax is the same as for `lm()`. The `summary()` command outputs the best set of variables for each model size.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShsZWFwcylcbnJlZ2ZpdC5mdWxsID0gcmVnc3Vic2V0cyhTYWxhcnl+LixIaXR0ZXJzKVxuc3VtbWFyeShyZWdmaXQuZnVsbClcbmBgYCJ9 -->

```r
library(leaps)
regfit.full = regsubsets(Salary~.,Hitters)
summary(regfit.full)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiU3Vic2V0IHNlbGVjdGlvbiBvYmplY3RcbkNhbGw6IHJlZ3N1YnNldHMuZm9ybXVsYShTYWxhcnkgfiAuLCBIaXR0ZXJzKVxuMTkgVmFyaWFibGVzICAoYW5kIGludGVyY2VwdClcbiAgICAgICAgICAgRm9yY2VkIGluIEZvcmNlZCBvdXRcbkF0QmF0ICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkhpdHMgICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkhtUnVuICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcblJ1bnMgICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcblJCSSAgICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbldhbGtzICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcblllYXJzICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNBdEJhdCAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNIaXRzICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNIbVJ1biAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNSdW5zICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNSQkkgICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNXYWxrcyAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkxlYWd1ZU4gICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkRpdmlzaW9uVyAgICAgIEZBTFNFICAgICAgRkFMU0VcblB1dE91dHMgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkFzc2lzdHMgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkVycm9ycyAgICAgICAgIEZBTFNFICAgICAgRkFMU0Vcbk5ld0xlYWd1ZU4gICAgIEZBTFNFICAgICAgRkFMU0VcbjEgc3Vic2V0cyBvZiBlYWNoIHNpemUgdXAgdG8gOFxuU2VsZWN0aW9uIEFsZ29yaXRobTogZXhoYXVzdGl2ZVxuICAgICAgICAgQXRCYXQgSGl0cyBIbVJ1biBSdW5zIFJCSSBXYWxrcyBZZWFycyBDQXRCYXQgQ0hpdHMgQ0htUnVuIENSdW5zIENSQkkgQ1dhbGtzIExlYWd1ZU4gRGl2aXNpb25XIFB1dE91dHMgQXNzaXN0cyBFcnJvcnMgTmV3TGVhZ3VlTlxuMSAgKCAxICkgXCIgXCIgICBcIiBcIiAgXCIgXCIgICBcIiBcIiAgXCIgXCIgXCIgXCIgICBcIiBcIiAgIFwiIFwiICAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIipcIiAgXCIgXCIgICAgXCIgXCIgICAgIFwiIFwiICAgICAgIFwiIFwiICAgICBcIiBcIiAgICAgXCIgXCIgICAgXCIgXCIgICAgICAgXG4yICAoIDEgKSBcIiBcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIiBcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgICBcIiBcIiAgICAgXCIgXCIgICAgICAgXCIgXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjMgICggMSApIFwiIFwiICAgXCIqXCIgIFwiIFwiICAgXCIgXCIgIFwiIFwiIFwiIFwiICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiIFwiICAgIFwiIFwiICAgXCIqXCIgIFwiIFwiICAgIFwiIFwiICAgICBcIiBcIiAgICAgICBcIipcIiAgICAgXCIgXCIgICAgIFwiIFwiICAgIFwiIFwiICAgICAgIFxuNCAgKCAxICkgXCIgXCIgICBcIipcIiAgXCIgXCIgICBcIiBcIiAgXCIgXCIgXCIgXCIgICBcIiBcIiAgIFwiIFwiICAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIipcIiAgXCIgXCIgICAgXCIgXCIgICAgIFwiKlwiICAgICAgIFwiKlwiICAgICBcIiBcIiAgICAgXCIgXCIgICAgXCIgXCIgICAgICAgXG41ICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIiBcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgICBcIiBcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjYgICggMSApIFwiKlwiICAgXCIqXCIgIFwiIFwiICAgXCIgXCIgIFwiIFwiIFwiKlwiICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiIFwiICAgIFwiIFwiICAgXCIqXCIgIFwiIFwiICAgIFwiIFwiICAgICBcIipcIiAgICAgICBcIipcIiAgICAgXCIgXCIgICAgIFwiIFwiICAgIFwiIFwiICAgICAgIFxuNyAgKCAxICkgXCIgXCIgICBcIipcIiAgXCIgXCIgICBcIiBcIiAgXCIgXCIgXCIqXCIgICBcIiBcIiAgIFwiKlwiICAgIFwiKlwiICAgXCIqXCIgICAgXCIgXCIgICBcIiBcIiAgXCIgXCIgICAgXCIgXCIgICAgIFwiKlwiICAgICAgIFwiKlwiICAgICBcIiBcIiAgICAgXCIgXCIgICAgXCIgXCIgICAgICAgXG44ICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIipcIiAgICBcIipcIiAgIFwiIFwiICBcIipcIiAgICBcIiBcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbiJ9 -->

```
Subset selection object
Call: regsubsets.formula(Salary ~ ., Hitters)
19 Variables  (and intercept)
           Forced in Forced out
AtBat          FALSE      FALSE
Hits           FALSE      FALSE
HmRun          FALSE      FALSE
Runs           FALSE      FALSE
RBI            FALSE      FALSE
Walks          FALSE      FALSE
Years          FALSE      FALSE
CAtBat         FALSE      FALSE
CHits          FALSE      FALSE
CHmRun         FALSE      FALSE
CRuns          FALSE      FALSE
CRBI           FALSE      FALSE
CWalks         FALSE      FALSE
LeagueN        FALSE      FALSE
DivisionW      FALSE      FALSE
PutOuts        FALSE      FALSE
Assists        FALSE      FALSE
Errors         FALSE      FALSE
NewLeagueN     FALSE      FALSE
1 subsets of each size up to 8
Selection Algorithm: exhaustive
         AtBat Hits HmRun Runs RBI Walks Years CAtBat CHits CHmRun CRuns CRBI CWalks LeagueN DivisionW PutOuts Assists Errors NewLeagueN
1  ( 1 ) " "   " "  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     " "       " "     " "     " "    " "       
2  ( 1 ) " "   "*"  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     " "       " "     " "     " "    " "       
3  ( 1 ) " "   "*"  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     " "       "*"     " "     " "    " "       
4  ( 1 ) " "   "*"  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     "*"       "*"     " "     " "    " "       
5  ( 1 ) "*"   "*"  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     "*"       "*"     " "     " "    " "       
6  ( 1 ) "*"   "*"  " "   " "  " " "*"   " "   " "    " "   " "    " "   "*"  " "    " "     "*"       "*"     " "     " "    " "       
7  ( 1 ) " "   "*"  " "   " "  " " "*"   " "   "*"    "*"   "*"    " "   " "  " "    " "     "*"       "*"     " "     " "    " "       
8  ( 1 ) "*"   "*"  " "   " "  " " "*"   " "   " "    " "   "*"    "*"   " "  "*"    " "     "*"       "*"     " "     " "    " "       
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




An asterisk indicates that a given variable is included in the corresponding model. For instance, this output indicates that the best two-variable model contains only `Hits` and `CRBI`. By default, `regsubsets()` only reports results up to the best eight-variable model. But the `nvmax` option can be used in order to return as many variables as are desired. Here we fit up to a 19-variable model.



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmVnZml0LmZ1bGwgPSByZWdzdWJzZXRzKFNhbGFyeX4uLGRhdGE9SGl0dGVycyAsbnZtYXggPTE5KVxucmVnLnN1bW1hcnkgPSBzdW1tYXJ5KHJlZ2ZpdC5mdWxsKVxuYGBgIn0= -->

```r
regfit.full = regsubsets(Salary~.,data=Hitters ,nvmax =19)
reg.summary = summary(regfit.full)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


The `summary()` function also returns $R^2$, `RSS`, adjusted `R2`, `Cp`, and `BIC`. We can examine these to try to select the best overall model.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubmFtZXMocmVnLnN1bW1hcnkpXG5gYGAifQ== -->

```r
names(reg.summary)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIFwid2hpY2hcIiAgXCJyc3FcIiAgICBcInJzc1wiICAgIFwiYWRqcjJcIiAgXCJjcFwiICAgICBcImJpY1wiICAgIFwib3V0bWF0XCIgXCJvYmpcIiAgIFxuIn0= -->

```
[1] "which"  "rsq"    "rss"    "adjr2"  "cp"     "bic"    "outmat" "obj"   
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


For instance, we see that the `R2` statistic increases from 32%, when only one variable is included in the model, to almost 55 %, when all variables
are included. As expected, the `R2` statistic increases monotonically as more variables are included.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmVnLnN1bW1hcnkkcnNxXG5gYGAifQ== -->

```r
reg.summary$rsq
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIFsxXSAwLjMyMTQ1MDEgMC40MjUyMjM3IDAuNDUxNDI5NCAwLjQ3NTQwNjcgMC40OTA4MDM2IDAuNTA4NzE0NiAwLjUxNDEyMjcgMC41Mjg1NTY5IDAuNTM0NjEyNCAwLjU0MDQ5NTAgMC41NDI2MTUzIDAuNTQzNjMwMiAwLjU0NDQ1NzBcblsxNF0gMC41NDUyMTY0IDAuNTQ1NDY5MiAwLjU0NTc2NTYgMC41NDU5NTE4IDAuNTQ2MDk0NSAwLjU0NjExNTlcbiJ9 -->

```
 [1] 0.3214501 0.4252237 0.4514294 0.4754067 0.4908036 0.5087146 0.5141227 0.5285569 0.5346124 0.5404950 0.5426153 0.5436302 0.5444570
[14] 0.5452164 0.5454692 0.5457656 0.5459518 0.5460945 0.5461159
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Plotting `RSS`, adjusted `R2`, `Cp`, and `BIC` for all of the models at once will help us decide which model to select. Note the `type="l"` option tells `R` to connect the plotted points with lines.

In a similar fashion we can plot the Cp and BIC statistics, and indicate the models with the smallest statistic using which.min().


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxud2hpY2gubWluKHJlZy5zdW1tYXJ5JHJzcylcblxuYGBgIn0= -->

```r
which.min(reg.summary$rss)

```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDE5XG4ifQ== -->

```
[1] 19
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


The `points()` command works like the `plot()` command, except that it `points()` puts points on a plot that has already been created, instead of creating a new plot. The `which.max()` function can be used to identify the location of the maximum point of a vector. We will now plot a red dot to indicate the model with the largest `adjusted R2` statistic.


The `regsubsets()` function has a built-in plot() command which can be used to display the selected variables for the best model with a given number of predictors, ranked according to the `BIC`, `Cp`, `adjusted R2`, or `AIC`. To find out more about this function, type `?plot.regsubsets`.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucGxvdChyZWdmaXQuZnVsbCAsc2NhbGUgPVwicjJcIilcbmBgYCJ9 -->

```r
plot(regfit.full ,scale ="r2")
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJjb25kaXRpb25zIjpbXSwiaGVpZ2h0Ijo0MzIuNjMyOSwic2l6ZV9iZWhhdmlvciI6MCwid2lkdGgiOjcwMH0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucGxvdChyZWdmaXQuZnVsbCAsc2NhbGUgPVwiYWRqcjJcIilcbmBgYCJ9 -->

```r
plot(regfit.full ,scale ="adjr2")
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJjb25kaXRpb25zIjpbXSwiaGVpZ2h0Ijo0MzIuNjMyOSwic2l6ZV9iZWhhdmlvciI6MCwid2lkdGgiOjcwMH0= -->

<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAArwAAAGwCAMAAAB8TkaXAAAA7VBMVEUAAAAAAA0AABcAACEAACgAACoAADIAADoAAEkAAGYADQAADVEAFwAAKAAAMZAAOpAAOp0AWLYAZrYXAAAXZtsaGhogAAAgIQAoAAAqAAAqOgAyUTEzMzM6AAA6ABc6ADo6AGY6Ojo6Zlg6kNtJSQBNTU1RvP9YZjpmAABmADpmAGZmOpBmWABmZmZmgWZmtv9m2/982/+BKACB//+QKACQOgCQOmaQZgCQkNuQ2/+cOgC2SQC2WAC2ZgC2Zma2//+8///beyDbkDHbkDrbkJDb///m5ub/gSj/nDr/tmb/23v/25D//7b//9v///+DCZ20AAAACXBIWXMAAA7DAAAOwwHHb6hkAAAbEElEQVR4nO2dCZcbu3GF+RTbL3YWxUrsrBPbkZfxkshZJomSMLIfo9j0zPD//xz3wq1J1EWjuoiuat7vnPckTU81CtWXIIAC0KsdIUFZze0AIVooXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYaF4SVgoXhIWipeEheIlYSkX73a1+vLj/u8vj6uGd7vd61Pz5/t0CYQAaop32yh3e1Dv8/f6v7w+NT/ZtCquId4J1U2jK8veReM4VUZZZ52Zyvb1qW1f13uZbr/5qfvz+eFD8//N/l8XJTiJEkBXlr2LxnGqjLLOOjOV7VCmm0Fbe2yQhyU4iRJAV5a9i8ZxqoyyzjozlW3fUTi0uOsfrM66uuvzltddlAC6suxdNI5TZZR11pmpbPvWdd/Gvjy+/dxodq/ebXrE5iVKAF1Z9i4ax6kyyjrrzFS2A/Huf9Q3uNv0eI3iNfEjAMo668xUtsNuQ/+jrhsstLsUr40fAVDWWWemsk3MK3R63kjapXhN/AiAss46M5Xt69M/rFZf/qLvITw//FXr9R9+2n3V/lkrSTGhuml0Zdm7aBwntffmhSE/dGY629988ePuv47/+frHbsD2u+9+g0mK6S4ax4niveD16W/7lvf16V2XKl6tmn7Er3v33/wyVYKTKAF0Zdm7aBwnivcCJilGVczcDx01y4og3rFJilMJTqIE0JVl76JxnCjeC0YnKeyDMzFKAF1Z9i4ax4nivYBJilEVM/dDR82yAoiXSYpRFTP3Q0fNsiKIl0mKMRUz90NHzbICiHewnnff5jZK3rQTZkIJNaPkxMqLeKuirLPOTGe7fbNavTl0eded13/WqPgvVy4ybE6sKN7xddaZ6Wy3X/Ti7ZIUz3+96pIUX/Xuf232eV4nVhTv+DrrzFS2zrcBObGieMfXWWemsnWeYXNiRfGOr7POTGXrfBuQEyuKd3yddWYqW+fbgJxYUbzj66wzU9k6z7A5saJ4x9dZZ6aydZ5hc2JF8Y6vs85MZes8w+bEiuIdX2edmcrW+TYgJ1Z3KV4AqrMuVDpb39uAnFhRvENQnXWhUtk63wbkxIriHYLqrAuVypZJilEVA2bKO4YG1VkXKpWt821ATqwo3iGozrpQqWydbwNyYkXxDkF11oVKZcskxaiKATPlHUOD6qwLlcqWSYpRFQNmyjuGBtVZFyqVLZMUoyoGzJR3DA2qsy5UKlsPSQodKAjWVhTvEFRnXah0tg6SFDpQEKytKN4hqM66UKlsPSQpdKAgWFtRvENQnXWhUtl6SFLoQEGwtqJ4h6A660KlsvWQpNCBgmBtRfEOQXXWhUpl6yFJoQMFwdqK4h2C6qwLlcrWQ5JCBwqCtRXFOwTVWRcqla2HJIUOFARrK4p3CKqzLlQqWw9JCh0oCNZWFO8QVGddqFS2Hs4q04GCYG1F8Q5BddaFSmfr+6wyHcqwm7toHCe197o7Kutc09b3WWU6dGXZu2gcJ4r3AudnlenQlWXvonGcKN4LPGTYdDUF6Mqyd9E4ThTvBc7PKtOhK8veReM4UbwXOD+rTIeuLHsXjeNE8V7gIcOmrKqMrix7F43jRPFe4CHDpqyqjK4sexeN40TxXuAhw6asqoyuLHsXjeNE8V7AbUBTK2Z/R/+gOoNrObgNCLuos7L3IzaozuBaDm4Dwi7qrOz9iA2qM7iWI2KSQgcKgrWVvR+xQXUG13JwGxB2UWdl70dsUJ3BtRzcBoR91VnZ+xEbVGdwLUfEJIUOFARrK3s/YoPqDK7liJik0IGCYG1l70dsUJ3BtRwRkxQ6UBCsrez9iA2qM7iW4362AelAofNyR/+gOiO1ZYi4DagmKHRe7ugfVOec4CxtHWwDqgkKnZc7+gfVeZzsTGw9bAOqCQqdlzv6B9UZyg1zPxk2HSh0Xu7oH1RncC1HxG1ANUGh83JH/6A6j5Kdja2HbUA1QaHzckf/oDpjvUGA7Wa16ifAzvuycTNsOlDovNzRP6jO4FoO2XbTCPTlsRXkuXjjZth0oNB5uaN/UJ3BtRyibT+t8PrUdAwG4g2bYdOBQufljv5BdQbXcoi2L499zmz99vO5VIVtQJvVh+fvpybKoj8RFDovd4wNiEeOTMu7a+d0B+1schvQ88P7l8fkLG/0J4JC5+WOsQHxyAH6vHsxvjyuBi1vahvQpveD87yz3DE2WJ8QONvQdxxen8Q+7zFJ0QzXtmx5Z7pjbEA8ctglKSjeue4Ym0IBDuIFrh27vWfISYoL8c4dEyNQ6LzcMTYgHjmQ7WHC4RyQpGDLO9MdYwPikQPaJvQoJiko3tnuGBskwAy45d3ff0SSguKd746xAfHIUb6eN5mkaPjt1/610hOZUN00NctSxsPce50bN4h9TdtkkmLXNtMU79TCdH6YWyn90FG35U0lKbq/UbxTC9P5YW6l9EPHjdY2vD/2eVenFecekhQTqpumZlkU74Uft7c9jtA8JCkmVDdNzbIo3gs/bm+7bbMR3V8cJCkmVDdNzbIo3gs/bmF73mcYt5OCLe/UwnR+mFsp/dBxuyRF1yUYKNVDkmJCddPULIvivfDjRrbdhELD5tBn2PlIUkyobpqaZVG8F37cyPawtmE7WM+bPKtsR/EaFKbzw9xK6YeOW68qW5+1vOmzylrqZdhigx7GPVIg1qt4oYvbLgGxGWyQSJ5VtquaYYsNehj3SKFgB/GCV7sph/N2VzirrMuwLXJhjj3oYdwjY5Wailfh73vIsMUGPYx7pFCAg3gV/v7oDNvcMXELehj3SKEAB/FCFw+JCilJgTJs9/1EAOhh3COFgh3EC11sDxx5d0hC9HjIsMUGPYx7ZLRUE/EC114e33eLGgZJCgcZttigh3GPFIj1Kl7gWpukaA9xOj/IyUOGLTboYdwjBWK9ihe41k6Lvfz040C8HrYBkSVxI/F2DWwzHDvvNnjYBkSWxK3E2yYjhkeVudgGRJbEzcR7DZMUxBa1dHlWGZkbvXYNX6jCDBvRMJd4d+eqZctLNCiF20mr8PeZpCC2KIXbSavw95mkILYohdtJq/D3bbcBIcduUl3LsnTPCmFeMXvv7f2oadt2d/cd36Yu3971A7Z+/VnyLYLKUFQNoLWHSswrZu+9vR9VbTf9i1Ne/+3rH09JiqbrwJZ3MuYVs/fe3o85bKX9QNcl6EJRNYDWHioxr5i99/Z+zGErpNoSJehCUTWA1h4qMa+Yvff2fsxhK6fa9jeeGIqqAbT2UIl5xey9t/djDls51XZZgi4UVQNo7aES84rZe2/vxxy2cqrtsgRdKKoG0NpDJeYVs/fe3o85bOVU22UJulBUDaC1h0rMK2bvvb0fc9jKqbbLEnShqBpAaw+VmFfM3nt7P+awlfcDXZbwHWu0LovULEuJuYteYj+LeMX9QFclKMNUMYA1y1Ji7qKX2M/U8qb3A12XoAxTxQDWLEuJuYteYu+gz4uSFMowVQxgzbKUmLvoJfYOZhtQkkIZpooBrFmWEnMXvcR+/nlemKRQhqliAGuWpcTcRS+xn1+8+x+lkxTKMFUMYM2ylJi76CX2DroN/Y/SSQplmCoGsGZZSsxd9BJ7BwO2/kfpJIUyTBUDWLMsJeYueol9XfFu94vRD+t529etPD/8pBmZ/VPUbkMAzMPhJfbzbAPa/2XbvbPiv7ptFX+RLEEZpooBDIB5OLzEfqYNmN1+oJfH1bfaRMWfNC3vD9N72JRhqhjAAJiHw0vs59z6vnn7H03L278rc03x3gzzcHiJ/YyHjjT/7F4x2L6rbZvOD1O8FpiHw0vs5zvuqe1E9O/H3A/jzm4cKMMWAPNweIn9fOJtj53uxLtumuLnh6gZtgCYh8NL7GfrNnT/6KfKriZ9TyUow1QxgAEwD4eX2M82YNvsOwYfErniUwnKMFUMYADMw+El9rOdVdZxannDrm0IgHk4vMS+bpLiTf/W9yP/8ke/6teiC8vRV38nA8rRWS0W83CAGyJsa7WrLd4vevH2U7vtNEMj3qb9baT75+l5XorXAIrXwPay2/DyuDq86Co9XqN4TaB4DWzTGbb+SnKmjOI1geI1sBUybLt+qvf8xkcoXgMoXgNbKcPWvWU7XQLFawDFa2ArZNikSd4dxWsDxWtgm86w7Y5/JEqgeA2geA1s0xk20GugeE2geA1sB0eUdbRJCvhClR/JgIJ0VoulZjhAWfaFVU1SDI4o2x2SFM9/L3V5KV4TKF4D2+ERZV2T24p3+0Z8owrFawHFa2ArJCnQWWUUrwEUr4GtkKS4PqvsVALFawDFa2CbTlIkzio7ZdgoXgMoXgNbMUmxE9fzUrwGULwGtmKSYieeVUbxGkDxGthKSYruWvqsMorXAIrXwFaxDegfZUBBOqvFsthwzL8NaLf+46YB/pv01neK14DFhmP+bUCvTys5PUzxGrDYcMy/DQie20DxGrDYcDjIsHUI5zZQvAYsNhwOMmwdg41ApyQFxWvAYsMxf4atv5TOD1O8Fiw2HD4ybNv0eI3iNWGx4XCRYRPaXYrXhsWGw0OGbSNpl+I1YbHhmHEbUCvfP21a3q9W8pLI/5eZ4PidsdggzrcNqG2B//sP/nn3u+9+42Mj5HSSYrFxr8ligzjbNqBuy/D6W+92v+67D29+mSphsXGvyWKDOGeSYnfME4tJisXGvSaLDeKMSYpd/yKgHiFJsdi412SxQZxvnrd7C9D741/TSYrFxr0miw3inOJtuw2HiV4hSbHYuNdksUGct9tw0LOYpFhs3Guy2CDOO2DrfwSSFIuNe00WG8TZ1vOedv9s0q9u7UogBKDXrmInRfuW4UOXd929NPu9eKR/UXk1L3nx4x69nyLXqXfa9G8Z3r/ofbVf2dAhHrY3qjw+/rGXvPgRT7w3K4+Pf+wlL35QvLNc8uLHPXpP8U685MWPe/Se4p14yYsf9+g9xTvxkhc/7tF7infiJS9+3KP3FO/ES178uEfvKd6Jl7z4cY/exxUvIWZQvCQsFC8JC8VLwkLxkrBQvCQsFC8JC8VLwuJGvC8/7Veyp18p5J243r88yju4vFNXvNv9vqVEuA6PP/Vii/ZYqc1qdTyC/Yz9q1xWZVYAYIUu+fa+UeiRi7L2l8RylPEo9kNDRfE2nu9Pdmie2YXr61OlErvh1m8/Pz+8G7z97XhJjoFglQkgKku6FML7g6up3Yb7D1GqCdbEQ+1HIfXE+/KzT+K/dqe2K2X5+KFpsz+kvpO7o/6KrZCXqCz5hv69319HfYTUR0kXj2l+jMZNnxfQhqINbOI7ub1UbqUvq/yGXrxveX4Q77YVGl5dPPR+FFFVvHBYc/hCTH0Zvnt5fPv55fH6S+h0ROU1otWmLWQtfU2KZaFLAbxvLYWe7Sbd38ndURkq2Y9SZhFv8gPZdJM279Jvjm+U8eXH9JPeyt8/klVb+vr06sPxZYFLAbxv+rVJga6BcvEddZckPxRUFC8e1rT9v23zTDZFn8rj+GX891B35k9/SkpZWdgP795L3UzQ774JllNzs7S8yWtNN+n5+5+6/wQzm0nUrqPZP7LUUOM/+z9f//3qUn/SlXxT195vxQ9I22eQey/Ae3BJDpXshwI3A7a2vm04wOMvHCkJk6iZx983RKkYg+GVe+9xN3Mr6xd4jy5JoTLr7nZUFm/3RZn2v+vMvb/+MoS9DfTFK0yi4sffHdV6mpEeXgLy8+19Pjnw/JB6LsB73AkUQhU3SbE7HOW7SZ9ptm7f0JJMNoHexv6+QooqRebxd81QMrC4h+rd+xEk53nBBDaa27ZTKKCqeF+f+m+TteV3R3/H65ZS+urKPX75mOybMbv3fR9lxDmJvvAzzzuJ5KAh3Y3Lf3WBCazbUMf7xvTt5/WltPc3lIZsqA3VLb8Q/NAwS8ubmOQRp96bCI34EkqNhso1mFGGnIiI4H3TZdu0eYP3l1ZjGtxkc4MWMLR96HRTLvihofaqsu6lANfPBU+9Z0mlcsb0u/6v6BtATERE8L6dD2kbjcJJjwNCz0ZawNB3XlLn5U/0Y0DdboPUNkyZeu8oMtrsS399Klw4ICQignj/ofMuJTWwMvOAsPpGWMBwmOdNhAP5UYqPeV4wDDGeXdn1Ux7tkHEL06JpJ5OJiBDeH1q81GAZrMw8kGoo5QUMh+GmkL+Q/CjFvXhP1yHXX6HSF283FGpuuLnukmGpiYmIEN7v+5qpb/IR/c/kEht5AQNoeYEfxdRPUqRGmtrHP+Ir9Op+XTGvTz8AOVEBKRERw/te3KkxFPpwqXo2qM8L/CimepIiOdJUPv5RX6HXexHae6lW8guJiCDei6CVmVrk2QZDKk+VCSNN3eMHX6FnXHdDu8cvNSVgYa5EbO93M0xsG1F5tkEYaebGNenHP+4r9PKTsn/8kg1YmCsRwnsw94am5fqJiNSkAZrABgvwLDPHs7S8xSNN6fGP+Aq9Gmrgxw8X5ipzQ0687yicodq/lVd+Oa/kR+6zb5JknaPPm+zHZ7YIgccvPChpqJF7/OLCXJQbCuD9HnlDb4Ljq05Lsy95bRb5ITDHkshkHw8ue4WPvzAKyvkwnBvy7/2BpKyE4dXZSC71IZPXNozoGywnSQFWh8LzMkY9/rIcsDQfhnJDEbw//41LpImts09dSmvZwxlynk7FiXh3I5a9Xpugx6/MooKFuajH7t/7Y6mpTcxCSgGLF6xtQDumZD+KqSzefl4T1SyxeUwCfYVqs6iIEbmhCt733+X9UooCQLZBTObiboP2QArRj2LqircPAfjUbYyWAIybRL0kt7M1lxtKea/RGvK+XU5w/ufAO910rZzMxQM2cDhDnQMHq8/ztghV22JplJWkyaLmDp2DpL2XtQb9kL0/NoGJlbla7+VkLpwqk9c2LHMb0P4jLq70VsyhotGQfktMYSMmei9r7WRW4v1ZbzI5KhO9P+ulXF+Uk7lSkkIN9KOQut2G/sOd+A5tx+vv0g8Y8vqUjmsmi5pnxCrBs18WvcdaU3ifmQA4OCROKTQjrNrHjNzOj8oDNuEjvn8k5dWB+xS1E+GpQ+defi5/DoD3+fG6fMOk92eFCJNNwpF5h6/3dshZ0oMB2RfxEF5UZ6UfSZxMlW3VLS/YIa4Sr3DonHCUQ4/sPdaaxvs1zBvIR+adjTdKRlMo+yIeIfzhUDXwgS30I8ksfd4ka1Wf9/l7yRGeUrzo0LkN7KRJ3mOtKbw/jvuvJwDgkXlnUwoDIcIVNpkjU9LzvFi8kh8aZpltEC+XzzZ0/ZDUkEeeREUOwA/PGt4q7T3Q2k7n/VaaAMh4f+xrFi3fzZyanZrnxeJV+pGk8sKcnJC2hbMrxuuo8aFzB63J+x5KtLbTet9PACQsM953H4k2fWw1fyXM82bEa+jHPLuHkdv/W1Kl/Nq7UuRD567fpJHg2ntRa3W9R8A3o8iPTJjnzYnXDicDNi35JLoC8dA5a6nJ3itzwLud5D0kv8KmaIxH8Y5EGPJM5vI7Dc42qLUmea/Ky52RfjWK1ISi00OOd5Rrf7meIyNe3U6lJD52D0+5n3UeMn3oHJrnVWtN9B7n5RDykXloh1D+5S2isK/Xc+TftlW6z0rCx+5hJ2QOnRPRay1NLgecBnuPdgjB15/s/UiKV7EaRfcChDQ+dg87Ydyhc1fotAb9GJMDvrZC3qMdQuhNMYffkI5T0+REMzuVRuNj97D2dprJXHu0WhO9z+eAyxmxQwh5efWh1K9GUfmRJMbuYYD9dJPCBbXWBO9xXk4EjhvzO4RKUK9GsfTDze5hLQ7Eq9XaTvQe5+Xkm8FxY26HUBna1SiWfrjZPay/4/zi1WmtRfIe5eVEVONGfHpIm7QTq6RbjWJI9HleF+LVaa1F9B7k5STMx439q2/QB1KzGsWQ8O+kcCFejdY6LL3PjRvL59j7jwP+JJSuRrGc6/fz7mHtPV2IV4uteOG4UZ5jFyd4e++yTU3RapSg76TAr53TQvEegeNGNMe+FgYiI8VbRNx3UpQfzZG/J8V7AI4bM3Ps21S35xbiXd47KXR4SVLouIH3eO1wbo79+nSeW7a88d5JMeK1M2QCaNyI59irtbxx30lhtoiflCPOsXeST/d5b/HVFvSdFG6Xk83DhBXnppgcejcHnjZg3hlTV5yTygtzgn7Eb4L1KuBx1DkCL0+82Yaor525BTfI5o7h+pSFMa/2vr0fGvztHr4XdKuAJ8OWl0znFivOR0DxEgP0q4CnkDw+LLlXorofxVC8s6FfBTyF1OtguuLL13Ma+1FOPfHGTubeAvUq4GJy77/oqPAZMtYAW94Z0a4CtvXh1HuJNpFJ8d45M40bTajYbfjZJ/FfZDZqz9jhc7PKqNjyntwedd4iqUL16eZ9v9diZU7tDFsP82xumClX8vLIARuZyhzitdp0TPHeOdVnMNvzg40KonhJVUz6C3soXlKZpuk1mm+geEl98GvBRkPxkjngbAMJyJprG0hQulPYje5F8ZKwULykMkFPiSQk6CmRhAQ+JZIQnhJJwhL3lEhCwp4SSUjUUyIJsYTiJWGheEk9eG4DWQBri5NWKF5Sn6YF5npeEpLnB5utQBQvqc3G6kRKipfU5fXJ7GBBipdUxai720HxkppsLQ+HoHhJRcy6ux0UL6kHkxSE9FC8JCwULwkLxUvCQvGSsFC8JCwULwkLxUvCQvGSsFC8JCwULwkLxUvCQvGSsFC8JCwULwkLxUvCQvGSsFC8JCwULwkLxUvC8nsPSRUXIoxzsAAAAABJRU5ErkJggg==" />

<!-- rnb-plot-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucGxvdChyZWdmaXQuZnVsbCAsc2NhbGUgPVwiQ3BcIilcbmBgYCJ9 -->

```r
plot(regfit.full ,scale ="Cp")
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJjb25kaXRpb25zIjpbXSwiaGVpZ2h0Ijo0MzIuNjMyOSwic2l6ZV9iZWhhdmlvciI6MCwid2lkdGgiOjcwMH0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucGxvdChyZWdmaXQuZnVsbCAsc2NhbGUgPVwiYmljXCIpXG5gYGAifQ== -->

```r
plot(regfit.full ,scale ="bic")
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJjb25kaXRpb25zIjpbXSwiaGVpZ2h0Ijo0MzIuNjMyOSwic2l6ZV9iZWhhdmlvciI6MCwid2lkdGgiOjcwMH0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


The top row of each plot contains a black square for each variable selected according to the optimal model associated with that statistic. For instance,
we see that several models share a BIC close to ???150. However, the model with the lowest BIC is the six-variable model that contains only `AtBat`,
`Hits`, `Walks`, `CRBI`, `DivisionW`, and `PutOuts`. We can use the `coef()` function to see the coefficient estimates associated with this model.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuY29lZihyZWdmaXQuZnVsbCAsNilcbmBgYCJ9 -->

```r
coef(regfit.full ,6)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgICAgICBBdEJhdCAgICAgICAgIEhpdHMgICAgICAgIFdhbGtzICAgICAgICAgQ1JCSSAgICBEaXZpc2lvblcgICAgICBQdXRPdXRzIFxuICA5MS41MTE3OTgxICAgLTEuODY4NTg5MiAgICA3LjYwNDM5NzYgICAgMy42OTc2NDY4ICAgIDAuNjQzMDE2OSAtMTIyLjk1MTUzMzggICAgMC4yNjQzMDc2IFxuIn0= -->

```
 (Intercept)        AtBat         Hits        Walks         CRBI    DivisionW      PutOuts 
  91.5117981   -1.8685892    7.6043976    3.6976468    0.6430169 -122.9515338    0.2643076 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### Forward and Backward Stepwise Selection

We can also use the `regsubsets()` function to perform forward stepwise or backward stepwise selection, using the argument `method="forward"` or `method="backward".`



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmVnZml0LmZ3ZCA8LSByZWdzdWJzZXRzKFNhbGFyeSB+IC4sIGRhdGEgPSBIaXR0ZXJzICwgbnZtYXggPSAxOSwgbWV0aG9kID0gXCJmb3J3YXJkXCIpXG4jQW4gb3B0aW9uIGlzIGF2YWlsYWJsZSB3aGljaCBtYWtlcyB0aGlzIG1hdHJpeCBwZXJoYXBzIG1vcmUgcmVhZGFibGU6XG4jbWF0cml4LmxvZ2ljYWw9VFJVRSAodGhlIGRlZmF1bHQgaXMgRkFMU0UpXG5zdW1tYXJ5KHJlZ2ZpdC5md2QpXG5gYGAifQ== -->

```r
regfit.fwd <- regsubsets(Salary ~ ., data = Hitters , nvmax = 19, method = "forward")
#An option is available which makes this matrix perhaps more readable:
#matrix.logical=TRUE (the default is FALSE)
summary(regfit.fwd)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiU3Vic2V0IHNlbGVjdGlvbiBvYmplY3RcbkNhbGw6IHJlZ3N1YnNldHMuZm9ybXVsYShTYWxhcnkgfiAuLCBkYXRhID0gSGl0dGVycywgbnZtYXggPSAxOSwgbWV0aG9kID0gXCJmb3J3YXJkXCIpXG4xOSBWYXJpYWJsZXMgIChhbmQgaW50ZXJjZXB0KVxuICAgICAgICAgICBGb3JjZWQgaW4gRm9yY2VkIG91dFxuQXRCYXQgICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuSGl0cyAgICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuSG1SdW4gICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuUnVucyAgICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuUkJJICAgICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuV2Fsa3MgICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuWWVhcnMgICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuQ0F0QmF0ICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuQ0hpdHMgICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuQ0htUnVuICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuQ1J1bnMgICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuQ1JCSSAgICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuQ1dhbGtzICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuTGVhZ3VlTiAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuRGl2aXNpb25XICAgICAgRkFMU0UgICAgICBGQUxTRVxuUHV0T3V0cyAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuQXNzaXN0cyAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuRXJyb3JzICAgICAgICAgRkFMU0UgICAgICBGQUxTRVxuTmV3TGVhZ3VlTiAgICAgRkFMU0UgICAgICBGQUxTRVxuMSBzdWJzZXRzIG9mIGVhY2ggc2l6ZSB1cCB0byAxOVxuU2VsZWN0aW9uIEFsZ29yaXRobTogZm9yd2FyZFxuICAgICAgICAgIEF0QmF0IEhpdHMgSG1SdW4gUnVucyBSQkkgV2Fsa3MgWWVhcnMgQ0F0QmF0IENIaXRzIENIbVJ1biBDUnVucyBDUkJJIENXYWxrcyBMZWFndWVOIERpdmlzaW9uVyBQdXRPdXRzIEFzc2lzdHMgRXJyb3JzIE5ld0xlYWd1ZU5cbjEgICggMSApICBcIiBcIiAgIFwiIFwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIiBcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgICBcIiBcIiAgICAgXCIgXCIgICAgICAgXCIgXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjIgICggMSApICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIiBcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgICBcIiBcIiAgICAgXCIgXCIgICAgICAgXCIgXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjMgICggMSApICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIiBcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgICBcIiBcIiAgICAgXCIgXCIgICAgICAgXCIqXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjQgICggMSApICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIiBcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgICBcIiBcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjUgICggMSApICBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIiBcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgICBcIiBcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjYgICggMSApICBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiKlwiICBcIiBcIiAgICBcIiBcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjcgICggMSApICBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIiBcIiAgIFwiKlwiICBcIipcIiAgICBcIiBcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjggICggMSApICBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIgXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIiBcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjkgICggMSApICBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIqXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIiBcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiIFwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjEwICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIqXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIiBcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjExICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiIFwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIqXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIipcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjEyICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiKlwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIqXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIipcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIiBcIiAgICBcIiBcIiAgICAgICBcbjEzICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIiBcIiAgIFwiKlwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIqXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIipcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIipcIiAgICBcIiBcIiAgICAgICBcbjE0ICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIipcIiAgIFwiKlwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIqXCIgICAgXCIgXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIipcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIipcIiAgICBcIiBcIiAgICAgICBcbjE1ICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIipcIiAgIFwiKlwiICBcIiBcIiBcIipcIiAgIFwiIFwiICAgXCIqXCIgICAgXCIqXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIipcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIipcIiAgICBcIiBcIiAgICAgICBcbjE2ICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIipcIiAgIFwiKlwiICBcIipcIiBcIipcIiAgIFwiIFwiICAgXCIqXCIgICAgXCIqXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIipcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIipcIiAgICBcIiBcIiAgICAgICBcbjE3ICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIipcIiAgIFwiKlwiICBcIipcIiBcIipcIiAgIFwiIFwiICAgXCIqXCIgICAgXCIqXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIipcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIipcIiAgICBcIipcIiAgICAgICBcbjE4ICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIipcIiAgIFwiKlwiICBcIipcIiBcIipcIiAgIFwiKlwiICAgXCIqXCIgICAgXCIqXCIgICBcIiBcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIipcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIipcIiAgICBcIipcIiAgICAgICBcbjE5ICAoIDEgKSBcIipcIiAgIFwiKlwiICBcIipcIiAgIFwiKlwiICBcIipcIiBcIipcIiAgIFwiKlwiICAgXCIqXCIgICAgXCIqXCIgICBcIipcIiAgICBcIipcIiAgIFwiKlwiICBcIipcIiAgICBcIipcIiAgICAgXCIqXCIgICAgICAgXCIqXCIgICAgIFwiKlwiICAgICBcIipcIiAgICBcIipcIiAgICAgICBcbiJ9 -->

```
Subset selection object
Call: regsubsets.formula(Salary ~ ., data = Hitters, nvmax = 19, method = "forward")
19 Variables  (and intercept)
           Forced in Forced out
AtBat          FALSE      FALSE
Hits           FALSE      FALSE
HmRun          FALSE      FALSE
Runs           FALSE      FALSE
RBI            FALSE      FALSE
Walks          FALSE      FALSE
Years          FALSE      FALSE
CAtBat         FALSE      FALSE
CHits          FALSE      FALSE
CHmRun         FALSE      FALSE
CRuns          FALSE      FALSE
CRBI           FALSE      FALSE
CWalks         FALSE      FALSE
LeagueN        FALSE      FALSE
DivisionW      FALSE      FALSE
PutOuts        FALSE      FALSE
Assists        FALSE      FALSE
Errors         FALSE      FALSE
NewLeagueN     FALSE      FALSE
1 subsets of each size up to 19
Selection Algorithm: forward
          AtBat Hits HmRun Runs RBI Walks Years CAtBat CHits CHmRun CRuns CRBI CWalks LeagueN DivisionW PutOuts Assists Errors NewLeagueN
1  ( 1 )  " "   " "  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     " "       " "     " "     " "    " "       
2  ( 1 )  " "   "*"  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     " "       " "     " "     " "    " "       
3  ( 1 )  " "   "*"  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     " "       "*"     " "     " "    " "       
4  ( 1 )  " "   "*"  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     "*"       "*"     " "     " "    " "       
5  ( 1 )  "*"   "*"  " "   " "  " " " "   " "   " "    " "   " "    " "   "*"  " "    " "     "*"       "*"     " "     " "    " "       
6  ( 1 )  "*"   "*"  " "   " "  " " "*"   " "   " "    " "   " "    " "   "*"  " "    " "     "*"       "*"     " "     " "    " "       
7  ( 1 )  "*"   "*"  " "   " "  " " "*"   " "   " "    " "   " "    " "   "*"  "*"    " "     "*"       "*"     " "     " "    " "       
8  ( 1 )  "*"   "*"  " "   " "  " " "*"   " "   " "    " "   " "    "*"   "*"  "*"    " "     "*"       "*"     " "     " "    " "       
9  ( 1 )  "*"   "*"  " "   " "  " " "*"   " "   "*"    " "   " "    "*"   "*"  "*"    " "     "*"       "*"     " "     " "    " "       
10  ( 1 ) "*"   "*"  " "   " "  " " "*"   " "   "*"    " "   " "    "*"   "*"  "*"    " "     "*"       "*"     "*"     " "    " "       
11  ( 1 ) "*"   "*"  " "   " "  " " "*"   " "   "*"    " "   " "    "*"   "*"  "*"    "*"     "*"       "*"     "*"     " "    " "       
12  ( 1 ) "*"   "*"  " "   "*"  " " "*"   " "   "*"    " "   " "    "*"   "*"  "*"    "*"     "*"       "*"     "*"     " "    " "       
13  ( 1 ) "*"   "*"  " "   "*"  " " "*"   " "   "*"    " "   " "    "*"   "*"  "*"    "*"     "*"       "*"     "*"     "*"    " "       
14  ( 1 ) "*"   "*"  "*"   "*"  " " "*"   " "   "*"    " "   " "    "*"   "*"  "*"    "*"     "*"       "*"     "*"     "*"    " "       
15  ( 1 ) "*"   "*"  "*"   "*"  " " "*"   " "   "*"    "*"   " "    "*"   "*"  "*"    "*"     "*"       "*"     "*"     "*"    " "       
16  ( 1 ) "*"   "*"  "*"   "*"  "*" "*"   " "   "*"    "*"   " "    "*"   "*"  "*"    "*"     "*"       "*"     "*"     "*"    " "       
17  ( 1 ) "*"   "*"  "*"   "*"  "*" "*"   " "   "*"    "*"   " "    "*"   "*"  "*"    "*"     "*"       "*"     "*"     "*"    "*"       
18  ( 1 ) "*"   "*"  "*"   "*"  "*" "*"   "*"   "*"    "*"   " "    "*"   "*"  "*"    "*"     "*"       "*"     "*"     "*"    "*"       
19  ( 1 ) "*"   "*"  "*"   "*"  "*" "*"   "*"   "*"    "*"   "*"    "*"   "*"  "*"    "*"     "*"       "*"     "*"     "*"    "*"       
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmVnZml0LmJ3ZCA8LSByZWdzdWJzZXRzKFNhbGFyeSB+IC4sIGRhdGEgPSBIaXR0ZXJzICwgbnZtYXggPSAxOSwgbWV0aG9kID0gXCJiYWNrd2FyZFwiKVxuc3VtbWFyeShyZWdmaXQuYndkLG1hdHJpeC5sb2dpY2FsPVRSVUUpXG5gYGAifQ== -->

```r
regfit.bwd <- regsubsets(Salary ~ ., data = Hitters , nvmax = 19, method = "backward")
summary(regfit.bwd,matrix.logical=TRUE)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiU3Vic2V0IHNlbGVjdGlvbiBvYmplY3RcbkNhbGw6IHJlZ3N1YnNldHMuZm9ybXVsYShTYWxhcnkgfiAuLCBkYXRhID0gSGl0dGVycywgbnZtYXggPSAxOSwgbWV0aG9kID0gXCJiYWNrd2FyZFwiKVxuMTkgVmFyaWFibGVzICAoYW5kIGludGVyY2VwdClcbiAgICAgICAgICAgRm9yY2VkIGluIEZvcmNlZCBvdXRcbkF0QmF0ICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkhpdHMgICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkhtUnVuICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcblJ1bnMgICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcblJCSSAgICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbldhbGtzICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcblllYXJzICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNBdEJhdCAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNIaXRzICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNIbVJ1biAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNSdW5zICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNSQkkgICAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkNXYWxrcyAgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkxlYWd1ZU4gICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkRpdmlzaW9uVyAgICAgIEZBTFNFICAgICAgRkFMU0VcblB1dE91dHMgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkFzc2lzdHMgICAgICAgIEZBTFNFICAgICAgRkFMU0VcbkVycm9ycyAgICAgICAgIEZBTFNFICAgICAgRkFMU0Vcbk5ld0xlYWd1ZU4gICAgIEZBTFNFICAgICAgRkFMU0VcbjEgc3Vic2V0cyBvZiBlYWNoIHNpemUgdXAgdG8gMTlcblNlbGVjdGlvbiBBbGdvcml0aG06IGJhY2t3YXJkXG4gICAgICAgICAgQXRCYXQgIEhpdHMgSG1SdW4gIFJ1bnMgICBSQkkgV2Fsa3MgWWVhcnMgQ0F0QmF0IENIaXRzIENIbVJ1biBDUnVucyAgQ1JCSSBDV2Fsa3MgTGVhZ3VlTiBEaXZpc2lvblcgUHV0T3V0cyBBc3Npc3RzIEVycm9ycyBOZXdMZWFndWVOXG4xICAoIDEgKSAgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgIEZBTFNFIEZBTFNFICBGQUxTRSAgVFJVRSBGQUxTRSAgRkFMU0UgICBGQUxTRSAgICAgRkFMU0UgICBGQUxTRSAgIEZBTFNFICBGQUxTRSAgICAgIEZBTFNFXG4yICAoIDEgKSAgRkFMU0UgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgIEZBTFNFIEZBTFNFICBGQUxTRSAgVFJVRSBGQUxTRSAgRkFMU0UgICBGQUxTRSAgICAgRkFMU0UgICBGQUxTRSAgIEZBTFNFICBGQUxTRSAgICAgIEZBTFNFXG4zICAoIDEgKSAgRkFMU0UgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgIEZBTFNFIEZBTFNFICBGQUxTRSAgVFJVRSBGQUxTRSAgRkFMU0UgICBGQUxTRSAgICAgRkFMU0UgICAgVFJVRSAgIEZBTFNFICBGQUxTRSAgICAgIEZBTFNFXG40ICAoIDEgKSAgIFRSVUUgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgRkFMU0UgIEZBTFNFIEZBTFNFICBGQUxTRSAgVFJVRSBGQUxTRSAgRkFMU0UgICBGQUxTRSAgICAgRkFMU0UgICAgVFJVRSAgIEZBTFNFICBGQUxTRSAgICAgIEZBTFNFXG41ICAoIDEgKSAgIFRSVUUgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgIFRSVUUgRkFMU0UgIEZBTFNFIEZBTFNFICBGQUxTRSAgVFJVRSBGQUxTRSAgRkFMU0UgICBGQUxTRSAgICAgRkFMU0UgICAgVFJVRSAgIEZBTFNFICBGQUxTRSAgICAgIEZBTFNFXG42ICAoIDEgKSAgIFRSVUUgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgIFRSVUUgRkFMU0UgIEZBTFNFIEZBTFNFICBGQUxTRSAgVFJVRSBGQUxTRSAgRkFMU0UgICBGQUxTRSAgICAgIFRSVUUgICAgVFJVRSAgIEZBTFNFICBGQUxTRSAgICAgIEZBTFNFXG43ICAoIDEgKSAgIFRSVUUgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgIFRSVUUgRkFMU0UgIEZBTFNFIEZBTFNFICBGQUxTRSAgVFJVRSBGQUxTRSAgIFRSVUUgICBGQUxTRSAgICAgIFRSVUUgICAgVFJVRSAgIEZBTFNFICBGQUxTRSAgICAgIEZBTFNFXG44ICAoIDEgKSAgIFRSVUUgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgIFRSVUUgRkFMU0UgIEZBTFNFIEZBTFNFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICBGQUxTRSAgICAgIFRSVUUgICAgVFJVRSAgIEZBTFNFICBGQUxTRSAgICAgIEZBTFNFXG45ICAoIDEgKSAgIFRSVUUgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgIFRSVUUgRkFMU0UgICBUUlVFIEZBTFNFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICBGQUxTRSAgICAgIFRSVUUgICAgVFJVRSAgIEZBTFNFICBGQUxTRSAgICAgIEZBTFNFXG4xMCAgKCAxICkgIFRSVUUgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgIFRSVUUgRkFMU0UgICBUUlVFIEZBTFNFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICBGQUxTRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICBGQUxTRSAgICAgIEZBTFNFXG4xMSAgKCAxICkgIFRSVUUgIFRSVUUgRkFMU0UgRkFMU0UgRkFMU0UgIFRSVUUgRkFMU0UgICBUUlVFIEZBTFNFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICAgVFJVRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICBGQUxTRSAgICAgIEZBTFNFXG4xMiAgKCAxICkgIFRSVUUgIFRSVUUgRkFMU0UgIFRSVUUgRkFMU0UgIFRSVUUgRkFMU0UgICBUUlVFIEZBTFNFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICAgVFJVRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICBGQUxTRSAgICAgIEZBTFNFXG4xMyAgKCAxICkgIFRSVUUgIFRSVUUgRkFMU0UgIFRSVUUgRkFMU0UgIFRSVUUgRkFMU0UgICBUUlVFIEZBTFNFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICAgVFJVRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICAgVFJVRSAgICAgIEZBTFNFXG4xNCAgKCAxICkgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgRkFMU0UgIFRSVUUgRkFMU0UgICBUUlVFIEZBTFNFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICAgVFJVRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICAgVFJVRSAgICAgIEZBTFNFXG4xNSAgKCAxICkgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgRkFMU0UgIFRSVUUgRkFMU0UgICBUUlVFICBUUlVFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICAgVFJVRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICAgVFJVRSAgICAgIEZBTFNFXG4xNiAgKCAxICkgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgRkFMU0UgICBUUlVFICBUUlVFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICAgVFJVRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICAgVFJVRSAgICAgIEZBTFNFXG4xNyAgKCAxICkgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgRkFMU0UgICBUUlVFICBUUlVFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICAgVFJVRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICAgVFJVRSAgICAgICBUUlVFXG4xOCAgKCAxICkgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgICBUUlVFICBUUlVFICBGQUxTRSAgVFJVRSAgVFJVRSAgIFRSVUUgICAgVFJVRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICAgVFJVRSAgICAgICBUUlVFXG4xOSAgKCAxICkgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgIFRSVUUgICBUUlVFICBUUlVFICAgVFJVRSAgVFJVRSAgVFJVRSAgIFRSVUUgICAgVFJVRSAgICAgIFRSVUUgICAgVFJVRSAgICBUUlVFICAgVFJVRSAgICAgICBUUlVFXG4ifQ== -->

```
Subset selection object
Call: regsubsets.formula(Salary ~ ., data = Hitters, nvmax = 19, method = "backward")
19 Variables  (and intercept)
           Forced in Forced out
AtBat          FALSE      FALSE
Hits           FALSE      FALSE
HmRun          FALSE      FALSE
Runs           FALSE      FALSE
RBI            FALSE      FALSE
Walks          FALSE      FALSE
Years          FALSE      FALSE
CAtBat         FALSE      FALSE
CHits          FALSE      FALSE
CHmRun         FALSE      FALSE
CRuns          FALSE      FALSE
CRBI           FALSE      FALSE
CWalks         FALSE      FALSE
LeagueN        FALSE      FALSE
DivisionW      FALSE      FALSE
PutOuts        FALSE      FALSE
Assists        FALSE      FALSE
Errors         FALSE      FALSE
NewLeagueN     FALSE      FALSE
1 subsets of each size up to 19
Selection Algorithm: backward
          AtBat  Hits HmRun  Runs   RBI Walks Years CAtBat CHits CHmRun CRuns  CRBI CWalks LeagueN DivisionW PutOuts Assists Errors NewLeagueN
1  ( 1 )  FALSE FALSE FALSE FALSE FALSE FALSE FALSE  FALSE FALSE  FALSE  TRUE FALSE  FALSE   FALSE     FALSE   FALSE   FALSE  FALSE      FALSE
2  ( 1 )  FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  FALSE FALSE  FALSE  TRUE FALSE  FALSE   FALSE     FALSE   FALSE   FALSE  FALSE      FALSE
3  ( 1 )  FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  FALSE FALSE  FALSE  TRUE FALSE  FALSE   FALSE     FALSE    TRUE   FALSE  FALSE      FALSE
4  ( 1 )   TRUE  TRUE FALSE FALSE FALSE FALSE FALSE  FALSE FALSE  FALSE  TRUE FALSE  FALSE   FALSE     FALSE    TRUE   FALSE  FALSE      FALSE
5  ( 1 )   TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  FALSE FALSE  FALSE  TRUE FALSE  FALSE   FALSE     FALSE    TRUE   FALSE  FALSE      FALSE
6  ( 1 )   TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  FALSE FALSE  FALSE  TRUE FALSE  FALSE   FALSE      TRUE    TRUE   FALSE  FALSE      FALSE
7  ( 1 )   TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  FALSE FALSE  FALSE  TRUE FALSE   TRUE   FALSE      TRUE    TRUE   FALSE  FALSE      FALSE
8  ( 1 )   TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  FALSE FALSE  FALSE  TRUE  TRUE   TRUE   FALSE      TRUE    TRUE   FALSE  FALSE      FALSE
9  ( 1 )   TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE   TRUE FALSE  FALSE  TRUE  TRUE   TRUE   FALSE      TRUE    TRUE   FALSE  FALSE      FALSE
10  ( 1 )  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE   TRUE FALSE  FALSE  TRUE  TRUE   TRUE   FALSE      TRUE    TRUE    TRUE  FALSE      FALSE
11  ( 1 )  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE   TRUE FALSE  FALSE  TRUE  TRUE   TRUE    TRUE      TRUE    TRUE    TRUE  FALSE      FALSE
12  ( 1 )  TRUE  TRUE FALSE  TRUE FALSE  TRUE FALSE   TRUE FALSE  FALSE  TRUE  TRUE   TRUE    TRUE      TRUE    TRUE    TRUE  FALSE      FALSE
13  ( 1 )  TRUE  TRUE FALSE  TRUE FALSE  TRUE FALSE   TRUE FALSE  FALSE  TRUE  TRUE   TRUE    TRUE      TRUE    TRUE    TRUE   TRUE      FALSE
14  ( 1 )  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE   TRUE FALSE  FALSE  TRUE  TRUE   TRUE    TRUE      TRUE    TRUE    TRUE   TRUE      FALSE
15  ( 1 )  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE   TRUE  TRUE  FALSE  TRUE  TRUE   TRUE    TRUE      TRUE    TRUE    TRUE   TRUE      FALSE
16  ( 1 )  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE   TRUE  TRUE  FALSE  TRUE  TRUE   TRUE    TRUE      TRUE    TRUE    TRUE   TRUE      FALSE
17  ( 1 )  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE   TRUE  TRUE  FALSE  TRUE  TRUE   TRUE    TRUE      TRUE    TRUE    TRUE   TRUE       TRUE
18  ( 1 )  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE   TRUE  TRUE  FALSE  TRUE  TRUE   TRUE    TRUE      TRUE    TRUE    TRUE   TRUE       TRUE
19  ( 1 )  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE   TRUE  TRUE   TRUE  TRUE  TRUE   TRUE    TRUE      TRUE    TRUE    TRUE   TRUE       TRUE
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


For instance, we see that using forward stepwise selection, the best one variable model contains only `CRBI`, and the best two-variable model additionally includes `Hits`. For this data, the best one-variable through six variable models are each identical for best subset and forward selection. However, the best seven-variable models identified by forward stepwise selection, backward stepwise selection, and best subset selection are different.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuY29lZihyZWdmaXQuZnVsbCwgNylcbmBgYCJ9 -->

```r
coef(regfit.full, 7)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgICAgICAgSGl0cyAgICAgICAgV2Fsa3MgICAgICAgQ0F0QmF0ICAgICAgICBDSGl0cyAgICAgICBDSG1SdW4gICAgRGl2aXNpb25XICAgICAgUHV0T3V0cyBcbiAgNzkuNDUwOTQ3MiAgICAxLjI4MzM1MTMgICAgMy4yMjc0MjY0ICAgLTAuMzc1MjM1MCAgICAxLjQ5NTcwNzMgICAgMS40NDIwNTM4IC0xMjkuOTg2NjQzMiAgICAwLjIzNjY4MTMgXG4ifQ== -->

```
 (Intercept)         Hits        Walks       CAtBat        CHits       CHmRun    DivisionW      PutOuts 
  79.4509472    1.2833513    3.2274264   -0.3752350    1.4957073    1.4420538 -129.9866432    0.2366813 
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuY29lZihyZWdmaXQuZndkLCA3KVxuYGBgIn0= -->

```r
coef(regfit.fwd, 7)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgICAgICBBdEJhdCAgICAgICAgIEhpdHMgICAgICAgIFdhbGtzICAgICAgICAgQ1JCSSAgICAgICBDV2Fsa3MgICAgRGl2aXNpb25XICAgICAgUHV0T3V0cyBcbiAxMDkuNzg3MzA2MiAgIC0xLjk1ODg4NTEgICAgNy40NDk4NzcyICAgIDQuOTEzMTQwMSAgICAwLjg1Mzc2MjIgICAtMC4zMDUzMDcwIC0xMjcuMTIyMzkyOCAgICAwLjI1MzM0MDQgXG4ifQ== -->

```
 (Intercept)        AtBat         Hits        Walks         CRBI       CWalks    DivisionW      PutOuts 
 109.7873062   -1.9588851    7.4498772    4.9131401    0.8537622   -0.3053070 -127.1223928    0.2533404 
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuY29lZihyZWdmaXQuYndkLCA3KVxuYGBgIn0= -->

```r
coef(regfit.bwd, 7)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgICAgICBBdEJhdCAgICAgICAgIEhpdHMgICAgICAgIFdhbGtzICAgICAgICBDUnVucyAgICAgICBDV2Fsa3MgICAgRGl2aXNpb25XICAgICAgUHV0T3V0cyBcbiAxMDUuNjQ4NzQ4OCAgIC0xLjk3NjI4MzggICAgNi43NTc0OTE0ICAgIDYuMDU1ODY5MSAgICAxLjEyOTMwOTUgICAtMC43MTYzMzQ2IC0xMTYuMTY5MjE2OSAgICAwLjMwMjg4NDcgXG4ifQ== -->

```
 (Intercept)        AtBat         Hits        Walks        CRuns       CWalks    DivisionW      PutOuts 
 105.6487488   -1.9762838    6.7574914    6.0558691    1.1293095   -0.7163346 -116.1692169    0.3028847 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Choosing Among Models using the Validation Set Approach and Cross-Validation

We just saw that it is possible to choose among a set of models of different sizes using `Cp`, `BIC`, and adjusted `R2`. We will now consider how to do this using the validation set and cross-validation approaches.

In order for these approaches to yield accurate estimates of the test error, we must use only the training observations to perform all aspects of model-fitting - including variable selection. Therefore, the determination of which model of a given size is best must be made using only the training observations. This point is subtle but important. If the full data set is used to perform the best subset selection step, the validation set errors and cross-validation errors that we obtain will not be accurate estimates of the test error.

In order to use the validation set approach, we begin by splitting the observations into a training set and a test set. We do this by creating a random vector, train, of elements equal to `TRUE` if the corresponding observation is in the training set, and `FALSE` otherwise. The vector test has a `TRUE` if the observation is in the test set, and a `FALSE` otherwise. Note the `!` in the command to create test causes `TRUEs` to be switched to `FALSEs` and vice versa. We also set a random seed so that the user will obtain the same training set / test set split.



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc2V0LnNlZWQoMSlcbnRyYWluIDwtIHNhbXBsZShjKFRSVUUsIEZBTFNFKSwgbnJvdyhIaXR0ZXJzKSwgcmVwID0gVFJVRSlcbnRlc3QgPC0oIXRyYWluKVxuYGBgIn0= -->

```r
set.seed(1)
train <- sample(c(TRUE, FALSE), nrow(Hitters), rep = TRUE)
test <-(!train)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Now, we apply `regsubsets()` to the training set in order to perform best subset selection.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmVnZml0LmJlc3QgPC0gcmVnc3Vic2V0cyhTYWxhcnkgfiAuLCBkYXRhID0gSGl0dGVyc1t0cmFpbiwgXSwgbnZtYXggPSAxOSlcbmBgYCJ9 -->

```r
regfit.best <- regsubsets(Salary ~ ., data = Hitters[train, ], nvmax = 19)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



Notice that we subset the `Hitters` data frame directly in the call in order to access only the training subset of the data, using the expression `Hitters[train,]`. We now compute the validation set error for the best model of each model size. We first make a model matrix from the test data.



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxudGVzdC5tYXQgPC0gbW9kZWwubWF0cml4KFNhbGFyeSB+IC4sIGRhdGEgPSBIaXR0ZXJzW3Rlc3QsIF0pXG5gYGAifQ== -->

```r
test.mat <- model.matrix(Salary ~ ., data = Hitters[test, ])
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

The `model.matrix()` function is used in many regression packages for building an "X" matrix from data. Now we run a loop, and for each size i, we extract the coefficients from regfit.best for the best model of that size, multiply them into the appropriate columns of the test model matrix to form the predictions, and compute the test MSE.



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxudmFsLmVycm9ycyA8LSByZXAoTkEsIDE5KVxuZm9yKGkgaW4gMToxOSkgXG57XG4gIGNvZWZpIDwtIGNvZWYocmVnZml0LmJlc3QsIGlkID0gaSlcbiAgcHJlZCA8LSB0ZXN0Lm1hdFsgLG5hbWVzKGNvZWZpKV0gJSolIGNvZWZpXG4gIHZhbC5lcnJvcnNbaV0gPC0gbWVhbigoSGl0dGVycyRTYWxhcnlbdGVzdF0gLSBwcmVkKV4yKVxufVxuYGBgIn0= -->

```r
val.errors <- rep(NA, 19)
for(i in 1:19) 
{
  coefi <- coef(regfit.best, id = i)
  pred <- test.mat[ ,names(coefi)] %*% coefi
  val.errors[i] <- mean((Hitters$Salary[test] - pred)^2)
}
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


We find that the best model is the one that contains ten variables.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShtYWdyaXR0cilcbnZhbC5lcnJvcnMgJT4lIHdoaWNoLm1pbiAlPiUgY29lZihyZWdmaXQuYmVzdCwgLilcbmBgYCJ9 -->

```r
library(magrittr)
val.errors %>% which.min %>% coef(regfit.best, .)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiKEludGVyY2VwdCkgICAgICAgQXRCYXQgICAgICAgIEhpdHMgICAgICAgV2Fsa3MgICAgICBDQXRCYXQgICAgICAgQ0hpdHMgICAgICBDSG1SdW4gICAgICBDV2Fsa3MgXG4tODAuMjc1MTQ5OSAgLTEuNDY4MzgxNiAgIDcuMTYyNTMxNCAgIDMuNjQzMDM0NSAgLTAuMTg1NTY5OCAgIDEuMTA1MzIzOCAgIDEuMzg0NDg2MyAgLTAuNzQ4MzE3MCBcbiAgICBMZWFndWVOICAgRGl2aXNpb25XICAgICBQdXRPdXRzIFxuIDg0LjU1NzYxMDMgLTUzLjAyODk2NTggICAwLjIzODE2NjIgXG4ifQ== -->

```
(Intercept)       AtBat        Hits       Walks      CAtBat       CHits      CHmRun      CWalks 
-80.2751499  -1.4683816   7.1625314   3.6430345  -0.1855698   1.1053238   1.3844863  -0.7483170 
    LeagueN   DivisionW     PutOuts 
 84.5576103 -53.0289658   0.2381662 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


This was a little tedious, partly because there is no `predict()` method for `regsubsets()`. Since we will be using this function again, we can capture our steps above and write our own predict method.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJlZGljdC5yZWdzdWJzZXRzIDwtIGZ1bmN0aW9uKG9iamVjdCwgbmV3ZGF0YSwgaWQsIC4uLikgXG57XG4gIGZvcm0gPC0gYXMuZm9ybXVsYShvYmplY3QkY2FsbFtbMl1dKVxuICBtYXQgPC0gbW9kZWwubWF0cml4KGZvcm0sIG5ld2RhdGEpXG4gIGNvZWZpIDwtIGNvZWYob2JqZWN0LCBpZCA9IGlkKVxuICB4dmFycyA8LSBuYW1lcyhjb2VmaSlcbiAgbWF0WyAseHZhcnNdICUqJSBjb2VmaVxufVxuYGBgIn0= -->

```r
predict.regsubsets <- function(object, newdata, id, ...) 
{
  form <- as.formula(object$call[[2]])
  mat <- model.matrix(form, newdata)
  coefi <- coef(object, id = id)
  xvars <- names(coefi)
  mat[ ,xvars] %*% coefi
}
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Our function pretty much mimics what we did above. The only complex part is how we extracted the formula used in the call to `regsubsets()`. We demonstrate how we use this function below, when we do cross-validation.

Finally, we perform best subset selection on the full data set, and select the best ten-variable model. It is important that we make use of the full data set in order to obtain more accurate coefficient estimates. Note that we perform best subset selection on the full data set and select the best tenvariable model, rather than simply using the variables that were obtained from the training set, because the best ten-variable model on the full data set may differ from the corresponding model on the training set.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmVnZml0LmJlc3QgPC0gcmVnc3Vic2V0cyhTYWxhcnkgfiAuLCBkYXRhID0gSGl0dGVycywgbnZtYXggPSAxOSlcbmNvZWYocmVnZml0LmJlc3QsIDEwKVxuYGBgIn0= -->

```r
regfit.best <- regsubsets(Salary ~ ., data = Hitters, nvmax = 19)
coef(regfit.best, 10)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgICAgICBBdEJhdCAgICAgICAgIEhpdHMgICAgICAgIFdhbGtzICAgICAgIENBdEJhdCAgICAgICAgQ1J1bnMgICAgICAgICBDUkJJICAgICAgIENXYWxrcyAgICBEaXZpc2lvblcgICAgICBQdXRPdXRzIFxuIDE2Mi41MzU0NDIwICAgLTIuMTY4NjUwMSAgICA2LjkxODAxNzUgICAgNS43NzMyMjQ2ICAgLTAuMTMwMDc5OCAgICAxLjQwODI0OTAgICAgMC43NzQzMTIyICAgLTAuODMwODI2NCAtMTEyLjM4MDA1NzUgICAgMC4yOTczNzI2IFxuICAgICBBc3Npc3RzIFxuICAgMC4yODMxNjgwIFxuIn0= -->

```
 (Intercept)        AtBat         Hits        Walks       CAtBat        CRuns         CRBI       CWalks    DivisionW      PutOuts 
 162.5354420   -2.1686501    6.9180175    5.7732246   -0.1300798    1.4082490    0.7743122   -0.8308264 -112.3800575    0.2973726 
     Assists 
   0.2831680 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


In fact, we see that the best ten-variable model on the full data set has a different set of variables than the best ten-variable model on the training set.

We now try to choose among the models of different sizes using crossvalidation. This approach is somewhat involved, as we must perform best subset selection within each of the k training sets. Despite this, we see that with its clever subsetting syntax, R makes this job quite easy. First, we create a vector that allocates each observation to one of k = 10 folds, and we create a matrix in which we will store the results.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuayA8LSAxMFxuc2V0LnNlZWQoMSlcbmZvbGRzIDwtIHNhbXBsZSgxOmssIG5yb3coSGl0dGVycyksIHJlcGxhY2UgPSBUUlVFKVxuY3YuZXJyb3JzIDwtIG1hdHJpeChOQSwgaywgMTksIGRpbW5hbWVzID0gbGlzdChOVUxMICwgcGFzdGUoMToxOSkpKVxuYGBgIn0= -->

```r
k <- 10
set.seed(1)
folds <- sample(1:k, nrow(Hitters), replace = TRUE)
cv.errors <- matrix(NA, k, 19, dimnames = list(NULL , paste(1:19)))
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Now we write a for loop that performs cross-validation. In the jth fold, the elements of `folds` that equal j are in the test set, and the remainder are in the training set. We make our predictions for each model size(using our new `predict()` method), compute the test errors on the appropriate subset, and store them in the appropriate slot in the matrix `cv.errors`.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZm9yKGogaW4gMTprKVxue1xuICBiZXN0LmZpdCA8LSByZWdzdWJzZXRzKFNhbGFyeSB+IC4sIGRhdGEgPSBIaXR0ZXJzW2ZvbGRzICE9IGosIF0sIG52bWF4ID0gMTkpXG4gIGZvcihpIGluIDE6MTkpIFxuICB7XG4gICAgcHJlZCA8LSBwcmVkaWN0KGJlc3QuZml0LCBIaXR0ZXJzW2ZvbGRzID09IGosIF0sIGlkID0gaSlcbiAgICBjdi5lcnJvcnNbaiwgaV0gPC0gbWVhbigoSGl0dGVycyRTYWxhcnlbZm9sZHMgPT0gal0gLSBwcmVkKV4yKVxuICB9XG59XG5gYGAifQ== -->

```r
for(j in 1:k)
{
  best.fit <- regsubsets(Salary ~ ., data = Hitters[folds != j, ], nvmax = 19)
  for(i in 1:19) 
  {
    pred <- predict(best.fit, Hitters[folds == j, ], id = i)
    cv.errors[j, i] <- mean((Hitters$Salary[folds == j] - pred)^2)
  }
}
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



This has given us a 10×19 matrix, of which the $(i, j)^{th}$ element corresponds to the test `MSE` for the ith cross-validation fold for the best j-variable model. We use the apply() function to average over the columns of this matrix in order to obtain a vector for which the jth element is the crossvalidation error for the j-variable model.



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubWVhbi5jdi5lcnJvcnMgPC0gYXBwbHkoY3YuZXJyb3JzLCAyLCBtZWFuKVxubWVhbi5jdi5lcnJvcnNcbmBgYCJ9 -->

```r
mean.cv.errors <- apply(cv.errors, 2, mean)
mean.cv.errors
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAgICAgIDEgICAgICAgIDIgICAgICAgIDMgICAgICAgIDQgICAgICAgIDUgICAgICAgIDYgICAgICAgIDcgICAgICAgIDggICAgICAgIDkgICAgICAgMTAgICAgICAgMTEgICAgICAgMTIgICAgICAgMTMgICAgICAgMTQgICAgICAgMTUgXG4xNjAwOTMuNSAxNDAxOTYuOCAxNTMxMTcuMCAxNTExNTkuMyAxNDY4NDEuMyAxMzgzMDIuNiAxNDQzNDYuMiAxMzAyMDcuNyAxMjk0NTkuNiAxMjUzMzQuNyAxMjUxNTMuOCAxMjgyNzMuNSAxMzM0NjEuMCAxMzM5NzQuNiAxMzE4MjUuNyBcbiAgICAgIDE2ICAgICAgIDE3ICAgICAgIDE4ICAgICAgIDE5IFxuMTMxODgyLjggMTMyNzUwLjkgMTMzMDk2LjIgMTMyODA0LjcgXG4ifQ== -->

```
       1        2        3        4        5        6        7        8        9       10       11       12       13       14       15 
160093.5 140196.8 153117.0 151159.3 146841.3 138302.6 144346.2 130207.7 129459.6 125334.7 125153.8 128273.5 133461.0 133974.6 131825.7 
      16       17       18       19 
131882.8 132750.9 133096.2 132804.7 
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucGFyKG1mcm93ID0gYygxLCAxKSlcbnBsb3QobWVhbi5jdi5lcnJvcnMsIHR5cGUgPSBcImJcIilcbmBgYCJ9 -->

```r
par(mfrow = c(1, 1))
plot(mean.cv.errors, type = "b")
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJjb25kaXRpb25zIjpbXSwiaGVpZ2h0Ijo0MzIuNjMyOSwic2l6ZV9iZWhhdmlvciI6MCwid2lkdGgiOjcwMH0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


We see that cross-validation selects an eleven-variable model. We now perform best subset selection on the full data set in order to obtain the elevenvariable model.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmVnLmJlc3QgPC0gcmVnc3Vic2V0cyhTYWxhcnkgfiAuLCBkYXRhID0gSGl0dGVycywgbnZtYXggPSAxOSlcbmNvZWYocmVnLmJlc3QsIDExKVxuYGBgIn0= -->

```r
reg.best <- regsubsets(Salary ~ ., data = Hitters, nvmax = 19)
coef(reg.best, 11)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgICAgICBBdEJhdCAgICAgICAgIEhpdHMgICAgICAgIFdhbGtzICAgICAgIENBdEJhdCAgICAgICAgQ1J1bnMgICAgICAgICBDUkJJICAgICAgIENXYWxrcyAgICAgIExlYWd1ZU4gICAgRGl2aXNpb25XIFxuIDEzNS43NTEyMTk1ICAgLTIuMTI3NzQ4MiAgICA2LjkyMzY5OTQgICAgNS42MjAyNzU1ICAgLTAuMTM4OTkxNCAgICAxLjQ1NTMzMTAgICAgMC43ODUyNTI4ICAgLTAuODIyODU1OSAgIDQzLjExMTYxNTIgLTExMS4xNDYwMjUyIFxuICAgICBQdXRPdXRzICAgICAgQXNzaXN0cyBcbiAgIDAuMjg5NDA4NyAgICAwLjI2ODgyNzcgXG4ifQ== -->

```
 (Intercept)        AtBat         Hits        Walks       CAtBat        CRuns         CRBI       CWalks      LeagueN    DivisionW 
 135.7512195   -2.1277482    6.9236994    5.6202755   -0.1389914    1.4553310    0.7852528   -0.8228559   43.1116152 -111.1460252 
     PutOuts      Assists 
   0.2894087    0.2688277 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



## Ridge Regression and the Lasso

We will use the glmnet package in order to perform ridge regression and the lasso. The main function in this package is `glmnet()`, which can be used to fit ridge regression models, lasso models, and more. This function has slightly different syntax from other model-fitting functions that we have encountered thus far. In particular, we must pass in an x matrix as well as a y vector, and we do not use the `y ~ x` syntax. We will now perform ridge regression and the lasso in order to predict `Salary` on the Hitters data. Before proceeding ensure that the missing values have been removed from the data.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxueCA8LSBtb2RlbC5tYXRyaXgoU2FsYXJ5IH4gLiwgSGl0dGVycylbICwgLTFdXG55IDwtIEhpdHRlcnMkU2FsYXJ5XG5gYGAifQ== -->

```r
x <- model.matrix(Salary ~ ., Hitters)[ , -1]
y <- Hitters$Salary
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


The `model.matrix()` function is particularly useful for creating x; not only does it produce a matrix corresponding to the 19 predictors but it also automatically transforms any qualitative variables into dummy variables. The latter property is important because `glmnet()` can only take numerical, quantitative inputs.


### Ridge Regression
The `glmnet()` function has an alpha argument that determines what type of model is fit. If alpha=0 then a ridge regression model is fit, and if alpha=1 then a lasso model is fit. We first fit a ridge regression model.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShnbG1uZXQpXG5ncmlkIDwtIDEwIF4gc2VxKDEwLCAtMiwgbGVuZ3RoID0gMTAwKVxucmlkZ2UubW9kIDwtIGdsbW5ldCh4LCB5LCBhbHBoYSA9IDAsIGxhbWJkYSA9IGdyaWQpXG5gYGAifQ== -->

```r
library(glmnet)
grid <- 10 ^ seq(10, -2, length = 100)
ridge.mod <- glmnet(x, y, alpha = 0, lambda = grid)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



Associated with each value of $\lambda$ is a vector of ridge regression coefficients, stored in a matrix that can be accessed by `coef()`. In this case, it is a 20×100 matrix, with 20 rows(one for each predictor, plus an intercept) and 100 columns (one for each value of $\lambda$).


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmlkZ2UubW9kJGxhbWJkYVs1MF1cbmBgYCJ9 -->

```r
ridge.mod$lambda[50]
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDExNDk3LjU3XG4ifQ== -->

```
[1] 11497.57
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuY29lZihyaWRnZS5tb2QpWyAsIDUwXVxuYGBgIn0= -->

```r
coef(ridge.mod)[ , 50]
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAoSW50ZXJjZXB0KSAgICAgICAgIEF0QmF0ICAgICAgICAgIEhpdHMgICAgICAgICBIbVJ1biAgICAgICAgICBSdW5zICAgICAgICAgICBSQkkgICAgICAgICBXYWxrcyAgICAgICAgIFllYXJzICAgICAgICBDQXRCYXQgICAgICAgICBDSGl0cyBcbjQwNy4zNTYwNTAyMDAgICAwLjAzNjk1NzE4MiAgIDAuMTM4MTgwMzQ0ICAgMC41MjQ2Mjk5NzYgICAwLjIzMDcwMTUyMyAgIDAuMjM5ODQxNDU5ICAgMC4yODk2MTg3NDEgICAxLjEwNzcwMjkyOSAgIDAuMDAzMTMxODE1ICAgMC4wMTE2NTM2MzcgXG4gICAgICAgQ0htUnVuICAgICAgICAgQ1J1bnMgICAgICAgICAgQ1JCSSAgICAgICAgQ1dhbGtzICAgICAgIExlYWd1ZU4gICAgIERpdmlzaW9uVyAgICAgICBQdXRPdXRzICAgICAgIEFzc2lzdHMgICAgICAgIEVycm9ycyAgICBOZXdMZWFndWVOIFxuICAwLjA4NzU0NTY3MCAgIDAuMDIzMzc5ODgyICAgMC4wMjQxMzgzMjAgICAwLjAyNTAxNTQyMSAgIDAuMDg1MDI4MTE0ICAtNi4yMTU0NDA5NzMgICAwLjAxNjQ4MjU3NyAgIDAuMDAyNjEyOTg4ICAtMC4wMjA1MDI2OTAgICAwLjMwMTQzMzUzMSBcbiJ9 -->

```
  (Intercept)         AtBat          Hits         HmRun          Runs           RBI         Walks         Years        CAtBat         CHits 
407.356050200   0.036957182   0.138180344   0.524629976   0.230701523   0.239841459   0.289618741   1.107702929   0.003131815   0.011653637 
       CHmRun         CRuns          CRBI        CWalks       LeagueN     DivisionW       PutOuts       Assists        Errors    NewLeagueN 
  0.087545670   0.023379882   0.024138320   0.025015421   0.085028114  -6.215440973   0.016482577   0.002612988  -0.020502690   0.301433531 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


We can use the `predict()` function for a number of purposes. For instance, we can obtain the ridge regression coefficients for a new value of $\lambda$, say 50:


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJlZGljdChyaWRnZS5tb2QsIHMgPSA1MCwgdHlwZSA9IFwiY29lZmZpY2llbnRzXCIpWzE6MjAsIF1cbmBgYCJ9 -->

```r
predict(ridge.mod, s = 50, type = "coefficients")[1:20, ]
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAoSW50ZXJjZXB0KSAgICAgICAgIEF0QmF0ICAgICAgICAgIEhpdHMgICAgICAgICBIbVJ1biAgICAgICAgICBSdW5zICAgICAgICAgICBSQkkgICAgICAgICBXYWxrcyAgICAgICAgIFllYXJzICAgICAgICBDQXRCYXQgICAgICAgICBDSGl0cyBcbiA0Ljg3NjYxMGUrMDEgLTMuNTgwOTk5ZS0wMSAgMS45NjkzNTllKzAwIC0xLjI3ODI0OGUrMDAgIDEuMTQ1ODkyZSswMCAgOC4wMzgyOTJlLTAxICAyLjcxNjE4NmUrMDAgLTYuMjE4MzE5ZSswMCAgNS40NDc4MzdlLTAzICAxLjA2NDg5NWUtMDEgXG4gICAgICAgQ0htUnVuICAgICAgICAgQ1J1bnMgICAgICAgICAgQ1JCSSAgICAgICAgQ1dhbGtzICAgICAgIExlYWd1ZU4gICAgIERpdmlzaW9uVyAgICAgICBQdXRPdXRzICAgICAgIEFzc2lzdHMgICAgICAgIEVycm9ycyAgICBOZXdMZWFndWVOIFxuIDYuMjQ0ODYwZS0wMSAgMi4yMTQ5ODVlLTAxICAyLjE4NjkxNGUtMDEgLTEuNTAwMjQ1ZS0wMSAgNC41OTI1ODllKzAxIC0xLjE4MjAxMWUrMDIgIDIuNTAyMzIyZS0wMSAgMS4yMTU2NjVlLTAxIC0zLjI3ODYwMGUrMDAgLTkuNDk2NjgwZSswMCBcbiJ9 -->

```
  (Intercept)         AtBat          Hits         HmRun          Runs           RBI         Walks         Years        CAtBat         CHits 
 4.876610e+01 -3.580999e-01  1.969359e+00 -1.278248e+00  1.145892e+00  8.038292e-01  2.716186e+00 -6.218319e+00  5.447837e-03  1.064895e-01 
       CHmRun         CRuns          CRBI        CWalks       LeagueN     DivisionW       PutOuts       Assists        Errors    NewLeagueN 
 6.244860e-01  2.214985e-01  2.186914e-01 -1.500245e-01  4.592589e+01 -1.182011e+02  2.502322e-01  1.215665e-01 -3.278600e+00 -9.496680e+00 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


We first set a random seed so that the results obtained will be reproducible.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc2V0LnNlZWQoMSlcbnRyYWluIDwtIHNhbXBsZSgxOm5yb3coeCksIG5yb3coeCkvMilcbnRlc3QgPC0gKC10cmFpbilcbnkudGVzdCA8LSB5W3Rlc3RdXG5gYGAifQ== -->

```r
set.seed(1)
train <- sample(1:nrow(x), nrow(x)/2)
test <- (-train)
y.test <- y[test]
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Next we fit a ridge regression model on the training set, and evaluate its `MSE` on the test set, using `\lambda = 4`. Note the use of the `predict()` function again. This time we get predictions for a test set, by replacing `type="coefficients"` with the `newx` argument.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmlkZ2UubW9kIDwtIGdsbW5ldCh4W3RyYWluLCBdLCB5W3RyYWluXSwgYWxwaGEgPSAwLCBsYW1iZGEgPSBncmlkLCB0aHJlc2ggPSAxZS0xMilcbnJpZGdlLnByZWQgPC0gcHJlZGljdChyaWRnZS5tb2QsIHM9NCwgbmV3eCA9IHhbdGVzdCwgXSlcbm1lYW4oKHJpZGdlLnByZWQgLSB5LnRlc3QpXjIpXG5gYGAifQ== -->

```r
ridge.mod <- glmnet(x[train, ], y[train], alpha = 0, lambda = grid, thresh = 1e-12)
ridge.pred <- predict(ridge.mod, s=4, newx = x[test, ])
mean((ridge.pred - y.test)^2)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDEwMTAzNi44XG4ifQ== -->

```
[1] 101036.8
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



In general, instead of arbitrarily choosing $\lambda = 4$, it would be better to use cross-validation to choose the tuning parameter $\lambda$. We can do this using the built-in cross-validation function, `cv.glmnet()`. By default, the function performs ten-fold cross-validation, though this can be changed using the argument `folds`. Note that we set a random seed first so our results will be reproducible, since the choice of the cross-validation folds is random.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc2V0LnNlZWQoMSlcbmN2Lm91dCA8LSBjdi5nbG1uZXQoeFt0cmFpbiwgXSwgeVt0cmFpbl0sIGFscGhhID0gMClcbnBsb3QoY3Yub3V0KVxuYGBgIn0= -->

```r
set.seed(1)
cv.out <- cv.glmnet(x[train, ], y[train], alpha = 0)
plot(cv.out)
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJjb25kaXRpb25zIjpbXSwiaGVpZ2h0Ijo0MzIuNjMyOSwic2l6ZV9iZWhhdmlvciI6MCwid2lkdGgiOjcwMH0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYmVzdGxhbSA8LSBjdi5vdXQkbGFtYmRhLm1pblxuYmVzdGxhbVxuYGBgIn0= -->

```r
bestlam <- cv.out$lambda.min
bestlam
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDIxMS43NDE2XG4ifQ== -->

```
[1] 211.7416
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



Finally, we refit our ridge regression model on the full data set, using the value of $\lambda$ chosen by cross-validation, and examine the coefficient estimates.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxub3V0IDwtIGdsbW5ldCh4LCB5LCBhbHBoYSA9IDApXG5wcmVkaWN0KG91dCwgdHlwZSA9IFwiY29lZmZpY2llbnRzXCIsIHMgPSBiZXN0bGFtKVsxOjIwLCBdIFxuYGBgIn0= -->

```r
out <- glmnet(x, y, alpha = 0)
predict(out, type = "coefficients", s = bestlam)[1:20, ] 
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgICAgICBBdEJhdCAgICAgICAgIEhpdHMgICAgICAgIEhtUnVuICAgICAgICAgUnVucyAgICAgICAgICBSQkkgICAgICAgIFdhbGtzICAgICAgICBZZWFycyAgICAgICBDQXRCYXQgICAgICAgIENIaXRzIFxuICA5Ljg4NDg3MTU3ICAgMC4wMzE0Mzk5MSAgIDEuMDA4ODI4NzUgICAwLjEzOTI3NjI0ICAgMS4xMTMyMDc4MSAgIDAuODczMTg5OTAgICAxLjgwNDEwMjI5ICAgMC4xMzA3NDM4MSAgIDAuMDExMTM5NzggICAwLjA2NDg5ODQzIFxuICAgICAgQ0htUnVuICAgICAgICBDUnVucyAgICAgICAgIENSQkkgICAgICAgQ1dhbGtzICAgICAgTGVhZ3VlTiAgICBEaXZpc2lvblcgICAgICBQdXRPdXRzICAgICAgQXNzaXN0cyAgICAgICBFcnJvcnMgICBOZXdMZWFndWVOIFxuICAwLjQ1MTU4NTQ2ICAgMC4xMjkwMDA0OSAgIDAuMTM3Mzc3MTIgICAwLjAyOTA4NTcyICAyNy4xODIyNzUzNSAtOTEuNjM0MTEyOTkgICAwLjE5MTQ5MjUyICAgMC4wNDI1NDUzNiAgLTEuODEyNDQ0NzAgICA3LjIxMjA4MzkwIFxuIn0= -->

```
 (Intercept)        AtBat         Hits        HmRun         Runs          RBI        Walks        Years       CAtBat        CHits 
  9.88487157   0.03143991   1.00882875   0.13927624   1.11320781   0.87318990   1.80410229   0.13074381   0.01113978   0.06489843 
      CHmRun        CRuns         CRBI       CWalks      LeagueN    DivisionW      PutOuts      Assists       Errors   NewLeagueN 
  0.45158546   0.12900049   0.13737712   0.02908572  27.18227535 -91.63411299   0.19149252   0.04254536  -1.81244470   7.21208390 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


As expected, none of the coefficients are zero - ridge regression does not perform variable selection!

### The Lasso
We saw that ridge regression with a wise choice of $\lambda$ can outperform least squares as well as the null model on the Hitters data set. We now ask whether the lasso can yield either a more accurate or a more interpretable model than ridge regression. In order to fit a lasso model, we once again use the `glmnet()` function; however, this time we use the argument `alpha=1`. Other than that change, we proceed just as we did in fitting a ridge model.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGFzc28ubW9kIDwtIGdsbW5ldCh4W3RyYWluLCBdLCB5W3RyYWluXSwgYWxwaGEgPSAxLCBsYW1iZGEgPSBncmlkKVxucGxvdChsYXNzby5tb2QpXG5gYGAifQ== -->

```r
lasso.mod <- glmnet(x[train, ], y[train], alpha = 1, lambda = grid)
plot(lasso.mod)
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJjb25kaXRpb25zIjpbXSwiaGVpZ2h0Ijo0MzIuNjMyOSwic2l6ZV9iZWhhdmlvciI6MCwid2lkdGgiOjcwMH0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

We can see from the coefficient plot that depending on the choice of tuning parameter, some of the coefficients will be exactly equal to zero. We now perform cross-validation and compute the associated test error.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc2V0LnNlZWQoMSlcbmN2Lm91dCA8LSBjdi5nbG1uZXQoeFt0cmFpbiwgXSwgeVt0cmFpbl0sIGFscGhhID0gMSlcbnBsb3QoY3Yub3V0KVxuYGBgIn0= -->

```r
set.seed(1)
cv.out <- cv.glmnet(x[train, ], y[train], alpha = 1)
plot(cv.out)
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJjb25kaXRpb25zIjpbXSwiaGVpZ2h0Ijo0MzIuNjMyOSwic2l6ZV9iZWhhdmlvciI6MCwid2lkdGgiOjcwMH0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYmVzdGxhbSA8LSBjdi5vdXQkbGFtYmRhLm1pblxubGFzc28ucHJlZCA8LSBwcmVkaWN0KGxhc3NvLm1vZCwgcyA9IGJlc3RsYW0sIG5ld3ggPSB4W3Rlc3QsIF0pXG5tZWFuKChsYXNzby5wcmVkIC0geS50ZXN0KSBeIDIpXG5gYGAifQ== -->

```r
bestlam <- cv.out$lambda.min
lasso.pred <- predict(lasso.mod, s = bestlam, newx = x[test, ])
mean((lasso.pred - y.test) ^ 2)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDEwMDc0My40XG4ifQ== -->

```
[1] 100743.4
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


This is substantially lower than the test set MSE of the null model and of least squares, and very similar to the test MSE of ridge regression with $\lambda$ chosen by cross-validation.

However, the lasso has a substantial advantage over ridge regression in that the resulting coefficient estimates are sparse. Here we see that twelve of the nineteen coefficient estimates are exactly zero. So the lasso model with $\lambda$ chosen by cross-validation contains only seven variables.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxub3V0IDwtIGdsbW5ldCh4LCB5LCBhbHBoYSA9IDEsIGxhbWJkYSA9IGdyaWQpXG5sYXNzby5jb2VmIDwtIHByZWRpY3Qob3V0LCB0eXBlID0gXCJjb2VmZmljaWVudHNcIiwgcyA9IGJlc3RsYW0pWzE6MjAsIF1cbmxhc3NvLmNvZWZcbmBgYCJ9 -->

```r
out <- glmnet(x, y, alpha = 1, lambda = grid)
lasso.coef <- predict(out, type = "coefficients", s = bestlam)[1:20, ]
lasso.coef
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgICAgICBBdEJhdCAgICAgICAgIEhpdHMgICAgICAgIEhtUnVuICAgICAgICAgUnVucyAgICAgICAgICBSQkkgICAgICAgIFdhbGtzICAgICAgICBZZWFycyAgICAgICBDQXRCYXQgICAgICAgIENIaXRzIFxuICAxOC41Mzk0ODQ0ICAgIDAuMDAwMDAwMCAgICAxLjg3MzUzOTAgICAgMC4wMDAwMDAwICAgIDAuMDAwMDAwMCAgICAwLjAwMDAwMDAgICAgMi4yMTc4NDQ0ICAgIDAuMDAwMDAwMCAgICAwLjAwMDAwMDAgICAgMC4wMDAwMDAwIFxuICAgICAgQ0htUnVuICAgICAgICBDUnVucyAgICAgICAgIENSQkkgICAgICAgQ1dhbGtzICAgICAgTGVhZ3VlTiAgICBEaXZpc2lvblcgICAgICBQdXRPdXRzICAgICAgQXNzaXN0cyAgICAgICBFcnJvcnMgICBOZXdMZWFndWVOIFxuICAgMC4wMDAwMDAwICAgIDAuMjA3MTI1MiAgICAwLjQxMzAxMzIgICAgMC4wMDAwMDAwICAgIDMuMjY2NjY3NyAtMTAzLjQ4NDU0NTggICAgMC4yMjA0Mjg0ICAgIDAuMDAwMDAwMCAgICAwLjAwMDAwMDAgICAgMC4wMDAwMDAwIFxuIn0= -->

```
 (Intercept)        AtBat         Hits        HmRun         Runs          RBI        Walks        Years       CAtBat        CHits 
  18.5394844    0.0000000    1.8735390    0.0000000    0.0000000    0.0000000    2.2178444    0.0000000    0.0000000    0.0000000 
      CHmRun        CRuns         CRBI       CWalks      LeagueN    DivisionW      PutOuts      Assists       Errors   NewLeagueN 
   0.0000000    0.2071252    0.4130132    0.0000000    3.2666677 -103.4845458    0.2204284    0.0000000    0.0000000    0.0000000 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGFzc28uY29lZltsYXNzby5jb2VmICE9IDBdXG5gYGAifQ== -->

```r
lasso.coef[lasso.coef != 0]
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgICAgICAgSGl0cyAgICAgICAgV2Fsa3MgICAgICAgIENSdW5zICAgICAgICAgQ1JCSSAgICAgIExlYWd1ZU4gICAgRGl2aXNpb25XICAgICAgUHV0T3V0cyBcbiAgMTguNTM5NDg0NCAgICAxLjg3MzUzOTAgICAgMi4yMTc4NDQ0ICAgIDAuMjA3MTI1MiAgICAwLjQxMzAxMzIgICAgMy4yNjY2Njc3IC0xMDMuNDg0NTQ1OCAgICAwLjIyMDQyODQgXG4ifQ== -->

```
 (Intercept)         Hits        Walks        CRuns         CRBI      LeagueN    DivisionW      PutOuts 
  18.5394844    1.8735390    2.2178444    0.2071252    0.4130132    3.2666677 -103.4845458    0.2204284 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->

