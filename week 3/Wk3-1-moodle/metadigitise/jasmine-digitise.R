# install.packages("metaDigitise")
library(metaDigitise)
library(dplyr)

browseVignettes("metaDigitise")

data <- metaDigitise(dir = "week 3/Wk3-1-moodle/metadigitise/")

cleaned_data <- data |> 
  mutate(group_id = case_when(group_id == "20" ~ "20C",
                              TRUE ~ group_id)) |> 
  arrange(variable) |> 
  tibble()

write_csv(cleaned_data, "week 3/Wk3-1-moodle/metadigitise/data/jasmine-mr.csv")
