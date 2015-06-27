#'Filter function for lambda expression
#'
#'@param data a vector.
#'@param ... lambda expression(unary).
#'
#'@return a vector.
#'
#'@examples
#'library(lambdaR)
#'library(dplyr)
#'1:10 %>% Filter_(x: x %% 2 == 0)
#'
#'@export
Filter_ <- function(data, ...) {
  func <- lambda(...)
  Filter(func, data)
}
