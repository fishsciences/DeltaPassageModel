## code to prepare `sac_timing` dataset goes here
sac_timing <- read.csv("data-raw/SacTiming.csv", stringsAsFactors = FALSE)
usethis::use_data(sac_timing)

flow_speed_sd_fn <- list.files(path = "data-raw", pattern = "Flow_Speed", full.names = TRUE)
flow_speed_sd <- lapply(flow_speed_sd_fn, read.csv)
names(flow_speed_sd) <- gsub(pattern = ".csv",
                             replacement = "",
                             x = gsub(pattern = "data-raw/Flow_Speed_SD_",
                                      replacement = "",
                                      x = flow_speed_sd_fn))
usethis::use_data(flow_speed_sd)

flow_survival_sd_fn <- list.files(path = "data-raw", pattern = "Flow_Survival", full.names = TRUE)
flow_survival_sd <- lapply(flow_survival_sd_fn, read.csv)
names(flow_survival_sd) <- gsub(pattern = ".csv",
                             replacement = "",
                             x = gsub(pattern = "data-raw/Flow_Survival_SD_",
                                      replacement = "",
                                      x = flow_survival_sd_fn))
usethis::use_data(flow_survival_sd)

