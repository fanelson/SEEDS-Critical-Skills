# Manipulating data with dplyr and tidyr

# library packages
library(dplyr) # data manipulation functions, akin to manual filtering, reordering, calculation
library(tidyr) # reshaping data functions
library(readr) # reading and writing csvs
library(udunits2) # unit conversions

# read in data
# read_csv: 1) faster 2) strings automatically read as factors 

surveys <- read.csv("data_raw/portal_data_joined.csv")
str(surveys)
head(surveys)
nrow(surveys); ncol(surveys)
View(surveys) 

# Subsetting by rows (filter) and column (select)
filter(surveys, year == 1995)
select(surveys, month, species, genus)
select(surveys, -record_id, -day)

surveys_sml <- surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

# Adding a calculated colum (mutate)
surveys %>%
  mutate(weight_kg = weight/1000) # original units g

survey %>%
  filter(!is.na(weight)) %>%
  select(weight) %>%
  mutate(weight_kg = ud.convert(weight, "g", "kg")) # orginal units g

# split/apply/combine paradigm  
surveys %>% group_by(sex, species_id) %>%
  filter(!is.na(weight), !is.na(sex)) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight)
            n = n())

# Counting, count(), n()
count(surveys, species, sex)