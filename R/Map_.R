#'Map function for lambda expression
#'
#'@param data a vector.
#'@param ... lambda expression.
#'
#'@return a list.
#'
#'@export
Map_ <- function(data, ...) {
  func <- lambda(...)
  Map(func, data)
}

#'Map function for lambda expression with unlisted output
#'
#'@param data a vector.
#'@param ... lambda expression.
#'
#'@return a vector.
#'
#'@export
Mapv_ <- function(data, ...) {
  unlist(Map_(data, ...))
}

#'@export
#'@rdname Mapv_
Mapu_ <- Mapv_