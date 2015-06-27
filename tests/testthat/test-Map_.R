context("Test for Map_()")

test_that("compute square number", {
  expect_equal(Map_(1:5, x: x ** 2), list(1,4,9,16,25))
})

test_that("variable", {
  data <- 5:1
  expect_equal(Map_(1:5, n: data[n]), list(5,4,3,2,1))
})

context("Test for Mapv_()")

test_that("compute square number", {
  expect_equal(Mapv_(1:5, x: x ** 2), c(1,4,9,16,25))
})

test_that("variable", {
  data <- 5:1
  expect_equal(Mapv_(1:5, n: data[n]), c(5,4,3,2,1))
})
