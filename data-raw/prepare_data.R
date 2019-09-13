## code to prepare datasets in this file

# reach length in km
reach_length = c("GeoDCC" = 25.59, "Sac1" = 41.04, "Sac2" = 10.78, "Sac3" = 22.37, "Sac4" = 23.98,
                 "SS" = 26.72, "Verona_to_Sac" = 37)
usethis::use_data(reach_length, overwrite = TRUE)

sac_timing <- read.csv("data-raw/SacTiming.csv", stringsAsFactors = FALSE)
usethis::use_data(sac_timing, overwrite = TRUE)

speed_min <- list("GeoDCC" = 0.34, "Sac1" = 0.54, "Sac2" = 0.34, "Sac3" = 0.37, "Sac4" = 0.36,
                  "SS" = 0.56, "Verona_to_Sac" = 0.54)
usethis::use_data(speed_min, overwrite = TRUE)

flow_speed_sd_fn <- list.files(path = "data-raw", pattern = "Flow_Speed", full.names = TRUE)
flow_speed_sd <- lapply(flow_speed_sd_fn, read.csv)
flow_speed_sd <- lapply(flow_speed_sd, function(x) approxfun(x$Flow, x$SpeedSD, rule = 2))
# some embarrassing nested gsub'ing rather than learning regex
names(flow_speed_sd) <- gsub(pattern = ".csv",
                             replacement = "",
                             x = gsub(pattern = "data-raw/Flow_Speed_SD_",
                                      replacement = "",
                                      x = flow_speed_sd_fn))
usethis::use_data(flow_speed_sd, overwrite = TRUE)

flow_survival_sd_fn <- list.files(path = "data-raw", pattern = "Flow_Survival", full.names = TRUE)
flow_survival_sd <- lapply(flow_survival_sd_fn, read.csv)
flow_survival_sd <- lapply(flow_survival_sd, function(x) approxfun(x$StandardizedFlow, x$SurvivalSD, rule = 2))
names(flow_survival_sd) <- gsub(pattern = ".csv",
                             replacement = "",
                             x = gsub(pattern = "data-raw/Flow_Survival_SD_",
                                      replacement = "",
                                      x = flow_survival_sd_fn))
usethis::use_data(flow_survival_sd, overwrite = TRUE)

