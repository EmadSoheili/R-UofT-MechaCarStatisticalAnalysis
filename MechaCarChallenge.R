library(dplyr)

# Part 1
mpg_df <- read.csv('MechaCar_mpg.csv')

summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, mpg_df))

summary(lm(mpg ~ vehicle_length + ground_clearance, mpg_df))

# Part 2
susp_df <- read.csv('Suspension_Coil.csv')

total_summary <- summarize(susp_df, Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))

lot_summary <- group_by(susp_df, Manufacturing_Lot) %>% summarize(Mean=mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
