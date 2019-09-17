#' Routing
#'
#' Determine next reach(es) for a cohort based on current reach.
#'
#' @md
#' @param reach       GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Yolo, Fremont Weir, or Interior Delta
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
  if(!(reach %in% c(names(reach_length), "Fremont Weir", "Interior Delta", "Yolo"))){
    stop("reach is not one of GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Fremont Weir, Yolo, Interior Delta")
  }
  flow_prop <- function(reach1, reach2, scenario, model_day, flow_list){
    flow_reach1 <- flow_list[[reach1]][[scenario]][model_day]
    flow_reach2 <- flow_list[[reach2]][[scenario]][model_day]
    p_reach1 <- flow_reach1 / (flow_reach1 + flow_reach2)
    out <- c()
    out[[reach1]] <- p_reach1
    out[[reach2]] <- 1 - p_reach1
    return(out[out > 0])
  }
  if(reach %in% c("Verona_to_Sac", "Yolo", "SS", "Sac3", "Sac4", "Interior Delta")){
    reach_lookup <- list("Verona_to_Sac" = c("Sac1" = 1),
                         "Yolo" = c("Sac4" = 1),
                         "SS" = c("Sac4" = 1),
                         "Sac3" = c("Sac4" = 1),
                         "Sac4" = c("Chipps Island" = 1),
                         "Interior Delta" = c("Chipps Island" = 1))
    out <- reach_lookup[[reach]]
  }
  # Junction A
  if(reach == "Fremont Weir"){  # reach is a misnomer here; Fremont Weir is primary model entry point in North Delta
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
    temp2 <- c("GeoDCC" = p_geo_dcc_mod, "Sac3" = 1 - p_geo_dcc_mod)
    out <- temp2[temp2 > 0]
  }
  # Salvage
  if(reach == "GeoDCC"){
    salvage_prop <- exp(-7.2159 + 0.0002664 * flow_list[["Exports"]][[scenario]][model_day])
    temp <- c("Salvage" = salvage_prop, "Interior Delta" = 1 - salvage_prop)
    out <- temp[temp > 0]
  }
  return(out)
}


