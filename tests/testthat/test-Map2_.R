context("Test for Map2_()")

test_that("add", {
  expect_equal(Map2_(list(1:5, 6:10), x,y: x+y), list(7,9,11,13,15))
})

test_that("variable", {
  data <- 1:10
  expect_equal(Map2_(list(1:5, 6:10), x,y: data[x]+data[y]), list(7,9,11,13,15))
})

context("Test for Map2v_()")

test_that("add", {
  expect_equal(Map2v_(list(1:5, 6:10), x,y: x+y), c(7,9,11,13,15))
})
