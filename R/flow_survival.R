#' Flow-survival relationship
#'
#' Calculates survival through a reach as a function of standardized flow in Sac3 reach
#'
#' @md
#' @param reach       Sac1, Sac2, Sac3, or SS
#' @param flow        Standardized flow in Sac3 on day entering reach
#'
#' @export
#' @examples
#' flow_survival("Sac1", -5)
#' flow_survival("Sac1", 0)
#' flow_survival("Sac1", 5)
#' flow_survival("SS", 0)
#'

flow_survival <- function(reach, flow){
  if(!(reach %in% c("Sac1", "Sac2", "Sac3", "SS"))){
    stop("Reach needs to be one of following: Sac1, Sac2, Sac3, or SS")
  }
  sac_slope = 0.52
  p = flow_survival_params[[reach]]
  exp(p[["B0"]] + sac_slope * flow)/(1 + exp(p[["B0"]] + sac_slope * flow))
}

