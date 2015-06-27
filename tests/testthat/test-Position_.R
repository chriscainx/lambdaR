context("Test for Position_()")

test_that("find F letter", {
  expect_equal(Position_(LETTERS, x: x == "F"), 6)
})
