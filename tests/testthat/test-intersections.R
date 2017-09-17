library(reconPlots)
context("Curve intersection")

test_that("curve_intersect calculates correct intersection for straight lines", {
  line1 <- data.frame(x = c(1, 9), y = c(1, 9))
  line2 <- data.frame(x = c(9, 1), y = c(1, 9))
  line_intersection <- curve_intersect(line1, line2)

  expect_equal(line_intersection$x, 5)
  expect_equal(line_intersection$y, 5)
})

test_that("curve_intersect calculates correct intersection for curved lines", {
  line1 <- data.frame(Hmisc::bezier(c(1, 8, 9), c(1, 5, 9)))
  line2 <- data.frame(Hmisc::bezier(c(1, 3, 9), c(9, 3, 1)))
  line_intersection <- curve_intersect(line1, line2)

  expect_equal(line_intersection$x, 4.654098, tolerance = 0.001)
  expect_equal(line_intersection$y, 3.395566, tolerance = 0.001)
})
