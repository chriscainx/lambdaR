#'Map function for lambda expression
#'
#'@param data a vector.
#'@param ... lambda expression.
#'
#'@return a list.
#'
#'@export
Map2_ <- function(data, ...) {
  data <- unname(data)
  func <- lambda(...)
  args <- c(f=func, data)
  do.call(Map, args)
}

#'Map function for lambda expression
#'
#'@param data a vector.
#'@param ... lambda expression.
#'
#'@return a vector.
#'
#'@export
Map2v_ <- function(data, ...) {
  unlist(Map2_(data, ...))
}
