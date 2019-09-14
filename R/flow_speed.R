#' Flow-speed relationship
#'
#' Calculates migration speed (km/day) as a function of flow (cfs).
#' Relationships can predict negative speeds but drawing from truncated distribution in travel_time() constrains values.
#'
#' @md
#' @param reach       GeoDCC, Sac1, Sac2, or Verona_to_Sac
#' @param flow        Flow on day entering reach
#'
#' @export
#' @examples
#' flow_speed("Sac1", 1e3)
#' flow_speed("Sac1", 1e4)
#' flow_speed("Sac1", 1e5)
#' flow_speed("GeoDCC", 1e4)

flow_speed <- function(reach, flow){
  if(!(reach %in% c("GeoDCC", "Sac1", "Sac2", "Verona_to_Sac"))){
    stop("Reach needs to be one of following: GeoDCC, Sac1, Sac2, Verona_to_Sac")
  }
  # convert from cfs to cms and log transform
  log_flow = log(flow * 0.0283)
  p = flow_speed_params[[reach]]
  p[["B1"]] * log_flow + p[["B0"]]
  # GoldSim model adjusted values below the min to min value
  # Here we use the calculated value with the potential implication that speeds might be slightly slower
}

