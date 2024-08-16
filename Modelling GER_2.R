# Load required libraries
library(minpack.lm)
library(dplyr)

# Load and prepare the dataset
Rainbow_trout <- read.csv("GER_data.csv", header = TRUE, sep = ",") %>%
  filter(expno %in% 6:14) %>%
  mutate(
    sqrtstw = sqrt(stw),  # Transform 'stw' to its square root
    sqrtsow = sqrt(sow)   # Transform 'sow' to its square root
  )

# The Square Root Function with a fixed length exponent C (0.75)
fit_sqrt_model <- function(exp_id) {
  experiment_data <- subset(Rainbow_trout, expno == exp_id)
  
  model <- nls(sqrtstw ~ sqrtsow - 0.5 * RL * predlcm^0.75 * time, 
               data = experiment_data, 
               start = list(RL = 0.01), 
               algorithm = "port")
  
  temp <- unique(experiment_data$temp)
  c(expno = exp_id, Temperature = temp[1], Estimate = coef(model)["RL"], 
    SE = summary(model)$coefficients["RL", "Std. Error"])
}

# Apply the Square Root Function to experiments 6 to 14 to estimate the rate parameter constant (RL) for each individual GE experiment
RL_results_df <- lapply(6:14, fit_sqrt_model) %>%
  do.call(rbind, .) %>%
  as.data.frame()

# Print the results
print(RL_results_df)


### The exponential function is utilized for the GE experiments performed
###at temperatures ranging from 7.8°C to 15.0°C for rainbow trout, to determine the temperature dependency
### within this lower range. The length exponent was fixed at 0.75


SQRT_model <- nls(sqrtstw ~ sqrtsow - 0.5 * RT * predlcm^0.75 * exp(A * temp) * time,
                  data = Rainbow_trout %>% filter(expno %in% 6:11),
                  start = list(RT = 0.01, A = 0.08),
                  algorithm = "port")

# Display the summary of the Function
summary(SQRT_model)
