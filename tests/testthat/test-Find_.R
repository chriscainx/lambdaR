context("Test for Find_()")

test_that("find F letter", {
  expect_equal(Find_(LETTERS, x: x == "F"), "F")
})
