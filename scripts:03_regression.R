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

# Regression Table

modelsummary(
  list(
    "OLS" = model_ols,
    "Airport FE" = model_fe,
    "Two-way FE" = model_twfe
  ),
  output = "output/tables/regression_table.html"
)

#relationship between flights and delays plot
ggplot(panel_day, aes(flights_n, avg_arr_delay)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm") +
  labs(
    title = "Relationship Between Flights and Delays",
    x = "Number of Flights",
    y = "Average Arrival Delay"
  )

ggsave("output/figures/delay_vs_flights.png", width = 8, height = 5)