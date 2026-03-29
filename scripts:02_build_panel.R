#packages
source("scripts/00_setup.R")

# data
flights <- nycflights13::flights

#date variable and airport-day panel
panel_day <- flights |>
  mutate(
    date = as.Date(time_hour)
  ) |>
  group_by(origin, date) |>
  summarise(
    flights_n = n(),
    avg_arr_delay = mean(arr_delay, na.rm = TRUE),
    avg_dep_delay = mean(dep_delay, na.rm = TRUE),
    share_arr_delay_15 = mean(arr_delay > 15, na.rm = TRUE),
    share_dep_delay_15 = mean(dep_delay > 15, na.rm = TRUE),
    .groups = "drop"
  )

glimpse(panel_day)
head(panel_day)

#summaries
summary(panel_day$flights_n)
summary(panel_day$avg_arr_delay)