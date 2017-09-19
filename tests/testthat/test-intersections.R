library(reconPlots)
context("Curve intersection")

test_that("curve_intersect calculates correct intersection for empirical straight lines", {
  line1 <- data.frame(x = c(1, 9), y = c(1, 9))
  line2 <- data.frame(x = c(9, 1), y = c(1, 9))
  line_intersection <- curve_intersect(line1, line2, empirical = TRUE)

  expect_equal(line_intersection$x, 5)
  expect_equal(line_intersection$y, 5)
})

test_that("curve_intersect calculates correct intersection for empirical curved lines", {
  line1 <- data.frame(Hmisc::bezier(c(1, 8, 9), c(1, 5, 9)))
  line2 <- data.frame(Hmisc::bezier(c(1, 3, 9), c(9, 3, 1)))
  line_intersection <- curve_intersect(line1, line2, empirical = TRUE)

  expect_equal(line_intersection$x, 4.654098, tolerance = 0.001)
  expect_equal(line_intersection$y, 3.395566, tolerance = 0.001)
})

test_that("curve_intersect calculates correct intersection for functional curved lines", {
  line1 <- function(q) (q - 10)^2
  line2 <- function(q) q^2 + 2*q + 8
  line_intersection <- curve_intersect(line1, line2,
                                       empirical = FALSE, domain = c(0, 5))

  expect_equal(line_intersection$x, 4.181818, tolerance = 0.001)
  expect_equal(line_intersection$y, 33.85124, tolerance = 0.001)
})

test_that("curve_intersect throws correct errors related to 'domain' when 'empirical=FALSE'", {
  line1 <- function(q) (q - 10)^2
  line2 <- function(q) q^2 + 2*q + 8

  expect_error(curve_intersect(line1, line2, empirical = FALSE),
               "'domain' must be provided")

  expect_error(curve_intersect(line1, line2, empirical = FALSE, domain = c("bad", "input")),
               "'domain' must be a two-value numeric vector")
})
