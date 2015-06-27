context("Test for lambda()")

test_that("one variable", {
  expect_equal(lambda(x: x + 1), function(x) x + 1)
})

test_that("two variables", {
  expect_equal(lambda(x,y: x + y), function(x,y) x + y)
})

test_that("one variable with placeholder", {
  expect_equal(lambda(._ + 1), function(._1) ._1 + 1)
})

test_that("two variable with placeholder", {
  expect_equal(lambda(._ + ._), function(._1,._2) ._1 + ._2)
})

test_that("f_", {
  expect_equal(f_(x: x + 1), function(x) x + 1)
})
