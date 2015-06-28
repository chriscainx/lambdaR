#'Lambda function
#'
#'@param ... lambda expression.
#'@param envir environment.
#'
#'@export
lambda <- function(..., envir = parent.frame()) {
  args <- lazyeval::lazy_dots(...)
  args_len <- length(args)
  if(args_len == 0) {
    return(eval(parse(text="function() {}"), envir=globalenv()))
  } else if(args_len == 1) {
    expr <- as.character(as.expression(args[[1]]$expr))
    if(is_default_lambda(expr)) {
      lambda_default(...)
    } else if(is_lambda_placeholder(expr)) {
      lambda_placeholder(...)
    } else if(is_valid_var_name(expr)) {
      eval(args[[1]]$expr, envir = envir)
    } else {
      eval(parse(text=expr), envir = envir)
    }
  } else {
    lambda_default(...)
  }
}

#'@export
#'@rdname lambda
f_ <- lambda

is_valid_var_name <- function(x) stringr::str_detect(x, "^[.a-zA-Z][_.a-zA-Z0-9]*$")

is_default_lambda <- function(expr) {
  contains_colon <- stringr::str_detect(expr, pattern = ":")
  if(contains_colon) {
    arg <- stringr::str_split(expr, pattern = ":", n = 2)[[1]]
    var <- arg[1]
    is_valid_var_name(var)
  } else {
    FALSE
  }
}

is_lambda_placeholder <- function(expr) {
  contains_placeholders <- stringr::str_detect(expr, pattern = "\\._")
  tryCatch({
    expr <- as.character(parse(text = expr)[[1]])
    contains_placeholders && !stringr::str_detect(expr[1], "_$")    
  }, error = function(e) {
    FALSE
  })
}

lambda_default <- function(...) {
  args <- lazyeval::lazy_dots(...)
  if(length(args) == 0) stop("No lambda expression.")
  envir <- args[[1]]$env
  args <- Map(function(x) x$expr, args)
  vars <- unlist(Map(as.character, head(args, -1)))
  last_arg <- tail(args, 1)[[1]]
  last_arg <- as.character(as.expression(last_arg))
  last_arg <- stringr::str_split(last_arg, pattern = ":", n = 2)[[1]]
  if(length(last_arg) != 2) stop("Invalid lambda expression.")
  vars <- c(vars, last_arg[1])
  vars <- paste(vars, collapse=", ")
  expr <- last_arg[2]
  func <- sprintf("function(%s) %s", vars, expr)
  eval(parse(text = func), envir = envir)
}

lambda_placeholder <- function(...) {
  args <- lazyeval::lazy_dots(...)
  if(length(args) == 0) stop("No lambda expression.")
  envir <- args[[1]]$env
  args <- Map(function(x) x$expr, args)
  expr <- as.character(as.expression(args[[1]]))
  var_count <- stringr::str_count(expr, "\\._")
  if(var_count == 0) stop("No placeholders in lambda expression.")
  vars <- paste0("._", seq_len(var_count))
  expr <- stringr::str_replace_all(expr, "\\._", "###dummy###")
  expr <- Reduce(function(expr,var) stringr::str_replace(expr, "###dummy###", var), vars, expr)
  vars = paste0(vars, collapse=",")
  func <- sprintf("function(%s) %s", vars, expr)
  eval(parse(text=func), envir = envir)
}
