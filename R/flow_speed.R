#' Flow-speed relationship
#'
#' Calculates migration speed (km/day) as a function of Sac1 flow (cfs)
#'
#' @md
#' @param Sac1_flow   Flow in Sac1 reach
#' @param reach       One of following reaches: GeoDCC, Sac1, Sac2, Verona_to_Sac
#'
#' @export
#' @examples
#' flow_speed(1e3, "Sac1")
#' flow_speed(1e4, "Sac1")
#' flow_speed(1e5, "Sac1")
#' flow_speed(1e4, "GeoDCC")

flow_speed<- function(Sac1_flow, reach){
  # Calculates migration speed (km/day) as a function of Sac1 flow (cfs)

  if (!(reach %in% c("GeoDCC", "Sac1", "Sac2", "Verona_to_Sac"))) stop("Reach needs to be one of following: GeoDCC, Sac1, Sac2, Verona_to_Sac")
  # statistical model parameters for each reach
  parms = list("GeoDCC" = list("Min" = 0.34, "B0" = -33.52, "B1" = 11.08),
               "Sac1" = list("Min" = 0.54, "B0" = -105.98, "B1" = 21.34),
               "Sac2" = list("Min" = 0.34, "B0" = -7.997, "B1" = 3.248264),
               "Verona_to_Sac" = list("Min" = 0.54, "B0" = -105.98, "B1" = 21.34))
  # convert from cfs to cms and log transform
  flow = log(Sac1_flow * 0.0283)

  p = parms[[reach]]
  out = p[["B1"]] * flow + p[["B0"]]
  if (out < p[["Min"]]) out = p[["Min"]]
  return(out)
}

