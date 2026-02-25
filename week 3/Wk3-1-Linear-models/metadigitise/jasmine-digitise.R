# install.packages("metaDigitise")
library(metaDigitise)
library(dplyr)

browseVignettes("metaDigitise")

# Choose 2. Import then 1. All data to read into R
data <- metaDigitise(dir = "week 3/Wk3-1-moodle/metadigitise/", summary = FALSE) 

fig3_data <- data$scatterplot$fig3.png
fig4_data <- data$scatterplot$fig4.png

fig3_data |> count(group) 
fig4_data |> count(group)  # Use fig 4, the sample sizes match the paper. 

clean_data <- fig4_data |> 
  mutate(temp_treatment = case_when(group == 1 ~ "20C",
                                    group == 2 ~ "24C",
                                    group == 3 ~ "28C")
         ) |> 
  mutate(fish_id = paste0("fish_", row_number())
         ) |> 
  rename(smr = x) |> 
  select(fish_id, temp_treatment, smr) |> 
  tibble()

write_csv(clean_data, "week 3/Wk3-1-moodle/metadigitise/data/martino-fish-smr.csv")
write_csv(clean_data, "week 3/Wk3-1-moodle/data/martino-fish-smr.csv")
