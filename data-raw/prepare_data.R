## code to prepare datasets in this file

library(tidyverse)

# reach length in km
reach_length = c("GeoDCC" = 25.59, "Sac1" = 41.04, "Sac2" = 10.78, "Sac3" = 22.37, "Sac4" = 23.98,
                 "SS" = 26.72, "Verona_to_Sac" = 37)
usethis::use_data(reach_length, overwrite = TRUE)

# Entry distributions (aka timing) ----------------------------------------------

lf <- read_csv("data-raw/LF_density.csv") %>%
  mutate(Day = lubridate::yday(Date)) %>%
  # model runs slower as number of cohorts increase
  # plus, not realistic that fish would move through on every day of year
  mutate(Daily_P = ifelse(Daily_P < 0.001, 0, Daily_P),
         Daily_P = Daily_P/sum(Daily_P))

sum(lf$Daily_P > 0)/nrow(lf)  # target value is around 50%; winter run timing used in DPM is 70% of year and spring/fall are 30%

sac_timing <- read.csv("data-raw/SacTiming.csv", stringsAsFactors = FALSE) %>%
  mutate(Day = lubridate::yday(Date)) %>%
  left_join(select(lf, Day, LateFall = Daily_P)) %>%
  select(-Day) %>%
  as.list()
usethis::use_data(sac_timing, overwrite = TRUE)

# # late-fall timing did not match trawl data
# lf_old <- read_csv("data-raw/EntryDistributions.csv") %>%
#   mutate(Day = lubridate::yday(Date)) %>%
#   select(Day, LateFall) %>%
#   # fill in value for leap years; filling in Day 274
#   # arguably should be filling in February 29th but difference is probably negligible
#   bind_rows(data.frame(Day = 274, LateFall = NA)) %>%
#   arrange(Day) %>%
#   mutate(LateFall = cfs.misc::fill_missing(LateFall, 10),
#          LateFall = LateFall/sum(LateFall))
# ggplot(lf_old, aes(x = Day, y = LateFall)) + geom_line()
#
# # exploring possibility that old late-fall timing data was simply stored incorrectly (shifted dates)
# ggplot(lf, aes(x = Day)) +
#   geom_line(aes(y = Daily_P)) +
#   geom_line(data = lf_old %>% mutate(Day = Day + 40, Day = ifelse(Day > 366, Day - 366, Day)), aes(y = LateFall), col = 2)


# Migration speed ----------------------------------------------

# NULL values indicate that parameter is based on relationship to flow
speed_params <- list("GeoDCC"         = c("min" = 0.34, "mean" = NULL, "sd" = NULL),
                     "Sac1"           = c("min" = 0.54, "mean" = NULL, "sd" = NULL),
                     "Sac2"           = c("min" = 0.34, "mean" = NULL, "sd" = NULL),
                     "Sac3"           = c("min" = 0.37, "mean" = 9.24, "sd" = 7.33),
                     "Sac4"           = c("min" = 0.36, "mean" = 8.60, "sd" = 6.79),
                     "SS"             = c("min" = 0.56, "mean" = 9.41, "sd" = 7.42),
                     "Interior Delta" = c("min" = 1.00, "mean" = 7.95, "sd" = 6.74),
                     "Verona_to_Sac"  = c("min" = 0.54, "mean" = NULL, "sd" = NULL))
usethis::use_data(speed_params, overwrite = TRUE)

flow_speed_params = list("GeoDCC"        = list("B0" =  -33.520, "B1" = 11.08),
                         "Sac1"          = list("B0" = -105.980, "B1" = 21.34),
                         "Sac2"          = list("B0" =   -7.997, "B1" =  3.248264),
                         "Verona_to_Sac" = list("B0" = -105.980, "B1" = 21.34))
usethis::use_data(flow_speed_params, overwrite = TRUE)

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


# Survival ----------------------------------------------

survival_params <- list("GeoDCC"        = c("mean" = 0.650, "sd" = 0.1260),
                        "Sac4"          = c("mean" = 0.698, "sd" = 0.1530),
                        "Verona_to_Sac" = c("mean" = 0.931, "sd" = 0.0222),
                        "Yolo" = list("I_80"       = c("mean" = 0.96, "sd" = 0.06),
                                      "screw_trap" = c("mean" = 0.96, "sd" = 0.06),
                                      "BTD"        = c("mean" = 0.94, "sd" = 0.11),
                                      "BCEW"       = c("mean" = 0.88, "sd" = 0.06)))
usethis::use_data(survival_params, overwrite = TRUE)

flow_survival_params = list("Sac1" = list("B0" =  0.934),
                            "Sac2" = list("B0" =  1.851),
                            "Sac3" = list("B0" = -0.121),
                            "SS"   = list("B0" = -0.175))
usethis::use_data(flow_survival_params, overwrite = TRUE)


flow_survival_sd_fn <- list.files(path = "data-raw", pattern = "Flow_Survival", full.names = TRUE)
flow_survival_sd <- lapply(flow_survival_sd_fn, read.csv)
flow_survival_sd <- lapply(flow_survival_sd, function(x) approxfun(x$StandardizedFlow, x$SurvivalSD, rule = 2))
names(flow_survival_sd) <- gsub(pattern = ".csv",
                                replacement = "",
                                x = gsub(pattern = "data-raw/Flow_Survival_SD_",
                                         replacement = "",
                                         x = flow_survival_sd_fn))
usethis::use_data(flow_survival_sd, overwrite = TRUE)

