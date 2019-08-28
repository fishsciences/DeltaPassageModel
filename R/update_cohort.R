#' Update cohort
#'
#' Update list of cohort parameters
#'
#' @md
#' @param cohort_list List of cohort parameters
#' @param reach       Reach that cohort is entering
#' @param day         Model day that cohort is entering reach
#' @param abundance   Number of fish in cohort
#' @param speed       Daily migration rate of cohort
#' @param survival    Survival rate of cohort
#'
#' @export
#' @examples
#' cohort <- initialize_cohort("Winter", "Sac1", 1, 1e6, 10, 0.8)
#' update_cohort(cohort, "Sac2", 10, 1e5, 15, 0.9)

update_cohort <- function(cohort_list, reach, day, abundance, speed, survival){
  # first element is NULL because Run is not a vector and nothing is appended
  new_vals <- list(NULL, reach, day, abundance, speed, survival)
  for (i in 1:length(cohort_list)){
    cohort_list[[i]] = c(cohort_list[[i]], new_vals[[i]])
  }
  return(cohort_list)
}
