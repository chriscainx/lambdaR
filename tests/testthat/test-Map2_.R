context("Test for Map2_()")

test_that("add", {
  expect_equal(Map2_(list(1:5, 6:10), x,y: x+y), list(7,9,11,13,15))
})

test_that("variable", {
  data <- 1:10
  expect_equal(Map2_(list(1:5, 6:10), x,y: data[x]+data[y]), list(7,9,11,13,15))
})

test_that("named list", {
  expect_equal(Map2_(list(a=1:5, b=6:10), x,y: x+y), list(7,9,11,13,15))
})

test_that("data.frame", {
  data <- cars[1:2, ]
  expect_equal(Map2_(data, x,y: x+y), list(6, 14))
})

context("Test for Map2v_()")

test_that("add", {
  expect_equal(Map2v_(list(1:5, 6:10), x,y: x+y), c(7,9,11,13,15))
})
