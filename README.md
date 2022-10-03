
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Lab6

<!-- badges: start -->
<!-- badges: end -->

The goal of Lab6 is to …

## Installation

You can install the development version of Lab6 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("seymi176/Lab6")
```

## 1. Brute force method

Implementation of brute_force method for solving the knapsack problem :

``` r
library(Lab6)
data(knapsack_objects)
brute_force_knapsack(x = knapsack_objects[1:8,], W = 3500)
#> $value
#> [1] 16770
#> 
#> $elements
#> [1] 5 8
brute_force_knapsack(x = knapsack_objects[1:12,], W = 3500)
#> $value
#> [1] 16770
#> 
#> $elements
#> [1] 5 8
brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000)
#> $value
#> [1] 15428
#> 
#> $elements
#> [1] 3 8
brute_force_knapsack(x = knapsack_objects[1:12,], W = 2000)
#> $value
#> [1] 15428
#> 
#> $elements
#> [1] 3 8
```

## 2. Dynamic programming

Implementation of dynamic programming method for solving the knapsack
problem :

``` r
data(knapsack_objects)
knapsack_dynamic(x = knapsack_objects[1:8,], W = 3500)
#> $value
#> [1] 16770
#> 
#> $elements
#> $elements[[1]]
#> [1] 8
#> 
#> $elements[[2]]
#> [1] 5
knapsack_dynamic(x = knapsack_objects[1:12,], W = 3500)
#> $value
#> [1] 16770
#> 
#> $elements
#> $elements[[1]]
#> [1] 8
#> 
#> $elements[[2]]
#> [1] 5
knapsack_dynamic(x = knapsack_objects[1:8,], W = 2000)
#> $value
#> [1] 15428
#> 
#> $elements
#> $elements[[1]]
#> [1] 8
#> 
#> $elements[[2]]
#> [1] 3
knapsack_dynamic(x = knapsack_objects[1:12,], W = 2000)
#> $value
#> [1] 15428
#> 
#> $elements
#> $elements[[1]]
#> [1] 8
#> 
#> $elements[[2]]
#> [1] 3
```

## 3. Greedy heuristic

Implementation of Greedy heuristic method for solving the knapsack
problem :

``` r
data(knapsack_objects)
greedy_knapsack(x = knapsack_objects[1:800,], W = 3500)
#> $value
#> [1] 192647
#> 
#> $elements
#>  [1]  92 574 472  80 110 537 332 117  37 776 577 288 234 255 500 794  55 290 436
#> [20] 346 282 764 599 303 345 300 243  43 747  35  77 229 719 564
greedy_knapsack(x = knapsack_objects[1:1200,], W = 2000)
#> $value
#> [1] 212337
#> 
#> $elements
#>  [1]   92  574  472   80  110  840  537 1000  332  117   37 1197 1152  947  904
#> [16]  776  577  288 1147 1131  234  255 1006  833 1176 1092  873  828 1059  500
#> [31] 1090  794 1033
```
