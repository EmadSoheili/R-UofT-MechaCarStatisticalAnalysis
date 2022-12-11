library(dplyr)

mpg_df <- read.csv('MechaCar_mpg.csv')

summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, mpg_df))

summary(lm(mpg ~ vehicle_length + ground_clearance, mpg_df))
