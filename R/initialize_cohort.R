#' Initialize cohort
#'
#' Initialize list of cohort parameters
#'
#' @md
#' @param run         Chinook Salmon run
#' @param reach       Reach that cohort is entering
#' @param day         Model day that cohort is entering reach
#' @param abundance   Number of fish in cohort
#' @param speed       Daily migration rate of cohort
#' @param survival    Survival rate of cohort
#'
#' @export
#' @examples
#' initialize_cohort("Winter", "Sac1", 1, 1e6, 10, 0.8)
#'

initialize_cohort <- function(run, reach, day, abundance, speed, survival){
  list(Run = run,
       ReachVec = reach,
       DayVec = day,
       AbunVec = abundance,
       SpeedVec = speed,
       SurvVec = survival)
}

