context("Test for Reduce_()")

test_that("sum 1 to 10", {
  expect_equal(Reduce_(1:10, x,y: x+y), 55)
})
