#' Interior Delta survival
#'
#' Draw random value for survival through the Interior Delta on a given day.
#'
#' @md
#' @param n           GeoDCC, Sac1, Sac2, Sac3, Sac4, SS, Verona_to_Sac, Yolo, or Interior Delta
#' @param scenario    Scenario describing water project operations
#' @param model_day   Integer day in 82-yr model period
#' @param flow_list   List that contains flow values for all reaches, scenarios, and days in 82-yr model period
#'
#' @export
#' @examples
#'

interior_delta_survival <- function(n, scenario, model_day, flow_list){
    # calculates export-dependent theta parameter
    # the ratio of survival between coded wire tagged smolts released into Georgiana Slough and smolts released into the Sacramento River
    exports <- flow_list[["Exports"]][[scenario]][model_day]
    theta = 0.5948 * exp(-0.000065 * exports)                   # warning: hard-coded values
    theta_with_export_effect = rtruncnorm_surv(n, theta, 0.178) # warning: hard-coded values

    geo_dcc_surv <- rtruncnorm_surv(n,
                                    survival_params[["GeoDCC"]][["mean"]],
                                    survival_params[["GeoDCC"]][["sd"]])

    sac3_sf <- flow_list[["Sac3"]][["Standardized"]][[scenario]][model_day]
    sac3_surv <- rtruncnorm_surv(n,
                                 flow_survival("Sac3", sac3_sf),
                                 flow_survival_sd[["Sac3"]](sac3_sf))

    # Equation that converts theta into survival that can be applied to smolts migrating through the interior Delta.
    id_surv <- (theta_with_export_effect / geo_dcc_surv) * sac3_surv
    return(ifelse(id_surv > 1, 1,
                  ifelse(id_surv < 0, 0, id_surv)))
}


