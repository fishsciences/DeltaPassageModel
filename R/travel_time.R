#' Travel time
#'
#' Draw random value for travel time through a reach on a given day.
#'
#' @md
#' @param reach       GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Yolo, or Interior Delta
#' @param scenario    Scenario describing water project operations
#' @param model_day   Integer day in 82-yr model period
#' @param flow_list   List that contains flow values for all reaches, scenarios, and days in 82-yr model period
#'
#' @export
#' @examples
#' travel_time("Sac1", "EXG", 2, list("Sac1" = list("EXG" = c(1000, 5000, 10000), "ALT" = c(2000, 10000, 20000))))
#' travel_time("Yolo", "EXG", 2, list("Sac1" = list("EXG" = c(1000, 5000, 10000), "ALT" = c(2000, 10000, 20000))))
#'

#### use sac1 flow but not sac1 sd; maybe a mistake in GoldSim model
#### my guess is that originally used flow from actual reach but changed to Sac1 reach only for flow-speed relationship and not sd extraction
#### approach here is to use flow and sd from actual reach, but need to check with Steve
travel_time <- function(reach, scenario, model_day, flow_list){
  if(!(reach %in% c(names(reach_length), "Interior Delta", "Yolo"))){
    stop("reach is not one of GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Yolo, Interior Delta")}
  sp <- speed_params[[reach]]
  if(reach %in% c("GeoDCC", "Sac1", "Sac2", "Verona_to_Sac")){
    #Sac1_flow <- flow_list[["Sac1"]][[scenario]][model_day]
    reach_flow <- flow_list[[reach]][[scenario]][model_day]
    sp[["mean"]] <- flow_speed(reach, reach_flow)
    sp[["sd"]] <- flow_speed_sd[[reach]](reach_flow)
  }
  if(reach == "Yolo") {
    return(runif(1, 4, 28))  # warning: hard-coded values
  } else {
    return(reach_length[[reach]]/truncnorm::rtruncnorm(1, sp[["min"]], 1e10, sp[["mean"]], sp[["sd"]]))
  }
}


