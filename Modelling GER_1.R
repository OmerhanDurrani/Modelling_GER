# Load required libraries
library(nls2)       # For advanced nonlinear least squares fitting with multiple algorithms
library(minpack.lm) # For robust nonlinear least-squares fitting using the Levenberg-Marquardt algorithm
library(dplyr)      # For data manipulation and transformation

# Load the dataset
data <- read.csv("GER_data.csv", TRUE, ",")

#### General Power Function (GPF) for Gastric Evacuation (GE) ####

# The GPF can describe the pattern of GE independent of meal size. The function depends on the value of B:
# B = 0: Linear (steady rate of GE)
# B = 0.5: Square root function (slower evacuation over time)
# B = 0.67: Surface-area-dependent function (evacuation depends on surface area)
# B = 1: Exponential (decrease in food evacuation over time)

#### Demo 1: Testing GPF with Experiment 1 and 2 Data ####

# Filter data for Brown trout (experiments 1 and 2)
Brown_trout <- data %>% filter(expno %in% c(1, 2))

# Define the General Power Function
model_func_gp <- function(R, B, sow, time) {
  s <- sow^(1 - B) - R * (1 - B) * time
  ifelse(s > 0, s^(1 / (1 - B)), 0)
}

# Fit the General Power Function 
GPF_model_1 <- nls2(stw ~ model_func_gp(R, B, sow, time),
                    data = Brown_trout,
                    start = list(R = 0.01, B = 0.5),
                    algorithm = "port")

summary(GPF_model_1)



# If B ≈ 0.5, use the Square Root Function for further analysis
# The following lines create new columns in the Brown_trout dataset,
# where 'stw' (stomach content weight at time t) and 'sow' (stomach content weight at time 0)
# are transformed to their square root values. This transformation is necessary
# to apply the Square Root Function for the gastric evacuation analysis.

SQRT_Brown_trout <- Brown_trout %>%
  mutate(
    sqrtstw = sqrt(stw), # Convert 'stw' to its square root
    sqrtsow = sqrt(sow)  # Convert 'sow' to its square root
  )


# Fit the Square Root Function 
SQRT_model_1 <- nls(sqrtstw ~ sqrtsow - 0.5 * R * time, 
                    data = SQRT_Brown_trout, 
                    start = list(R = 0.01),
                    algorithm = "port")

summary(SQRT_model_1)

#### Demo 2: GPF Applied to Experiments 1-5 with Extensions for Temperature and Fish Size ####

# Experiments 1-5 include large and small fish with varying meal sizes and water temperatures

# Filter data for Brown trout (experiments 1 to 5)
Brown_trout <- data %>% filter(expno %in% 1:5)

# Define the extended General Power Function 
model_func_ext <- function(sow, predlcm, temp, time, RLT, B, C, A) {
  R <- RLT * predlcm^C * exp(A * temp)
  s <- sow^(1 - B) - R * (1 - B) * time
  ifelse(s > 0, s^(1 / (1 - B)), 0)
}

# Fit the extended General Power Function 
GPF_model_2 <- nlsLM(stw ~ model_func_ext(sow, predlcm, temp, time, RLT, B, C, A),
                     data = Brown_trout,
                     start = list(RLT = 0.01, B = 0.5, C = 1.3, A = 0.08))

summary(GPF_model_2)

# If B ≈ 0.5, use the Square Root Function for further analysis
SQRT_Brown_trout_2 <- Brown_trout %>%
  mutate(
    sqrtstw = sqrt(stw), # Convert 'stw' to its square root
    sqrtsow = sqrt(sow) # Convert 'sow' to its square root
  )

# Fit the Square Root Function with extended parameters
SQRT_model_2 <- nls(sqrtstw ~ sqrtsow - 0.5 * RLT * predlcm^C * exp(A * temp) * time,
                    data = SQRT_Brown_trout_2,
                    start = list(RLT = 0.01, C = 1.3, A = 0.08),
                    algorithm = "port")

summary(SQRT_model_2)

#### Demo 3: GPF with Optimum and Upper Thermal Limits for Experiments 6-14 ####

# Experiments 6-14 involve small, medium, and large rainbow trout with varying meal sizes and temperatures

# Filter data for Rainbow trout (experiments 6 to 14)
Rainbow_trout <- data %>% filter(expno %in% 6:14)

# Define the General Power Function model with thermal limits
GPF_model_3 <- nls(stw ~ (sow^(1-B) - RLT * predlcm^C * exp(A1 * temp) * (1 - exp(A2 * (temp - TU))) * (1 - B) * time)^(1 / (1 - B)),
                   data = Rainbow_trout,
                   start = list(RLT = 0.00132, B = 0.5, C = 0.8, A1 = 0.08, A2 = 3, TU = 20),
                   algorithm = "port")

summary(GPF_model_3)

# If B ≈ 0.5, use the Square Root Function with optimum temperature for further analysis
SQRT_Rainbow_trout <- Rainbow_trout %>%
  mutate(
    sqrtstw = sqrt(stw), # Convert 'stw' to its square root
    sqrtsow = sqrt(sow) # Convert 'sow' to its square root
  )


# Fit the Square Root Function with optimum temperature
SQRT_model_3 <- nls(sqrtstw ~ sqrtsow - 0.5 * (RLT * predlcm^C * exp(A1 * temp) * (1 - exp(A2 * (temp - TU)))) * time,
                    data = SQRT_Rainbow_trout,
                    start = list(RLT = 0.0022, C = 1.31, A1 = 0.08, A2 = 0.46, TU = 20),
                    algorithm = "port")

summary(SQRT_model_3)


# Fit the Square Root Function with optimum temperature
# Note: The parameter A1 is fixed at 0.08 based on prior knowledge or assumptions,
# and therefore is not included in the list of parameters to be estimated.
SQRT_model_4 <- nls(sqrtstw ~ sqrtsow - 0.5 * (RLT * predlcm^C * exp(0.08 * temp) * (1 - exp(A2 * (temp - TU)))) * time,
                    data = SQRT_Rainbow_trout,
                    start = list(RLT = 0.0022, C = 1.31, A2 = 0.46, TU = 20),
                    algorithm = "port")

summary(SQRT_model_4)

