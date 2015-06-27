context("Test for Negate_()")

test_that("even number to odd number", {
  expect_equal(Negate_(x: x %% 2 == 0)(1:5), c(TRUE, FALSE, TRUE, FALSE, TRUE))
})

test_that("with Filter_()", {
  expect_equal(Filter_(1:10, Negate_(x: x %% 2 == 0)), c(1,3,5,7,9))
  expect_equal(Filter_(1:10, Negate_(._ %% 2 == 0)), c(1,3,5,7,9))
})
