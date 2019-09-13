#' Migration speed standard deviation
#'
#' Look-up tables for the standard deviation in migration speed for a given flow (cfs).
#' Tables are used to apply stochasticity to migration speed in reaches that use a flow-migration speed relationship.
#'
#' @format A list of 4 data frames with Flow and SpeedSD columns:
#' \describe{
#'   \item{GeoDCC}{Combined reach of Georgiana Slough, Delta Cross Channel, and South and North Forks
#'   of the Mokelumne River ending at confluence with the San Joaquin River.}
#'   \item{Sac1}{Sacramento River from Freeport to junction with Sutter Slough.}
#'   \item{Sac2}{Sacramento River from Sutter Slough junction to junction with Delta Cross Channel.}
#'   \item{Verona_to_Sac}{Sacramento River from Verona to Freeport; uses same values as Sac1 reach.}
#' }
#'
"flow_speed_sd"
