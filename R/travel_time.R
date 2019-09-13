#' Travel time
#'
#' Draw random value for travel time through a reach on a given day.
#'
#' @md
#' @param reach       GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, or Yolo
#' @param scenario    Scenario describing water project operations
#' @param model_day   Integer day in 82-yr model period
#' @param flow_list   List that contains flow values for all reaches, scenarios, and days in 82-yr model period
#' @param reach
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
  if (!(reach %in% c(names(reach_length), "Yolo"))) stop("reach is not one of GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Yolo")
  if (reach %in% c("GeoDCC", "Sac1", "Sac2", "Verona_to_Sac")){
    #Sac1_flow <- flow_list[["Sac1"]][[scenario]][model_day]
    reach_flow <- flow_list[[reach]][[scenario]][model_day]
    speed_mean <- flow_speed(reach, reach_flow)
    speed_sd <- flow_speed_sd[[reach]](reach_flow)
  }
  if (reach == "Sac3"){
    speed_mean <- 9.24
    speed_sd <- 7.33
  }
  if (reach == "Sac4"){
    speed_mean <- 8.6
    speed_sd <- 6.79
  }
  if (reach == "SS"){
    speed_mean <- 9.41
    speed_sd <- 7.42
  }
  if (reach == "Yolo") {
    return(runif(1, 4, 28))
  }else{
    return(reach_length[[reach]]/truncnorm::rtruncnorm(1, speed_min[[reach]], 1e10, speed_mean, speed_sd))
  }
}


