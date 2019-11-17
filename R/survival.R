#' Survival
#'
#' Draw random value for survival through a reach on a given day.
#'
#' @md
#' @param reach       GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Yolo, or Interior Delta
#' @param scenario    Scenario describing water project operations
#' @param model_day   Integer day in 82-yr model period
#' @param flow_list   List that contains flow values for all reaches, scenarios, and days in 82-yr model period
#'
#' @export
#' @examples
#' survival("Sac3", "EXG", 2, list("Sac3" = list("Standardized" = list("EXG" = c(-5, 0, 5)))))
#' survival("Sac2", "EXG", 2, list("Sac3" = list("Standardized" = list("EXG" = c(-5, 0, 5)))))
#'

survival <- function(reach = c("GeoDCC", "Sac1", "Sac2", "Sac3", "Sac4", "SS",
                               "Verona_to_Sac", "Interior Delta", "Yolo"),
                     scenario, model_day, flow_list){
  reach <- match.arg(reach)
  sp <- survival_params[[reach]]
  if(reach %in% c("Sac1", "Sac2", "Sac3", "SS")){
    sac3_sf <- flow_list[["Sac3"]][["Standardized"]][[scenario]][model_day]
    sp[["mean"]] <- flow_survival(reach, sac3_sf)
    sp[["sd"]] <- flow_survival_sd[[reach]](sac3_sf)
  }
  if(reach == "Yolo"){
    ys <- c()
    for (i in c("I_80", "screw_trap", "BTD", "BCEW")){
      ys <- c(ys, rtruncnorm_surv(1, sp[[i]][["mean"]], sp[[i]][["sd"]]))
    }
    return(prod(ys))
  } else if(reach == "Interior Delta"){
    return(interior_delta_survival(1, scenario, model_day, flow_list))
  } else {
    return(rtruncnorm_surv(1, sp[["mean"]], sp[["sd"]]))
  }
}


