#' Update cohort
#'
#' Update list of cohort parameters
#'
#' @md
#' @param cohort_list List of cohort parameters
#' @param reach       Reach that cohort is entering
#' @param model_day   Model day that cohort is entering reach
#' @param abundance   Number of fish in cohort
#' @param travel_time Travel time for cohort through reach
#' @param survival    Survival rate of cohort through reach
#'
#' @export
#' @examples
#' cohort <- initialize_cohort("Winter", "Sac1", 1, 1e6, 10, 0.8)
#' update_cohort(cohort, "Sac2", 10, 1e5, 15, 0.9)

update_cohort <- function(cohort_list, reach, model_day, abundance, travel_time, survival){
  new_vals <- list(reach, model_day, abundance, travel_time, survival)
  for (i in 1:length(cohort_list)){
    cohort_list[[i]] = c(cohort_list[[i]], new_vals[[i]])
  }
  return(cohort_list)
}
