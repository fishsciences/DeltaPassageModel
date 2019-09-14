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

survival <- function(reach, scenario, model_day, flow_list){
  if(!(reach %in% c(names(reach_length), "Interior Delta", "Yolo"))){
    stop("reach is not one of GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Yolo, Interior Delta")
  }
  rtruncnorm_surv <- function(mean, sd){
    truncnorm::rtruncnorm(1, 0, 1, mean, sd)
  }
  sp <- survival_params[[reach]]
  if(reach %in% c("Sac1", "Sac2", "Sac3", "SS")){
    sac3_sf <- flow_list[["Sac3"]][["Standardized"]][[scenario]][model_day]
    sp[["mean"]] <- flow_survival(reach, sac3_sf)
    sp[["sd"]] <- flow_survival_sd[[reach]](sac3_sf)
  }
  if(reach == "Yolo"){
    ys <- c()
    for (i in c("I_80", "screw_trap", "BTD", "BCEW")){
      ys <- c(ys, rtruncnorm_surv(sp[[i]][["mean"]], sp[[i]][["sd"]]))
    }
    return(prod(ys))
  } else if(reach == "Interior Delta"){
    # calculates export-dependent theta parameter
    # the ratio of survival between coded wire tagged smolts released into Georgiana Slough and smolts released into the Sacramento River
    exports <- flow_list[["Exports"]][[scenario]][model_day]
    theta = 0.5948 * exp(-0.000065 * exports)                # warning: hard-coded values
    theta_with_export_effect = rtruncnorm_surv(theta, 0.178) # warning: hard-coded values

    geo_dcc_surv <- rtruncnorm_surv(survival_params[["GeoDCC"]][["mean"]],
                                    survival_params[["GeoDCC"]][["sd"]])

    sac3_sf <- flow_list[["Sac3"]][["Standardized"]][[scenario]][model_day]
    sac3_surv <- rtruncnorm_surv(flow_survival("Sac3", sac3_sf),
                                 flow_survival_sd[["Sac3"]](sac3_sf))

    # Equation that converts theta into survival that can be applied to smolts migrating through the interior Delta.
    id_surv <- (theta_with_export_effect / geo_dcc_surv) * sac3_surv
    return(ifelse(id_surv > 1, 1,
                  ifelse(id_surv < 0, 0, id_surv)))
  } else {
    return(rtruncnorm_surv(sp[["mean"]], sp[["sd"]]))
  }
}


