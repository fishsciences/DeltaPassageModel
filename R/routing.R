#' Routing
#'
#' Determine next reach(es) for a cohort based on current reach.
#'
#' @md
#' @param reach       GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Yolo, or Interior Delta
#' @param scenario    Scenario describing water project operations
#' @param model_day   Integer day in 82-yr model period
#' @param flow_list   List that contains flow values for all reaches, scenarios, and days in 82-yr model period
#'
#' @export
#' @examples
#' routing("Sac1", "EXG", 2, list("SS" = list("EXG" = c(1000, 5000, 10000)), "Sac2" = list("EXG" = c(2000, 10000, 20000))))
#' routing("SS", "EXG", 2, list("SS" = list("EXG" = c(1000, 5000, 10000)), "Sac2" = list("EXG" = c(2000, 10000, 20000))))
#'

routing <- function(reach, scenario, model_day, flow_list){
  if(!(reach %in% c(names(reach_length), "Interior Delta", "Yolo"))){
    stop("reach is not one of GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Yolo, Interior Delta")
  }
  flow_prop <- function(reach1, reach2, scenario, model_day, flow_list){
    flow_reach1 <- flow_list[[reach1]][[scenario]][model_day]
    flow_reach2 <- flow_list[[reach2]][[scenario]][model_day]
    p_reach1 <- flow_reach1 / (flow_reach1 + flow_reach2)
    out <- c()
    out[[reach1]] <- p_reach1
    out[[reach2]] <- 1 - p_reach1
    out
  }
  if(reach %in% c("Verona_to_Sac", "Yolo", "SS", "Sac3", "Sac4", "Interior Delta")){
    reach_lookup <- c("Verona_to_Sac" = "Sac1",
                      "Yolo" = "Sac4",
                      "SS" = "Sac4",
                      "Sac3" = "Sac4",
                      "Sac4" = "Chipps",
                      "Interior Delta" = "Chipps")
    out <- reach_lookup[[reach]]
  }
  # Junction A
  if(is.na(reach)){
    out <- flow_prop("Yolo", "Verona_to_Sac", scenario, model_day, flow_list)
  }
  # Junction B
  if(reach == "Sac1"){
    out <- flow_prop("SS", "Sac2", scenario, model_day, flow_list)
  }
  # Junction C
  if(reach == "Sac2"){
    temp <- flow_prop("GeoDCC", "Sac3", scenario, model_day, flow_list)
    p_geo_dcc_mod <- 0.22 + 0.47 * temp[["GeoDCC"]]
    out <- c("GeoDCC" = p_geo_dcc_mod, "Sac3" = 1 - p_geo_dcc_mod)
  }
  # Salvage
  if(reach == "GeoDCC"){
    salvage_prop <- exp(-7.2159 + 0.0002664 * flow_list[["Exports"]][[scenario]][model_day])
    out <- c("Salvage" = salvage_prop, "Interior Delta" = 1 - salvage_prop)
  }
  return(out)
}


