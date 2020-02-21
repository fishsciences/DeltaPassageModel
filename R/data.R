#' Flow-speed parameters
#'
#' Statistical parameters for the flow-speed relationship.
#'
#' @format A list of named vectors (B0, B1) for the following reaches:
#' \describe{
#'   \item{GeoDCC}{Combined reach of Georgiana Slough, Delta Cross Channel, and South and North Forks
#'   of the Mokelumne River ending at confluence with the San Joaquin River.}
#'   \item{Sac1}{Sacramento River from Freeport to junction with Sutter Slough.}
#'   \item{Sac2}{Sacramento River from Sutter Slough junction to junction with Delta Cross Channel.}
#'   \item{Verona_to_Sac}{Sacramento River from Verona to Freeport.}
#' }
#'
"flow_speed_params"

#' Migration speed standard deviation
#'
#' Interpolation functions for the standard deviation in migration speed for a given flow (cfs).
#' Used to apply stochasticity to migration speed in reaches that use a flow-migration speed relationship.
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

#' Flow-survival parameters
#'
#' Statistical parameters for the flow-survival relationship.
#'
#' @format A list of named vectors (B0) for the following reaches:
#' \describe{
#'   \item{Sac1}{Sacramento River from Freeport to junction with Sutter Slough.}
#'   \item{Sac2}{Sacramento River from Sutter Slough junction to junction with Delta Cross Channel.}
#'   \item{Sac3}{Sacramento River from Delta Cross Channel junction to Rio Vista.}
#'   \item{SS}{Combined reach of Sutter Slough and Steamboat Slough ending at Rio Vista.}
#' }
#'
"flow_survival_params"

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

#' Reach length
#'
#' Length (km) of reaches in the Delta Passage Model.
#'
#'
#' @format A named vector of lengths for the following reaches:
#' \describe{
#'   \item{GeoDCC}{Combined reach of Georgiana Slough, Delta Cross Channel, and South and North Forks
#'   of the Mokelumne River ending at confluence with the San Joaquin River.}
#'   \item{Sac1}{Sacramento River from Freeport to junction with Sutter Slough.}
#'   \item{Sac2}{Sacramento River from Sutter Slough junction to junction with Delta Cross Channel.}
#'   \item{Sac3}{Sacramento River from Delta Cross Channel junction to Rio Vista.}
#'   \item{Sac4}{Sacramento River from Rio Vista to Chipps Island.}
#'   \item{SS}{Combined reach of Sutter Slough and Steamboat Slough ending at Rio Vista.}
#'   \item{Verona_to_Sac}{Sacramento River from Verona to Freeport.}
#' }
#'
"reach_length"

#' Sacramento River entry timing
#'
#' A dataset containing the proportion of the population that enters the model
#' in the Sacramento River at Freeport on each day of the 82-yr model period.
#'
#' @format A list with 5 vectors of 29950 elements:
#' \describe{
#'   \item{Date}{character string representing the date}
#'   \item{Winter}{winter-run daily entry proportion}
#'   \item{Spring}{spring-run daily entry proportion}
#'   \item{Fall}{fall-run daily entry proportion}
#'   \item{LateFall}{late-fall-run daily entry proportion}
#' }
#'
"sac_timing"

#' Migration speed parameters
#'
#' Mininimum, mean, and standard deviation of daily migration speed (km/day) for each reach.
#' Missing values of mean and standard deviation indicate a flow-based relationship for that reach.
#'
#' @format A list of named vectors (min, mean, sd) for the following reaches:
#' \describe{
#'   \item{GeoDCC}{Combined reach of Georgiana Slough, Delta Cross Channel, and South and North Forks
#'   of the Mokelumne River ending at confluence with the San Joaquin River.}
#'   \item{Sac1}{Sacramento River from Freeport to junction with Sutter Slough.}
#'   \item{Sac2}{Sacramento River from Sutter Slough junction to junction with Delta Cross Channel.}
#'   \item{Sac3}{Sacramento River from Delta Cross Channel junction to Rio Vista.}
#'   \item{Sac4}{Sacramento River from Rio Vista to Chipps Island.}
#'   \item{SS}{Combined reach of Sutter Slough and Steamboat Slough ending at Rio Vista.}
#'   \item{Verona_to_Sac}{Sacramento River from Verona to Freeport.}
#'   \item{Interior Delta}{Begins at end of reaches GeoDCC or SJ2 or through Old River Junction (D) and ends at Chipps Island.}
#' }
#'
"speed_params"


