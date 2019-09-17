#' Initialize cohort
#'
#' Initialize list of cohort parameters
#'
#' @md
#' @param reach       Reach that cohort is entering
#' @param model_day   Model day that cohort is entering reach
#' @param abundance   Number of fish in cohort
#' @param travel_time Travel time for cohort through reach
#' @param survival    Survival rate of cohort through reach
#'
#' @export
#' @examples
#' initialize_cohort("Winter", "Sac1", 1, 1e6, 10, 0.8)
#'

initialize_cohort <- function(reach, model_day, abundance, travel_time, survival){
  list(ReachVec = reach,
       ModelDayVec = model_day,
       AbunVec = abundance,
       TravelTimeVec = travel_time,
       SurvVec = survival)
}

