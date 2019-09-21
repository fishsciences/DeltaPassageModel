#' Truncated normal survival
#'
#' Wrapper function for rtruncnorm where parameters a and b equal 0 and 1, respectively.
#'
#' @md
#' @param n       Number of random values to draw from truncted normal distribution
#' @param mean    Mean of truncated normal distribution
#' @param sd      Standard deviation of truncated normal distribution
#'
#' @export
#'

rtruncnorm_surv <- function(n, mean, sd){
  truncnorm::rtruncnorm(n, 0, 1, mean, sd)
}
