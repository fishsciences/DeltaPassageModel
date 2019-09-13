#' Survival standard deviation
#'
#' Interpolation functions for the standard deviation in survival for a given standardized flow.
#' Used to apply stochasticity to survival in reaches that use a flow-survival relationship.
#'
#' @format A list of 4 interpolation functions with StandardizedFlow and SurvivalSD columns:
#' \describe{
#'   \item{Sac1}{Sacramento River from Freeport to junction with Sutter Slough.}
#'   \item{Sac2}{Sacramento River from Sutter Slough junction to junction with Delta Cross Channel.}
#'   \item{Sac3}{Sacramento River from Delta Cross Channel junction to Rio Vista, CA.}
#'   \item{SS}{Combined reach of Sutter Slough and Steamboat Slough ending at Rio Vista, CA.}
#' }
#'
"flow_survival_sd"
