## Module 15 Challenge.
library(dplyr)

############# Deliverable 1. ###########################
## Linear Regression to Predict MPG
## Multi variable linear regression

mechacar_df <- read.csv(file = "resources/MechaCar_mpg.csv")

model <- lm( mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, mechacar_df)

model_results <- summary(model)

r_squared <- model_results$r.squared

################# Output to console###############
## Model coefficients
model
## Linear Model Summary
model_results
## p-Values
model_results$coefficients[,4]
## r-squared value
r_squared

############# Deliverable 2. ###########################
## Summary Statistics on Suspension Coils

coils_df <- read.csv(file = "resources/Suspension_Coil.csv")
total_summary <- coils_df %>% summarise(Mean = mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI))
lot_summary <- coils_df %>% group_by(Manufacturing_Lot) %>% 
                summarise(Mean = mean(PSI), Median=median(PSI), Variance=var(PSI), SD=sd(PSI), .groups = 'keep')
lot_summary_df <- as.data.frame(lot_summary)  # for visualisation purposes

################# Output to console###############
total_summary
lot_summary_df

################# Generate Plot ##################
plt<- ggplot(coils_df, aes(x=PSI, color=Manufacturing_Lot))
plt + geom_density() + labs(title = 'Density Distribution by Manufacturing Lot', y='Density', color='Manufacturing Lot') + theme(legend.position = c(0.1,0.7), legend.background = element_rect(fill='white', size=0.5, linetype='solid', color='black'))

############# Deliverable 3 ###########################
## T-test on Suspension Coils


