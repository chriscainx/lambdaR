#'Reduce function for lambda expression
#'
#'@param data a vector.
#'@param ... lambda expression(binary).
#'@param init an R object of the same kind as the elements of x.
#'@param right a logical indicating whether to proceed from left to right (default) or from right to left.
#'@param accumulate a logical indicating whether the successive reduce combinations should be accumulated. By default, only the final combination is used.
#'
#'@return a value.
#'
#'@export
Reduce_ <- function(data, ..., init, right = FALSE, accumulate = FALSE) {
  func <- lambda(...)
  Reduce(f=func, x=data, init=init, right=right, accumulate=accumulate)
}
