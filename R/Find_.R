#'Find function for lambda expression
#'
#'@param data a vector.
#'@param ... lambda expression(unary).
#'@param right a logical indicating whether to proceed from left to right (default) or from right to left.
#'@param nomatch the value to be returned in the case when "no match" (no element satisfying the predicate) is found.
#'
#'@return an obejct.
#'
#'@export
Find_ <- function(data, ..., right = FALSE, nomatch = NULL) {
  func <- lambda(...)
  Find(func, data, right = right, nomatch = nomatch)
}
