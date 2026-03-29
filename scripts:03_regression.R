# packages
source("scripts/00_setup.R")

#panel data
flights <- nycflights13::flights

panel_day <- flights |>
  mutate(date = as.Date(time_hour)) |>
  group_by(origin, date) |>
  summarise(
    flights_n = n(),
    avg_arr_delay = mean(arr_delay, na.rm = TRUE),
    .groups = "drop"
  )


# Regression 1: Pooled OLS
model_ols <- feols(
  avg_arr_delay ~ flights_n,
  data = panel_day
)

summary(model_ols)

# Regression 2: Fixed Effects

model_fe <- feols(
  avg_arr_delay ~ flights_n | origin,
  data = panel_day
)

summary(model_fe)

# Regression 3: Two-way Fixed Effects
model_twfe <- feols(
  avg_arr_delay ~ flights_n | origin + date,
  data = panel_day
)

summary(model_twfe)