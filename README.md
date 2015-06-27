# lambdaR - Lambda expressions in R
Koji MAKIYAMA  



## Overview

With this package, you can use lambda expressions in R:


```r
library(lambdaR)
library(dplyr)
1:10 %>% Filter_(x: x %% 2 == 0) %>% Map_(x: x ** 2) %>% Reduce_(x,y: x + y)
```

```
## [1] 220
```

You can use placeholders:


```r
1:10 %>% Filter_(._ %% 2 == 0) %>% Map_(._ ** 2) %>% Reduce_(._ + ._)
```

```
## [1] 220
```

And you can write like below:


```r
is_even <- lambda(._ %% 2 == 0)
square <- lambda(._ ** 2)
add <- lambda(._ + ._)
1:10 %>% Filter_(is_even) %>% Map_(square) %>% Reduce_(add)
```

```
## [1] 220
```

## How to install


```r
install.packages("devtools") # if you have not installed "devtools" package
devtools::install_github("hoxo-m/lambdaR")
```

## Usage

### lambda()

`lambda()` function is to enable using lambda expressions in R:


```r
increment <- lambda(x: x + 1)
add <- lambda(x,y: x + y)
```

That allows to redefine higher order functions using lambda expressions.

### Application

We redefined higher order functions:

- `Filter()` to `Filter_()`
- `Map()` to `Map_()`
- `Reduce()` to `Reduce_()`
- `Find()` to `Find_()`
- `Position()` to `Position_()`
- `Negate()` to `Negate_()`

You can input lambda expressions to these functions:

#### Filter_()


```r
1:10 %>% Filter_(x: x %% 2 == 0)
```

```
## [1]  2  4  6  8 10
```

#### Map_()


```r
1:10 %>% Map_(x: x ** 2) %>% unlist
```

```
##  [1]   1   4   9  16  25  36  49  64  81 100
```


```r
list(1:5, 6:10) %>% Map2_(x,y: x + y) %>% unlist
```

```
## [1]  7  9 11 13 15
```

#### Reduce_()


```r
1:10 %>% Reduce_(x,y: x + y)
```

```
## [1] 55
```

#### Find_()


```r
LETTERS %>% Find_(x: tolower(x) == "f")
```

```
## [1] "F"
```

#### Position_()


```r
LETTERS %>% Position_(x: x == "F")
```

```
## [1] 6
```

#### Negate_()


```r
1:10 %>% Filter_(Negate_(x: x %% 2 == 0))
```

```
## [1] 1 3 5 7 9
```

#### placeholders

And also you can use placeholders:


```r
1:10 %>% Filter_(._ %% 2 == 0)
```

```
## [1]  2  4  6  8 10
```


```r
1:10 %>% Map_(._ ** 2) %>% unlist
```

```
##  [1]   1   4   9  16  25  36  49  64  81 100
```


```r
list(1:5, 6:10) %>% Map2_(._ + ._) %>% unlist
```

```
## [1]  7  9 11 13 15
```


```r
1:10 %>% Reduce_(._ + ._)
```

```
## [1] 55
```


```r
LETTERS %>% Find_(tolower(._) == "f")
```

```
## [1] "F"
```


```r
LETTERS %>% Position_(._ == "F")
```

```
## [1] 6
```


```r
1:10 %>% Filter_(Negate_(._ == 0))
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```
