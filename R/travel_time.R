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

travel_time <- function(reach = c("GeoDCC", "Sac1", "Sac2", "Sac3", "Sac4", "SS",
                                  "Verona_to_Sac", "Interior Delta", "Yolo"),
                        scenario, model_day, flow_list){
  reach <- match.arg(reach)
  if(reach == "Yolo") {
    return(runif(1, 4, 28))  # warning: hard-coded values
  }else{
    sp <- speed_params[[reach]]
    if(reach == "Interior Delta"){
      # Interior Delta is returning travel time
      return(truncnorm::rtruncnorm(1, sp[["min"]], 1e10, sp[["mean"]], sp[["sd"]]))
    }else{
      if(reach %in% c("GeoDCC", "Sac1", "Sac2", "Verona_to_Sac")){
        reach_flow <- flow_list[[reach]][[scenario]][model_day]
        sp[["mean"]] <- flow_speed(reach, reach_flow)
        sp[["sd"]] <- flow_speed_sd[[reach]](reach_flow)
      }
      return(reach_length[[reach]]/truncnorm::rtruncnorm(1, sp[["min"]], 1e10, sp[["mean"]], sp[["sd"]]))
    }
  }
}


