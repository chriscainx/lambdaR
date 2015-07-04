# lambdaR - Novel lambda expressions in R
Koji MAKIYAMA (@hoxo_m)  



## 1. Overview

In recent years, the concepts of functional programming have widely spread.  
R also has common higher-order functions in functional programming languages(See [`help(Map)`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/funprog.html) or [excellent article](http://www.johnmyleswhite.com/notebook/2010/09/23/higher-order-functions-in-r/)).

Usage of the higher-order functions is like below.


```r
# extract even numbers from 1 to 10
Filter(function(x) x %% 2 == 0, 1:10)
```

```
## [1]  2  4  6  8 10
```

You need to pass a function to higher-order functions.  
In above, the higher-order function is `Filter` and the passed function is `function(x) x %% 2 == 0`.

In such case, **lambda expressions** are very useful in some other languages.  
Lambda expressions make description of functions more concise.

In Python, you can describe a function to pass, like `lambda x: x % 2 == 0`.

```python
# Python - extract even numbers from 1 to 10
filter(lambda x: x % 2 == 0, range(1, 11))
```

In Scala, you can describe a function to pass, like `x => x % 2 == 0`.

```scala
// Scala - extract even numbers from 1 to 10
(1 to 10).filter(x => x % 2 == 0)
```

In Scala, lambda expressions may be more concise by using placeholders `_`.

```scala
// Scala - extract even numbers from 1 to 10
(1 to 10).filter(_ % 2 == 0)
```

The package **lambdaR** have been created to provide lambda expressions into R.  

By using the package, you can use Python-like lambda expressions in R.


```r
library(lambdaR)
Filter_(1:10, x: x %% 2 == 0)
```

```
## [1]  2  4  6  8 10
```

You can also use Scala-like lambda expressions with placeholders `._`.


```r
Filter_(1:10, ._ %% 2 == 0)
```

```
## [1]  2  4  6  8 10
```

By using the pipe-operator `%>%` in `dplyr`(or `magrittr`), you can write the code more Scala-like.


```r
library(dplyr)
1:10 %>% Filter_(._ %% 2 == 0)
```

```
## [1]  2  4  6  8 10
```

## 2. How to install

The source code for `lambdaR` package is available on GitHub at

- https://github.com/hoxo-m/lambdaR

You can install the package from there.


```r
install.packages("devtools") # if you have not installed "devtools" package
devtools::install_github("hoxo-m/lambdaR")
```

## 3. Basic of lambda expressions in `lambdaR`

Lambda expressions in `lambdaR` are basically the same in Python except that we don't need to write `lambda`.  
It has input variables and body of the function, and these are separated by a colon `:`.

For example, lambda expressions in Python are like below.

```python
lambda x: x + 1
lambda x,y: x + y
lambda x,y,z: x + y + z
```

The corresponded lambda expressions in `lambdaR` are the next.

```python
x: x + 1
x,y: x + y
x,y,z: x + y + z
```

`lambdaR` package provides the `lambda()` function that recieves a lambda expression and returns the corresponded function object.


```r
# increment function
lambda(x: x + 1)
```

```
## function (x) 
## x + 1
```

```r
lambda(x: x + 1)(1)
```

```
## [1] 2
```

```r
# add funtion
lambda(x,y: x + y)
```

```
## function (x, y) 
## x + y
```

```r
lambda(x,y: x + y)(1, 2)
```

```
## [1] 3
```

```r
# because the results are normal functions, 
# you can assign it to a varible and use it
subtract <- lambda(x,y: x - y)
subtract(7, 3)
```

```
## [1] 4
```

You can also write multi-line lambda expressions.


```r
head_and_tail <- lambda(df, n: {
  H <- head(df, n)
  T <- tail(df, n)
  rbind(H, T)
})
head_and_tail
```

```
## function (df, n) 
## {
##     H <- head(df, n)
##     T <- tail(df, n)
##     rbind(H, T)
## }
```

```r
head_and_tail(iris, 3)
```

```
##     Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
## 1            5.1         3.5          1.4         0.2    setosa
## 2            4.9         3.0          1.4         0.2    setosa
## 3            4.7         3.2          1.3         0.2    setosa
## 148          6.5         3.0          5.2         2.0 virginica
## 149          6.2         3.4          5.4         2.3 virginica
## 150          5.9         3.0          5.1         1.8 virginica
```

`lambda()` is a very simple function, but we can use it for various applications.  
`lambda()` enables to redefine higher-order functions to enable using lambda expressions.

## 4. Application

We redefined six higher-order functions.

- `Filter()` to `Filter_()`
- `Map()` to `Map_()`
- `Reduce()` to `Reduce_()`
- `Find()` to `Find_()`
- `Position()` to `Position_()`
- `Negate()` to `Negate_()`

You can input lambda expressions to these functions.

### Filter_()


```r
1:10 %>% Filter_(x: x %% 2 == 0)
```

```
## [1]  2  4  6  8 10
```

### Map_()


```r
1:3 %>% Map_(x: x ** 2)
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 4
## 
## [[3]]
## [1] 9
```

`Map_()` returns a list.  
If you want to get the result as a vector, you can use `Mapv_()`.


```r
1:3 %>% Mapv_(x: x ** 2)
```

```
## [1] 1 4 9
```

### Reduce_()


```r
1:10 %>% Reduce_(x,y: x + y)
```

```
## [1] 55
```

### Find_()


```r
LETTERS %>% Find_(x: tolower(x) == "f")
```

```
## [1] "F"
```

### Position_()


```r
LETTERS %>% Position_(x: x == "F")
```

```
## [1] 6
```

### Negate_()


```r
1:10 %>% Filter_(Negate_(x: x %% 2 == 0))
```

```
## [1] 1 3 5 7 9
```

### Combination


```r
1:10 %>% Filter_(x: x %% 2 == 0) %>% Map_(x: x ** 2) %>% Reduce_(x,y: x + y)
```

```
## [1] 220
```

## 5. Lambda expressions with placeholders

If each of input variables is used only once in a lambda expression, you can describe it more concisely using placeholders `._`.


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
1:10 %>% Filter_(Negate_(._ %% 2 == 0))
```

```
## [1] 1 3 5 7 9
```


```r
1:10 %>% Filter_(._ %% 2 == 0) %>% Map_(._ ** 2) %>% Reduce_(._ + ._)
```

```
## [1] 220
```

## 6. `lambda()` accepts any functions

If you input a function to `lambda()`, it returns the input function.


```r
identical(lambda(max), max)
```

```
## [1] TRUE
```

It means that the description like below is allowed.


```r
is_even <- lambda(._ %% 2 == 0)
square <- lambda(._ ** 2)
# `+` is default add function
1:10 %>% Filter_(is_even) %>% Map_(square) %>% Reduce_(`+`)
```

```
## [1] 220
```

## 7. How to redefine functions

It is very easy to create a function that accepts lambda expressions.  
For example, let's redefine `Filter()`.


```r
Filter_ <- function(data, ...) {
  func <- lambda(...)
  Filter(func, data)
}
```

Lambda expressions in `LambdaR` is implimented by `...`.  
The `Filter_()` becomes to accept lambda expressions.

## 8. Miscellaneous

### `f_()`

`f_()` is an alias of `lambda()`.


```r
increment <- f_(x: x + 1)
increment
```

```
## function (x) 
## x + 1
```

```r
add <- f_(x,y: x + y)
add
```

```
## function (x, y) 
## x + y
```

### `Mapv_()`

`Mapv_()` is the same action as `Map_()` except returning a vector instead of a list.  
It means `Mapv_()` is a shortcut of `unlist(Map_(...))`.


```r
1:3 %>% Map_(x: x ** 2)
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 4
## 
## [[3]]
## [1] 9
```

```r
1:3 %>% Mapv_(x: x ** 2)
```

```
## [1] 1 4 9
```

### `Map2_()`

`Map2_()` is available for multiple-input.


```r
list(1:3, 4:6) %>% Map2_(x,y: x + y)
```

```
## [[1]]
## [1] 5
## 
## [[2]]
## [1] 7
## 
## [[3]]
## [1] 9
```


```r
list(1:3, 4:6, 7:9) %>% Map2_(x,y,z: x + y + z)
```

```
## [[1]]
## [1] 12
## 
## [[2]]
## [1] 15
## 
## [[3]]
## [1] 18
```

It can be used for `data.frame` objects.


```r
df <- data.frame(x=1:3, y=4:6)
df %>% Map2_(x,y: x + y)
```

```
## [[1]]
## [1] 5
## 
## [[2]]
## [1] 7
## 
## [[3]]
## [1] 9
```

Of course, `Map2v_()` is also available.

## 9. Related work

- [lambda.r: Modeling Data with Functional Programming](http://cran.r-project.org/web/packages/lambda.r/)
- [purrr by Hadley Wickham](https://github.com/hadley/purrr)
- [rlist by Kun Ren](http://renkun.me/rlist/)
