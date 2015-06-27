#'Negate function for lambda expression
#'
#'@param ... lambda expression.
#'
#'@return a function.
#'
#'@export
Negate_ <- function(...) {
  func <- lambda(...)
  Negate(func)
}
