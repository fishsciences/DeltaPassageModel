#' Flow-speed relationship
#'
#' Calculates migration speed (km/day) as a function of flow (cfs)
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
  if (!(reach %in% c("GeoDCC", "Sac1", "Sac2", "Verona_to_Sac"))) stop("Reach needs to be one of following: GeoDCC, Sac1, Sac2, Verona_to_Sac")
  # statistical model parameters for each reach
  parms = list("GeoDCC" = list("B0" = -33.52, "B1" = 11.08),
               "Sac1" = list("B0" = -105.98, "B1" = 21.34),
               "Sac2" = list("B0" = -7.997, "B1" = 3.248264),
               "Verona_to_Sac" = list("B0" = -105.98, "B1" = 21.34))
  # convert from cfs to cms and log transform
  log_flow = log(flow * 0.0283)
  p = parms[[reach]]
  p[["B1"]] * log_flow + p[["B0"]]
}

