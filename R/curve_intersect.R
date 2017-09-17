#' Calculate the intersection of two curves
#'
#' Calculate where two lines or curves intersect. Curves are defined as data
#' frames with x and y columns providing cartesian coordinates for the lines.
#' This function works on both linear and nonlinear curves.
#'
#' @param curve1 \code{data.frame} with columns named \code{x} and \code{y}
#' @param curve2 \code{data.frame} with columns named \code{x} and \code{y}
#'
#' @details For now, \code{curve_intersect} will only find one intersection.
#'
#' @importFrom stats approxfun uniroot
#'
#' @examples
#' library(reconPlots)
#'
#' # Straight lines
#' line1 <- data.frame(x = c(1, 9), y = c(1, 9))
#' line2 <- data.frame(x = c(9, 1), y = c(1, 9))
#'
#' curve_intersect(line1, line2)
#'
#' # Curved lines
#' curve1 <- data.frame(Hmisc::bezier(c(1, 8, 9), c(1, 5, 9)))
#' curve2 <- data.frame(Hmisc::bezier(c(1, 3, 9), c(9, 3, 1)))
#'
#' curve_intersect(curve1, curve2)
#' @export

curve_intersect <- function(curve1, curve2) {
  # Approximate the functional form of both curves
  curve1_f <- approxfun(curve1$x, curve1$y, rule = 2)
  curve2_f <- approxfun(curve2$x, curve2$y, rule = 2)

  # Calculate the intersection of curve 1 and curve 2 along the x-axis
  point_x <- uniroot(function(x) curve1_f(x) - curve2_f(x),
                     c(min(curve1$x), max(curve1$x)))$root

  # Find where point_x is in curve 2
  point_y <- curve2_f(point_x)

  return(list(x = point_x, y = point_y))
}
