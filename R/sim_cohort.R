#' Simulate cohort
#'
#' Simulate cohort as it passes through the Delta
#'
#' @md
#' @param abundance   Number of fish in cohort when entering the model
#' @param scenario    Scenario describing water project operations
#' @param model_day   Integer day in 82-yr model period
#' @param flow_list   List that contains flow values for all reaches, scenarios, and days in 82-yr model period
#'
#'
#' @export
#'
#'

sim_cohort <- function(abundance, scenario, model_day, flow_list){

  md_max <- length(flow_list[["Sac1"]][["date"]]) # arbitrarily choosing reach; all reaches should have same length
  # initialize
  cohort_id <- 1
  active <- list()
  inactive <- list()
  # only entry point in this version is Fremont Weir
  next_reaches <- routing("Fremont Weir", scenario, model_day, flow_list)
  for (i in names(next_reaches)){
    tt <- travel_time(i, scenario, model_day, flow_list)
    surv <- survival(i, scenario, model_day, flow_list)
    active[[as.character(cohort_id)]] <- initialize_cohort(i, model_day, abundance * next_reaches[[i]], tt, surv)
    cohort_id <- cohort_id + 1
  }

  # move through Delta
  while (length(active) > 0){
    for (i in names(active)){
      lv <- lapply(active[[i]], function(x) x[length(x)]) # lv = last values
      md <- lv[["ModelDayVec"]] + lv[["TravelTimeVec"]]
      md_floor <- floor(md)
      abun <- lv[["AbunVec"]] * lv[["SurvVec"]]
      if(md_floor > md_max){
        # cohort hasn't reached Chipps Island by end of available flow data
        # move cohort to inactive list and remove it from active list
        inactive[[i]] <- active[[i]]
        active[[i]] <- NULL
      } else {
        next_reaches <- routing(lv[["ReachVec"]], scenario, md_floor, flow_list)
        for (j in names(next_reaches)){
          p = next_reaches[[j]]
          if(j %in% c("GeoDCC", "SS", "Salvage")){
            i_new <- as.character(cohort_id)
            cohort_id <- cohort_id + 1
          } else {
            i_new <- i
          }
          if(j %in% c("Chipps Island", "Salvage")){
            inactive[[i_new]] <- update_cohort(active[[i]], j, md, abun * p, NA, NA)
          } else {
            active[[i_new]] <- update_cohort(active[[i]], j, md, abun * p,
                                             travel_time(j, scenario, md_floor, flow_list),
                                             survival(j, scenario, md_floor, flow_list))
          }
          if(j == "Chipps Island"){
            active[[i]] <- NULL  # remove cohort from active list after it arrives at Chipps Island (moved to inactive list above)
          } else if(p == 1 & i_new != i){
            active[[i]] <- NULL  # if whole cohort routed into GeoDCC, SS or Salvage, then remove 'original' cohort
          } else {
            # do nothing
          }
        }
      }
    }
  }
  # initially returned inactive list but the resulting objects were fairly large
  # moreover, the details contained in those objects are unlikely to be included in any summaries
  results = unique(do.call("rbind", lapply(inactive, as.data.frame)))
  results_agg = aggregate(AbunVec ~ ReachVec, results, sum)
  names(results_agg) = c("Reach", "Abundance")
  results_agg = results_agg[order(results_agg$Abundance, decreasing = TRUE),]
  return(results_agg)
}
