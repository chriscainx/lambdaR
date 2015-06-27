context("Test for Filter_()")

test_that("filter odd number", {
  expect_equal(Filter_(1:10, x: x %% 2 == 0), c(2,4,6,8,10))
})
