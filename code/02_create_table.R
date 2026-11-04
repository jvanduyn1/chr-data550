here::i_am(
  "code/02_create_table.R"
)

library(dplyr)
library(labelled)
library(gtsummary)

df_final <- read.csv("data/derived/project_data.csv")

var_label(df_final) <- list(
  area = "County type",
  infant_mortality_rate = "Infant mortality rate (per 1,000)",
  percent_children_in_poverty.x = "Children in poverty (%)",
  years_of_potential_life_lost_rate.x = "YPLL rate (per 100,000)"
)

table <- df_final %>%
  filter(year == 2025) %>%
  select(area, infant_mortality_rate, percent_children_in_poverty.x, years_of_potential_life_lost_rate.x) %>%
  tbl_summary(by = area, statistic = all_continuous() ~ "{mean} ({sd})", digits = all_continuous() ~ 1, missing = "no") %>%
  add_p() %>%
  modify_caption("Mean and standard deviation of county health metrics (rural vs. urban counties) in 2025.")

saveRDS(table, "output/table.rds")