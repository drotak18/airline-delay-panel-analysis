#libraries
library(tidyverse)
library(fixest)
library(modelsummary)
library(lubridate)
library(skimr)
library(data.table)
library(nycflights13)

#packages
source("scripts/00_setup.R")

# dataset
flights <- nycflights13::flights

glimpse(flights)

# checking airports
flights %>%
  count(origin)

# delay summary
summary(flights$arr_delay)
